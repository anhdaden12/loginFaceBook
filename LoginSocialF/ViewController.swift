//
//  ViewController.swift
//  LoginSocialF
//
//  Created by Apple on 11/1/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit
import FacebookCore

class ViewController: UIViewController {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet var lblName: UILabel!
    
    @IBOutlet weak var lblID: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoginButton()
        
//        lblName.text = "Name: (Empty)"
        
//        let logged = AccessToken.isCurrentAccessTokenActive
        
        //check if user logged or not log
        if AccessToken.current != nil {
            print("da dang nhap")
            fetchUserProfile()
        } else {
            print("chua dang nhap")
        }
    
    }

    
    fileprivate func setupLoginButton() {
          let fbButton = FBLoginButton(permissions: [ .publicProfile , .email , .userFriends])
          //        fbButton.center = self.view.center
          self.view.addSubview(fbButton)
          fbButton.translatesAutoresizingMaskIntoConstraints = false
          fbButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
          fbButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
          fbButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
          fbButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        
        fbButton.addTarget(self, action: #selector(fetchUserProfile), for: .touchUpInside)
      }

    @objc func fetchUserProfile(){
        
        //doing to get user data
        let graphReqquest: GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "id, email, name, picture.width(480).height(480)"])
        
        graphReqquest.start { (connection, result, error) in
            if ((error) != nil) { // neu co loi
                print("Error took place : \(error)")
            } else {
                print("Ket qua nhan duoc la: \(result)")
                
                for (key, value) in (result as? Dictionary<String, AnyObject>)! {
                  //  print("key: \(key), value: \(value)")
                
                    switch key {
                    case "name":
                        self.lblName.text = "FB Name: \(value as! String)"
                    case "id":
                        self.lblID.text = "FB ID: \(value as! String)"
                    case "picture":
                        print(value)
                    default:
                        return
                    }
                }
            }
        }
    }
    
    



}
