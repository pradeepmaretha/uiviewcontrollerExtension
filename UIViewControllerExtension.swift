//
//  UIViewControllerExtension.swift

//  Created by pradeep maretha on 13/06/20.
//  Copyright © 2020 pradeep maretha. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

extension UIViewController{
    

    typealias requiredData = (NSDictionary?, NSError?) -> ()
    
    func alert(message: String, title: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    func networkService(Param:[String:Any],url:String,header:HTTPHeaders,completionHandler: @escaping requiredData) {
        if Connectivity.isConnectedToInternet{
            
        let Url = apiURL.baseURL + url
        
            
            Alamofire.request(Url, method: .post, parameters: Param, encoding: URLEncoding.default, headers: header).responseJSON{
            (responseData) -> Void in
    
            
            print(Param)
            
            switch responseData.result {
                
            case .success(let JSON):
                DispatchQueue.main.async {
                completionHandler(JSON as? NSDictionary, nil)
                }
            case .failure(let error):
                
           //     hide Loader
                DispatchQueue.main.async {
                completionHandler(nil, error as NSError)
                }
                }
            }
        }else{
            
           alert(message: "please check your internet connection", title: "Network Error")
            
        }
    }
    
    
    func getNetworkService(Param:[String:String],url:String,header:HTTPHeaders,completionHandler: @escaping (NSDictionary?, NSError?) -> ()) {
    
        if Connectivity.isConnectedToInternet{
        
     //   showLoader(options: loaderOptions.shortText)
        
        let Url = apiURL.baseURL + url
        
        Alamofire.request(Url, method: .get, parameters: Param, encoding: URLEncoding.default, headers: header).responseJSON {
            (responseData) -> Void in

            
            print(Param)
            
            switch responseData.result {
                
            case .success(let JSON):
                
                completionHandler(JSON as? NSDictionary, nil)
                
            case .failure(let error):
               
                completionHandler(nil, error as NSError)
                
            }
            
        }
        
        }else{
            
            alert(message: "please check your internet connection", title: "Network Error")
            
        }
    }
    
    
    func ContactNetworkService(Param:[String:Any],url:String,header:HTTPHeaders,completionHandler: @escaping (NSDictionary?, NSError?) -> ()) {
        if Connectivity.isConnectedToInternet{
//            showLoader(options: loaderOptions.shortText)
            let Url = apiURL.baseURL + url
            
            
            Alamofire.request(Url, method: .post, parameters: Param, encoding: JSONEncoding.default, headers: header).responseJSON {
                (responseData) -> Void in

                
                print(Param)
                
                switch responseData.result {
                    
                case .success(let JSON):
                    
                    
                    
                    completionHandler(JSON as? NSDictionary, nil)
                    
                case .failure(let error):
                    
                    
                    completionHandler(nil, error as NSError)
                    
                }
            }
        }else{
            
            alert(message: "please check your internet connection", title: "Network Error")
            
        }
    }
   
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}


class Connectivity {
    
    class var isConnectedToInternet:Bool {
        
        return NetworkReachabilityManager()?.isReachable ?? false
    
    }
}
