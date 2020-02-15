//
//  UpdateViewController.swift
//  Example 2
//
//  Created by Carmel Braga on 2/14/20.
//  Copyright © 2020 Carmel Braga. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/itunes-music/top-songs/all/10/explicit.json")!
        let request = NetworkRequest2(url: url)
            request.execute { [weak self] (data) in
              if let data = data {
                 self?.decode(data)
                 print("Requesting works!")
                    
                }
        }

    }
    
}

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

private extension UpdateViewController{
    func decode(_ data: Data) {
           let decoder = JSONDecoder()
           do {
              decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
               let chart = try! decoder.decode(Chart.self, from: data)
               let format = chart.updated
            
            print("Decoding works!")
            print(format)
            dateLabel.text = format.description

           } catch {
               print("Oopsie daisy!")
           }
       }
}
