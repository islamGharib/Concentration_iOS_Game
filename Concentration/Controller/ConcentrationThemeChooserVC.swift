//
//  ConcentrationThemeChooserVC.swift
//  Concentration
//
//  Created by Islam Gharib on 3/3/19.
//  Copyright © 2019 Gharib. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserVC: UIViewController, UISplitViewControllerDelegate {

    let themes = [
        "Sports":"⚽️🏀🏈⚾️🎾🏐🏉🎱🏓🏸🏄‍♂️",
        "Animals":"🐶🐱🐭🐹🐰🦊🐻🐼🙈🐔🐮",
        "Faces":"😀😃😅😂😇😍😎😡😱🤫"
    ]
    
    // display this VC (Details) before the Concentration game (specify the theme first)
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let dist = secondaryViewController as? ConcentrationVC{
            if dist.theme == nil{
                return true
            }
        }
        return false
    }
    
    // move to the Concentration game and change the theme
    @IBAction func changeTheme(_ sender: Any) {
        // in case of continue the game using landscape ipade or iphone plus
        if let dist = splitViewDetailConcentrationVC{
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName]{
                dist.theme = theme
            }
            // in case of continue the game using other devices
        }else if let dist = lastSeguedToConcentrationVC{
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName]{
                dist.theme = theme
            }
            navigationController?.pushViewController(dist, animated: true)
            // print("Islam")
        }else{  // in case of starting the game
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
       
    }
    // this var save the last game of the landscape ipad or iphone plus(using the split VC)
    private var splitViewDetailConcentrationVC:ConcentrationVC?{
        return splitViewController?.viewControllers.last as? ConcentrationVC
    }
    // this var save the last game of the other devices(using the segue)
    private var lastSeguedToConcentrationVC:ConcentrationVC?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme"{
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName]{
                if let dist = segue.destination as? ConcentrationVC{
                    dist.theme = theme
                    lastSeguedToConcentrationVC = dist
                }
            }
        }
        
    }
}
