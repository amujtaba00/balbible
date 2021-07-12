//
//  playerNames.swift
//  BasketballBible
//
//  Created by Muji on 2020-08-19.
//  Copyright © 2020 Muji. All rights reserved.
//

/**
 Some Constants that are needed throughout
 */
import Foundation

struct Constants {
    
    static var baseURL = "http://127.0.0.1:5000/"
    
    static var playerName = ""
    static var teamName = ""
    static var currentStatArray = ["1","2","3","4","5","6","7","8","9","1","2","3","4","5","6","7","8","9"]
    
    
    /*
     Pattern Match of Explanation of Statistics
     "XXX":"{FullForm}---{Simple Explanation}---{Link}---{Formula}"
    
     */
    static var perGamestatsExplained = [
        0:"Year--- --- --- ---",
        1:"Age--- --- --- ---",
        2:"Team--- --- --- ---",
        3:"League--- --- --- ---",
        4:"Position--- --- --- ---",
        5:"Games Played--- --- --- ---",
        6:"Games Started--- --- --- ---",
        7:"Minutes Played--- --- --- ---",
        8:"Field Goals--- --- --- ---",
        9:"Field Goals Attempted--- --- --- ---",
        10:"Field Goals Percentage--- --- --- ---",
        11:"Three Points Shot--- --- --- ---",
        12:"Three Points Attempted--- --- --- ---",
        13:"Three Point Percentage--- --- --- ---",
        14:"Two Points Shot--- --- --- ---",
        15:"Two Points Attempted--- --- --- ---",
        16:"Two Point Percetage--- --- --- ---",
        17:"Effective Field Goal Percentage--- --- --- EFG% = (2Pt + 1.5 x 3Pt) / FGA",
        18:"Free Throws Shot--- --- --- ---",
        19:"Free Throws Attempted--- --- --- ---",
        20:"Free Throws Percetage--- --- --- ---",
        21:"Offensive Rebounds--- --- --- ---",
        22:"Defensive Rebounds--- --- --- ---",
        23:"Total Rebounds--- --- --- ---",
        24:"Assists--- --- --- ---",
        25:"Steals--- --- --- ---",
        26:"Blocks--- --- --- ---",
        27:"Turnovers--- --- --- ---",
        28:"Personal Fouls--- --- --- ---",
        29:"Points--- --- --- ---",
        ]
    
    //MARK:- TOTALS

    
    static var totalStatsExplained = [
        0:"Year--- --- --- ---",
        1:"Age--- --- --- ---",
        2:"Team--- --- --- ---",
        3:"League--- --- --- ---",
        4:"Position--- --- --- ---",
        5:"Games Played--- --- --- ---",
        6:"Games Started--- --- --- ---",
        7:"Minutes Played--- --- --- ---",
        8:"Field Goals--- --- --- ---",
        9:"Field Goals Attempted--- --- --- ---",
        10:"Field Goals Percentage--- --- --- ---",
        11:"Three Points Shot--- --- --- ---",
        12:"Three Points Attempted--- --- --- ---",
        13:"Three Point Percentage--- --- --- ---",
        14:"Two Points Shot--- --- --- ---",
        15:"Two Points Attempted--- --- --- ---",
        16:"Two Point Percetage--- --- --- ---",
        17:"Effective Field Goal Percentage--- --- --- EFG% = (2Pt + 1.5 x 3Pt) / FGA",
        18:"Free Throws Shot--- --- --- ---",
        19:"Free Throws Attempted--- --- --- ---",
        20:"Free Throws Percetage--- --- --- ---",
        21:"Offensive Rebounds--- --- --- ---",
        22:"Defensive Rebounds--- --- --- ---",
        23:"Total Rebounds--- --- --- ---",
        24:"Assists--- --- --- ---",
        25:"Steals--- --- --- ---",
        26:"Blocks--- --- --- ---",
        27:"Turnovers--- --- --- ---",
        28:"Personal Fouls--- --- --- ---",
        29:"Points--- --- --- ---",
        30:" --- --- ---- ----",
        31:"Triple Doubles---A score in a basketball game of at least ten points, ten rebounds, and ten assists by a single player.--- --- ",
        ]
        
        

        //MARK:- Per 36
    static var per36Explained = [
        0:"Year--- --- --- ---",
        1:"Age--- --- --- ---",
        2:"Team--- --- --- ---",
        3:"League--- --- --- ---",
        4:"Position--- --- --- ---",
        5:"Games Played--- --- --- ---",
        6:"Games Started--- --- --- ---",
        7:"Minutes Played--- --- --- ---",
        8:"Field Goals--- --- --- ---",
        9:"Field Goals Attempted--- --- --- ---",
        10:"Field Goals Percentage--- --- --- ---",
        11:"Three Points Shot--- --- --- ---",
        12:"Three Points Attempted--- --- --- ---",
        13:"Three Point Percentage--- --- --- ---",
        14:"Two Points Shot--- --- --- ---",
        15:"Two Points Attempted--- --- --- ---",
        16:"Two Point Percetage--- --- --- ---",
        17:"Free Throws Shot--- --- --- ---",
        18:"Free Throws Attempted--- --- --- ---",
        19:"Free Throws Percetage--- --- --- ---",
        20:"Offensive Rebounds--- --- --- ---",
        21:"Defensive Rebounds--- --- --- ---",
        22:"Total Rebounds--- --- --- ---",
        23:"Assists--- --- --- ---",
        24:"Steals--- --- --- ---",
        25:"Blocks--- --- --- ---",
        26:"Turnovers--- --- --- ---",
        27:"Personal Fouls--- --- --- ---",
        28:"Points--- --- --- ---",
        ]
    
    //MARK:- Per 100 Poss
    
    static var per100PossExplained = [
        0:"Year--- --- --- ---",
        1:"Age--- --- --- ---",
        2:"Team--- --- --- ---",
        3:"League--- --- --- ---",
        4:"Position--- --- --- ---",
        5:"Games Played--- --- --- ---",
        6:"Games Started--- --- --- ---",
        7:"Minutes Played--- --- --- ---",
        8:"Field Goals--- --- --- ---",
        9:"Field Goals Attempted--- --- --- ---",
        10:"Field Goals Percentage--- --- --- ---",
        11:"Three Points Shot--- --- --- ---",
        12:"Three Points Attempted--- --- --- ---",
        13:"Three Point Percentage--- --- --- ---",
        14:"Two Points Shot--- --- --- ---",
        15:"Two Points Attempted--- --- --- ---",
        16:"Two Point Percetage--- --- --- ---",
        17:"Free Throws Shot--- --- --- ---",
        18:"Free Throws Attempted--- --- --- ---",
        19:"Free Throws Percetage--- --- --- ---",
        20:"Offensive Rebounds--- --- --- ---",
        21:"Defensive Rebounds--- --- --- ---",
        22:"Total Rebounds--- --- --- ---",
        23:"Assists--- --- --- ---",
        24:"Steals--- --- --- ---",
        25:"Blocks--- --- --- ---",
        26:"Turnovers--- --- --- ---",
        27:"Personal Fouls--- --- --- ---",
        28:"Points--- --- --- ---",
        29:"--- --- --- ---",
        30:"Offensive Rating---Team's points scored per 100 possessions while on court.--- ---",
        31:"Defensive Rating---Teams's points allowed per 100 possessions while on court.--- ---"
        ]
    
        
        //MARK:- Advanced
    
    static var advancedExplained = [
        0:"Year--- --- --- ---",
        1:"Age--- --- --- ---",
        2:"Team--- --- --- ---",
        3:"League--- --- --- ---",
        4:"Position--- --- --- ---",
        5:"Games Played--- --- --- ---",
        6:"Minutes Played--- --- --- ---",
        7:"Player Efficiency Rating--- The overall rating of a player's per-minute statistical production. The league average is 15.00 every season.--- https://www.basketball-reference.com/about/per.html---",
        8:"True Shooting Percentage--- Measures a player's efficiency at shooting the ball. 2PT,3PT and FT are taken individually---https://en.wikipedia.org/wiki/True_shooting_percentage---",
        9:"Three Pointed Rate---3PA per FGA--- --- ",
        10:"Free Throws Rate---FTA per FGA --- --- ",
        11:"Offensive Rebounding Percentage---ORB per Total Rebounds Available --- ---",
        12:"Defensive Rebounding Percentage---DRB per Total Rebounds Available --- --- ",
        13:"Total Rebounding Percentage---REB per Total Rebounds Available --- --- ",
        14:"Assist Percentage---Estimate of % of teammate FG assisted. --- https://www.basketball-reference.com/about/glossary.html#:~:text=Assist%20Percentage---100 * AST / (((MP / (Tm MP / 5)) * Tm FG) - FG).",
        15:"Steal Percentage--Estimate of % of opponent possessions that end with a steal by the player.---https://www.basketball-reference.com/about/glossary.html#:~:text=Steal%20Percentage--- 100 * (STL * (Tm MP / 5)) / (MP * Opp Poss)",
        16:"Block Percentage---Estimate of % of opponent 2PA that end with a block by the player.---https://www.basketball-reference.com/about/glossary.html#:~:text=Block%20Percentage--- 100 * (BLK * (Tm MP / 5)) / (MP * (Opp FGA - Opp 3PA))",
        17:"Turnover Percentage---Estimate of TOV per 100 plays.---https://www.basketball-reference.com/about/glossary.html#:~:text=Turnover%20Percentage--- 100 * TOV / (FGA + 0.44 * FTA + TOV)",
        18:"Usage Percentage---Estimate of % of team plays used by a player while he was on the floor.---https://www.basketball-reference.com/about/glossary.html#:~:text=Usage%20Percentage---100 * ((FGA + 0.44 * FTA + TOV) * (Tm MP / 5)) / (MP * (Tm FGA + 0.44 * Tm FTA + Tm TOV))",
        19:"--- --- --- ---",
        20:"Offensive Win Shares---Player Statistic that divys up credit to a player based on ORtg.---https://www.basketball-reference.com/about/ws.html#:~:text=Crediting%20Offensive%20Win%20Shares%20to%20Players---",
        21:"Defensive Win Shares---Player Statistic that divys up credit to a player based on DRtg.---https://www.basketball-reference.com/about/ws.html#:~:text=Crediting%20Defensive%20Win%20Shares%20to%20Players---",
        22:"Win Shares---Combines Offensive Win Shares and Defensive Win Shares---https://www.basketball-reference.com/about/ws.html#:~:text=Putting%20It%20All%20Together---OWS + DWS",
        23:"Win Shares per 48---Measures the efficiency of a player's contributions based on WS---https://www.sportsbettingdime.com/guides/how-to/nba-win-shares/#:~:text=when%20handicapping%20the%20potential%20impact%20of---48 * (WS / MP)",
        24: "--- --- --- ---",
        25:"Offensive Box Plus Minus---Estimates a player's offensive contribution to a team when on-court. League Average is defined as 0.0---https://www.basketball-reference.com/about/bpm2.html---",
        26:"Defensive Box Plus Minus---Estimates a player's defensive contribution to a team when on-court. League Average is defined as 0.0---https://www.basketball-reference.com/about/bpm2.html---",
        27:"Box Plus Minus---Estimates a player'scontribution to a team when on-court. League Average is defined as 0.0---https://www.basketball-reference.com/about/bpm2.html---",
        28:"Value Over Replacement Player---Estimates value of player over 82 games season using BPM---https://www.basketball-reference.com/about/glossary.html#:~:text=VORP%20%2D%20Value%20Over%20Replacement%20Player,to%20an%2082%2Dgame%20season.---[BPM - (-2.0)] * (% of possessions played) * (team games/82)",
        
    ]
//MARK:- ADJUSTED SHOOTING
    static var adjustedShootingExplained = [
        0:"Year--- --- --- ---",
        1:"Age--- --- --- ---",
        2:"Team--- --- --- ---",
        3:"League--- --- --- ---",
        4:"Position--- --- --- ---",
        5:"Games Played--- --- --- ---",
        6:"Minutes Played--- --- --- ---",
        7:"--- --- --- ---",
        8:"Field Goal Percentage--- --- --- ---",
        9:"Field Goal Percentage on 2 Point Attempts --- --- --- ---",
        10:"Field Goal Percentage on 3 Point Attempts --- --- --- ---",
        11:"Effective Field Goal Percentage--- --- --- EFG% = (2Pt + 1.5 x 3Pt) / FGA",
        12:"Free Throw Percentage --- --- --- ---",
        13:"True Shooting Percentage--- Measures a player's efficiency at shooting the ball. 2PT,3PT and FT are taken individually---https://en.wikipedia.org/wiki/True_shooting_percentage---",
        14:"Free Throws Per FG Attempt --- --- --- ---",
        15:"3-Point Attempts Per FG Attempt--- --- --- ---",
        16:"--- --- --- ---",
        17:"League Field Goal Percentage on FGA",
        18:"League Field Goal Percentage on 2 Point Attempts --- --- --- ---",
        19:"League Field Goal Percentage on 3 Point Attempts --- --- --- ---",
        20:"League Effective Field Goal Percentage--- --- --- EFG% = (2Pt + 1.5 x 3Pt) / FGA",
        21:"League Free Throw Percentage --- --- --- ---",
        22:"League True Shooting Percentage--- Measures a player's efficiency at shooting the ball. 2PT,3PT and FT are taken individually---https://en.wikipedia.org/wiki/True_shooting_percentage---",
        23:"League Free Throws Per FG Attempt --- --- --- ---",
        24:"League 3-Point Attempts Per FG Attempt",
        25:"--- --- --- ---",
        
        
        

        
        26:"Field Goal Percentage Added---Percentage of Players's FG% over League Average FG%. League Average is 100---N/A--- (Plyr FG% / Lg FG%) * 100",
        27:"Two Points Percentage Added---Percentage of Players's 2P% over League Average 2P%. League Average is 100---N/A--- (Plyr 2P% / Lg 2P%) * 100",
        28:"Three Points Percentage Added---Percentage of Players's 3P% over League Average 3P%. League Average is 100---N/A--- (Plyr 3P% / Lg 3P%) * 100",
        29:"Effective Field Goal Percentage Added---Percentage of Players's eFGP% over League Average eFGP%. League Average is 100---N/A--- (Plyr eFG% / Lg eFG%) * 100",
        30:"Free Throw Percentage Added---Percentage of Players's FT% over League Average FT%. League Average is 100---N/A--- (Plyr FT% / Lg FT%) * 100",
        31:"True Shooting Percentage Added---Percentage of Players's TS% over League Average TS%. League Average is 100---N/A--- (Plyr TS% / Lg TS%) * 100",
        32:"Free Throw Rate Percentage Added---Percentage of Players's FTr over League Average FTr. League Average is 100---N/A--- (Plyr FTr / Lg FTr) * 100",
        33:"Three Point Attempts Rate Percentage Added---Percentage of Players's 3PAr over League Average 3PAr. League Average is 100---N/A--- (Plyr 3PAr / Lg 3PAr) * 100",
        34:"--- --- --- ---",
        35:"Points Added By FG Shooting---Number of Points added or subtracted by making FGA compared to the league average---N/A---N/A",
        36:"Points Added By TS Shooting---Number of Points added or subtracted by making True Shot Attempts compared to the league average---N/A---N/A",
        ]
        
//MARK:- SHOOTING
        static var shootingExplained = [
        0:"Year--- --- --- ---",
        1:"Age--- --- --- ---",
        2:"Team--- --- --- ---",
        3:"League--- --- --- ---",
        4:"Position--- --- --- ---",
        5:"Games Played--- --- --- ---",
        6:"Minutes Played--- --- --- ---",
        7:"Field Goals Percentage--- --- --- ---",
        8:"Average Distance of FGA---N/A---N/A---N/A",
        9:"--- --- --- ---",
        10:"Percentage of FG that were 2PA---N/A---N/A---( 2PA / FGA )",
        11:"Percentage of FG from 0-3 Ft---N/A---N/A---N/A",
        12:"Percentage of FG from 3-10 Ft---N/A---N/A---N/A",
        13:"Percentage of FG from 10-16 Ft---N/A---N/A---N/A",
        14:"Percentage of FG from 16Ft to 3PT Line---N/A---N/A---N/A",
        15:"Percentage of FG that were 3PA---N/A---N/A---( 3PA / FGA )",
        16:"--- --- --- ---",
        17:"FG% on 2PA---N/A---N/A---( 2P / 2PA )",
        18:"FG% from 0-3 Ft---N/A---N/A---N/A",
        19:"FG% from 3-10 Ft---N/A---N/A---N/A",
        20:"FG% from 10-16 Ft---N/A---N/A---N/A",
        21:"FG% from 16Ft to 3PT Line---N/A---N/A---N/A",
        22:"FG% on 3PA---N/A---N/A---( 3P / 3PA )",
        23:"--- --- ---  ---",
        24:"Percentage of 2P that were assisted---N/A---N/A---N/A",
        25:"Percentage of 3P that were assisted---N/A---N/A---N/A",
        26:"--- --- ---  ---",
        27:"Percentage of 2PA that were dunks---N/A---N/A---N/A",
        28:"Number of Dunks---N/A---N/A---N/A",
        29:"--- --- ---  ---",
        30:"Percentage of 3PA that were from the corner---N/A---N/A---N/A",
        31:"3P% from the corner---N/A---N/A---N/A",
        32:"--- --- --- ---",
        33:"Heave Attempts at end of Shot Clock---N/A---N/A---N/A",
        34:"Heaves Made at end of Shot Clock---N/A---N/A---N/A",
        
    
    ]
    
    static var gameHighsExplained = [
        
        0:"Year --- --- --- ---",
        1:"Age --- --- --- ---",
        2:"Team --- --- --- ---",
        3:"League --- --- --- --- ",
        4:"Minutes Played--- --- --- ---",
        5:"Field Goals Made--- --- --- ---",
        6:"Field Goals Attempted--- --- --- ---",
        7:"3 Points Made--- --- --- ---",
        8:"3 Points Attempted--- --- --- ---",
        9:"2 Points Made--- --- --- ---",
        10:"2 Points Attempted--- --- --- ---",
        11:"Free Throws Points Made--- --- --- ---",
        12:"Free Throws Points Attempted--- --- --- ---",
        13:"Offensive Rebounds--- --- --- ---",
        14:"Defensive Rebounds--- --- --- ---",
        15:"Total Rebounds--- --- --- ---",
        16:"Assists--- --- --- ---",
        17:"Steals--- --- --- ---",
        18:"Blocks--- --- --- ---",
        19:"Turnovers--- --- --- ---",
        20:"Personal Fouls--- --- --- ---",
        21:"Points --- --- --- ---",
        22:"Game Score --- --- --- ---"
        
    ]
    
    static var playByPlayExplained = [
        0:"Year--- --- --- ---",
        1:"Age--- --- --- ---",
        2:"Team--- --- --- ---",
        3:"League--- --- --- ---",
        4:"Position--- --- --- ---",
        5:"Games Played--- --- --- ---",
        6:"Minutes Played--- --- --- ---",
        7:"Percentage of Minutes Played at PG--- --- --- ---",
        8:"Percentage of Minutes Played at SG--- --- --- ---",
        9:"Percentage of Minutes Played at SF--- --- --- ---",
        10:"Percentage of Minutes Played at PF--- --- --- ---",
        11:"Percentage of Minutes Played at C--- --- --- ---",
        12:"Plus-Minus While On Court--- --- --- ---",
        13:"(+/- On Court) - (+/- Off Court)--- --- --- ---",
        14:"Bad Pass Turnover--- --- --- ---",
        15:"Lost Ball Turnover--- --- --- ---",
        16:"Shooting Foul Commited--- --- --- ---",
        17:"Offensive Foul Commited--- --- --- ---",
        18:"Shooting Foul Drawn--- --- --- ---",
        19:"Offensive Foul Drawn--- --- --- ---",
        20:"Points Generated By Assists --- --- --- ---",
        21:"And 1's Drawn--- --- --- ---",
        22:"Shots Blocked--- --- --- ---",

    ]
}
