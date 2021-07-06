//
//  PhotoSearchParameters.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 08/05/2021.
//

import Foundation


struct PhotoSearchParameters {

    enum SortKind: String {
        case datePostedAscending = "date-posted-asc"
        case datePostedDescending = "date-posted-desc"
        case dateTakenAscending = "date-taken-asc"
        case dateTakenDescending = "date-taken-desc"
        case interestingnessAscending = "interestingness-asc"
        case interestingnessDescending = "interestingness-desc"
        case relevance = "relevance"
    }


    enum GeoContext: Int {
        case notDefined = 0, indoors, outdoors
    }

    enum ContentType: Int {
        case photos = 1
    }

    enum Media: String {
        case photos = "photos"
        case videos = "videos"
    }

    let longitude: Double?
    let latitude: Double?
    let sort: SortKind?
    let hasGeo: Bool?
    let geoContext: GeoContext?
    let accuracy: Int?
    let contentType: ContentType?
    let media: Media?
    let radius: Distance?


}


extension PhotoSearchParameters {

    var asURLParameters: [String: Any] {
        var parameters = HttpParameters()

        if let longitude = longitude { parameters["lon"] = longitude }
        if let latitude = latitude { parameters["lat"] = latitude }
        if let sort = sort { parameters["sort"] = sort.rawValue }
        if let hasGeo = hasGeo { parameters["has_geo"] = hasGeo }
        if let geoContext = geoContext { parameters["geo_context"] = geoContext.rawValue }
        if let accuracy = accuracy { parameters["accuracy"] = accuracy }
        if let contentType = contentType { parameters["contentType"] = contentType.rawValue }
        if let media = media { parameters["media"] = media.rawValue }
        if let radius = radius {
            parameters["radius"] = radius.value
            parameters["radius_units"] = radius.unit.rawValue
        }

        return parameters
    }
}
