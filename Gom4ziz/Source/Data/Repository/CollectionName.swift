//
//  CollectionName.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/21.
//
import Foundation

enum CollectionName {

    static var user: String {
        ProcessInfo().isRunningTests ? "TestUsers": "Users"
    }

    static var artwork: String {
        ProcessInfo().isRunningTests ? "TestArtworks": "Artworks"
    }

    static var artworkDescription: String {
        ProcessInfo().isRunningTests ? "TestArtworkDescriptions": "ArtworkDescriptions"
    }

    static var artworkReview: String {
        ProcessInfo().isRunningTests ? "TestArtworkReviews": "ArtworkReviews"
    }

    static var highlight: String {
        ProcessInfo().isRunningTests ? "TestHighlights": "Highlights"
    }

}
