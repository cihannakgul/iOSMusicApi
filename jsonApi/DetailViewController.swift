//
//  DetailViewController.swift
//  jsonApi
//
//  Created by cihan on 24.10.22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    
    var photo = Photo(dictionary: [:])
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        detailTitle.text = photo.title
        
        if let url = URL(string: photo.url){
            
            image.load(url: url)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
