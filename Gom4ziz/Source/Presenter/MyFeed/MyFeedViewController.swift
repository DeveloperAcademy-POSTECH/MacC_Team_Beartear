//
//  MyFeedViewController.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/11/23.
//

import UIKit

import RxCocoa
import RxSwift

final class MyFeedViewController: UIViewController {
    
    private let myFeedView: MyFeedView = .init(artwork: .mockData, artworkDescription: .mockData, artworkReview: .mockData, highlights: [])
    private let viewModel: MyFeedViewModel = MyFeedViewModel(fetchArtworkReviewUseCase: RealFetchArtworkReviewUseCase(),
                                                             fetchArtworkDescriptionUseCase: RealFetchArtworkDescriptionUseCase(),
                                                             fetchHighlightUseCase: RealFetchHighlightUseCase())
    private let disposebag: DisposeBag = .init()
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}

