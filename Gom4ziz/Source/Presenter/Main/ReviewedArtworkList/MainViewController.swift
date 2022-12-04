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
    
    init(reviewedArtworkListViewModel: ReviewedArtworkListViewModel, userViewModel: UserViewModel) {
        self.reviewedArtworkListViewModel = reviewedArtworkListViewModel
        self.userViewModel = userViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        guard let user = userViewModel.user else {
          return
        }
        let userId = user.id
        let lastArtworkId = user.lastArtworkId
        reviewedArtworkListViewModel.fetchReviewedArtworkListCellList(for: userId, before: lastArtworkId)
        
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
        
        let reviewdArtworkCellListDriver = reviewedArtworkListViewModel.reviewedArtworkListCellListObservable
                     .asDriver()

        // 리뷰된 작품이 불러와졌을 때의 스트림
        reviewdArtworkCellListDriver
            .compactMap { $0.value }
            .map { [Section(headerTitle: "감상 기록", items: $0)] }
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        // 리뷰된 작품이 불러오는 중이거나 실패했을 때의 스트림
        reviewdArtworkCellListDriver
            .drive(onNext: { [weak self] status in
                switch status {
                    case .notRequested:
                        print("notRequested")
                    case .failed(let error):
                        self?.showErrorView(.reviewedArtwork, false) {
                            guard let user = self?.userViewModel.user else {
                              return
                            }
                            let userId = user.id
                            let lastArtworkId = user.lastArtworkId
                            self?.reviewedArtworkListViewModel
                                .fetchReviewedArtworkListCellList(for: userId, before: lastArtworkId)
                        }
                    case .isLoading(let last):
                        print("last")
                    default:
                        return
                }
            })
            .disposed(by: disposeBag)
    }
    
}
