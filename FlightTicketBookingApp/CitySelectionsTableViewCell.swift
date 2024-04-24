//
//  CitySelectionsTableViewCell.swift
//  FlightTicketBookingApp
//
//  Created by KKNANXX on 4/23/24.
//

import UIKit
class CitySelectionsTableViewCell: UITableViewCell{
    
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
//        cityPickerView.delegate = self
//        cityPickerView.dataSource = self
    }
}
