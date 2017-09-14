//
//  Movie.swift
//  Movie_Selectr
//
//  Created by Tim Beals on 2017-03-07.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

public struct Movie {
    static let apiKey = "e46c318970fbdd4287139b3436c78f3e"
    private static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    
    public let title: String!
    public let imageRef: String!
    public let description: String!
    
    
    private static func getMovieData(with completion: @escaping(_ success:Bool, _ object: AnyObject?) -> ()) {
     
        let session = URLSession(configuration: .default)
        let request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&language=en-US&page=1")!)
        
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    completion(true, json as AnyObject?)
                } else {
                    completion(false, json as AnyObject?)
                }
            }
        }.resume()
    }
    
    public static func nowPlaying(with completion: @escaping(_ success: Bool, _ movies: [Movie]?) -> ()) {
        Movie.getMovieData { (success, object) in
            
            if success {
                
                var movieArray = [Movie]()
                
                if let movieResults = object?["results"] as? [Dictionary<String, AnyObject>] {
                    
                    for movie in movieResults {
                        
                        let newTitle = movie["original_title"] as! String
                        let newOverview = movie["overview"] as! String
                        guard let newPoster = movie["poster_path"] as? String else { continue }
                        
                        let newMovie = Movie(title: newTitle, imageRef: newPoster, description: newOverview)
                        
                        movieArray.append(newMovie)
                    }
                }
                completion(true, movieArray)
            } else {
                completion(false, nil)
            }
        }
    }
    
    
    //MARK: Get image data and store in a cache
    
    private static func getDocumentsDirectory() -> String? {
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        guard let documents: String = paths.first else { return nil }
        return documents
    }
    
    private static func checkForImageData(withMovieObject movie: Movie) -> String? {
        
        if let documents = getDocumentsDirectory() {
            let movieImagePath = documents + "/\(movie.title)"
            let escapedImagePath = movieImagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
            
            if FileManager.default.fileExists(atPath: escapedImagePath!) {
                return escapedImagePath
            }
        }
        return nil
    }
    
    public static func getImageData(forCell cell: AnyObject, withMovieObject movie: Movie) {
        
        if let imagePath = checkForImageData(withMovieObject: movie) {
            //image already exists
            if let imageData = FileManager.default.contents(atPath: imagePath) {
                updateCell(cell, with: imageData)
            }
        } else {
            //download image data and store in the cache
            let imagePath = imageBaseURL + movie.imageRef
            let imageURL = URL(string: imagePath)
            
            DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                
                do {
                    let data = try Data(contentsOf: imageURL!)
                    
                    if let documents = getDocumentsDirectory() {
                        let imagePath = documents + "/\(movie.title)"
                        let escapedImagePath = imagePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                        
                        if FileManager.default.createFile(atPath: escapedImagePath!, contents: data, attributes: nil) {
                            print("image saved")
                        }
                        
                        DispatchQueue.main.async {
                            updateCell(cell, with: data)
                        }
                    }
                } catch {
                    print("No data at specified location")
                }
            }
        }
    }
 

    private static func updateCell(_ cell: AnyObject, with imageData: Data) {
        if cell is UITableViewCell {
            let tableViewCell = cell as! UITableViewCell
            tableViewCell.imageView?.image = UIImage(data: imageData)
            tableViewCell.setNeedsLayout()
        } else {
            //implement collection view cell
            let collectionViewCell = cell as! MovieCellCollectionViewCell
            collectionViewCell.imageView.image = UIImage(data: imageData)
            collectionViewCell.setNeedsLayout()
        }
    }

}
