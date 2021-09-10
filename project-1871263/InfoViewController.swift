//
//  InfoViewController.swift
//  ch06-1871263-tabBarController
//
//  Created by mac021 on 2021/04/06.
//

import UIKit
import WebKit

class InfoViewController: UIViewController {

   
    let baseURLString = "https://api.openweathermap.org/data/2.5/weather"
    let apiKey = "065da625bf2a708368159459f3cfc177"
    var city: String?
    var stilFlower: String?
    var sff: String?
    
    @IBOutlet weak var webView: WKWebView!
    
    var good = ["개나리", "진달래", "벚꽃", "튤립", "철쭉", "목련", "유채꽃", "민들레", "산수유", "장미", "나팔꽃", "해바라기", "무궁화", "연꽃", "봉숭아", "접시꽃", "수국"]
    var bad = ["국화", "코스모스", "억새", "메밀꽃", "백일홍", "채송화", "동백나무", "수선화", "군자란", "프리지아", "칼랑코에", "복수초"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("InfoViewController.viewDidLoad")
    }
    
        
}

extension InfoViewController{
    override func viewWillAppear(_ animated: Bool) {
        if(stilFlower == "no"){
            getWeatherDate(cityName: city!)
            
            
            
        }
        else if(city == "no")
        {
            myWeather2(randomFlower: stilFlower!)
        }
    }
}


extension InfoViewController{
    func getWeatherDate(cityName city: String){
        
        //Prog.start(in: self, .activityIndicator)
        var urlStr = baseURLString+"?"+"q="+city+"&"+"appid="+apiKey
        urlStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let session = URLSession(configuration: .default)
        let url = URL(string: urlStr)
        let request = URLRequest(url: url!)
        
        var randomFlower : String!
        
        let dataTask = session.dataTask(with: request){
            (data,respond, error) in
            guard let jsonData = data else{ print(error!); return }
            if let jsonStr = String(data:jsonData, encoding: .utf8){
                //print(jsonStr)
            }

          
            randomFlower = self.extractWeatherData(jsonData:jsonData)
           
            
            self.myWeather(randomFlower: randomFlower)
            
          
           
            
        }
        dataTask.resume()
        
        
        //return randomFlower!
    }
    
}



extension InfoViewController{
    func myWeather(randomFlower: String){
        
                    let flowerStr = randomFlower.addingPercentEncoding(withAllowedCharacters: .urlUserAllowed)!
                    let urlStr = URL(string: "http://ko.wikipedia.org/wiki/\(flowerStr)")!
                    let request = URLRequest(url: urlStr)
                    
                        let session = URLSession(configuration: .default)
                   
                        let dataTask = session.dataTask(with: request){
                            (data, response, error) in
                            if let error = error{
                                print(error)
                                return
                            }
                            if let jsonData = data{
                                if let jsonString = String(data: jsonData, encoding: .utf8){
                                    //print(jsonString)
                                
                                }
                            }
                       }
        
//                    let urlStr = "http://"
//                    let url = URL(string: urlStrs)!
//                    if let imageData = try? Data(contentsOf: url){
//                    DispatchQueue.main.async(){
//                        //self.updateMap(title: title, longitute: longitute, lattitute: latitute)
//                       // Prog.dismiss(in: self)
//                    }
//                    }
        dataTask.resume()
        webView.load(request)
        
    }
}



extension InfoViewController{
    func myWeather2(randomFlower: String){
        
                    let flowerStr = randomFlower.addingPercentEncoding(withAllowedCharacters: .urlUserAllowed)!
                    let urlStr = URL(string: "http://en.wikipedia.org/wiki/\(flowerStr)")!
                    let request = URLRequest(url: urlStr)
                    
                        let session = URLSession(configuration: .default)
                   
                        let dataTask = session.dataTask(with: request){
                            (data, response, error) in
                            if let error = error{
                              
                                print(error)
                                return
                            }
                            if let jsonData = data{
                                if let jsonString = String(data: jsonData, encoding: .utf8){
                                   
                                    //print(jsonString)
                                    
                                }
                            }
                       }
        
//                    let urlStr = "http://"
//                    let url = URL(string: urlStrs)!
//                    if let imageData = try? Data(contentsOf: url){
//                    DispatchQueue.main.async(){
//                        //self.updateMap(title: title, longitute: longitute, lattitute: latitute)
//                       // Prog.dismiss(in: self)
//                    }
//                    }
        dataTask.resume()
        webView.load(request)
        
    }
}



extension InfoViewController{
    func extractWeatherData(jsonData: Data)->(String){
        let json = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
        if let code = json["cod"]{
            if code is String, code as! String == "404"{
                return "nil"
            }
        }
        let weather = (json["weather"] as! [[String: Any]])
        var arr = "w"
        var wArr = "q"
        for w in weather{
            arr = w["icon"] as! String
            wArr = w["main"] as! String
        }
        print(arr)
        
        DispatchQueue.main.async(){
            self.navigationItem.title = "Weather: "+wArr
                            }
        
        let randomFlower : String!
        
        if(arr=="01d"||arr=="01n"||arr=="02d"||arr=="02n"){
            randomFlower = good.randomElement()
        }
        else{
            randomFlower = bad.randomElement()
        }
        
        
        
       return randomFlower
      
    }
}
