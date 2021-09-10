//
//  StoryViewController.swift
//  ch08-1234567-cameraCoreML
//
//  Created by mac021 on 2021/05/26.
//

import UIKit

class StoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var flowerArr = ["개나리", "진달래", "벚꽃", "튤립", "유채꽃", "민들레", "나팔꽃", "해바라기", "무궁화", "연꽃", "코스모스", "억새", "메밀꽃", "백일홍", "채송화", "수선화", "군자란", "프리지아", "카랑코에", "복수초"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        self.navigationItem.title = "Flowers"
    }

}

extension StoryViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flowerArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlowerTableViewCell") as! UITableViewCell
        
        cell.textLabel!.text = self.flowerArr[indexPath.row]
        
        let imageName = "Icon-20.png"
        let image = UIImage(named: imageName)
        cell.imageView!.image = image
        
        return cell
    }
}

extension StoryViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
         let storyDetailViewController = segue.destination as! StoryDetailViewController
         if let row = tableView.indexPathForSelectedRow?.row{
            storyDetailViewController.myRow = row
         }
     }

}
