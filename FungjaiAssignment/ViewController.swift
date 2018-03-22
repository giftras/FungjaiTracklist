//
//  ViewController.swift
//  FungjaiAssignment
//
//  Created by Macbook Pro on 3/21/2561 BE.
//  Copyright © 2561 Student. All rights reserved.
//

import UIKit

struct fungjaidata: Decodable {
    let id : Int
    let name : String
    let type : String
    let cover : String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var trackimg1: UIImageView!
    @IBOutlet weak var trackimg2: UIImageView!
    @IBOutlet weak var trackimg3: UIImageView!
    @IBOutlet weak var videoimg: UIImageView!
    @IBOutlet weak var adsimg: UIImageView!
    @IBOutlet weak var trackname1: UILabel!
    @IBOutlet weak var trackname2: UILabel!
    @IBOutlet weak var trackname3: UILabel!
    let jsonURL = "https://www.anop72.info/api/seed.json"
    
    var fungjaidatas = [fungjaidata]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //calling the function that will fetch the json
        getJsonDataFromUrl()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func getJsonDataFromUrl(){
        let url = URL(string: jsonURL)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do{
                self.fungjaidatas = try JSONDecoder().decode([fungjaidata].self, from: data!)
                for eachdata in self.fungjaidatas{
                    //print(eachdata.name)
                    if(eachdata.id == 2){
                        print(eachdata.name)
                        //for display name label
                        self.trackname1.text = eachdata.name
                        let url = URL(string: eachdata.cover)
                        DispatchQueue.global().async {
                            let data = try? Data(contentsOf: url!)
                            DispatchQueue.main.async {
                                self.trackimg1.image = UIImage(data: data!)
                            }
                        }
                    }
                    if(eachdata.id == 8){
                       // print(eachdata.name)
                        self.trackname2.text = eachdata.name
                        let url = URL(string: eachdata.cover)
                        DispatchQueue.global().async {
                            let data = try? Data(contentsOf: url!)
                            DispatchQueue.main.async {
                                self.trackimg2.image = UIImage(data: data!)
                            }
                        }
                    }
                    if(eachdata.id == 10){
                       // print(eachdata.name)
                        self.trackname3.text = eachdata.name
                        let url = URL(string: eachdata.cover)
                        DispatchQueue.global().async {
                            let data = try? Data(contentsOf: url!)
                            DispatchQueue.main.async {
                                self.trackimg3.image = UIImage(data: data!)
                            }
                        }
                    }
                    //getting video img
                    if(eachdata.id == 101){
                        let url = URL(string: eachdata.cover)
                        DispatchQueue.global().async {
                            let data = try? Data(contentsOf: url!)
                            if(data != nil){
                                DispatchQueue.main.async {
                                    self.videoimg.image = UIImage(data: data!)
                                    //print("link work")
                                }
                                
                            }else{
                                print("url image link not work")
                            }
                        }
                    }
                    //getting ads img if url not work then display defualt image
                    if(eachdata.id == 304){
                        let url = URL(string: eachdata.cover)
                        DispatchQueue.global().async {
                            let data = try? Data(contentsOf: url!)
                            if(data != nil){
                            DispatchQueue.main.async {
                                self.adsimg.image = UIImage(data: data!)
                                //print("link work")
                                }
                                
                            }else{
                                print("url image link not work")
                            }
                        }
                    }

                }
                
            }catch{
                print("error")
            }
            }.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //for avoid screet rotation, can do only portrait
    override var shouldAutorotate: Bool{
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return .portrait
    }
}
