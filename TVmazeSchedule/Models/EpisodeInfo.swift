//
//  ScheduleShow.swift
//  TVmazeSchedule
//
//  Created by Aleksandr Mayyura on 04.11.2022.
//

import Foundation

struct EpisodeInfo: Decodable {
    let name: String?
    let summary: String?
    let show: Show
    let airstamp: String
}

struct Show: Decodable {
    let name: String?
    let summary: String?
    let image: Image?
    let language: String?
    let schedule: Schedule?
    let network: Network?
    let webChannel: WebChannel?
    let genres: [String]?
}

struct Schedule: Decodable {
    let time: String
    let days: [String]?
}

struct Image: Decodable {
    let medium: String?
}

struct Network: Decodable {
    let country: Country
}

struct WebChannel: Decodable {
    let country: Country
}

struct Country: Decodable {
    let timezone: String
}





