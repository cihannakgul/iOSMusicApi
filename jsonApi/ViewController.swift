//
//  ViewController.swift
//  jsonApi
//
//  Created by cihan on 29.09.22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var tableVieew: UITableView!
    var photos = [Photo]()
    @IBOutlet weak var myImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadLogo()
        getPhotos()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        
        let row = photos[indexPath.row]
        cell.myLabel.text = row.title
        cell.myImage.load(url: URL(string: row.url)!)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = photos[indexPath.row]
        
        print("rowzo",indexPath.row)
        performSegue(withIdentifier: "toDetail", sender: row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail"{
            
            
            let desVC = segue.destination as! DetailViewController
            desVC.photo = sender as! Photo
            
        }
    }
    
    func loadLogo(){
        
        if let logo = UIImage(named:"music2.png")
        {
            let newLogo = Util.app.resizeImageWithAspect(image: logo, scaledToMaxWidth: 140, maxHeight: 90)
            let imageWay = UIImageView(image: newLogo)
            self.navigationItem.titleView = imageWay
            
        }
    }
    
    func getPhotos(){
        
        photos = []
        
        let url = URL(string:"http://localhost:3000/photos")!
        let task = URLSession.shared.dataTask(with: url) {(data,response,error) in
            if let error = error{
                
                print(error)
            }
             
            else
            {
                if let response = response as? HTTPURLResponse{
                    print("status : \(response.statusCode)")
                    
                }
                
                do{
                    
                if let json = try JSONSerialization.jsonObject(with: data!, options:[]) as? [[String:Any]]{
                      
                    print(json)
                    for dic in json{
                        self.photos.append(Photo(dictionary: dic))
                    }
                    self.photos = Array(self.photos.prefix(5))
                    
                    DispatchQueue.main.async {
                        self.tableVieew.reloadData()
                    }
                    
                    }
                }
                
                catch let error as NSError {
                    
                    print("error for NS : \(error.localizedDescription)")

                }
                
                
            }
            
            
        }
        task.resume()
    }

}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

