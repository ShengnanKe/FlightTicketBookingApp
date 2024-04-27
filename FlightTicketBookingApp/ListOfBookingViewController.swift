//
//  ListOfBookingViewController.swift
//  FlightTicketBookingApp
//
//  Created by KKNANXX on 4/26/24.
//

/*
 
 list of booking, a button -> add a booking () then navigate to the page for destination selection ->seat selection -> user info -> able to edit

 save data of seat data that seat is already been booked, it need to be gray out.  edit, free the ticket if the booking been deleted.
 
 */

import UIKit

class ListOfBookingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 //Bookings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    @IBOutlet weak var listOfBookingTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        listOfBookingTableView.dataSource = self
        listOfBookingTableView.delegate = self
        listOfBookingTableView.reloadData()
        // Do any additional setup after loading the view.
    }

}
