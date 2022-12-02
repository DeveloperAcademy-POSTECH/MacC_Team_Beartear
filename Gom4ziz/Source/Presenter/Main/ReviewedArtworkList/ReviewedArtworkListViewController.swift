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
    private let viewModel: ReviewedArtworkListViewModel
    private let userId: String
    private let artworkCount: Int
    private let disposeBag = DisposeBag()
    private var sectionSubject = BehaviorRelay(value: [Section]())
    
    init(viewModel: ReviewedArtworkListViewModel,
         reviewedArtworkListCellViewModelList: [ReviewedArtworkListCellViewModel],
         userId: String,
         artworkCount: Int) {
        self.viewModel = viewModel
        self.userId = userId
        self.artworkCount = artworkCount
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchReviewedArtworkListCellList(for: userId, before: artworkCount)
        setupViews()
        setupTableViewDataSource()
        bind()
        
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
    
    private func bind() {
        viewModel.reviewedArtworkListCellListObservable
            .asObservable()
            .subscribe { status in
                switch status {
                    case .notRequested:
                        print("notRequested")
                    case .loaded(let reviewedArtworkListCellViewModelList):
                        print("loaded", reviewedArtworkListCellViewModelList)
                        self.sectionSubject.accept([Section(headerTitle: "감상 기록", items: reviewedArtworkListCellViewModelList)])
                    case .failed(let error):
                        print("error", error)
                    case .isLoading(let last):
                        print("last")
                }
            } onError: { error in
                print(error)
            }
            .disposed(by: disposeBag)
        
        sectionSubject
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
}

extension ReviewedArtworkListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
