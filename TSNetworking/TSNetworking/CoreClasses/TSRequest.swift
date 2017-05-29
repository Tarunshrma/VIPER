//
//  TSRequest.swift
//  TSNetworking
//
//  Created by TARUN SHARMA on 17/12/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

import Foundation

open class TSRequest: NSObject {
    // MARK: - Private Member Variables -
    fileprivate var baseUrl: URL
    var httpParameterEncoding:HTTPClientParameterEncoding
    var request:URLRequest?
    
    // MARK: - Class methods -
    /*!
     * @discussion Constructer to initialize NetworkCalls object with delegate base url
     * @param _baseURL: base url or hostname where to make api calls
     * @param _delegate: Callback delegate
     * @return instance of NetworkCalls
     */
    //Handle try catch to check if proper netowork object is formed
    init(baseUrl _baseurl:String) {
        self.baseUrl = URL(string: _baseurl)!;
        //Default encoding is form url
        self.httpParameterEncoding = .jsonParameterEncoding
    }
    
    /*!
     * @discussion This method returns the request object based on passed parameter, http method & api endpoint
     * @param method: HTTP method e.g. GET,POST etc
     * @param apiEndPoint: API Path where to make the call
     * @param apiEndPoint: API parameters
     * @return Instance of NSMutableURLRequest, wrap around all request data, Invalid url exception if url is invalid
     */
    func requestWithMethod(method _method:NetworkRequestMethod, relativeUrl _relativeUrl:String, parameters _parameters:[String:AnyObject]?)throws ->NSMutableURLRequest{
        
        //Append the path to base url
        //var url = URL(string: _relativeUrl, relativeTo: self.baseUrl)
        let url = URL(string: self.baseUrl.absoluteString)
        url?.appendingPathComponent(_relativeUrl)
        
        let request:NSMutableURLRequest = NSMutableURLRequest();
        request.httpMethod = _method.rawValue;
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let boundary:String = self.generateBoundaryString()
        
        //        //Set the content type based on http parameter encoding
        switch self.httpParameterEncoding{
        case .formURLParameterEncoding:
            request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        case .jsonParameterEncoding:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        case .multipartFormDataEncoding:
            let contentType:String = "multipart/form-data; boundary=\(boundary)"
            request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        }
        
        if let param = _parameters{
            switch _method{
            case .GET:
                //Get method, attach parameter list as query string
                let parameterString = param.stringFromHttpParameters()
                var stringUrl = "\(url!.absoluteString)?\(parameterString)"
                
                let URL = Foundation.URL(string: stringUrl.addingPercentEscapes(using: String.Encoding.utf8)!)!
                
                //                url = NSURL(string:"\(url!.absoluteString)?\(parameterString)")!
                break
            case .POST:
                //Post method, attach parameter list in http body
                do{
                    request.httpBody = try getPostMethodBodyFromParameter(param)
                }catch{
                    throw NetworkCallAPIError.invalidPostParameter
                }
                
                break
            default: ()
            }
        }
        
        //throw invalid url type exception
        guard url != nil else{
            throw NetworkCallAPIError.invalidURL
        }
        
        request.url = url;
        self.request = request as URLRequest
        
        return request;
    }
    //multipart/x-zip
    //Suggested by http://stackoverflow.com/users/1271826/rob
    func mutipartRequestWithMethod(method _method:NetworkRequestMethod, relativeUrl _relativeUrl:String, parameters _parameters:[String:AnyObject]?, filePath _filePath:URL, fileName _fileName:String)throws ->NSMutableURLRequest{
        assert(_method != .GET , "GET method not allowed for multipart request")
        
        let request:NSMutableURLRequest
        
        do{
            self.httpParameterEncoding  = .multipartFormDataEncoding
            request = try self.requestWithMethod(method: _method, relativeUrl: _relativeUrl, parameters: nil)
        }catch NetworkCallAPIError.invalidURL{
            throw NetworkCallAPIError.invalidURL
        }
        
        //Add mutipart form data to content type header
        let boundary:String = self.generateBoundaryString()
        //        let contentType:String = "multipart/form-data; boundary=\(boundary)"
        //        request.addValue(contentType, forHTTPHeaderField: "Content-Type")
        
        //Create mutipart boundry
        let mutipartBody:Data = self.createBodyWithBoundary(boundary, parameters: _parameters, filePath: _filePath, fieldName: _fileName)
        
        request.httpBody = mutipartBody
        
        self.request = request as URLRequest
        
        return request
    }

    
    func absoluteUrl()->String?
    {
        return self.request!.url?.absoluteString
    }
    
    //TODO: Add capablity to add http/custom header from client of liberary
    open func addHeader(withKey _key:String,value _value:String)
    {
        
    }
    
    //TODO: Add capablity to add multiple http/custom header from client of liberary
    open func addHeaders(_ _dict:Dictionary<String,String>)
    {
        
    }
    
    open func addAuthorizationHeader(withUsername username:String, password:String)
    {
        let loginString = String(format: "%@:%@", username, password)
        let loginData: Data = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString(options: [])
        
        self.request!.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
    }
    
}
