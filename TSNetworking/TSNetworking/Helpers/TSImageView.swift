//
//  TSImageView.swift
//  TSNetworking
//
//  Created by TARUN SHARMA on 17/12/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

import UIKit

/*!
* @discussion Helper image view class to load image asyncronously
*/

open class TSImageView: UIImageView {
    
    fileprivate var indicatorView:UIActivityIndicatorView?
    
    public override init (frame : CGRect) {
        super.init(frame : frame)
        initializeWithIndicator()
    }
    
    public convenience init () {
        self.init(frame:CGRect.zero)
        initializeWithIndicator()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeWithIndicator()
    }
    
    public convenience init (frame : CGRect, imageUrl url:String) {
        self.init(frame: frame);
        initializeWithIndicator()
        loadImageFromNetwork(withUrl: url)
    }
    
    public convenience init (frame : CGRect, imageUrl url:String, placeholderImage placeholder:UIImage) {
        self.init(frame: frame);
        initializeWithIndicator()
        loadImageFromNetwork(withUrl: url)
    }
    
    open func initializeWithIndicator(){
        indicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        indicatorView!.stopAnimating()
        self.addSubview(indicatorView!)
    }
    
    open func setImageUrl(imageUrl url:String){
        loadImageFromNetwork(withUrl: url);
    }
    
    open func setImageUrl(imageUrl url:String, placeholderImage placeholder:UIImage){
        self.image = placeholder;
        loadImageFromNetwork(withUrl: url)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.indicatorView?.center = self.convert(self.center, from: self.superview)

    }
    
    fileprivate func loadImageFromNetwork(withUrl url:String){
        DispatchQueue.main.async(execute: { () -> Void in
            self.indicatorView?.startAnimating()
        });
        
        do{
            let request = try TSNetworking.sharedInstance.createRequest(fromUrl: url, method: NetworkRequestMethod.GET, data: nil)
            
            _ = try TSNetworking.sharedInstance.fetchContentData(withRequest: request!) { (data, error) -> Void in
                if let rawData = data as? Data {
                    if let img:UIImage = UIImage(data: rawData){
                        // do whatever with jsonResult
                        DispatchQueue.main.async(execute: { () -> Void in
                            self.image = img;
                            self.indicatorView?.stopAnimating()
                        });
                    }
                }
                
            }
        }catch {
            print("Eror fetching for image:")
        }
    }

}
