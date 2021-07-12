//
//  PlayerInfoViewController.swift
//  BasketballBible
//
//  Created by Muji on 2020-08-22.
//  Copyright © 2020 Muji. All rights reserved.
//

/**
 ViewController that shows a particular players information
 */
import UIKit
import Foundation
import CardParts
import RxCocoa
import Alamofire
import SwiftUI
import SwiftyJSON
import SafariServices
import SkeletonView

class PlayerInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    
    // MARK:-START: CONSTANTS AND VARIABLES
   
    var playerName = Constants.playerName

    var strPlayerName = String()
    // Uncomment below line
    var teamName = "Toronto Raptors"
    var statsType = ["Per Game","Totals","Per 36", "Per 100 Poss","Advanced","Adjusted Shooting","Shooting","Play by Play","Game Highs"]
    var statsTypeCounter = 0
    var currentStatsDict = [String?:Any]()
    var yearsList = [String]()
    var statTo = PlayerStatModel(legend: [""], playerName: "", fullStatDict: ["":""], statAsList: [[""]], keysAsList: [""])
    var isRetired = false
    var strTwitterURL = ""
    var arrData:[String:Any] = [:]
    var accolades:[String] = []
    // MARK:-END: CONSTANTS AND VARIABLES
    
    
    // MARK:-START: OUTLETS
    
    // Opens players twitter pagee in SafariView
    @IBAction func twitterButton(_ sender: Any) {
        
        
        let twitterURL = URL(string: self.strTwitterURL)
        let vc = SFSafariViewController(url: twitterURL!)
        present(vc, animated: true, completion: nil)
        
        
        
    }
    
    // Opens players youtube pagee in SafariView
    @IBAction func youtubeButtonPressed(_ sender: Any) {
        
        let strYoutube = "https://www.youtube.com/results?search_query=Best+Of+" + strPlayerName.replacingOccurrences(of: " ", with: "+")
        
        let youtubeURL = URL(string: strYoutube)
        
        let vc = SFSafariViewController(url: youtubeURL!)
        
        present(vc, animated: true, completion: nil)
        
    }
    

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var dimmedBG: UIImageView!
    @IBOutlet var fullView: UIView!
    @IBOutlet weak var singleView: UIView!
    let tapRec = UITapGestureRecognizer()
    @IBOutlet weak var backGround: UIImageView!
    @IBOutlet weak var statsButton: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var twitterImage: UIButton!
    @IBAction func youtubeButton(_ sender: Any) {
    }
    @IBOutlet weak var youtubeButton: UIButton!
    @IBOutlet weak var whiteBackground2: UIImageView!
    @IBOutlet weak var whiteBackground: UIImageView!
    @IBOutlet weak var whiteBackground3: UIImageView!
    @IBOutlet weak var playerInfoLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var LabelStackView: UIStackView!
    @IBOutlet weak var editableStackView: UIStackView!
    @IBOutlet weak var positonLable: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var pobLabel: UILabel!
    @IBOutlet weak var measurementsLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var collegeLabel: UILabel!
    
    // Season Stats Labels
    @IBOutlet weak var GLabel: UILabel!
    @IBOutlet weak var FGLabel: UILabel!
    @IBOutlet weak var PTSLabel: UILabel!
    @IBOutlet weak var ThreeFGLabel: UILabel!
    @IBOutlet weak var REBLabel: UILabel!
    @IBOutlet weak var FTLabel: UILabel!
    @IBOutlet weak var ASTLabel: UILabel!
    @IBOutlet weak var eFGLabel: UILabel!
    @IBOutlet weak var WSLabel: UILabel!
    @IBOutlet weak var PERLabel: UILabel!
    
    
    // Career Stats Labels
    @IBOutlet weak var CGLabel: UILabel!
    @IBOutlet weak var CFGLabel: UILabel!
    @IBOutlet weak var CPTSLabel: UILabel!
    @IBOutlet weak var CREBLabel: UILabel!
    @IBOutlet weak var C3FGLabel: UILabel!
    @IBOutlet weak var CFTSLabel: UILabel!
    @IBOutlet weak var CASTLabel: UILabel!
    @IBOutlet weak var CeFGLabel: UILabel!
    @IBOutlet weak var CWSLabel: UILabel!
    @IBOutlet weak var CPERLabel: UILabel!
    
    // Accolades Labels
    @IBOutlet weak var accoladesTable: UITableView!
    @IBOutlet weak var accoladesView: UIView!
    
    
    // Bottom View Labels
    var currentBottomView = 1
    @IBOutlet weak var seasonView: UIView!
    @IBOutlet weak var statTypeLabel: UILabel!
    @IBOutlet weak var careerView: UIView!
    
    

    // Change Views when left arrow button is pressed
    @IBAction func leftArrowPressed(_ sender: Any) {
        
        if self.isRetired == false {
            if currentBottomView == 1 {
                currentBottomView = 3
            }
            else{
                currentBottomView -= 1
            }
            if self.isRetired == false {
                setView(currentView: currentBottomView, direction: "Right")
            }
        }
        
        if self.isRetired == true {
            
            if currentBottomView == 2 {
                currentBottomView = 3
            }else {
                
                currentBottomView = 2
            }
        }
        setView(currentView: currentBottomView, direction: "Right")
        
    }
    // Change Views when right arrow button is pressed
    @IBAction func rightArrowPressed(_ sender: Any) {
    
        if self.isRetired == false {
            if currentBottomView == 3 {
                currentBottomView = 1
            }
            else{
                currentBottomView += 1
            }
        }
        
        if self.isRetired == true {
            
            if currentBottomView == 2 {
                currentBottomView = 3
            }
            else {
                currentBottomView = 2
            }
            
            
        }
        
        setView(currentView: currentBottomView, direction: "Left")
        
        
    }
    // MARK:- END: OUTLETS
    
    // MARK: - Helper Function to Set Correct View
    func setView(currentView: Int,direction:String) {
        
        if currentView == 1 {
            
            
            careerView.isHidden = true
            accoladesView.isHidden = true
            seasonView.isHidden = false
            seasonView.alpha = 0
            statTypeLabel.text = "Season Stats"
            statTypeLabel.alpha = 0
            
            //  UI View animation to change to the final state of the cell
            UIView.animate(withDuration: 0.4, delay: 0, options: .transitionCurlUp) {
                self.seasonView.alpha = 1
                self.statTypeLabel.alpha = 1
            
            }

        
            
        }
        
        
        if currentView == 2{
            statTypeLabel.alpha = 0
            statTypeLabel.text = "Career Stats"
            careerView.isHidden = false
            seasonView.isHidden = true
            accoladesView.isHidden = true
            careerView.alpha = 0
            
            UIView.animate(withDuration: 0.4) {
                self.careerView.alpha = 1
                self.statTypeLabel.alpha = 1

            }

            
            
        }

        if currentView == 3{
            
            statTypeLabel.alpha = 0
            statTypeLabel.text = "Accolades"
            careerView.isHidden = true
            seasonView.isHidden = true
            accoladesView.isHidden = false
            accoladesView.alpha = 0
            
            UIView.animate(withDuration: 0.4) {
                self.accoladesView.alpha = 1
                self.statTypeLabel.alpha = 1

            
            }

        }
        pageControl.currentPage = Int(currentView-1)
        
        if self.isRetired {
            

            
            if currentView == 3 {
                pageControl.currentPage = 1
            }
            if currentView == 2 {
                pageControl.currentPage = 0
            }
            
        }
    }
    
    
    
    
    
    // MARK: - Helper Function to Get Data
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }


    // MARK: - Helper Function to Download Image
    func downloadImage(from url: URL) throws {
        
        
        
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.playerImage.image = UIImage(data: data)
        
            }
        }
    }
    
    // Handles Swipe on Botton View
    @objc func handleSwipe(sender: UISwipeGestureRecognizer){
        
        if sender.state == .ended {
            switch sender.direction {
            case .right:
            
                if self.isRetired == false {
                    if currentBottomView == 1 {
                        currentBottomView = 3
                    }
                    else{
                        currentBottomView -= 1
                    }
                    if self.isRetired == false {
                        setView(currentView: currentBottomView,direction: "Right")
                    }
                }
                
                if self.isRetired == true {
                    
                    if currentBottomView == 2 {
                        currentBottomView = 3
                    }else {
                        
                        currentBottomView = 2
                    }
                }
                setView(currentView: currentBottomView,direction: "Left")

                
            case .left:
            
                if self.isRetired == false {
                    if currentBottomView == 3 {
                        currentBottomView = 1
                    }
                    else{
                        currentBottomView += 1
                    }
                }
                
                if self.isRetired == true {
                    
                    if currentBottomView == 2 {
                        currentBottomView = 3
                    }
                    else {
                        currentBottomView = 2
                    }
                    
                    
                }
                
                setView(currentView: currentBottomView, direction: "Left")
            default:
                break
            }
            
        }
        
    }
    
    
   // MARK:- START: VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Making Views Skeletonable
        activityIndicator.isHidden = true
        pageControl.isSkeletonable = true
        statsButton.isSkeletonable = true
        playerInfoLabel.isSkeletonable = true
        teamNameLabel.isSkeletonable = true
        playerImage.isSkeletonable = true
        twitterImage.isSkeletonable = true
        youtubeButton.isSkeletonable = true
        topView.isSkeletonable = true
        accoladesView.isSkeletonable = true
        careerView.isSkeletonable = true
        singleView.isSkeletonable = true
        seasonView.isSkeletonable = true
        LabelStackView.isSkeletonable = true
        editableStackView.isSkeletonable = true
        statTypeLabel.isSkeletonable = true
        pageControl.showAnimatedSkeleton(usingColor: .skeletonDefault, animation: .none, transition: .crossDissolve(0.5))
        view.showAnimatedSkeleton(usingColor: .skeletonDefault, animation: .none, transition: .crossDissolve(0.5))
        playerInfoLabel.showAnimatedSkeleton(usingColor: .skeletonDefault, animation: .none, transition: .crossDissolve(0.5))
        teamNameLabel.showAnimatedSkeleton(usingColor: .skeletonDefault, animation: .none, transition: .crossDissolve(0.5))
        fullNameLabel.showAnimatedSkeleton(usingColor: .skeletonDefault, animation: .none, transition: .crossDissolve(0.5))
        statsButton.showAnimatedSkeleton(usingColor: .skeletonDefault, animation: .none, transition: .crossDissolve(0.5))
        twitterImage.showAnimatedSkeleton(usingColor: .skeletonDefault, animation: .none, transition: .crossDissolve(0.5))
        youtubeButton.showAnimatedSkeleton(usingColor: .skeletonDefault, animation: .none, transition: .crossDissolve(0.5))
        playerImage.showAnimatedSkeleton(usingColor: .skeletonDefault, animation: .none, transition: .crossDissolve(0.5))
        fullView.showAnimatedSkeleton(usingColor: .skeletonDefault, animation: .none, transition: .crossDissolve(0.5))
        accoladesView.showAnimatedSkeleton(usingColor: .skeletonDefault, animation: .none, transition: .crossDissolve(0.5))
        careerView.showAnimatedSkeleton(usingColor: .skeletonDefault, animation: .none, transition: .crossDissolve(0.5))
        singleView.showAnimatedSkeleton(usingColor: .skeletonDefault, animation: .none, transition: .crossDissolve(0.5))
        seasonView.showAnimatedSkeleton(usingColor: .skeletonDefault, animation: .none, transition: .crossDissolve(0.5))
        LabelStackView.showAnimatedSkeleton(usingColor: .skeletonDefault, animation: .none, transition: .crossDissolve(0.5))
        editableStackView.showAnimatedSkeleton(usingColor: .skeletonDefault, animation: .none, transition: .crossDissolve(0.5))
        statTypeLabel.showAnimatedSkeleton(usingColor: .skeletonDefault, animation: .none, transition: .crossDissolve(0.5))
        
        // Adding Swipe Gesture Recognizers
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        leftSwipe.direction = .left
        
        let rightSwipe2 = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        let leftSwipe2 = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        leftSwipe2.direction = .left
        
        let rightSwipe3 = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        let leftSwipe3 = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        leftSwipe3.direction = .left
        
        seasonView.addGestureRecognizer(rightSwipe)
        seasonView.addGestureRecognizer(leftSwipe)
        
        careerView.addGestureRecognizer(rightSwipe2)
        careerView.addGestureRecognizer(leftSwipe2)
        
        accoladesView.addGestureRecognizer(rightSwipe3)
        accoladesView.addGestureRecognizer(leftSwipe3)
        
        

        // Setting Labels + Images
        twitterImage.setImage(UIImage(named: "twitterLogo"), for: .normal)
        Constants.playerName = strPlayerName
        Constants.teamName = teamNameLabel.text!
        
        //Hiding Background Views
        seasonView.isHidden = true
        careerView.isHidden = true
        accoladesView.isHidden = true
         if self.isRetired == false {
         careerView.isHidden = true
         seasonView.isHidden = false
             
         pageControl.numberOfPages = 3
         statTypeLabel.text = "Season Stats"
         }
         
         if self.isRetired {
             pageControl.numberOfPages = 2
         }
         
        
        // Setting PlayerInfoViewController as delegate for TableViewController
        accoladesTable.delegate = self
        accoladesTable.dataSource = self
        

        // Do any additional setup after loading the view.
        whiteBackground.layer.cornerRadius = 8
        whiteBackground.layer.borderColor = UIColor.black.cgColor
        whiteBackground.layer.borderWidth = 2
        whiteBackground2.layer.cornerRadius = 8
        whiteBackground2.layer.borderColor = UIColor.black.cgColor
        whiteBackground2.layer.borderWidth = 2
        whiteBackground3.layer.cornerRadius = 8
        whiteBackground3.layer.borderColor = UIColor.black.cgColor
        whiteBackground3.layer.borderWidth = 2
        
        playerImage.layer.borderWidth = 2
        playerImage.layer.borderColor = UIColor.black.cgColor
        playerImage.layer.masksToBounds = false
        playerImage.layer.borderColor = UIColor.black.cgColor
        playerImage.layer.cornerRadius = 50
        playerImage.clipsToBounds = true
        playerInfoLabel.text = strPlayerName.replacingOccurrences(of: "*", with: "")
        
        
        
                
        
        //MARK:- START: Define API Call + Organize Data in a needed form
        let playerName = strPlayerName.lowercased().replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "*", with: "")
        let urlString = Constants.baseURL + "player/information?name=" + playerName
        guard let url = URL(string:urlString) else {return }
        
        let task = URLSession.shared.dataTask(with: url) {(data,response, error) in
            guard let dataResponse = data,
                error == nil else{
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: .allowFragments)
                
                
                
                                
                if let json = jsonResponse as? [String:Any]  {
                    
                    
                    
                    self.arrData = json
                    var imageURL = URL(string: "")
                    let secondaryImageURL = URL(string: "\(Constants.baseURL)player/image?name=\(playerName)")
                    
                    for (key,value) in json {
                        
                        if key == "Season" {
                            
                            
                            
                            DispatchQueue.main.async {
                                var counter = 0
                                var blankcounter = 0
                                for item in (value as! NSArray) {
                                    
                                    counter += 1
                                    
                                    
                                    if item as! String == "" {
                                        blankcounter += 1
                                    }
                                    
                                    if blankcounter > 2 {
                                        
                                        self.isRetired = true
                                        self.pageControl.numberOfPages = 2
                                        self.statTypeLabel.text = "Career Stats"
                                        self.currentBottomView = 2
                                        
                                        self.seasonView.isHidden = true
                                        self.careerView.isHidden = false
                                    }
                                
                                
                                    
                                
                                    switch counter {
                                    case 1:
                                        self.GLabel.text = item as? String
                                    case 2:
                                        self.PTSLabel.text = item as? String
                                    case 3:
                                        self.REBLabel.text = item as? String
                                    case 4:
                                        self.ASTLabel.text = item as? String
                                    case 5:
                                        self.FGLabel.text = item as? String
                                    case 6:
                                        self.ThreeFGLabel.text = item as? String
                                    case 7:
                                        self.FTLabel.text = item as? String
                                    case 8:
                                        self.eFGLabel.text = item as? String
                                    case 9:
                                        self.PERLabel.text = item as? String
                                    case 10:
                                        self.WSLabel.text = item as? String
                                    default:
                                        print("ERROR : Line 186")
                                    }
                                    
                                }
                            }
                            
                        }
                        if key == "Career" {
                            
            
                            
                            DispatchQueue.main.async {
                                var counter = 0
                                for item in (value as! NSArray) {
                                    
                                    counter += 1
                                    print(item)
                                
                                
                                    
                                
                                    switch counter {
                                    case 1:
                                        self.CGLabel.text = item as? String
                                    case 2:
                                        self.CPTSLabel.text = item as? String
                                    case 3:
                                        self.CREBLabel.text = item as? String
                                    case 4:
                                        self.CASTLabel.text = item as? String
                                    case 5:
                                        self.CFGLabel.text = item as? String
                                    case 6:
                                        self.C3FGLabel.text = item as? String
                                    case 7:
                                        self.CFTSLabel.text = item as? String
                                    case 8:
                                        self.CeFGLabel.text = item as? String
                                    case 9:
                                        if item as? String != nil {
                                            self.CPERLabel.text = item as? String
                                        }
                                        else{
                                            self.CPERLabel.text = "N/A"
                                        }
                                    case 10:
                                        if item as? String != nil {
                                            self.CWSLabel.text = item as? String
                                        }
                                        else{
                                            self.CWSLabel.text = "N/A"
                                        }
                                    default:
                                        print("ERROR : Line 186")
                                    }
                                    
                                }
                            }
                            
                        }
                        if key == "ImageURL" {
                            imageURL = URL(string: value as? String ?? "https://via.placeholder.com/150" )
                            
                            
                        }
                        
                    // Set the text labels here
                        if key == "Fullname" {
                            
                            
                            DispatchQueue.main.async {
                                
                                let valueString = value as! String
                                self.fullNameLabel.text = valueString.replacingOccurrences(of: "  ", with: "")
                                
                                
                            }
                        }
                        
                        if key == "Position" {
                            
                            DispatchQueue.main.async {
                                var valueString = value as? String
                                valueString = valueString?.replacingOccurrences(of: "Point Guard", with: "PG")
                                valueString = valueString?.replacingOccurrences(of: "Shooting Guard", with: "SG")
                                valueString = valueString?.replacingOccurrences(of: "Small Forward", with: "SF")
                                valueString = valueString?.replacingOccurrences(of: "Power Forward", with: "PF")
                                
                                self.positonLable.text = valueString!.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "and", with: ", ")
                                
                            }
                            
                        }
                        
                        if key == "DOB" {
                            
                            let valueString = value as? String
                            
                            let ArrayOfValueString = valueString?.components(separatedBy: " ")
                            var dobString = ""
                            var pobString = ""
                            
                            var dobStringTurn = true
                            for word in ArrayOfValueString! {
                                
                                if dobStringTurn {
                                    if word != "in"
                                    {
                                        dobString += " \(word) "
                                        
                                    }
                                    
                                }
                                else {
                                    if word != "in"
                                    {
                                        pobString += " \(word) "
                                        
                                    }
                                }
                                
                                if word == "in" {
                                    dobStringTurn = false
                                }
                                
                                
                                
                            }
                            dobString = dobString.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: "   ", with: " ").replacingOccurrences(of: "  ", with: " ")
                            
                            
                            pobString = pobString.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: "   ", with: " ").replacingOccurrences(of: "  ", with: " ")
                            
                            
                            DispatchQueue.main.async {
                            
                                self.dobLabel.text = dobString
                                self.pobLabel.text = pobString
                            }
                            
                            
                            
                        }
                        if key == "Measurements" {
                            
                            DispatchQueue.main.async {
                                
                                let valueString = value as! String
                                self.measurementsLabel.text = valueString.trimmingCharacters(in: .whitespaces)
                                
                            }
                            
                        }
                        
                        if key == "Experience" {
                            
                            DispatchQueue.main.async {
                                
                                let valueString = value as! String
                                if valueString != ""{
                                    self.experienceLabel.text = valueString.trimmingCharacters(in: .whitespaces)
                                }
                                else{
                                    self.experienceLabel.text = "N/A"
                                }
                                

                            }
                            
                        }
                        if key == "College" {
                            DispatchQueue.main.async {
                                                            
                                let valueString = value as! String
                                if valueString != ""{
                                    self.collegeLabel.text = valueString
                                }
                                else{
                                    self.collegeLabel.text = "N/A"
                                    
                                    
                                }

                            }
                        }
                        
                        if key == "Team" {
                            
                            DispatchQueue.main.async {
                                
                                
                                
                                let valueString = value as! String
                                if valueString != "" {
                                
                                self.teamNameLabel.text = value as? String
                                    self.backGround.image = UIImage(named: (value as? String)?.replacingOccurrences(of: " ", with: "") ?? "NBA-2")
                                    
                                }
                                else {
                                    self.teamNameLabel.text = "Retired/FA"
                                    self.isRetired = true
                                    self.backGround.image = UIImage(named: "NBA-2")
                                    
                                }
                                
                                Constants.teamName = self.teamNameLabel.text!
                            }
                                
                            
                        }
                        
                        if key == "Accolades" {
                            
                            
                            self.accolades = value as! [String]
                            
                            
                            DispatchQueue.main.async {
                                var counter = 0
                                for _ in (value as! NSArray) {
                                    
                                    counter += 1
                                    
                                }
                                
                                self.accoladesTable.reloadData()
                        }
                           
                            
                        }
                        
                        if key == "Twitter" {
                            
                            
                            self.strTwitterURL = value as? String ?? "N/A"
                            
                            


                            if self.strTwitterURL == "" || self.strTwitterURL == "N/A" {
                                
                                DispatchQueue.main.async {
                                    
                                    self.twitterImage.isHidden = true
                                }
                                
                                
                                

                                
                            }
                            
                            
                            
                        }
                        

                        Constants.teamName = self.teamNameLabel.text!
                        Constants.playerName = self.strPlayerName
                        
                    }
                    
                    do
                    {
                        
                        
                        
                        try self.downloadImage(from: ((imageURL ?? secondaryImageURL!) )!)
                    }
                    catch {
                        
                    }
                    
                }
                else {
                    
                    
                }
                
            } catch let parsingError {
                print("Error", parsingError)
            }
            
            //MARK:- END: Define API Call + Organize Data in a needed form
            
            //Make changes asynchronously
            DispatchQueue.main.async {
                
               
                
                self.statsButton.hideSkeleton()
                self.playerInfoLabel.hideSkeleton()
                self.teamNameLabel.hideSkeleton()
                self.twitterImage.hideSkeleton()
                self.youtubeButton.hideSkeleton()
                self.playerImage.hideSkeleton()
                self.LabelStackView.hideSkeleton()
                self.editableStackView.hideSkeleton()
                self.careerView.hideSkeleton()
                self.seasonView.hideSkeleton()
                self.accoladesView.hideSkeleton()
                self.statTypeLabel.hideSkeleton()
                self.pageControl.hideSkeleton()
                
                self.playerImage.layer.borderWidth = 2
                self.playerImage.layer.borderColor = UIColor.black.cgColor
                self.playerImage.layer.masksToBounds = false
                self.playerImage.layer.borderColor = UIColor.black.cgColor
                self.playerImage.layer.cornerRadius = 50
                self.playerImage.clipsToBounds = true
                
                
            }
            
            
        }
        
        //MARK: MAKE THE API CALL
        task.resume()
        
            
        }
        
   
    //MARK: START: Required Methods for tableView Protocol
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let answer = self.accolades.count
        return(answer)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "accoladesCell", for: indexPath)
        cell.textLabel!.text = self.accolades[indexPath.row]
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        return(cell)
    }
    //MARK: END: Required Methods for tableView Protocol
    
    // MARK:- START: Function to put StatsList in order by years
    func putInOrder(statsArrayDict: [String:Any]) -> [String] {
        
        var intKeys:[Int] = []
        var strKeys:[String] = []
        var finalKeys:[String] = []
        for (key,_) in statsArrayDict {
            
            if key.contains("season") == false && key != "Legend" && key != "Career" && key != "Season" && key.contains("Season") == false {
                
                intKeys += [Int(key.prefix(4))!]
            }
            else if key != "Legend" && key != "Career" && key != "Season"{
                strKeys += [key]
                
            }
            
            
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
    // MARK:- END: Function to put StatsList in order of years
    
    
    
    
    

    //MARK: START: Function to get full stats for new VC + present new VC
    @IBAction func statsButtonPressed(_ sender: Any) {
        
        self.pageControl.isHidden = true
        self.dimmedBG.isHidden = false
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.startAnimating()
        self.activityIndicator.center = self.view.center
        self.activityIndicator.isHidden = false

        
    
    
    
    // Setting and formatting the baseURL
    let statsURL = Constants.baseURL + "/player/stats?name=\(self.playerName.lowercased().replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "*", with: ""))&type=\(self.statsType[statsTypeCounter].lowercased().replacingOccurrences(of: " ", with: ""))"
    
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
                
                self.statTo = statToPost
                
                
    
            }
            else{
                // statsArray failed to initialize
                
            }
        }
        
        catch {
            
            print("JSON SERIALIZATION ERROR", error)
        }
        
        
        DispatchQueue.main.async {
            //MARK: PRESENT NEW VC
            presentingNewVC(statTo: statTo)
            
            
        }
        
        
    }// End Task Declaration
    task.resume()
        
        
        
        
    }
    //MARK: END: Function to get full stats for new VC + present new VC
    
    
    // Function to present new VC
    func presentingNewVC(statTo: PlayerStatModel) {
        let vc = self.storyboard?.instantiateViewController(identifier: "SpreadSheetViewController") as! SpreadSheetViewController
        
        vc.currentStatsDict = self.currentStatsDict
        vc.playerName = self.playerName
        vc.data = statTo.statAsList
        vc.header = statTo.legend
        vc.isModalInPresentation = true
        vc.view.backgroundColor = UIColor.gray
        self.present(vc, animated: true) {
            vc.presentationController?.presentedView?.gestureRecognizers?[0].isEnabled = false
            self.dimmedBG.isHidden = true
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            
            vc.setChart(yearStart: 0, column: vc.data[0].count-1)
            
        }
        
        
    }


    
    
    }



    

    


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */





