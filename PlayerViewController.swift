//
//  FirstViewController.swift
//  BasketballBible
//
//  Created by Muji on 2020-08-19.
//  Copyright © 2020 Muji. All rights reserved.
//

/**
 Purpose : View Controller for PlayerSearchScreen
 */

import UIKit
import VegaScrollFlowLayout
import Foundation
import SwiftUI

// Set Global Variables
var playerInfo:[String] = currentPlayer.cureentPlayerInfo
var hallOfFame:[String] = hofersInfo.hofersPlayerInfo
class PlayerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    // Reset All Filters
    @IBAction func resetButtonPressed(_ sender: Any) {
        
        playerInfoToDisplay = playerInfo
        
        
       // Get rid of the filterView
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.filterView.frame = CGRect(x: 0, y: 813, width: 414, height: 0)
        }, completion: nil)
    
        filterView.isHidden = true
        filterHStackView.isHidden = true
        dimmedBackGround.isHidden = true
        

        playerNames.removeAll()
        viewDidLoad()
        playerList.reloadData()
        
       
    }
    // Closes Filter View, Selected Filters are not applied
    @IBAction func closeFilter(_ sender: Any) {
        
       
        
       // Get rid of the filterView using simple animation
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            var viewFrame = self.filterView.frame
            viewFrame.origin.y += viewFrame.size.height
            
            self.filterView.frame = viewFrame
        }, completion: {_ in
            self.filterView.isHidden = true
        }
        )
        
    }

    // Initialize Variables and Constants
    var referenceDict:[String:String] = [:]
    var tempText = ""
    let rangeSlider = RangeSlider(frame: .zero)
    let rangeSlider2 = RangeSlider(frame: .zero)
    let rangeSlider3 = RangeSlider(frame: .zero)
    var selectedTeam:String?
    var listOfTeams = playerConstansts.teamNames
    var referenceAllTimePlayerNameList = playerConstansts.allPlayersInfo
    var referenceCurrentPlayerNameList = [String]()
    var finalDict = [String]()
    var playerInfoToDisplay = currentPlayer.cureentPlayerInfo
    var stackImageIsChecked = [true,true,true]
    var playerNames = [String]()
    var hofPlayerInfo:[String] = hofersInfo.hofersPlayerInfo
    var currentPlayerInfo:[String] =  currentPlayer.cureentPlayerInfo
    var allPlayerInfo:[String] = playerConstansts.allPlayersInfo
    var infoDict:[String:String] = [:]
    var originalPlayerNames = [String]()
    //END: Initialize Variables and Constants
    
    
    //Outlets to Storyboard Objects
    @IBOutlet weak var yearView: UIView!
    @IBOutlet weak var minYearLabel: UILabel!
    @IBOutlet weak var maxYearLabel: UILabel!
    @IBOutlet weak var heightStackView: UIStackView!
    @IBOutlet weak var minHeightLabel: UILabel!
    @IBOutlet weak var heightView: UIView!
    @IBOutlet weak var maxHeightLabel: UILabel!
    @IBOutlet weak var weightStackView: UIStackView!
    @IBOutlet weak var minWeightLabel: UILabel!
    @IBOutlet weak var weightView: UIView!
    @IBOutlet weak var maxWeightLabel: UILabel!
    
    

    @IBOutlet weak var positionStackImage1: UIImageView! {
        didSet {
            self.positionStackImage1.tappable = true
        }
    }
    @IBOutlet weak var positionStackImage2: UIImageView! {
        didSet {
            self.positionStackImage2.tappable = true
        }
    }
    @IBOutlet weak var positionStackImage3: UIImageView! {
        didSet {
            self.positionStackImage3.tappable = true
        }
    }
    
    @IBOutlet weak var textSearchField: UITextField!
    @IBOutlet weak var playerList: UITableView!
    @IBOutlet weak var filterTeamTextField: UITextField!
    @IBOutlet weak var filterHStackView: UIStackView!
    @IBOutlet weak var filterViewHeightConstraint: NSLayoutConstraint!
    
    // Apply Filters + Hide Filter View
    @IBAction func filterButton(_ sender: Any) {
       
        filterView.isHidden = true
        self.filterViewHeightConstraint.constant = 300
        self.filterView.frame = CGRect(x: 0, y: 800, width: 10, height: 300)
        dimmedBackGround.backgroundColor = UIColor.black
        dimmedBackGround.alpha = 0.5
        dimmedBackGround.isHidden = true
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            var viewFrame = self.filterView.frame
            print("A",viewFrame.origin.y)
            print("B",viewFrame.size.height)
            
            viewFrame.origin.y -= viewFrame.size.height
            
            print("C",viewFrame.origin.y)
            print("D",viewFrame.size.height)
            
            self.filterView.frame = viewFrame
            self.filterView.isHidden = false
            self.filterHStackView.isHidden = false
        }, completion: nil)
        self.rangeSlider.isHidden = false}
    //END: Apply Filters + Hide Filter View
    
    @IBOutlet weak var dimmedBackGround: UIImageView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    // END: Outlets to Storyboard Objects
    
    
    
    // MARK:- START: Override ViewDidLoad to do additional set up
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Instantiate + Fill a Dictionary Object to hold all Players Info
        for item in playerInfo {
            
            let key = item.components(separatedBy: ",")[0]
            let value = item
            self.referenceDict[key] = value
            
        }
        originalPlayerNames.removeAll()
        
        // Instantiate + Fill Dict with Info that is to be displayed
        for item in playerInfoToDisplay {
            let name = item.components(separatedBy: ",")[0]
            playerNames.append(name)
            originalPlayerNames.append(name)
            infoDict[name] = item
            
        }
        

        // START: Setting up different views that could be need + hiding unneccessary ones
        filterView.layer.borderWidth = 2
        filterView.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        rangeSlider.isHidden = true
        self.yearView.addSubview(rangeSlider)
        self.heightView.addSubview(rangeSlider2)
        self.weightView.addSubview(rangeSlider3)
        rangeSlider.addTarget(self, action: #selector(rangeSliderValueChanged(_:)),
                              for: .valueChanged)
        
        rangeSlider2.addTarget(self, action: #selector(rangeSliderValueChanged2(_:)), for: .valueChanged)
        
        rangeSlider3.addTarget(self, action: #selector(rangeSliderValueChanged3(_:)), for: .valueChanged)
        
       
        self.positionStackImage1.callback = {
            if self.stackImageIsChecked[0] {
                self.positionStackImage1.image = UIImage(systemName: "circle")
                self.stackImageIsChecked[0] = false
            }
            else {
                self.positionStackImage1.image = UIImage(systemName: "circle.fill")
                self.stackImageIsChecked[0] = true

            }
        }
        self.positionStackImage2.callback = {
            if self.stackImageIsChecked[1] {
                self.positionStackImage2.image = UIImage(systemName: "circle")
                self.stackImageIsChecked[1] = false

            }
            else {
                self.positionStackImage2.image = UIImage(systemName: "circle.fill")
                self.stackImageIsChecked[1] = true

            }
        }
        self.positionStackImage3.callback = {
            if self.stackImageIsChecked[2] {
                self.positionStackImage3.image = UIImage(systemName: "circle")
                self.stackImageIsChecked[2] = false

            }
            else {
                self.positionStackImage3.image = UIImage(systemName: "circle.fill")
                self.stackImageIsChecked[2] = true

            }
        }
        
        
        filterViewHeightConstraint.constant = 0
        filterView.isHidden = true
        filterHStackView.isHidden = true
        segmentedControl.backgroundColor = .clear
        segmentedControl.tintColor = .clear
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "AvenirNextCondensed-Medium", size: 14)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "AvenirNextCondensed-Medium", size: 14)!, NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        
        self.createAndSetUpPickerView()
        
        // END: Setting up different views that could be need + hiding unneccessary ones
    
        
        
        // Setting ViewController as delegate for TableView and TextField
        playerList.delegate = self
        playerList.dataSource = self
        textSearchField.delegate = self
        
        // ViewController will run SearchRecords, everytime textSearchField is edited
        textSearchField.addTarget(self, action: #selector(searchRecords(_ :)), for: .editingChanged)
        
            }
    // MARK:- END: Override ViewDidLoad to do additional set up

    // MARK: - START: Search Records
    // Purpose: Match Text from textSearchField to all playerName
    @objc func searchRecords(_ textField: UITextField) {
        //print(playerNames[0],originalPlayerNames[0])
        print(playerInfoToDisplay.count)
        print(playerNames.count)
        print(originalPlayerNames.count)
        print(finalDict.count)
        
        playerNames.removeAll()
        
        self.finalDict.removeAll()
        var counter = 0
        if textSearchField.text?.count != 0 {
            
            for playerName in originalPlayerNames {
                counter += 1
                if textField.text != nil{
                    let range = playerName.lowercased().range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
                    
                    if range != nil {
                        
                        self.playerNames.append(playerName)
                        self.finalDict.append(self.referenceDict[playerName]!)
        
                    }
                }
            }
            
        } else {
            playerNames = originalPlayerNames
        }
    
        // Reloads data for tableView
        playerInfoToDisplay = finalDict
        playerList.reloadData()
        
    
    
    }
    // MARK: - END: Search Records
    
    // MARK: - UITextField Protocol
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textSearchField.resignFirstResponder()
        return true
    }
    
    
    // MARK:- START: TableViewDataSource Protocols
    
    // Returns number of cells needed
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return playerNames.count
    }
    
    // Returns custom UITableViewCell for each item
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Readies the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell") as! prototypeCell

        
        // Gets values for all the labels
        let name = playerNames[indexPath.row]
        var properName = name
        
        // Sets color for cell
        if name.contains("*") {
            
            properName = name.replacingOccurrences(of: "*", with: "")
            cell.cardView.layer.backgroundColor = CGColor(red: 255, green: 215, blue: 0, alpha: 1)
            
        }
        else{
            cell.cardView.layer.backgroundColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        }
        
        //Gets Values for Labels
        let item = self.referenceDict[name]
        let weight = item!.components(separatedBy: ",")[1]
        let height = item!.components(separatedBy: ",")[2]
        let position = item!.components(separatedBy: ",")[3]
        let team = item!.components(separatedBy: ",")[4]
        let lastYear = item!.components(separatedBy: ",")[5]
        let firstYear = item!.components(separatedBy: ",")[6]
        
        // Set all the labels
        cell.imageLabel.text = properName
        cell.measurementsLabel.text = height as String + ", " + weight as String + " lbs"
        cell.positionLabel.text = position as String
        cell.yearsLabel.text = firstYear as String + "-" + lastYear as String
        
        // Set the cell Image
                if team == " Retired" || team == " N/A" || team == ""{
                    cell.logoImage.image =  UIImage(named: "NBA")
                }
            
                else if team != " " {
                    cell.logoImage.image = UIImage(named: team.replacingOccurrences(of: " ", with: ""))}
                else{
                    cell.logoImage.image =  UIImage(named: "NBA")
                    
                }
        
        return cell
    
    
    }
    // The animation for showing new cells/while scrolling
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // Set the initial state of the cell
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        cell.layer.transform = transform

        //  UI View animatioj to change to the final state of the cell
        UIView.animate(withDuration: 0.8) {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        
        }
    
        
        
    }
    
    
    // Navigate to PlayerInfoViewController when a player is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Ready the new VC
        let infoVC = self.storyboard?.instantiateViewController(identifier: "PlayerInfoViewController") as! PlayerInfoViewController
        
        // Setting Constants for new VC
        let playerName = playerNames[indexPath.row] as String
        infoVC.strPlayerName = playerName.folding(options: .diacriticInsensitive, locale: .current)
        infoVC.playerName = playerName.folding(options: .diacriticInsensitive, locale: .current)
        
        // Animates and Pushes Info VC
        navigationController?.pushViewController(infoVC, animated: true)
        self.present(infoVC, animated: true)
        
    
    }
    // MARK:- END: TableViewDataSource Protocols
    
    
    // When segmentValue is changed (The 3 categories uptop)
    @IBAction func segmentValueChanged(_ sender: Any) {
        
        
        
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            playerInfo = currentPlayerInfo
        case 1:
            playerInfo = allPlayerInfo
        case 2:
            playerInfo = hofPlayerInfo
            print("Third Segment Selected")
        default:
            break
        }
        
        playerInfoToDisplay = playerInfo
        self.playerNames.removeAll()
        viewDidLoad()
        playerList.reloadData()
        
        
        
    }
    
    // Create and Set Up PickerView
    func createAndSetUpPickerView() {
        let pickerView = UIPickerView()
        pickerView.frame = CGRect(x: 0, y: 800, width: 414, height: 200)
        pickerView.delegate = self
        self.filterTeamTextField.inputView = pickerView
        pickerView.dataSource = self
        self.dismissAndClosePickerView()
    }
    
    
    // Funcrion To Dismiss and Close PickerView
    func dismissAndClosePickerView()  {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissAction))
        
        toolBar.setItems([button], animated: true)
        
        
        
        toolBar.isUserInteractionEnabled = true
        self.filterTeamTextField.inputAccessoryView = toolBar
        
        
    }
    @objc func dismissAction(){
        
        
        self.view.endEditing(true)
        self.tempText = filterTeamTextField.text!
        filterTeamTextField.text = self.tempText
        
    }
    

}


//MARK:- START: PLAYERVIEWCONTROLLER EXTENSION FOR PICKERVIEW
extension PlayerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print(listOfTeams)
        // Set as all the TeamNames -- Constant
        return listOfTeams.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return listOfTeams[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         
        self.filterTeamTextField.text = self.listOfTeams[row]
        
    }
    
    
}
//MARK:- END: PLAYERVIEWCONTROLLER EXTENSION FOR PICKERVIEW
//MARK:- START: EXTENSION FOR FILTERS
extension PlayerViewController {
    
    
    //MARK: START: Filtering Functionality
    @IBAction func applyFiltersButton(_ sender: Any) {
        
        
        
        // Reset playerInfoToDisplay
        playerInfoToDisplay = playerInfo
        
        // Filters based on the teamName pickerView
        let selectedTeam = self.filterTeamTextField.text
        if selectedTeam != "All" && selectedTeam! != "Select Team" {

            filterByTeam(teamName: selectedTeam ?? "")
        }
        
        // Filter based on position
        filterByPosition()
        
        // Filter Based on Year
        let minYearFilter = Int(self.minYearLabel.text!)!
        let maxYearFilter = Int(self.maxYearLabel.text!)!
        print(playerInfoToDisplay)
        
        filterByYears(minYearFilter: minYearFilter, maxYearFilter: maxYearFilter)
        
        
        
        filterByHeight(minHeightFilter: minHeightLabel.text!, maxHeightFilter: maxHeightLabel.text!)
        
       // Get rid of the filterView
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.filterView.frame = CGRect(x: 0, y: 813, width: 414, height: 0)
        }, completion: nil)
    
        
        filterView.isHidden = true
        filterHStackView.isHidden = true
        dimmedBackGround.isHidden = true
        
        
        
        playerNames.removeAll()
        viewDidLoad()
        playerList.reloadData()
        
        
        
        
    }
    
    func filterByTeam(teamName:String) {
        
        
        if teamName != "All" || teamName != "" {
        
            var tempPlayerInfoToDisplay = [String]()
            
            
            for item in playerInfoToDisplay {
                if item.contains(teamName) {
                    tempPlayerInfoToDisplay += [item]
                }
            }
            
            
            playerInfoToDisplay = tempPlayerInfoToDisplay
            
        }
        
        

        
        
    }
    
    func filterByPosition() {
        
        // Constants
        var counter = 0
        var positionFilters = [String]()
        let positions = ["G","F","C"]
        var tempPlayerInfoToDisplay = [String]()
        
        // Get Position Filters Value
        for item in self.stackImageIsChecked {
            if item {
                positionFilters += [positions[counter]]
            }
            counter += 1
        }
        // Checks that filters are necessary to apply
        if positionFilters.count > 0 && positionFilters.count < 3 {
            for item in playerInfoToDisplay {
                let position = item.components(separatedBy: ",")[3]
                
                for positionFilter in positionFilters {
                    if position.contains(positionFilter) {
                        tempPlayerInfoToDisplay += [item]
                    }
                }
            }
            playerInfoToDisplay = tempPlayerInfoToDisplay
        }
        else {
            
        }
    }
    
    func filterByYears(minYearFilter:Int,maxYearFilter:Int) {
        var tempPlayerInfoToDisplay = [String]()
        for item in playerInfoToDisplay {
            let maxYear = Int(item.components(separatedBy: ",")[5].replacingOccurrences(of: " ", with: ""))
            let minYear = Int(item.components(separatedBy: ",")[6].replacingOccurrences(of: " ", with: ""))
            // BOTH ARE BETWEEN
            // BOTH ARE HIGHER THAN MAXFILTER
            
            if (maxYear! > maxYearFilter && minYear! > maxYearFilter) {
                
                // TOO LATE / YOUNG
                print("TOO YOUNG")
            }
            // BOTH ARE LOWER THAN MINFILTER
            else if (minYear! < minYearFilter && maxYear! < minYearFilter) {
                
                // TOO EARLY / OLD
                print("TOO OLD")
                
            }
            else {
                
                print("FITS DESC")
                tempPlayerInfoToDisplay += [item]
                
            }
            // MIN IS BETWEEN
            // MAX IS BETWEEN
//            if ((maxYear ?? 0 > minYearFilter && maxYear ?? 0 < maxYearFilter) || (minYear ?? 0 > minYearFilter && minYear ?? 0 < maxYearFilter))  {
//                tempPlayerInfoToDisplay += [item]
//
//            }
            
        }
        
        playerInfoToDisplay = tempPlayerInfoToDisplay
        
    }
    
    func filterByHeight(minHeightFilter:String,maxHeightFilter:String) {
        
        
        var tempPlayerInfoToDisplay = [String]()
        
        let minHeight = (Int(minHeightFilter.components(separatedBy: "'")[0])! * 12) + Int(minHeightFilter.components(separatedBy: "'")[1])!
        let maxHeight = (Int(maxHeightFilter.components(separatedBy: "'")[0])! * 12) + Int(maxHeightFilter.components(separatedBy: "'")[1])!
        print("minHeight:",minHeight)
        print("maxHeight:",maxHeight)
        
        
        for item in playerInfoToDisplay {
            let heightStr = item.components(separatedBy: ",")[2].replacingOccurrences(of: " ", with: "")
            let heightInt = (Int(heightStr.components(separatedBy: "-")[0])! * 12) + (Int(heightStr.components(separatedBy: "-")[1])!)
            if (heightInt < minHeight) {
                
                // TOO LATE / YOUNG
                print("TOO SHORT")
            }
            // BOTH ARE LOWER THAN MINFILTER
            else if (heightInt > maxHeight) {
                
                // TOO EARLY / OLD
                print("TOO TALL")
                
            }
            else {
                
                print("FITS DESC")
                tempPlayerInfoToDisplay += [item]
                
            }
            // MIN IS BETWEEN
            // MAX IS BETWEEN
//            if ((maxYear ?? 0 > minYearFilter && maxYear ?? 0 < maxYearFilter) || (minYear ?? 0 > minYearFilter && minYear ?? 0 < maxYearFilter))  {
//                tempPlayerInfoToDisplay += [item]
//
//            }
            
        }
        
        playerInfoToDisplay = tempPlayerInfoToDisplay
        
    }
}
//MARK: END: Filtering Functionality
// MARK:- END EXTENSION


// MARK:- END: EXTENSION TO MAKE IMAGES TAPPABLE
public typealias SimpleClosure = (() -> ())
private var tappableKey : UInt8 = 0
private var actionKey : UInt8 = 1

extension UIImageView {
    
    @objc var callback: SimpleClosure {
        get {
            return objc_getAssociatedObject(self, &actionKey) as! SimpleClosure
        }
        set {
            objc_setAssociatedObject(self, &actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var gesture: UITapGestureRecognizer {
        get {
            return UITapGestureRecognizer(target: self, action: #selector(tapped))
        }
    }
    
    var tappable: Bool! {
        get {
            return objc_getAssociatedObject(self, &tappableKey) as? Bool
        }
        set(newValue) {
            objc_setAssociatedObject(self, &tappableKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            self.addTapGesture()
        }
    }

    fileprivate func addTapGesture() {
        if (self.tappable) {
            self.gesture.numberOfTapsRequired = 1
            self.isUserInteractionEnabled = true
            self.addGestureRecognizer(gesture)
        }
    }

    @objc private func tapped() {
        callback()
    }
}
// MARK:- END: EXTENSION TO MAKE IMAGES TAPPABLE

// MARK:- END: EXTENSION TO ADD RANGE SLIDER FUNCTIONALITY
extension PlayerViewController {
 
  
@objc override func viewDidLayoutSubviews() {
    let width = self.yearView.bounds.width
    let height: CGFloat = self.yearView.bounds.height - 10
    
    rangeSlider.frame = CGRect(x: 0, y: 0,
                               width: width, height: height)
    rangeSlider.frame.origin.y = self.yearView.frame.origin.y
    rangeSlider.frame.origin.x = 0
    
    
    rangeSlider2.frame = CGRect(x: 0, y: 0,
                               width: width, height: height)
    rangeSlider2.frame.origin.y = self.heightView.frame.origin.y
    rangeSlider2.frame.origin.x = 0
    
    
    rangeSlider3.frame = CGRect(x: 0, y: 0,
                               width: width, height: height)
    rangeSlider3.frame.origin.y = self.weightView.frame.origin.y
    rangeSlider3.frame.origin.x = 0
  }
    
@objc func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
    
      let values = "(\(rangeSlider.lowerValue) \(rangeSlider.upperValue))"
      print("Range slider value changed: \(values)")
    let lowerValue = Int((rangeSlider.lowerValue * 50) + 1970)
    let upperValue = Int((rangeSlider.upperValue * 50) + 1970)
    print("LowerValue",lowerValue)
    print("UpperValue",upperValue)
    
    let minString:String = "\(lowerValue)"
    let maxString:String = "\(upperValue)"
    print("MinString:",minString)
    print("MaxString:",maxString)
    DispatchQueue.main.async {
        self.minYearLabel.text = minString
        self.maxYearLabel.text = maxString
        
    }
    }

@objc func rangeSliderValueChanged2(_ rangeSlider: RangeSlider) {
    
      let values = "(\(rangeSlider.lowerValue) \(rangeSlider.upperValue))"
      print("Range slider value changed: \(values)")
    let lowerValue = Int((rangeSlider.lowerValue * 32) + 64)
    let upperValue = Int((rangeSlider.upperValue * 32) + 64)
    print("TotalInchesLower",lowerValue)
    print("TotalInchesUpper",upperValue)
    
    let lowerValueInch = lowerValue % 12
    let upperValueInch = upperValue % 12
    print("LowerValueInch",lowerValueInch)
    print("UpperValueInch",upperValueInch)
    
    let lowerValueFt = (lowerValue - lowerValueInch) / 12
    let upperValueFt = (upperValue - upperValueInch) / 12
    print("LowerValueFt",lowerValueFt)
    print("UpperValueFt",upperValueFt)
    
    let minString:String = "\(lowerValueFt)'\(lowerValueInch)"
    let maxString:String = "\(upperValueFt)'\(upperValueInch)"
    print("MinString:",minString)
    print("MaxString:",maxString)
    DispatchQueue.main.async {
        self.minHeightLabel.text = minString
        self.maxHeightLabel.text = maxString
        
    
        
        
    }
    }

@objc func rangeSliderValueChanged3(_ rangeSlider: RangeSlider) {
    
      let values = "(\(rangeSlider.lowerValue) \(rangeSlider.upperValue))"
      print("Range slider value changed: \(values)")
    let lowerValue = Int((rangeSlider.lowerValue * 200) + 150)
    let upperValue = Int((rangeSlider.upperValue * 200) + 150)
    print("LowerValue",lowerValue)
    print("UpperValue",upperValue)
    
    let minString:String = "\(lowerValue)"
    let maxString:String = "\(upperValue)"
    print("MinString:",minString)
    print("MaxString:",maxString)
    DispatchQueue.main.async {
        self.minWeightLabel.text = minString
        self.maxWeightLabel.text = maxString
        
    
        
        
    }
    }
    

}
// MARK:- END: EXTENSION TO ADD RANGE SLIDER FUNCTIONALITY


