//
//  CitySelectionsTableViewCell.swift
//  FlightTicketBookingApp
//
//  Created by KKNANXX on 4/23/24.
//

import UIKit

class CitySelectionsTableViewCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    var cityData: String = ""
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // just city
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard !cityData.isEmpty else { return 0 }
        
        if component == 0 {
            return cityData.count
        } else {
            let selectedcity = pickerView.selectedRow(inComponent: 0)
            if selectedStateIndex < cityData.count {
                let selectedCity = Array(cityData)
                return countryData[selectedState]?.count ?? 0
            } else {
                return 0
            }
        }
    }
    
    @IBOutlet weak var citySelectionLabel: UILabel! // origin and the destination
    @IBOutlet weak var citySelectionPickerView: UIPickerView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
