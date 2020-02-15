//
//  Books.swift
//  Example 3
//
//  Created by Carmel Braga on 2/14/20.
//  Copyright © 2020 Carmel Braga. All rights reserved.
//

import Foundation
import UIKit

struct Books{
    
  var results: [Book]
    
  enum CodingKeys: String, CodingKey {

    case f = "feed"
    case r = "results"
  }
}

extension Books: Decodable{
    
    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      let feed = try container.nestedContainer(keyedBy:
      CodingKeys.self, forKey: .f)
      self.results = try feed.decode([Book].self, forKey: .r)
    }
}

extension Books: Encodable{
    func encode(to encoder: Encoder) throws {
     var container = encoder.container(keyedBy: CodingKeys.self)
     var feed = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .f)
     try feed.encode(self.results, forKey: .r)
    }
}

struct Book{
        
        let artistName: String
        let name: String
        let releaseDate: String
        let artworkUrl100: URL
        var artwork: UIImage?
        
        enum CodingKeys: String, CodingKey {
        case a = "artistName"
        case n = "name"
        case i = "artworkUrl100"
        case d = "releaseDate"

    }
    
    }

extension Book: Decodable{
    init(from decoder: Decoder) throws {
       let container = try decoder.container(keyedBy: CodingKeys.self)
       self.artistName = try container.decode(String.self, forKey: .a)
       self.name = try container.decode(String.self, forKey: .n)
       self.artworkUrl100 = try container.decode(URL.self, forKey: .i)
       self.releaseDate = try container.decode(String.self, forKey: .d)
    }
    
}

extension Book: Encodable{
    func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(self.artistName, forKey: .a)
      try container.encode(self.name, forKey: .n)
      try container.encode(self.artworkUrl100, forKey: .i)
      try container.encode(self.releaseDate, forKey: .d)
    }
 }
