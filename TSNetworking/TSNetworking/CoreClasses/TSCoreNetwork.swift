//
//  TSCoreNetwork.swift
//  TSNetworking
//
//  Created by TARUN SHARMA on 4/18/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

import UIKit

// MARK: - Exception Types -
enum NetworkCallAPIError: Error {
    case invalidURL
    case invalidRequest
    case invalidPostParameter
}

// MARK: - Callback methods -
protocol NetworkOperations {
    func didReceiveReposne(_ data: AnyObject?, forTaskIdentifer taskIdentifier:Int)
    func didReceiveError(_ error:Error, forTaskIdentifer taskIdentifier:Int)
}

// MARK: - Core netowrk class responsible to make api calls -
internal class TSCoreNetwork: NSObject {
    
    // MARK: - Private Member Variables -
    fileprivate var delegate : NetworkOperations?
    fileprivate var taskIdentifer : Int?
    
    // MARK: - Class methods -
    /*!
     * @discussion Constructer to initialize NetworkCalls object with delegate base url
     * @param _delegate: Callback delegate
     * @return instance of NetworkCalls
     */
    //Handle try catch to check if proper netowork object is formed
    init(delegate _delegate:NetworkOperations) {
        self.delegate = _delegate;
    }
    
    /*!
     * @discussion API call to fetch/post data
     * @param Request object of type NSMutableURLRequest
     * @return Instance of task
     */
    internal func dataAPIWithRequest(_ _req:TSRequest)-> URLSessionTask{
        
        let session = URLSession.shared
        let sessionConfig = session.configuration;
        sessionConfig.urlCache = URLCache.shared
        sessionConfig.requestCachePolicy = NSURLRequest.CachePolicy.returnCacheDataDontLoad
        
        var task:URLSessionTask?
        
        task =  session.dataTask(with: _req.request!, completionHandler: { ( data: Data?, response: URLResponse?, err: Error?) -> Void in
            
            self.taskIdentifer = task!.taskIdentifier
            
            //if error found then return to delegate
            if (err != nil){
                self.delegate!.didReceiveError(err!,forTaskIdentifer: self.taskIdentifer!);
                return;
            }
            
            do {
                //Handle generic error recieved from status header
                if let objResponse:HTTPURLResponse = response as? HTTPURLResponse
                {
                    try self.checkForErrorInResponse(objResponse);
                }
                self.delegate?.didReceiveReposne(data as AnyObject?, forTaskIdentifer: self.taskIdentifer!)
            }catch let error as NSError {
                //Handle Error
                self.delegate!.didReceiveError(error,forTaskIdentifer: self.taskIdentifer!);
            }
        })
        task!.resume();
        return task!;
    }
    
    /*!
    * @discussion Validate the http response
    * @param Response object of type NSHTTPURLResponse
    */
    fileprivate func checkForErrorInResponse(_ response:HTTPURLResponse) throws -> Void
    {
        //Check if response code is not 200 then throw the exception
        guard (response.statusCode == 200) else{
            var errorMessage = "";
            
            if let strErrorMessage:String = HTTPURLResponse.localizedString(forStatusCode: response.statusCode) {
                errorMessage = strErrorMessage
            }
            
            let error = NSError(domain: "HTTPError", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey:errorMessage])
            
            throw error
        }
        
    }
    
}
