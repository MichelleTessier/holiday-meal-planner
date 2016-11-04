//
//  AppInterfaceVC.swift
//  HolidayMealPlanner
//
//  Created by Michelle Tessier on 11/3/16.
//  Copyright © 2016 Michelle Tessier. All rights reserved.
//

import UIKit

class AppInterfaceVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        showWelcomeVC()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showWelcomeVC() {
        
        if let welcomeVC = UIStoryboard.init(name: "SignUp", bundle: nil).instantiateInitialViewController() {
            
            switchRootVC(toViewController: welcomeVC)
            
        } else {
            
            print("could not load welcome vc")
        }
        
        
        
    }
    
    func showTabController() {
        
        //Create tab bar controller
        let mainTabBarController = UITabBarController.init()
        
        //Initialize child view controllers
        
        if let guestsNavController = UIStoryboard.init(name: "Guests", bundle: nil).instantiateInitialViewController(), let recipesNavController = UIStoryboard.init(name: "Recipes", bundle: nil).instantiateInitialViewController(), let menuNavController = UIStoryboard.init(name: "Menu", bundle: nil).instantiateInitialViewController() {
            
            mainTabBarController.setViewControllers([guestsNavController, recipesNavController, menuNavController], animated: false)
            
    
            //Add tab controller as child vc
            
            switchRootVC(toViewController: mainTabBarController)
            
            
        } else {
            
            print("could not load one of the tab bar controllers child vcs")
        }
 
        
    }
    
    func switchRootVC(toViewController: UIViewController) {
        
        //See if there's a current root view controller
        
        if self.childViewControllers.count > 0 {
            
            //Prepare for transition
            let currentRootVC = self.childViewControllers[0]
            
            currentRootVC.willMove(toParentViewController: nil)
            addChildViewController(toViewController)
          
            toViewController.view.frame = CGRect.init(x: view.frame.width, y: 0 , width: view.frame.width, height: view.frame.height)
            view.addSubview(toViewController.view)
            
            //Transition
            transition(from: currentRootVC, to: toViewController, duration: 0.25, options: .curveLinear, animations: {
                
                currentRootVC.view.frame = CGRect.init(x: -currentRootVC.view.frame.width, y: 0 , width: currentRootVC.view.frame.width, height: currentRootVC.view.frame.height)
                
                toViewController.view.frame = self.view.bounds
              
                }, completion: { (finished) in
                    
                    if finished {
                        
                        //Finish transition
                        currentRootVC.removeFromParentViewController()
                        currentRootVC.didMove(toParentViewController: nil)
                        toViewController.didMove(toParentViewController: self)
                        
                    }
                    
                    
            })
            
            
        } else {
            
            //Otherwise, just add the new VC
            
            addChildViewController(toViewController)
            toViewController.view.frame = self.view.bounds
            self.view.addSubview(toViewController.view)
            toViewController.didMove(toParentViewController: self)
            
        }
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
