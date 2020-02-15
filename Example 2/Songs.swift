//
//  Songs.swift
//  Example 2
//
//  Created by Carmel Braga on 2/14/20.
//  Copyright © 2020 Carmel Braga. All rights reserved.
//

import Foundation

struct Chart{
    
 let updated: Date
    
  enum CodingKeys: String, CodingKey {

    case f = "feed"
    case d = "updated"
  }
}

extension Chart: Decodable{
    
    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      let feed = try container.nestedContainer(keyedBy:
      CodingKeys.self, forKey: .f)
      self.updated = try feed.decode(Date.self, forKey: .d)
    }
}

extension Chart: Encodable{
    func encode(to encoder: Encoder) throws {
     var container = encoder.container(keyedBy: CodingKeys.self)
     var feed = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .f)
     try feed.encode(self.updated, forKey: .d)
    }
}
