//
//  TKNetworkOperation.swift
//  TSNetworking
//
//  Created by TARUN SHARMA on 17/12/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

import Foundation

//typealias ServiceResponse = (AnyObject?, NSError?) -> Void

// MARK: - Wrap around network tasks for tracking purpose -
open class TSNetworkOperation
{
    fileprivate(set) var tasks:URLSessionTask!
    fileprivate(set) var completionHandler:ServiceResponse!
    fileprivate(set) var apiEndPoint:String!
    
    var responseType:ResponseType
    
    
    init(withTask task: URLSessionTask, request requestIdentier:String, completionHandler completion:@escaping ServiceResponse){
        self.tasks = task;
        self.completionHandler = completion;
        self.apiEndPoint = requestIdentier;
        
        self.responseType = ResponseType.data
    }
    
    //Cancel a task if running
    open func cancelRequest(){
        if (self.tasks.state == URLSessionTask.State.running){
            self.tasks.cancel();
            
            //TODO: Need a way to dequeue from active task list
        }
    }
    
    
    
}
