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
    let show: Show?
    let airtime: String?
}

struct Show: Decodable {
    let name: String?
    let summary: String?
    let image: Image?
    let language: String?
    let schedule: Schedule?
    let genres: [String]?
}

struct Schedule: Decodable {
    let time: String?
    let days: [String]?
}

struct Image: Decodable {
    let medium: String?
}
