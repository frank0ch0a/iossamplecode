//
//  WineModel.swift
//  Wines
//
//  Created by Lagash Systems on 29/02/2020.
//  Copyright © 2020 Lagash Systems. All rights reserved.
//

import Foundation




// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let WineModel = try? newJSONDecoder().decode(WineModel.self, from: jsonData)

import Foundation

// MARK: - WineModelElement
class WineModel: Codable {
   
    let id: String
    let origin, name, company, notes: String
    let grapes: [Grape]
    let year: Int
    let type: String
    let companyWeb: String
    let wineWeb: String
    let picture: String
    let rating: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case origin, name, company, notes, grapes, year, type
        case companyWeb = "company_web"
        case wineWeb = "wine_web"
        case picture, rating
    }

    init(id: String, origin: String, name: String, company: String, notes: String, grapes: [Grape], year: Int, type: String, companyWeb: String, wineWeb: String, picture: String, rating: Int) {
        self.id = id
        self.origin = origin
        self.name = name
        self.company = company
        self.notes = notes
        self.grapes = grapes
        self.year = year
        self.type = type
        self.companyWeb = companyWeb
        self.wineWeb = wineWeb
        self.picture = picture
        self.rating = rating
    }
}

// MARK: - Grape
class Grape: Codable {
    let grape: String

    init(grape: String) {
        self.grape = grape
    }

}

typealias Wines = [WineModel?]
struct FailableDecodable<Base : Decodable> : Decodable {

    let base: Base?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.base = try? container.decode(Base.self)
    }
}
