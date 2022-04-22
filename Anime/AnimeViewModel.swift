//
//  AnimeViewModel.swift
//  AnimeApp
//
//  Created by
// Balaji Chandupatla
// Shiva Rama Krishna nutakki
// Alekhya Gollamudi
// Kavya Chapparapu
// Satya Venkata Rohit
//
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Animes: Codable {
    let pagination: Pagination
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let malID: Int?
    let url: String?
    let images: [String: Image]?
    let trailer: Trailer?
    let title, titleEnglish, titleJapanese: String?
    let titleSynonyms: [String]?
    let type, source: String?
    let episodes: Int?
    let status: String?
    let airing: Bool
    let aired: Aired?
    let duration, rating: String?
    let score: Float?
    let scoredBy, rank, popularity, members: Int?
    let favorites: Int?
    let synopsis, background, season: String?
    let year: Int?
    let broadcast: Broadcast?
    let producers, licensors, studios, genres: [Genre]?
    let explicitGenres: [String]?
    let themes: [Genre]
    let demographics: [Genre]?

    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case url, images, trailer, title
        case titleEnglish = "title_english"
        case titleJapanese = "title_japanese"
        case titleSynonyms = "title_synonyms"
        case type, source, episodes, status, airing, aired, duration, rating, score
        case scoredBy = "scored_by"
        case rank, popularity, members, favorites, synopsis, background, season, year, broadcast, producers, licensors, studios, genres
        case explicitGenres = "explicit_genres"
        case themes, demographics
    }
}

// MARK: - Aired
struct Aired: Codable {
    let from, to: String?
    let prop: Prop?
    let string: String?
}

// MARK: - Prop
struct Prop: Codable {
    let from, to: From?
}

// MARK: - From
struct From: Codable {
    let day, month, year: Int?
}

// MARK: - Broadcast
struct Broadcast: Codable {
    let day, time, timezone, string: String?
}

// MARK: - Genre
struct Genre: Codable {
    let malID: Int?
    let type, name: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case type, name, url
    }
}

// MARK: - Image
struct Image: Codable {
    let imageURL, smallImageURL, largeImageURL: String?

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case smallImageURL = "small_image_url"
        case largeImageURL = "large_image_url"
    }
}

// MARK: - Trailer
struct Trailer: Codable {
    let youtubeID: String?
    let url, embedURL: String?
    let images: Images?

    enum CodingKeys: String, CodingKey {
        case youtubeID = "youtube_id"
        case url
        case embedURL = "embed_url"
        case images
    }
}

// MARK: - Images
struct Images: Codable {
    let imageURL, smallImageURL, mediumImageURL, largeImageURL: String?
    let maximumImageURL: String?

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case smallImageURL = "small_image_url"
        case mediumImageURL = "medium_image_url"
        case largeImageURL = "large_image_url"
        case maximumImageURL = "maximum_image_url"
    }
}

// MARK: - Pagination
struct Pagination: Codable {
    let lastVisiblePage: Int?
    let hasNextPage: Bool
    let currentPage: Int?
    let items: Items?

    enum CodingKeys: String, CodingKey {
        case lastVisiblePage = "last_visible_page"
        case hasNextPage = "has_next_page"
        case currentPage = "current_page"
        case items
    }
}

// MARK: - Items
struct Items: Codable {
    let count, total, perPage: Int?

    enum CodingKeys: String, CodingKey {
        case count, total
        case perPage = "per_page"
    }
}
