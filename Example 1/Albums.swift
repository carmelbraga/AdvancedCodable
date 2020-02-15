//
//  Albums.swift
//  Example 1
//
//  Created by Carmel Braga on 2/14/20.
//  Copyright © 2020 Carmel Braga. All rights reserved.
//

import Foundation
import UIKit

struct Albums{
    
  var results: [Album]
    
  enum CodingKeys: String, CodingKey {

    case f = "feed"
    case r = "results"
  }
}

extension Albums: Decodable{
    
    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      let feed = try container.nestedContainer(keyedBy:
      CodingKeys.self, forKey: .f)
      self.results = try feed.decode([Album].self, forKey: .r)
    }
}

extension Albums: Encodable{
    func encode(to encoder: Encoder) throws {
     var container = encoder.container(keyedBy: CodingKeys.self)
     var feed = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .f)
     try feed.encode(self.results, forKey: .r)
    }
}

struct Album{
        
        let artistName: String
        let name: String
        let artworkUrl100: URL
        var artwork: UIImage?
        
        enum CodingKeys: String, CodingKey {
        case a = "artistName"
        case n = "name"
        case i = "artworkUrl100"
    }
    
    }

extension Album: Decodable{
    init(from decoder: Decoder) throws {
       let container = try decoder.container(keyedBy: CodingKeys.self)
       self.artistName = try container.decode(String.self, forKey: .a)
       self.name = try container.decode(String.self, forKey: .n)
       self.artworkUrl100 = try container.decode(URL.self, forKey: .i)
    }
    
}

extension Album: Encodable{
    func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(self.artistName, forKey: .a)
      try container.encode(self.name, forKey: .n)
      try container.encode(self.artworkUrl100, forKey: .i)
    }
 }
