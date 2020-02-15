//
//  BookViewController.swift
//  Example 3
//
//  Created by Carmel Braga on 2/14/20.
//  Copyright © 2020 Carmel Braga. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {
    
     var book: Book?
    
    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            setBook(book!)
            title = book?.name
        }
        
    }

    private extension BookViewController {
        func getBook() {
            let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/books/top-paid/all/50/explicit.json")!
            let request = NetworkRequest3(url: url)
            request.execute { [weak self] (data) in
                if let data = data {
                    self?.decode(data)
                }
            }
        }
        
        func decode(_ data: Data) {
            let decoder = JSONDecoder()
            if let book = try? decoder.decode(Book.self, from: data) {
                setBook(book)
            }
        }
        
        func setBook(_ book: Book) {
            
            dateLabel.text = "Released:" + " " + book.releaseDate
            titleLabel.text = book.name
            authorLabel.text = "by:" + " " + book.artistName
            
            getArtwork(withURL: book.artworkUrl100)
        }
        
        func getArtwork(withURL url: URL) {
            let request = NetworkRequest3(url: url)
            request.execute { [weak self] (data) in
                guard let data = data else {
                    return
                }
                self?.coverImageView.image = UIImage(data: data)
            }
        }
    }
