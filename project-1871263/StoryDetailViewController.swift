//
//  StoryDetailViewController.swift
//  ch08-1234567-cameraCoreML
//
//  Created by mac021 on 2021/05/30.
//

import UIKit

class StoryDetailViewController: UIViewController {

    @IBOutlet weak var flowerLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var myRow: Int?
    var operationQueue: OperationQueue!
    
    var urlArr = ["https://upload.wikimedia.org/wikipedia/ko/thumb/e/e2/%EC%84%9C%EC%9A%B8%EC%8B%9C%EC%A7%80%EC%8B%9D%EA%B3%B5%EC%9C%A0115.JPG/375px-%EC%84%9C%EC%9A%B8%EC%8B%9C%EC%A7%80%EC%8B%9D%EA%B3%B5%EC%9C%A0115.JPG", "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7d/Rhododendron_mucronulatum4.jpg/375px-Rhododendron_mucronulatum4.jpg", "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/Prunus_sargentii_%28Moscow%29_08.JPG/180px-Prunus_sargentii_%28Moscow%29_08.JPG", "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Tulip_-_floriade_canberra03.jpg/375px-Tulip_-_floriade_canberra03.jpg", "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Brassica_napus_LC0027.jpg/330px-Brassica_napus_LC0027.jpg", "https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Mindlre.jpg/330px-Mindlre.jpg", "https://upload.wikimedia.org/wikipedia/commons/thumb/1/10/PharbitisNil5.jpg/375px-PharbitisNil5.jpg", "https://upload.wikimedia.org/wikipedia/commons/thumb/4/40/Sunflower_sky_backdrop.jpg/375px-Sunflower_sky_backdrop.jpg", "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Gangneung-1.jpg/405px-Gangneung-1.jpg", "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Nelumno_nucifera_open_flower_-_botanic_garden_adelaide2.jpg/375px-Nelumno_nucifera_open_flower_-_botanic_garden_adelaide2.jpg", "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/Cosmos_bipinnatus03.jpg/375px-Cosmos_bipinnatus03.jpg", "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Miscanthus_sinensis0842.JPG/375px-Miscanthus_sinensis0842.JPG", "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/%EB%A9%94%EB%B0%80.JPG/375px-%EB%A9%94%EB%B0%80.JPG", "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/Zinnia_elegans_01.jpg/375px-Zinnia_elegans_01.jpg", "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c9/Portulaca_grandiflora2.jpg/375px-Portulaca_grandiflora2.jpg", "https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Narzisse.jpg/375px-Narzisse.jpg", "https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/CliviaMiniata.jpg/375px-CliviaMiniata.jpg", "https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/FreesiaRefracta2.jpg/375px-FreesiaRefracta2.jpg", "https://upload.wikimedia.org/wikipedia/commons/thumb/6/67/Kalanchoe.blossfeldiana.jpg/306px-Kalanchoe.blossfeldiana.jpg", "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5f/W_hukujusou4031.jpg/375px-W_hukujusou4031.jpg"
    ]
    
    var storyArr = ["희망", "사랑의 기쁨", "순결", "영원한 사랑", "쾌활", "감사", "덧없는 사랑", "숭배", "영원", "청정", "순정", "활력", "연인", "인연", "순진", "자존심", "고귀", "새 출발", "설렘", "영원한 행복"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Flower Story"

        operationQueue = OperationQueue()
        // Do any additional setup after loading the view.
    }


}


extension StoryDetailViewController{
    override func viewWillAppear(_ animated: Bool) {
        
        operationQueue.addOperation {
            let url = URL(string: self.urlArr[self.myRow!])!
                if let imageData = try? Data(contentsOf: url){
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data:imageData)
                        self.flowerLabel.text = "[꽃말: "+self.storyArr[self.myRow!]+"]"
                    }
                }
            }
        
    }
}
