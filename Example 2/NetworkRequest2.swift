//
//  NetworkRequest2.swift
//  Example 2
//
//  Created by Carmel Braga on 2/14/20.
//  Copyright © 2020 Carmel Braga. All rights reserved.
//

import Foundation

class NetworkRequest2 {
    let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: .main)
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func execute(withCompletion completion: @escaping (Data?) -> Void) {
        let task = session.dataTask(with: url, completionHandler: { (data: Data?, _, _) -> Void in
            completion(data)
        })
        task.resume()
    }
}
