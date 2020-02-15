//
//  AlbumsViewController.swift
//  Example 1
//
//  Created by Carmel Braga on 2/14/20.
//  Copyright © 2020 Carmel Braga. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var albumsTableView: UITableView!
    
    var albums: Albums?
        
        override func viewDidLoad() {
            super.viewDidLoad()

            let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/25/explicit.json")!
                          let request = NetworkRequest(url: url)
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
            return albums?.results.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = albumsTableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath)
            
            if let cell = cell as? AlbumTableViewCell,
                let album = albums?.results[indexPath.row]{
                cell.artistLabel.text = album.artistName
                cell.titleLabel.text = album.name
                cell.artworkImageView.image = album.artwork
         }
            
        return cell

        }
        
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
                var album = albums?.results[indexPath.row]
            if let _ = album?.artwork {
                    return
                }
            let request = NetworkRequest(url: album!.artworkUrl100)
                request.execute { [weak self](data) in
                    guard let data = data else {
                        return
                    }
                    album?.artwork = UIImage(data: data)
                    self?.albums?.results[indexPath.row] = album!
                    self!.albumsTableView.reloadRows(at: [indexPath], with: .fade)
                }
            }
        }

    private extension AlbumsViewController{
        func decode(_ data: Data) {
               let decoder = JSONDecoder()
               do {
                   albums = try decoder.decode(Albums.self, from: data)
                   albumsTableView.reloadData()
                   print(albums!)
                   print(albums!.results.count)
               } catch {
                   print("Oopsie daisy!")
               }
           }
    }

