//
//  MainViewController.swift
//  Gom4ziz
//
//  Created by 이가은 on 2022/12/01.
//

import UIKit

import RxCocoa
import RxDataSources
import RxSwift

final class MainViewController: UIViewController, UIScrollViewDelegate {
    
    private var tableView = UITableView(frame: .zero, style: .grouped)
    private let reviewedArtworkListViewModel: ReviewedArtworkListViewModel
    private let questionViewModel: QuestionViewModel
    private let userViewModel: UserViewModel
    private let disposeBag = DisposeBag()
    private var skeletonView: MainViewSkeletonUI?
    
    init(reviewedArtworkListViewModel: ReviewedArtworkListViewModel,
         userViewModel: UserViewModel,
         questionViewModel: QuestionViewModel) {
        self.reviewedArtworkListViewModel = reviewedArtworkListViewModel
        self.userViewModel = userViewModel
        self.questionViewModel = questionViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupViews()
        setupTableViewDataSource()
        setObserver()
        reviewedArtworkListViewModel.fetchReviewedArtworkListCellList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let user = userViewModel.user else { return }
        questionViewModel
            .requestArtwork(with: user)
    }
    
    // row 데이터 적용 (section은 dataSource.titleForHeaderInSection으로 설정)
    var dataSource = RxTableViewSectionedReloadDataSource<Section> { dataSource, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewedArtworkCell", for: indexPath) as! ReviewedArtworkCell
        cell.setViewModel(reviewedArtworkListCellViewModel: item)
        return cell
        
    }
}

private extension MainViewController {
    
    func setupViews() {
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInsetAdjustmentBehavior = .never
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.register(ReviewedArtworkCell.self, forCellReuseIdentifier: "reviewedArtworkCell")
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    func setupTableViewDataSource() {
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].headerTitle
        }
    }
    
    func setObserver() {
    
        questionViewModel
            .artwork
            .asDriver()
            .drive(onNext: { [weak self] status in
                guard let self else { return }
                switch status {
                case .waitNextArtworkDay(let remainingTimeStatus):
                    self.setRemainTimeViewAsHeader(remainingTimeStatus)
                case .noMoreData:
                    self.setNoDataViewAsHeader()
                case .loaded(let artwork):
                    self.setQuestionViewAsHeader(artwork)
                case .failed:
                    self.showErrorView(.tiramisul, false) {
                        guard let user = self.userViewModel.user else { return }
                        self.questionViewModel.requestArtwork(with: user)
                    }
                case .loading:
                    print("loading")
                case .notRequested:
                    print("notRequested")
                }
            })
            .disposed(by: disposeBag)
        
        let reviewdArtworkCellListDriver = reviewedArtworkListViewModel.reviewedArtworkListCellListObservable
                     .asDriver()

        // 리뷰된 작품이 불러와졌을 때의 스트림
        reviewdArtworkCellListDriver
            .compactMap { $0.value }
            .map { [Section(headerTitle: "감상 기록", items: $0)] }
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        // 작품 로딩 스트림
        reviewdArtworkCellListDriver
            .map {
                $0.isLoading
            }
            .drive(onNext: { [weak self] isLoading in
                guard let self else { return }
                if isLoading {
                    self.addLoadingView()
                    return
                }
                self.removeLoadingView()
            })
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(ReviewedArtworkListCellViewModel.self)
            .subscribe(onNext: { [unowned self] in
                let artwork: Artwork = Artwork(
                    id: $0.artworkId,
                    imageUrl: $0.imageURLString,
                    question: $0.question,
                    title: $0.artworkTitle,
                    artist: $0.artist
                )
                let questionAnswer: QuestionAnswer = QuestionAnswer(
                    questionAnswer: $0.answer,
                    timeStamp: 0,
                    uid: self.userViewModel.user!.id
                )
                let vc = MyFeedViewController(
                    user: self.userViewModel.user!,
                    artwork: artwork,
                    questionAnswer: questionAnswer
                )
                navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
        // 에러 스트림
        reviewdArtworkCellListDriver
            .compactMap { $0.error }
            .drive(onNext: { [weak self] _ in
                guard let self else { return }
                self.showErrorView(.reviewedArtwork, false) {
                    self.reviewedArtworkListViewModel.fetchReviewedArtworkListCellList()
                }
            })
            .disposed(by: disposeBag)

    }

    private func addLoadingView() {
        skeletonView = .init()
        skeletonView!.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(skeletonView!)
        NSLayoutConstraint.activate([
            skeletonView!.topAnchor.constraint(equalTo: view.topAnchor),
            skeletonView!.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            skeletonView!.leftAnchor.constraint(equalTo: view.leftAnchor),
            skeletonView!.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }

    private func removeLoadingView() {
        skeletonView?.removeFromSuperview()
        skeletonView = nil
    }
}

private extension MainViewController {
    
    func setRemainTimeViewAsHeader(_ remainingTime: RemainingTimeStatus) {
        let remainTimeStatusView: RemainingTimeView = RemainingTimeView(remainingTimeStatus: remainingTime)
        remainTimeStatusView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 390)
        tableView.tableHeaderView = remainTimeStatusView
    }
    
    func setQuestionViewAsHeader(_ artwork: Artwork) {
        let questionView: MainQuestionView = MainQuestionView(artwork: artwork)
        let tapGestureRecognizer = setTapGesture()
        questionView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 520)
        tableView.tableHeaderView = questionView
        questionView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setNoDataViewAsHeader() {
        let noDataView: NoMoreDataView = NoMoreDataView()
        noDataView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 390)
        tableView.tableHeaderView = noDataView
    }
}

// MARK: - Tap Gesture
private extension MainViewController {
    
    func setTapGesture() -> UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(tapArtworkQuestion))
    }

    @objc func tapArtworkQuestion() {
        print("tap")
        // TODO: navigate
    }
}

#if DEBUG
import SwiftUI
struct MainViewControllerPreview: PreviewProvider {
    static var previews: some View {
        MainViewController(reviewedArtworkListViewModel: ReviewedArtworkListViewModel(user: UserViewModel.shared.user), userViewModel: UserViewModel.shared, questionViewModel: QuestionViewModel(requestNextQuestionUsecase: RealRequestNextArtworkUsecase()))
            .toPreview()
    }
}
#endif
