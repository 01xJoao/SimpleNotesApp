//
//  LocationServiceImp.swift
//  SimpleNotes
//
//  Created by João Palma on 13/12/2019.
//  Copyright © 2019 João Palma. All rights reserved.
//

import Foundation
import CoreLocation

class LocationServiceImp : NSObject, LocationService, CLLocationManagerDelegate {
    
    private let _reportServiceProtocol: ReportService = DiContainer.resolve()
    private var _locationManager : CLLocationManager = CLLocationManager()
    private var _currentLocation : String?
    
    override init() {
        super.init()
        _setupLocationManager()
    }
    
    func _setupLocationManager() {
        if(CLLocationManager.locationServicesEnabled()) {
            _locationManager.delegate = self
            _locationManager.desiredAccuracy = kCLLocationAccuracyBest
            _locationManager.distanceFilter = kCLDistanceFilterNone
            _locationManager.startMonitoringSignificantLocationChanges()
        }
    }
    
    func requestUserAuthorization() {
        if(!CLLocationManager.locationServicesEnabled()) {
            self._locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if(status == .authorizedWhenInUse) {
            _setupLocationManager()
        }
    }

    func getUserLocation() -> String {
        return _currentLocation ?? ""
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let currentlocation = CLLocation(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        
        _fetchCityAndCountry(from: currentlocation) { city, country, error in
            guard let city = city, let country = country, error == nil else {
                if(error != nil) {
                    self._reportServiceProtocol.sendError(error: error!, message: "Coudn't fetch city and country")
                }
                return
            }
            
            self._currentLocation =  "\(city), \(country)"
        }
    }
    
    func _fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality, placemarks?.first?.country, error)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        _reportServiceProtocol.sendError(error: error, message: error.localizedDescription)
    }
}
