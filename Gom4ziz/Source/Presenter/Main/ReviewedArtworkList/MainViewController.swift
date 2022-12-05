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
    
    private var tableView = UITableView()
    private let reviewedArtworkListViewModel: ReviewedArtworkListViewModel
    private let userViewModel: UserViewModel
    private let disposeBag = DisposeBag()
    private var skeletonView: MainViewSkeletonUI?
    
    init(reviewedArtworkListViewModel: ReviewedArtworkListViewModel, userViewModel: UserViewModel) {
        self.reviewedArtworkListViewModel = reviewedArtworkListViewModel
        self.userViewModel = userViewModel
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
    
    private func setupViews() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    // row 데이터 적용 (section은 dataSource.titleForHeaderInSection으로 설정)
    var dataSource = RxTableViewSectionedReloadDataSource<Section> { _, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewedArtworkCell", for: indexPath) as! ReviewedArtworkCell
        cell.setViewModel(reviewedArtworkListCellViewModel: item)
        return cell
        
    }
    
    private func setupTableViewDataSource() {
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].headerTitle
        }
    }
    
    private func setObserver() {
        
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
