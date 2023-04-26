//
//  ViewController.swift
//  dummyApi
//
//  Created by Mohan K on 18/01/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var dummytableView: UITableView!
    
    var dumy = [dummyStatus]()
    var limit = [1]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        downloadJSON {
            self.dummytableView.reloadData()
//            print("dumy: \(self.dumy.count - 1)")
            print("Success")

        }
        dummytableView.delegate = self
        dummytableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dumy.count
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let dumy = dumy[indexPath.row]
        cell.textLabel?.text = dumy.localized_name.capitalized
//        cell.detailTextLabel?.text = dumy.primary_attr.lowercased()
        cell.detailTextLabel?.text = "\(dumy.id)"

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
        print("dumy.count indexPath: \(indexPath)")

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == limit.count - 1 {
            
            print("limit.count: \(limit.count)")
            moredumy()
            self.showToast(message: "\(limit.count)", font: .systemFont(ofSize: 12.0))
        }
    }
   
    
    func moredumy() {
        for _ in 0...10 {
            limit.append(limit.last! + 1)
        }
        dummytableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? dummyViewController {
            destination.dummy = dumy[dummytableView.indexPathForSelectedRow!.row]
        }
    }
    
    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "https://api.opendota.com/api/heroStats")
        URLSession.shared.dataTask(with: url!) { data, response, err in
            if err == nil {
                do {
                    self.dumy = try JSONDecoder().decode([dummyStatus].self, from: data!)
                    
                    DispatchQueue.main.async {
                        completed()
                    
                    }
                }
                catch {
                    print("error fetching data from api")
                }
               
            }
        }.resume()
    }

}


