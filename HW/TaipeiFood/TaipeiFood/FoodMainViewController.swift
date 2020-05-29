//
//  HotelMainViewController.swift
//  TaipeiTravel
//
//  Created by joe feng on 2016/6/6.
//  Copyright © 2016年 hsin. All rights reserved.
//

import UIKit
import CoreLocation

class FoodMainViewController: BaseMainViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 導覽列標題
        self.title = "食物"
        
        // 獲取類型
        self.fetchType = "food"
        
        // 台北美食資料 ID
        self.strTargetID = "fdf50da3-b1ef-4dfe-86fe-4bebebec0bf5" //&limit=3&offset=0"
        
        self.targetUrl = {
            do {
                return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(self.fetchType + ".json")
            } catch {
                fatalError("Error getting file URL from document directory.")
            }
        }()

        // 取得 API 資料
        self.addData()
    }
    
    override func goDetail(_ index: Int) {
        let thisData = self.apiData[self.apiDataForDistance[index].index]
        let title = thisData["stitle"] as? String ?? ""
        let intro = thisData["xbody"] as? String ?? ""
        let type = thisData["CAT2"] as? String ?? ""
        let address = thisData["address"] as? String ?? "無地址資訊"
        
        var latitude = 0.0
        if let num = thisData["latitude"] as? String {
            latitude = Double(num)!
        }
        
        var longitude = 0.0
        if let num = thisData["longitude"] as? String {
            longitude = Double(num)!
        }
        
        let info :[String:AnyObject] = [
            "title" : title as AnyObject,
            "intro" : intro as AnyObject,
            "type" : type as AnyObject,
            "address" : address as AnyObject,
            "latitude" : latitude as AnyObject,
            "longitude" : longitude as AnyObject,
        ]

        print(info["title"] as? String ?? "NO Title")

        let detailViewController = FoodDetailViewController()
        detailViewController.info = info
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}