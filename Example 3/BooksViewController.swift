//
//  BooksViewController.swift
//  Example 3
//
//  Created by Carmel Braga on 2/14/20.
//  Copyright © 2020 Carmel Braga. All rights reserved.
//

import UIKit

class BooksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var booksTableView: UITableView!
    
    var books: Books?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/books/top-paid/all/50/explicit.json")!
                      let request = NetworkRequest3(url: url)
                      request.execute { [weak self] (data) in
                          if let data = data {
                              self?.decode(data)
                          }
                      }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = booksTableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath)
        
        if let cell = cell as? BookTableViewCell,
            let book = books?.results[indexPath.row]{
            cell.artworkImageView.image = book.artwork
     }
        
    return cell

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            var book = books?.results[indexPath.row]
        if let _ = book?.artwork {
                return
            }
        let request = NetworkRequest3(url: book!.artworkUrl100)
            request.execute { [weak self](data) in
                guard let data = data else {
                    return
                }
                book?.artwork = UIImage(data: data)
                self?.books?.results[indexPath.row] = book!
                self!.booksTableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if let destination = segue.destination as? BookViewController,
              let selectedIndexPath = booksTableView.indexPathForSelectedRow {
              destination.book = books?.results[selectedIndexPath.row]
          }
      }
    }


private extension BooksViewController{
    func decode(_ data: Data) {
           let decoder = JSONDecoder()
           do {
               books = try decoder.decode(Books.self, from: data)
               booksTableView.reloadData()
               print(books!)
               print(books!.results.count)
           } catch {
               print("Oopsie daisy!")
           }
       }
}
