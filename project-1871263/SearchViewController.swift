//
//  SearchViewController.swift
//  ch08-1234567-cameraCoreML
//
//  Created by mac021 on 2021/05/25.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchButton: UIButton!

    @IBOutlet weak var pickerView: UIPickerView!
    
    var cities: [String: [String:Double]] = [
        "Seoul" : ["lon":126.9778,"lat":37.5683], "Athens" : ["lon":23.7162,"lat":37.9795],
        "Bangkok" : ["lon":100.5167,"lat":13.75], "Berlin" : ["lon":13.4105,"lat":52.5244],
        "Jerusalem" : ["lon":35.2163,"lat":31.769], "Lisbon" : ["lon":-9.1333,"lat":38.7167],
        "London" : ["lon":-0.1257,"lat":51.5085], "New York" : ["lon":-74.006,"lat":40.7143],
        "Paris" : ["lon":2.3488,"lat":48.8534], "Sydney" : ["lon":151.2073,"lat":-33.8679]
    ]
    
    

}

extension SearchViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        self.navigationItem.title = "Weather"
    }
    
}

extension SearchViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Array(cities.keys).count
    }
}

extension SearchViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let sorted = Array(cities.keys).sorted()
        return sorted[row]
    }
}

extension SearchViewController{
    func getCurrentLonLat() -> (String, Double?, Double?){
        var cityNames = Array(cities.keys)
        cityNames.sort()
        let selectedIndex = pickerView.selectedRow(inComponent: 0)
        let selectedCity = cityNames[selectedIndex]
        let city = cities[selectedCity]
        return (selectedCity, city!["lon"], city!["lat"])
    }
}


extension SearchViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let infoViewController = segue.destination as! InfoViewController
        let (city, longitute, latitute) = getCurrentLonLat()
        infoViewController.city = city
        infoViewController.stilFlower = "no"
    }
}

