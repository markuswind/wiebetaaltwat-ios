//
//  Client.swift
//  wiebetaaltwat-ios
//
//  Created by Markus Wind on 6/18/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import Alamofire

class Client {

    let manager = Manager()

    class var sharedClient: Client {
        struct Singleton {
            static let instance = Client()
        }

        return Singleton.instance
    }

    func getLoginSession(url: String, parameters: [String: AnyObject], completion: ([NSHTTPCookie]?, String?) -> ()) {
        Alamofire.request(.POST, url, parameters: parameters).responseString { response in
            if let
                urlresponse = response.response,
                headerFields = urlresponse.allHeaderFields as? [String: String],
                URL = response.request?.URL,
                html = response.result.value
            {
                let cookies = NSHTTPCookie.cookiesWithResponseHeaderFields(headerFields, forURL: URL)

                completion(cookies, html)
            } else {
                completion(nil, nil)
            }
        }
    }

    func request(method: Alamofire.Method, url: String, parameters: [String: AnyObject], completion: (String?) -> ()) {
        manager.request(method, url, parameters: parameters, encoding: .URL, headers: Manager.defaultHTTPHeaders).responseString { response in
            if let html = response.result.value {
                completion(html)
            } else {
                completion(nil)
            }
        }
    }
    
}