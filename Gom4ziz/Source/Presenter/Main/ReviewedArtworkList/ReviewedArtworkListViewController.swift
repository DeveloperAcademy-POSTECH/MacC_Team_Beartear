//
//  ReviewedArtworkListViewController.swift
//  Gom4ziz
//
//  Created by 이가은 on 2022/12/01.
//

import UIKit

import RxCocoa
import RxDataSources
import RxSwift

final class ReviewedArtworkListViewController: UIViewController {
    
    private var tableView = UITableView()
    private let reviewedArtworkListViewModel: ReviewedArtworkListViewModel
    private let userViewModel = UserViewModel.shared
    private let disposeBag = DisposeBag()
    
    init(reviewedArtworkListViewModel: ReviewedArtworkListViewModel,
         reviewedArtworkListCellViewModelList: [ReviewedArtworkListCellViewModel]) {
        self.reviewedArtworkListViewModel = reviewedArtworkListViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let userId = userViewModel.user?.id, let lastArtworkId = userViewModel.user?.lastArtworkId {
            reviewedArtworkListViewModel.fetchReviewedArtworkListCellList(for: userId, before: lastArtworkId)
        }
        setupViews()
        setupTableViewDataSource()
        setObserver()
        
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
    var dataSource = RxTableViewSectionedReloadDataSource<Section> { dataSource, tableView, indexPath, item in
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
        // 리뷰된 작품이 불러와졌을 때의 스트림
        reviewedArtworkListViewModel.reviewedArtworkListCellListObservable
            .asDriver()
            .compactMap { $0.value}
            .map { [Section(headerTitle: "감상 기록", items: $0)] }
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        // 리뷰된 작품이 불러오는 중이거나 실패했을 때의 스트림
        reviewedArtworkListViewModel.reviewedArtworkListCellListObservable
            .subscribe(onNext: { status in
                switch status {
                    case .notRequested:
                        print("notRequested")
                    case .failed(let error):
                        print("error", error)
                    case .isLoading(let last):
                        print("last")
                    default:
                        return
                }
            })
            .disposed(by: disposeBag)
    }
    
}

extension ReviewedArtworkListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
