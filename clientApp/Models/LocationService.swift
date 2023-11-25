//
//  LocationService.swift
//  clientApp
//
//  Created by  g01dt00th on 25.11.2023.
//

import Foundation
import CoreLocation

final class LocationService: NSObject {
	let manager = CLLocationManager()
	
	override init() {
		super.init()
		manager.delegate = self
		manager.requestWhenInUseAuthorization()
	}
}


extension LocationService: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print(error.localizedDescription)
		manager.requestAlwaysAuthorization()
	}
}
