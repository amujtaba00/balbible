//
//  SpreadSheetViewController.swift
//  BasketballBible
//
//  Created by Muji on 2020-10-08.
//  Copyright © 2020 Muji. All rights reserved.
//

/**
 ViewController For Representing All Statistics with a Chart on Top + SpreadSheet on Bottom
 */

import Foundation
import SpreadsheetView
import Charts
import SkeletonView

class SpreadSheetViewController: UIViewController, SpreadsheetViewDelegate, SpreadsheetViewDataSource, UITextFieldDelegate{
    
    

    
// MARK:-START CONSTANTS, VARIABLES
    let toolBar = UIToolbar()
    let thePicker = UIPickerView()
    var chartStatType = ""
    var tempText = ""
    var currentStatInfo = ""
    var firstYear = 0.0
    let soccerPlayers = ["Ozil","Ramsey","Laca","Auba","Xhaka","Torreira"]
    let goals = [6, 8, 26, 30, 8, 10]
    var statsOrder = "None"
    var currentStatsDict = [String?:Any]()
    var playerName = ""
    var statsTypeCounter = 0
    var statsType = ["Per Game","Totals","Per 36", "Per 100 Poss","Advanced","Adjusted Shooting","Shooting","Play by Play","Game Highs","Playoffs Per Game","Playoffs Totals","Playoffs Per 36","Playoffs Per 100 Poss","Playoffs Shooting","Playoffs Advanced","Playoffs Play by Play","Playoffs Game Highs"]
    var statTo = PlayerStatModel(legend: [""], playerName: "", fullStatDict: ["":""], statAsList: [[""]], keysAsList: [""])
    var header = [String]()
    var data = [[String]]()
    
    // MARK:-END CONSTANTS, VARIABLES
    
    // MARK:-START OUTLETS
    
    @IBOutlet weak var statSelectTextField: UITextField!
    @IBAction func closePickerView(_ sender: Any) {
        self.pickerView.isHidden = true
    }
    @IBAction func openPickerView(_ sender: Any) {
        
        self.pickerView.layer.borderWidth = 2
        self.pickerView.layer.borderColor = .init(red: 1, green: 1, blue: 1, alpha: 1)

        self.pickerView.layer.cornerRadius = 8
        self.pickerView.layer.borderColor = UIColor.gray.cgColor
        self.pickerView.frame = CGRect(x: 0, y: 1936, width: 414, height: 128)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.pickerView.frame = CGRect(x: 0, y: 908, width: 414, height: 128)
            self.pickerView.isHidden = false
        }
        
        createAndSetUpPickerView()
    }
    func createAndSetUpPickerView() {

        let pickerView = UIPickerView()
        pickerView.frame = CGRect(x: 0, y: 880, width: 414, height: 250)
        pickerView.delegate = self
        statSelectTextField.inputView = pickerView
        pickerView.dataSource = self
        self.dismissAndClosePickerView()

    }

    func dismissAndClosePickerView(){


        let toolBar = UIToolbar()
        toolBar.sizeToFit()

        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissAction))

        toolBar.setItems([button], animated: true)

        toolBar.isUserInteractionEnabled = true
        self.statSelectTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissAction(){
        
        self.view.endEditing(true)
        self.toolBar.isHidden = true
        self.pickerView.isHidden = true
        spreadsheetView.showAnimatedSkeleton(usingColor: .lightGray, animation: .none, transition: .crossDissolve(0.5))
        pickerLabel.showAnimatedSkeleton(usingColor: .lightGray, animation: .none, transition: .crossDissolve(0.5))
        openPickerButton.showAnimatedSkeleton(usingColor: .lightGray, animation: .none, transition: .crossDissolve(0.5))
        
        
        self.tempText = statSelectTextField.text!
        
        statSelectTextField.text! = self.tempText
        setStats()

        
    }
    
    
    @IBOutlet weak var openPickerButton: UIButton!
    @IBOutlet weak var pickerView: UIView!
    
    @IBOutlet weak var statTextField: UITextField!
    @IBOutlet weak var chartLabel: UILabel!
    
    @IBOutlet weak var grayBackground: UIImageView!
    @IBOutlet weak var displayStatInfoViewButton: UIButton!
    @IBOutlet weak var statInfoView: UIView!
    @IBOutlet weak var statName: UILabel!
    @IBOutlet weak var statExplainedLabel: UILabel!
    @IBOutlet weak var statEquationLabel: UILabel!
    
    @IBOutlet weak var chartView: BarChartView!
    @IBOutlet weak var pickerLabel: UILabel!
    @IBOutlet weak var spreadsheetView: SpreadsheetView!
    @IBOutlet weak var leftButtonPressed: UIButton!
    @IBOutlet weak var rightButtonPressed: UIButton!
    
    @IBOutlet weak var spreadsheetViewHeight: NSLayoutConstraint!
    @IBAction func rightButtonPressed(_ sender: Any) {
        
        spreadsheetView.showAnimatedSkeleton(usingColor: .lightGray, animation: .none, transition: .crossDissolve(0.5))
        pickerLabel.showAnimatedSkeleton(usingColor: .lightGray, animation: .none, transition: .crossDissolve(0.5))
        openPickerButton.showAnimatedSkeleton(usingColor: .lightGray, animation: .none, transition: .crossDissolve(0.5))
        
        
        if statsTypeCounter < 15 {
            
            statsTypeCounter += 1
        }
        else{
            statsTypeCounter = 0
        }
        self.setStats()
        
        spreadsheetView.reloadData()

    }
    @IBAction func leftButtonPressed(_ sender: Any) {
        
        spreadsheetView.showAnimatedSkeleton(usingColor: .lightGray, animation: .none, transition: .crossDissolve(0.5))
        pickerLabel.showAnimatedSkeleton(usingColor: .lightGray, animation: .none, transition: .crossDissolve(0.5))
        openPickerButton.showAnimatedSkeleton(usingColor: .lightGray, animation: .none, transition: .crossDissolve(0.5))
        
        
        
        if statsTypeCounter > 0 {
            
            statsTypeCounter -= 1
        }
        else{
            statsTypeCounter = 15
        }
        self.setStats()
        
        
        spreadsheetView.reloadData()
        

    }
    
    
    
    @IBAction func displayStatInfo(_ sender: Any) {
        
        let fullInfoString = self.currentStatInfo
        
        self.statName.text = fullInfoString.components(separatedBy: "---")[0] + " (" + self.chartStatType + ")"

        self.statExplainedLabel.text = fullInfoString.components(separatedBy: "---")[1]

        self.statEquationLabel.text = fullInfoString.components(separatedBy: "---")[3]
        
        
        self.grayBackground.isHidden = false
        self.grayBackground.alpha = 1
        self.statInfoView.layer.cornerRadius = 8
        self.statInfoView.layer.borderWidth = 2
        self.statInfoView.layer.borderColor = UIColor.black.cgColor
        self.statInfoView.isHidden = false
        
        
    }
    
    @IBAction func xButtonPressed(_ sender: Any) {
        self.statInfoView.isHidden = true
        
    }
    
    @IBAction func dismissButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    

    // MARK:-END OUTLETS
    
    
    // MARK:- START: Function to put StatsList in order of years
        func putInOrder(statsArrayDict: [String:Any]) -> [String] {
            
            var intKeys:[Int] = []
            var strKeys:[String] = []
            var finalKeys:[String] = []
            for (key,_) in statsArrayDict {
                
                
                
                strKeys += [key]
                
                
                
            }
            intKeys.sort()
            
            for item in intKeys {
                for (key,_) in statsArrayDict {
                    if key.contains(String(item)) {
                        
                        finalKeys += [key]
                    }
                    
                }
                
            }
            strKeys += ["Career"]
            finalKeys += strKeys
            
            
            return(finalKeys)
            
        }
    // MARK:- START: Function to put StatsList in order of years

// MARK:- START: VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        
        
        DispatchQueue.main.async {
            
            self.pickerLabel.text = self.statsType[self.statsTypeCounter]
            
            self.spreadsheetViewHeight.constant = (CGFloat(self.data.count) * 25)+25
            if self.spreadsheetViewHeight.constant > 400 {
                
                
                self.spreadsheetViewHeight.constant = (CGFloat(400))

                
            }

        }
        
        self.spreadsheetView.dataSource = self
        self.spreadsheetView.delegate = self
        

        spreadsheetView.register(HeaderCell.self, forCellWithReuseIdentifier: String(describing: HeaderCell.self))
        spreadsheetView.register(TextCell.self, forCellWithReuseIdentifier: String(describing: TextCell.self))

            }
    // MARK:- END: VIEW DID LOAD

    // MARK:- VIEW DID APPEAR
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        spreadsheetView.flashScrollIndicators()
    }

    // MARK: Implementing Methods for TableView Protocol
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        
        return header.count
    }

    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 1 + data.count
    }
    
    
    // MARK:START: Implementing Methods for Spreadsheet Protocol
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        if column == 0 {
            return 100
        }
        else{
            return 50
        }
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        if case 0 = row {
            return 25
        } else {
            return 25
        }
    }

    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        
        if case 0 = indexPath.row {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderCell.self), for: indexPath) as! HeaderCell
            
             
            let label = header[indexPath.column]
            cell.label.text = "\(label)"
            
            cell.setNeedsLayout()
            
            return cell
        } else {
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: TextCell.self), for: indexPath) as! TextCell
            
            var label = "N/A"
            if data.count > indexPath.row-1
            {
                if data[indexPath.row-1].count > indexPath.column {
                    label = data[indexPath.row-1][indexPath.column]
                }
                
            }

            cell.label.text = "\(label)"
            
            return cell
        }
    }
    
    
    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }
    
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, didSelectItemAt indexPath: IndexPath) {
    
        
        
        if indexPath.row == 0 {
            
            
            let statType = self.pickerLabel.text
            self.chartStatType = statType!
            switch  statType{
            case "Per Game":
                self.currentStatInfo = Constants.perGamestatsExplained[indexPath.column]!
                break
            case "Totals":
                self.currentStatInfo = Constants.totalStatsExplained[indexPath.column]!
                break
            case "Per 36":
                self.currentStatInfo = Constants.per36Explained[indexPath.column]!
                break
            case "Per 100 Poss":
                self.currentStatInfo = Constants.per100PossExplained[indexPath.column]!
                break
            case "Advanced":
                self.currentStatInfo = Constants.advancedExplained[indexPath.column]!
                break
            case "Adjusted Shooting":
                self.currentStatInfo = Constants.adjustedShootingExplained[indexPath.column]!
                break
            case "Shooting":
                self.currentStatInfo = Constants.shootingExplained[indexPath.column]!
                break
            case "Play by Play":
                self.currentStatInfo = Constants.playByPlayExplained[indexPath.column]!
                break
            case "Game Highs":
                self.currentStatInfo = Constants.gameHighsExplained[indexPath.column]!
                break
            case "Playoffs Per Game":
                self.currentStatInfo = Constants.perGamestatsExplained[indexPath.column]!
                break
            case "Playoffs Totals":
                self.currentStatInfo = Constants.totalStatsExplained[indexPath.column]!
                break
            case "Playoffs Per 36":
                self.currentStatInfo = Constants.per36Explained[indexPath.column]!
                break
            case "Playoffs Per 100 Poss":
                self.currentStatInfo = Constants.per100PossExplained[indexPath.column]!
                break
            case "Playoffs Advanced":
                self.currentStatInfo = Constants.advancedExplained[indexPath.column]!
                break
            case "Playoffs Adjusted Shooting":
                self.currentStatInfo = Constants.adjustedShootingExplained[indexPath.column]!
                break
            case "Playoffs Shooting":
                self.currentStatInfo = Constants.shootingExplained[indexPath.column]!
                break
            case "Playoffs Play by Play":
                self.currentStatInfo = Constants.playByPlayExplained[indexPath.column]!
                break
            case "Playoffs Game Highs":
                self.currentStatInfo = Constants.gameHighsExplained[indexPath.column]!
                break
            default:
                
                
                break
            }
            
            
            
            
            self.displayStatInfoViewButton.isHidden = false
            
            // Sets firstYear onetime
            if firstYear == 0.0 {
                firstYear = Double(self.data[0][0].prefix(4)) ?? 0.0
            
            
                let oldFirstYear = firstYear
                var years:[Double] = []
                for item in data[0]{
                    
                    let year = String(item.prefix(4))
                    let numberSet = CharacterSet(charactersIn: "0123456789")
                    let yearCharSet = CharacterSet(charactersIn: year)
                    
                    
                    if yearCharSet.isSubset(of: numberSet) && year != ""{
                        years += [Double(year)!]
                    }
                }
                firstYear = years.min() ?? oldFirstYear
            }
            
            
            
            setChart(yearStart: firstYear, column: indexPath.column)
            
            // Defining variables
            var counter = 0
            var container = [Int:Double]()
            var nonSortedKeys = [Int]()
            
            
            
            // Iterating through current data ---
            for item in self.data {
                
                
                if item.count > indexPath.column {
                
                

                // Removing alpha characters from data item
                let valueString = item[indexPath.column].trimmingCharacters(in: CharacterSet(charactersIn: "0123456789.").inverted)
                
                // Checking that data is infact a number
                if valueString != "" {
                    
                    
                    // Putting in values to a container (counter is kept as a ref to original key)
                    let value = (valueString as NSString).doubleValue
                    container[counter] = value
                }
                else{
                    nonSortedKeys += [counter]
                }
                }
                counter += 1
                
            }
            
            // Sorting the container according to value
            var sortedDict = container.sorted { $0.1 > $1.1 }
            
            
            if statsOrder == "Ascending" {
                sortedDict = container.sorted { $0.1 > $1.1 }
                statsOrder = "Descending"
            }
            else {
                sortedDict = container.sorted { $0.1 < $1.1 }
                statsOrder = "Ascending"
            }
            
            
            // Variable to store key values for sortedDict
            var sortedKeys = [Int]()
            
            // Populating sortedKeys
            for (key,_) in sortedDict {
                sortedKeys += [key]
            }
            
            if sortedKeys == [] {
                
                
            }
            
            let totalKeys = sortedKeys + nonSortedKeys
            
            // Defining newData as a placeholder for the sorted data
            var newData = [[String]]()
            
            // Populating sortedKeys
            for item in totalKeys{
                newData += [data[item]]
            }
            // ---
            self.data = newData
        }
        spreadsheetView.reloadData()
        
    }
    // MARK:END: Implementing Methods for Spreadsheet Protocol
    
// MARK:- START: SET STATS FUNCTION
    func setStats()  {
        
    // MARK: Making a REST API call based on current pickerLabelText
        // TODO: Add functionality to save already viewed stat (Memoization)
        
        //Setting and formatting the baseURL
        let statsURL = Constants.baseURL + "player/stats?name=\(self.playerName.lowercased().replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "*", with: ""))&type=\(self.statsType[statsTypeCounter].lowercased().replacingOccurrences(of: " ", with: ""))"

        // Declaring URL Object
        let url = URL(string: statsURL)
        
        // Declaring Task Object
        let task = URLSession.shared.dataTask(with: url!) { [self](data,response,error ) in
            guard let dataResponse = data,
                  error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            
            
            // Serialization dataResponse as JSONResponse
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: .allowFragments)
                
                
                // Casting jsonResponse as a Dict named statsDict
                if let statsDict = jsonResponse as? [String:Any] {
                    // statsDict succesfully initialized
                    self.currentStatsDict = statsDict
                    
                    
                    if statsDict.count > 2 {
                        
                    }
                    
                    
                    // Ordering keys of JSON Response
                    let orderedKeys = self.putInOrder(statsArrayDict: statsDict)
                    
                    
                    // Initializing variables to hold value to send to the model
                    var statsAsList = [[String]]()
                    var statsAsListDict = [String:[String]]()
                    var legendArray = [String]()

                    
                    for item in orderedKeys{
                        
                        for (key,value) in statsDict {
                            if key.contains(item){
                                
                                if key != "Legend" {
                                    
                                    
                                
                            
                                let keyList = [key]
                                let listToAdd = value as! [String]
                                let completeList = keyList + listToAdd
                                    statsAsList += [completeList ]
                                
                                
                                
                                
                                    statsAsListDict[key] = value as? [String]
                                }
                            }
                            
                            //Sets the legend array
                            if key == "Legend" {
                                
                                let yearList = ["Year"]
                                let listToAddLegend = value as! [String]
                                let completeListLegend = yearList + listToAddLegend
                                legendArray = completeListLegend
                                
                                
                                
                            }
                            
                        }
                        
                        
                    }
                    
                    
                    // Get rid of blank values in statsAsList
                    var firstcounter = 0

                    for item in statsAsList {

                        var secondcounter = 0
                        for value in item {

                            if value.contains("season"){
                                statsAsList[firstcounter][secondcounter] = statsAsList[firstcounter][secondcounter + 2] + " (" + statsAsList[firstcounter][secondcounter].replacingOccurrences(of: "season", with: "").replacingOccurrences(of: "s", with: "").replacingOccurrences(of: " ", with: "")  + ")"
                            }
                            secondcounter += 1
                        }
                        firstcounter += 1
                    }
                    
                    
                    
                    // Create PlayerStatModel Object
                    let statToPost = PlayerStatModel(legend: legendArray , playerName: self.playerName, fullStatDict: statsDict, statAsList: statsAsList,keysAsList:orderedKeys)
                    
                    // Set it as GlobalCurrentStatModel
                    self.statTo = statToPost
                    
                    
        
                }
                else{
                    // statsArray failed to initialize

                
                }
            }
            
            catch {
                
                print("JSON SERIALIZATION ERROR", error)
            }
            
            
            self.data = self.statTo.statAsList
            self.header = self.statTo.legend
            
            
            DispatchQueue.main.async {
                
                sortData()
                checkStats()
                
                
                var height = (self.data.count  * 25) + 25
                if height > 400 {
                    height = 400
                }
                self.spreadsheetViewHeight.constant = CGFloat(height)
                
                self.viewDidLoad()
                pickerLabel.hideSkeleton()
                spreadsheetView.hideSkeleton()
                openPickerButton.hideSkeleton()
            }
            
        }// End Task Declaration
        task.resume()
        

    }
// MARK:- END SET STATS FUNCTION

    

    
// MARK:- START SETCHART FUNCTION
    func setChart(yearStart:Double, column:Int) {
        
        
        self.chartLabel.text = header[column]
        var teamNameList:[String] = []
        var chartDataList:[Double] = []
        var chartLabelList:[Int] = []
        for item in self.data {
            if item[0].contains("-"){
                let chartLabelListEntry = Int(item[0].prefix(4))!
                chartLabelList += [chartLabelListEntry]
            
            
                var lastIndex = column
                if (column == -1 || (lastIndex > (item.count - 1))) {
                    lastIndex = item.count - 1
                }
                
                let chartDataListEntry = Double(item[lastIndex]) ?? 0
                chartDataList += [chartDataListEntry]
                teamNameList += [item[2]]
            
            }
            
        }
        
        
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<chartDataList.count {
            
            
            let dataEntry = BarChartDataEntry(x: Double(Int(chartLabelList[i])), y: Double(chartDataList[i]))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: header[column])
        
        var colors:[NSUIColor] = []
        var counter = 0
        for _ in dataEntries{
            
            
            colors.append(((currentPlayer.teamColors[teamNameList[counter]] ?? currentPlayer.teamColors["BRK"])!))
            counter += 1
        }
        chartDataSet.colors = colors
        
        
        
        let chartData = BarChartData(dataSet: chartDataSet)
        
        
        
        var noOfLabels = 0
        if chartLabelList.count > 10 {
            
            noOfLabels = 10
            
            
        }
        else{
            noOfLabels = chartLabelList.count
            
        }
        
        
        
        
        
        chartView.gridBackgroundColor = .lightGray
        chartView.layer.cornerRadius = 5
        chartView.layer.shadowColor = UIColor.white.cgColor
        chartView.layer.shadowOpacity = 1
        chartView.noDataText = "Select A Stat To View Graph"
        chartView.legend.enabled = false
        chartView.data = chartData
        chartView.data?.setValueTextColor(.white)
        chartView.xAxis.labelTextColor = .white
        chartView.xAxis.gridColor = .white
        chartView.xAxis.axisLineColor = .white
        chartView.leftAxis.labelTextColor = .white
        chartView.rightAxis.enabled = false
    
        chartView.borderColor = .white
        chartView.borderLineWidth = 5
        chartView.gridBackgroundColor = .white
        chartView.xAxis.setLabelCount(noOfLabels, force: true)
        
        
    
        chartView.backgroundColor = .black
        self.chartLabel.isHidden = false
    }
    
// MARK:- END SETCHART FUNCTION
    
// MARK:- START SORTDATA FUNCTION
    func sortData() {
        
            
            // Defining variables
            var counter = 0
            var container = [Int:Double]()
            var nonSortedKeys = [Int]()
            var careerKey = Int()
            
            
            
        
        for item in self.data {
                
            

            if (item.count < 2) == false {
                
                
                
            
                // Removing alpha characters from data item
                let valueString = item[1].trimmingCharacters(in: CharacterSet(charactersIn: "0123456789.").inverted)
                
                // Checking that data is infact a number
                if valueString != "" {
                    
                    
                    // Putting in values to a container (counter is kept as a ref to original key)
                    let value = (valueString as NSString).doubleValue
                    container[counter] = value
                }
                else{
                    if valueString.contains("Career") == false {
                    nonSortedKeys += [counter]
                    }
                    else{
                        careerKey = counter
                    }
                    
                }
                counter += 1
            }
            }
            
            // Sorting the container according to value
        let sortedDict = container.sorted { $0.1 < $1.1 }
            
            
            
            
            // Variable to store key values for sortedDict
            var sortedKeys = [Int]()
            
            // Populating sortedKeys
        for (key,_) in sortedDict {
                sortedKeys += [key]
            }
           
            
        let totalKeys = sortedKeys + nonSortedKeys + [careerKey]
            
            // Defining newData as a placeholder for the sorted data
            var newData = [[String]]()
            
            // Populating sortedKeys
            for item in totalKeys{
                newData += [data[item]]
            }
        self.data = newData
        spreadsheetView.reloadData()
        
        }
// MARK:- END SORTSTATS FUNCTION

    
// MARK:- START CHECKSTATS FUNCTION
    func checkStats(){
        
        var keysContainer = [String]()
        var keycounter = 0
        var keyTracker = [Int]()
        for item in self.data {
            if item[0] != "Season" {
            if keysContainer.contains(item[0]) {

            }
            else{
                keysContainer += [item[0]]
                keyTracker += [keycounter]
                }

            }
            else{
                
                
                
            }
            
            keycounter += 1
        }
        
        var checkedData = [[String]]()
        for item in keyTracker {
            checkedData += [self.data[item]]
        }
        
        
       
        
        self.data = checkedData
        
        
    }
// MARK:- END CHECKSTATS FUNCTION


}

//MARK: START: Extension to add methods to conform to PickerView Protocol
extension SpreadSheetViewController:UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return statsType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return statsType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         
        self.statsTypeCounter = row
        self.statSelectTextField.text! = self.statsType[row]
    }
}
//MARK: END: Extension to add methods to conform to PickerView Protocol
