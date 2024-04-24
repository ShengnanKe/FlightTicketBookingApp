//
//  CitySelectionsTableViewCell.swift
//  FlightTicketBookingApp
//
//  Created by KKNANXX on 4/23/24.
//

import UIKit
class CitySelectionsTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var citySelectionLabel: UILabel! // origin and the destination
    @IBOutlet weak var cityPickerView: UIPickerView!
    
    var cities: [String] = []
    var pickerMode: PickerMode = .origin // Default to origin

    enum PickerMode {
        case origin
        case destination
    }

    func configure(with cityData: [String], mode: PickerMode) {
        cities = cityData
        pickerMode = mode
        cityPickerView.reloadAllComponents()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        cityPickerView.delegate = self
        cityPickerView.dataSource = self
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerMode {
        case .origin:
            // Handle origin city selection
            print("Origin city selected: \(cities[row])")
        case .destination:
            // Handle destination city selection
            print("Destination city selected: \(cities[row])")
        }
    }
}
