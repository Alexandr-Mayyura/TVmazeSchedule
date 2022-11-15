//
//  ScheduleShow.swift
//  TVmazeSchedule
//
//  Created by Aleksandr Mayyura on 04.11.2022.
//

import Foundation

struct EpisodeInfo: Decodable {
    let name: String
    let summary: String?
    let show: Show
    let airstamp: String?
    let airtime: String?
    let type: String?
}

struct Show: Decodable {
    let name: String
    let summary: String?
    let image: ImageIcon
    let officialSite: String?
    let type: String?
    let schedule: Schedule?
    let network : Network?
    let genres: [String]?
    let rating: Rating?
}

struct Rating: Decodable {
    let average: Double?
}

struct Schedule: Decodable {
    let time: String
    let days: [String]

}

struct ImageIcon: Decodable {
    let medium: String

}

struct Network: Decodable {
    let country: Country

}

struct Country: Decodable {
    let timezone: String

}





