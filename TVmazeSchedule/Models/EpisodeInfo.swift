//
//  ScheduleShow.swift
//  TVmazeSchedule
//
//  Created by Aleksandr Mayyura on 04.11.2022.
//

import Foundation

struct EpisodeInfo {
    let name: String
    let summary: String?
    let show: Show
    let airstamp: String
    let airtime: String
    
    init(episodeInfoData: [String: Any]) {
        name = episodeInfoData["name"] as? String ?? ""
        summary = episodeInfoData["summary"] as? String ?? ""
        let showData = episodeInfoData["show"] as? [String: Any] ?? [:]
        show = Show(showData: showData)
        airtime = episodeInfoData["airtime"] as? String ?? ""
        airstamp = episodeInfoData["airstamp"] as? String ?? ""
    }
    
    static func getEpisodes(from value: Any) -> [EpisodeInfo] {
        guard let episodesData = value as? [[String: Any]] else { return [] }
        return episodesData.map { EpisodeInfo(episodeInfoData: $0)}
    }
}

struct Show {
    let name: String
    let summary: String
    let image: ImageIcon
    let officialSite: String
    let type: String
    let schedule: Schedule
    let network : Network
    
    init(showData: [String: Any]) {
        name = showData["name"] as? String ?? ""
        summary = showData["summary"] as? String ?? ""
        officialSite = showData["officialSite"] as? String ?? ""
        type = showData["type"] as? String ?? ""
        
        let imageData = showData["image"] as? [String: Any] ?? [:]
        image = ImageIcon(imageData: imageData)
        
        let scheduleData = showData["schedule"] as? [String: Any] ?? [:]
        schedule = Schedule(scheduleData: scheduleData)
        
        let networkData = showData["network"] as? [String: Any] ?? [:]
        network = Network(networkData: networkData)
    }
    
    static func getShows(from value: Any) -> [Show] {
        guard let showData = value as? [[String: Any]] else { return [] }
        return showData.map { Show(showData: $0)
        }
    }
}

struct Schedule {
    let time: String
    let days: [String]

    init(scheduleData: [String: Any]) {
        time = scheduleData["time"] as? String ?? ""
        days = scheduleData["days"] as? [String] ?? [""]
    }
}

struct ImageIcon {
    let medium: String
    
    init(imageData: [String: Any]) {
        medium = imageData["medium"] as? String ?? ""
    }
}

struct Network {
    let country: Country

    init(networkData: [String: Any]) {
        let countryData = networkData["country"] as? [String: Any] ?? [:]
        country = Country(countryData: countryData)
    }
}

struct Country: Decodable {
    let timezone: String

    init(countryData: [String: Any]) {
        timezone = countryData["timezone"] as? String ?? ""
    }
}





