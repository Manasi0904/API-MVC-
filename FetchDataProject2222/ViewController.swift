//
//  ViewController.swift
//  FetchDataProject2222
//
//  Created by Kumari Mansi on 06/12/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var releasedLabel: UILabel!
    @IBOutlet var directorLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var boxOfficeLabel: UILabel!
    @IBOutlet var languageLabel: UILabel!
    @IBOutlet var runTimeLabel: UILabel!
    @IBOutlet var starCastLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
    }
    func fetchData()
    {
        let url = URL(string: "https://www.omdbapi.com/?i=tt8178634&apikey=fb31d0ef" )
        let dataTask = URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error ) in
            guard let data = data, error == nil else
            {
                print("Error Occurred While Accessing Data with URL")
                return
            }
            var movieInfo:MovieData = MovieData(Title: "", Year: "", Released: "", Director: "", BoxOffice: "", Language: "", Runtime: "", Genre: "")
            do
            {
                movieInfo = try JSONDecoder().decode(MovieData.self, from: data)
            }
            catch{
                print("Error Occurred While Decoding JSON into Swift Structure \(error)")
            }
            
            DispatchQueue.main.async {
                self.titleLabel.text = "Title: \(movieInfo.Title)"
                self.yearLabel.text = "Year: \(movieInfo.Year)"
                self.releasedLabel.text = "Released: \(movieInfo.Released)"
                self.directorLabel.text = "Director: \(movieInfo.Director)"
                self.boxOfficeLabel.text = "BoxOffice: \(movieInfo.BoxOffice)"
                self.languageLabel.text = "Language: \(movieInfo.Language)"
                self.runTimeLabel.text = "RunTime: \(movieInfo.Runtime)"
                self.starCastLabel.text = "Genre: \(movieInfo.Genre)"
                
            }
        })
        dataTask.resume()
    }
}
extension UIImageView
{
    func downloadImage(from url:URL)
    {
        contentMode = .scaleToFill
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data)
            else
            {
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        })
        dataTask.resume()
    }
}




