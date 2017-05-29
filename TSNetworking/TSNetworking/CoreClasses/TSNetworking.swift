//
//  TSNetworking.swift
//  TSNetworking
//
//  Created by TARUN SHARMA on 17/12/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

import Foundation

public typealias ServiceResponse = (AnyObject?, Error?) -> Void

// MARK: Extension Class to handle Queue-Dequeue of active tasks
extension TSNetworking{
    
    /*!
    * @discussion Enqueue all incoming api requests to track the active running tasks
    */
    fileprivate func enqueueNetworkRequest(_ networkRequest:TSNetworkOperation){
        self.activeTasks.append(networkRequest)
        print("Enquing request...Current is \(self.activeTasks.count)");
    }
    
    /*!
    * @discussion Dequeue api requests once recieved response from server
    */
    fileprivate func deQueueNetworkRequest(_ networkRequest:TSNetworkOperation){
        
        let index = self.activeTasks.index{$0 === networkRequest}
        guard let idx = index, idx>=0 && idx<self.activeTasks.count else{
            //Do nothing
            return
        }
        
        self.activeTasks.remove(at: idx)
        print("Dequing request...Current is \(self.activeTasks.count)");
    }
    
    /*!
    * @discussion Get instance of network request(urlsession task+completion handler) from task identifier.
    */
    fileprivate func getNetworkRequest(forTaskIdentifier taskIdentifier:Int)->TSNetworkOperation?{
        
        var filteredRequest = self.activeTasks.filter( { (networkRequest: TSNetworkOperation) -> Bool in
            return networkRequest.tasks.taskIdentifier == taskIdentifier;
        });
        
        guard let objRequest:TSNetworkOperation = filteredRequest[0] else{
            return nil;
        }
        
        return objRequest;
    }
    
}

// MARK: Extension Class of TSNetworking to create request objects
extension TSNetworking{
    
    //Fetch the fresh request object
    public func createRequest(fromUrl url:String,method:NetworkRequestMethod, data:[String:String]?) throws ->  TSRequest?
    {
        let networkRequest = TSRequest(baseUrl: url)
        //If exception occur throw it
        do{
            try networkRequest.requestWithMethod(method: method, relativeUrl: "", parameters: data as [String : AnyObject]?)
        }catch{
            print("Exception in generating request object")
            throw error
        }
        
        return networkRequest
    }
    
    //Fetch the fresh multipart request object
    public func createMultipartRequest(fromUrl url:String,method:NetworkRequestMethod, data:[String:String]?, filePath:URL, fileName:String) throws ->  TSRequest?
    {
        let networkRequest = TSRequest(baseUrl: url)
        //If exception occur throw it
        do{
            try networkRequest.mutipartRequestWithMethod(method: method, relativeUrl: "", parameters: data as [String : AnyObject]?, filePath: filePath, fileName: fileName)
        }catch{
            print("Exception in generating request object")
            throw error
        }
        
        return networkRequest
    }
}


// MARK: Extension Class of TSNetworking to provide helper data fetching public methods
extension TSNetworking{
    
    public func fetchXMLData(withRequest request:TSRequest,completionHandler: @escaping ServiceResponse) throws ->  TSNetworkOperation?
    {
        var networkOperation: TSNetworkOperation?
        
        do{
            networkOperation =  try requestData(withRequest: request, completionHandler: completionHandler)
            networkOperation?.responseType = ResponseType.xml
        }catch{
            
        }
        
        return networkOperation;
    }
    
    public func fetchJSONData(withRequest request:TSRequest,completionHandler: @escaping ServiceResponse) throws ->  TSNetworkOperation?
    {
        var networkOperation: TSNetworkOperation?
        
        do{
            networkOperation =  try requestData(withRequest: request, completionHandler: completionHandler)
            networkOperation?.responseType = ResponseType.json
        }catch{
            
        }
        
        return networkOperation;
    }
    
    public func fetchContentData(withRequest request:TSRequest,completionHandler: @escaping ServiceResponse) throws ->  TSNetworkOperation?
    {
        
        //Check for data in cache, if found return immediatly
        if let cachedData  = self.imageCache.object(forKey: request.absoluteUrl()! as AnyObject){
            completionHandler(cachedData,nil)
            return nil
        }
        
        var networkOperation: TSNetworkOperation?
        
        do{
            networkOperation =  try requestData(withRequest: request, completionHandler: completionHandler)
            networkOperation?.responseType = ResponseType.cachableContentData
        }catch{
            
        }
        
        return networkOperation;
    }
    

}

// MARK: Core TSNetworking class to handle all network api calls
open class TSNetworking:NSObject,NetworkOperations {

//    private static var __once: () = {
//            Static.instance = TSNetworking()
//            //FIXME: Capacity should be set from client of liberary
//            let URLCache = Foundation.URLCache(memoryCapacity: 400 * 1024 * 1024, diskCapacity: 400 * 1024 * 1024, diskPath: nil)
//            Foundation.URLCache.setSharedURLCache(URLCache)
//        }()

    fileprivate let imageCache = NSCache<AnyObject, AnyObject>()
    
    // MARK: - Private Member Variables -
    fileprivate var activeTasks:[TSNetworkOperation] = [TSNetworkOperation](); //initilize empty active running request
    
    /*!
    * @discussion Static class method to get singleton instance of NetworkManager class
    */
//    open class var sharedInstance: TSNetworking {
//        struct Static {
//            static var onceToken: Int = 0
//            static var instance: TSNetworking? = nil
//        }
//        _ = TSNetworking.__once
//        return Static.instance!
//    }
    
    public static let sharedInstance : TSNetworking = {
        let instance = TSNetworking()
        return instance
    }()
    
    func requestData(withRequest request:TSRequest,completionHandler: @escaping ServiceResponse) throws ->  TSNetworkOperation?
    {
        
        //Create instance of network core class
        let coreNetworkObject = TSCoreNetwork(delegate: self)
        var networkOperation: TSNetworkOperation?
        
        do{

            let task:URLSessionTask = coreNetworkObject.dataAPIWithRequest(request)

            //Enqueue request
            networkOperation = TSNetworkOperation(withTask: task, request: request.absoluteUrl()!, completionHandler: completionHandler)
            self.enqueueNetworkRequest(networkOperation!)
            
        }catch let exception as NetworkCallAPIError{
            throw exception
        }catch let error as NSError {
            completionHandler(nil,error)
        }
        
        return networkOperation
        
    }


    
    // MARK: - API Delegate Methods -
    
    /*!
    * @discussion Callback delegate method to response recieved from server response
    * @param data: Response recieved
    * @param taskIdentifier: Task identifier to de-queue network request object from active running tasks
    */
    func didReceiveReposne(_ data: AnyObject?, forTaskIdentifer taskIdentifier:Int){
        
        //Fetch the netowrk request object from active running tasks queue
        guard let queuedNetworkOperation = self.getNetworkRequest(forTaskIdentifier: taskIdentifier) else{
            return;
        }
        
        //get the callback from aboe fetched object
        let callback:ServiceResponse = queuedNetworkOperation.completionHandler
        
        //Received reposne from API.
        if let webResponse:AnyObject = data{
            //Try to parse the response and send back to callback
            do{
                if let parsedResponse:AnyObject = try queuedNetworkOperation.responseType.parseResponse(webResponse) {
                   
                    //Cache the response if response type is cachable content data
                    if(queuedNetworkOperation.responseType == ResponseType.cachableContentData){
                        self.imageCache.setObject(parsedResponse, forKey: queuedNetworkOperation.apiEndPoint as AnyObject)
                    }
                    
                    callback(parsedResponse, nil)
                }else{
                    let error = NSError(domain: "com.tarun.TSNetworking", code: 111, userInfo: [NSLocalizedDescriptionKey:"Invalid response recieved!"])
                    callback(nil, error)
                }
             }catch let error as NSError {
                callback(nil, error)
            }
        }else{
            let error = NSError(domain: "com.tarun.TSNetworking", code: 111, userInfo: [NSLocalizedDescriptionKey:"Invalid response recieved!"])
            callback(nil, error)
        }
        
         //De-queue the request object from active running tasks list
        self.deQueueNetworkRequest(queuedNetworkOperation)
    }
    
    /*!
    * @discussion Callback delegate method to handle error recieved from server response
    * @param error: Error recieved
    * @param taskIdentifier: Task identifier to de-queue network request object from active running tasks
    */
    func didReceiveError(_ error: Error, forTaskIdentifer taskIdentifier:Int) {
        // received error
        guard let networkRequest = self.getNetworkRequest(forTaskIdentifier: taskIdentifier) else{
            return;
        }
        
        let callback:ServiceResponse = networkRequest.completionHandler
        callback(nil, error)
        
        //De-queue the request object from active running tasks list
        self.deQueueNetworkRequest(networkRequest)
    }
    
    

}
