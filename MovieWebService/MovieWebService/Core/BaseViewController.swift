//
//  BaseViewController.swift
//  MovieWebService
//
//  Created by TARUN SHARMA on 11/03/17.
//  Copyright © 2017 Tarun Sharma. All rights reserved.
//

import Foundation
import UIKit

protocol BaseViewControllerProtocol{
    func showNetworkActivityIndicator()
    func hideNetworkActivityIndicator()
}

class BaseViewController: UIViewController,BaseViewControllerProtocol {
    
    private var vwActivityIndicator:UIView?
    private var activityIndicator:UIActivityIndicatorView?
    
    private let IndicatorViewWidth:CGFloat = 120
    private let IndicatorViewHeight:CGFloat = 80
    private let ActivityIndicatorViewSize:CGFloat = 35
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupActivityIndicator(){
        
        if (self.vwActivityIndicator != nil)
        {
            self.vwActivityIndicator?.removeFromSuperview()
            self.vwActivityIndicator = nil
        }
        
        let screenBounds:CGRect = UIScreen.main.bounds
        var xCordinate = screenBounds.size.width/2-IndicatorViewWidth/2
        var yCordinate = screenBounds.size.height/2-IndicatorViewHeight/2
        
        self.vwActivityIndicator = UIView(frame: CGRect(x:xCordinate, y:yCordinate, width:IndicatorViewWidth, height:IndicatorViewHeight))
        
        self.vwActivityIndicator?.backgroundColor = UIColor.black
        self.vwActivityIndicator?.alpha = 0.8
        self.vwActivityIndicator?.layer.borderColor = UIColor.white.cgColor
        self.vwActivityIndicator?.layer.borderWidth = 3.0
        self.vwActivityIndicator?.layer.cornerRadius = 5.0
        
        xCordinate = IndicatorViewWidth/2-ActivityIndicatorViewSize/2
        yCordinate = IndicatorViewHeight/2-ActivityIndicatorViewSize/2
        
        
        self.activityIndicator = UIActivityIndicatorView(frame: CGRect(x:xCordinate,y:yCordinate,width:ActivityIndicatorViewSize,height:ActivityIndicatorViewSize))
        self.vwActivityIndicator?.addSubview(self.activityIndicator!)
        self.activityIndicator?.startAnimating()
        
        self.activityIndicator?.accessibilityIdentifier = "LoadingIndicator"
        self.view.addSubview(self.vwActivityIndicator!)
    }
    
    func showNetworkActivityIndicator(){
        self.view.isUserInteractionEnabled = false
        setupActivityIndicator()
    }
    
    func hideNetworkActivityIndicator(){
        self.view.isUserInteractionEnabled = true
        self.vwActivityIndicator?.removeFromSuperview()
    }
    
    
}
