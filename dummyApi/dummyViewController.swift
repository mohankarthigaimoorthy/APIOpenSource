//
//  dummyViewController.swift
//  dummyApi
//
//  Created by Mohan K on 18/01/23.
//

import UIKit

class dummyViewController: UIViewController {

    
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var lbleOne: UILabel!
    
    @IBOutlet weak var lbleTwo: UILabel!
     
    @IBOutlet weak var lbleThree: UILabel!
    
    @IBOutlet weak var lbleFour: UILabel!
    
    var dummy: dummyStatus?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lbleOne.text = dummy?.localized_name
        lbleTwo.text = dummy?.primary_attr
        lbleThree.text = dummy?.attack_type
        lbleFour.text = "\((dummy?.legs)!)"
        
        let imgUrl =  "https://api.opendota.com" + (dummy?.img)!
        photo.downloaded(from: imgUrl)
    }
    

}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
