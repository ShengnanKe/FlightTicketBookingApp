//
//  SeatSelectionViewController.swift
//  FlightTicketBookingApp
//
//  Created by KKNANXX on 4/24/24.
//

// save in userdefault


import UIKit

class SeatSelectionViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    @IBOutlet weak var firstClassSeatSelectionCollectionView: UICollectionView!
    // 1 way: transparent background color
    // 2 way: change icon
    // 1 collection view with 2 sections
    @IBOutlet weak var econClassSeatSelectionCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstClassSeatSelectionCollectionView.delegate = self
        firstClassSeatSelectionCollectionView.dataSource = self
        firstClassSeatSelectionCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let size : CGSize = CGSize(width: self.view.frame.width, height: 100.0)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // apply seperator here
        let size : CGSize = CGSize(width: self.view.frame.width, height: 20.0)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 12
        }else{
            return 30
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        if indexPath.section == 0 {
            let unselectedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UnselectedSeatCell", for: indexPath) as! UnselectedSeatCollectionViewCell
            unselectedCell.unSelectedSeatLable.text = "Row - \(indexPath.row)"
            cell = unselectedCell
        }
        else{
            let selectedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedSeatCell", for: indexPath) as! SelectedSeatCollectionViewCell
            selectedCell.selectedSeatLable.text = "Row - \(indexPath.row)"
            cell = selectedCell
        }
        return cell
    }
    
}
