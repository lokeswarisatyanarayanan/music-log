//
//  SpotifyUser.swift
//  Music Log
//
//  Created by Lokeswari on 29/06/25.
//


import Foundation

struct SpotifyUser: Decodable {
    let displayName: String
    let email: String
    let id: String
    let country: String?
    let product: String?
    let imageURL: URL?

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case email
        case id
        case country
        case product
        case images
    }

    struct Image: Decodable {
        let url: URL
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        displayName = try container.decode(String.self, forKey: .displayName)
        email = try container.decode(String.self, forKey: .email)
        id = try container.decode(String.self, forKey: .id)
        country = try? container.decode(String.self, forKey: .country)
        product = try? container.decode(String.self, forKey: .product)

        let images = try? container.decode([Image].self, forKey: .images)
        imageURL = images?.first?.url
    }
}
