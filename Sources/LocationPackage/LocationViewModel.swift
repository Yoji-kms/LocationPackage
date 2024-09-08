//
//  WeatherViewModel.swift
//  MiniApps
//
//  Created by Yoji on 08.09.2024.
//

import Foundation
import LocationService
import NetworkService

final class LocationViewModel {
    private let locationService: LocationService
    private let networkService: NetworkService
    private let key: String
    private var language = {
        "&lang=\(Locale.current.language.languageCode ?? "en")"
    }()
    
    init() {
        self.networkService = NetworkService()
        self.key = self.networkService.weatherKey ?? ""
        self.locationService = LocationService()
    }
    
    func updateLocation(completion: @escaping @Sendable (String)->Void) {
        if self.locationService.isAuthorized {
            self.locationService.getLocation { [weak self] lat, lon in
                guard let self else { return }
                let coordinates = Coordinates(lat: lat, lon: lon)
                self.getNewLocationBy(coordinates: coordinates, completion: completion)
            }
        } else if locationService.isNotDeterminedAuthorization {
            self.locationService.requestWhenInUseAuthorization { [weak self] in
                guard let self else { return }
                self.locationService.getLocation { [weak self] lat, lon in
                    guard let self else { return }
                    let coordinates = Coordinates(lat: lat, lon: lon)
                    self.getNewLocationBy(coordinates: coordinates, completion: completion)
                }
            }
        } else {
            let coordinates = Coordinates()
            self.getNewLocationBy(coordinates: coordinates, completion: completion)
        }
    }
    
    private func getNewLocationBy(coordinates: Coordinates, completion: @escaping @Sendable (String)->Void) {
        let basicUrl = networkService.getUrlBy(lat: coordinates.lat, lon: coordinates.lon)
        let url = basicUrl + self.key + self.language
        
        Task {
            let response: WeatherResponse? = await url.handleAsDecodable()
            guard let response else { return }
            let location = response.name ?? ""
            completion(location)
        }
    }
}
