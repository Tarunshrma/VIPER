//
//  TSCoreNetwork+Helper.swift
//  TSNetworking
//
//  Created by TARUN SHARMA on 18/12/16.
//  Copyright © 2016 Tarun Sharma. All rights reserved.
//

import Foundation

//Suggested by http://stackoverflow.com/users/1271826/rob
extension TSRequest {
    
    func generateBoundaryString()-> String{
        //return String("Boundary-\(NSUUID().UUIDString)")
        return String("Boundary-011000010111000001101001")
    }
    
    func createBodyWithBoundary(_ _boundry:String, parameters _param:[String:AnyObject]?, filePath _path:URL?, fieldName _fieldName:String)->Data{
        
        let httpData:NSMutableData = NSMutableData()
        
        //============================================================================
        //                              Start add file data
        //============================================================================
        if let filePath = _path{
            let filename:String  = filePath.lastPathComponent;
            let data:Data      = try! Data(contentsOf: filePath);
            let mimetype:String  = filePath.mimeType();
            
            let strBoundary:String = "--\(_boundry)\r\n"
            httpData.append(strBoundary.data(using: String.Encoding.utf8)!)
            
            let strParameterKey:String = "Content-Disposition: form-data; name=\u{22}\(_fieldName)\u{22}; filename=\u{22}\(filename)\u{22}\r\n"
            httpData.append(strParameterKey.data(using: String.Encoding.utf8)!)
            
            let strParameterType:String = "Content-Type: \(mimetype)\r\n\r\n"
            httpData.append(strParameterType.data(using: String.Encoding.utf8)!)
            
            httpData.append(data)
            
            let strParameterValue:String = "\r\n"
            httpData.append(strParameterValue.data(using: String.Encoding.utf8)!)
        }
        //============================================================================
        //                              End add file data
        //============================================================================
        
        //============================================================================
        //                              Start adding params (all params are strings)
        //============================================================================
        if let dictParameters:[String:AnyObject] = _param{
            for (key,value) in dictParameters{
                let strBoundary:String = "--\(_boundry)\r\n"
                httpData.append(strBoundary.data(using: String.Encoding.utf8)!)
                
                let strParameterKey:String = "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n"
                httpData.append(strParameterKey.data(using: String.Encoding.utf8)!)
                
                let strParameterValue:String = "\(value)\r\n"
                httpData.append(strParameterValue.data(using: String.Encoding.utf8)!)
            }
        }
        //============================================================================
        //                              End adding params (all params are strings)
        //============================================================================
        
        //Cloes boundary
        let strClosingBoundary:String = "--\(_boundry)--\r\n"
        httpData.append(strClosingBoundary.data(using: String.Encoding.utf8)!)
        
        return httpData as Data
    }
    
    func getPostMethodBodyFromParameter(_ parameter:[String:AnyObject])throws ->Data? {
        var postData:Data?
        
        switch self.httpParameterEncoding{
            //In case if multi form data dont append anything to httpbody, instead do it externally from request caller method
        case .multipartFormDataEncoding:fallthrough
            
        case .formURLParameterEncoding:
            
            let parameterString = parameter.stringFromHttpParameters()
            if let paramString:String = parameterString{
                postData = paramString.data(using: String.Encoding.utf8)!
            }else{
                throw NetworkCallAPIError.invalidPostParameter
            }
            
        case .jsonParameterEncoding:
            
            //Post method, attach parameter list in http body
            do{
                postData = try JSONSerialization.data(withJSONObject: parameter, options: JSONSerialization.WritingOptions.prettyPrinted)
            }catch{
                throw NetworkCallAPIError.invalidPostParameter
            }
            
            
        }
        
        return postData
    }
    
}
