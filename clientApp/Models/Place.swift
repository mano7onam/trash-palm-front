//
//  Place.swift
//  { Module name }
//
// Created by Stanislav Zelikson on 25/11/2023.
//

import Foundation
import MapKit

struct Place: Identifiable {
  let id = UUID()
  let name: String
  let coordinate: CLLocationCoordinate2D
}

extension CLLocationCoordinate2D: Identifiable {
  public var id: String {
    "\(latitude)-\(longitude)"
  }
}
