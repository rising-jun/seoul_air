//
//  PermissionChecking.swift
//  FirstMVVMproject
//
//  Created by 김동준 on 2020/07/28.
//  Copyright © 2020 김동준. All rights reserved.
//

import Foundation
import CoreLocation
class PermissionChecking: CLLocationManagerDelegate{
//
//    var locationManager: CLLocationManager!
//
//    func updateInfo(airInfoList: Array<AirInfo>){
//        print("\(airInfoList.count) main view")
//    }
//
//    func checkLocationPermission(){
//        let status = CLLocationManager.authorizationStatus()
//               if status == CLAuthorizationStatus.denied || status == CLAuthorizationStatus.restricted {
//                print("find")
//                   locationManager.delegate = self
//                   locationManager.requestWhenInUseAuthorization()
//                   locationManager.desiredAccuracy = kCLLocationAccuracyBest
//                   locationManager.startUpdatingLocation()
//
//               }else{
//                   print("good")
//                let mvc = MainViewController()
//                mvc.modalPresentationStyle = .fullScreen
//                self.present(mvc,animated: true, completion: nil)
//        }
//    }
//    func getLocation(){
//        var locationManager: CLLocationManager!
//        locationManager = CLLocationManager()
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.startUpdatingLocation()
//
//        let coor = locationManager.location?.coordinate
//        var lat = coor?.latitude
//        var lng = coor?.longitude
//        print("lat \(lat) lng \(lng)")
//        if(lat == nil || lng == nil){
//
//        }
//    }
//
//    func presentScreen(consent: Bool){
//        let mvc = MainViewController()
//        mvc.modalPresentationStyle = .fullScreen
//        self.present(mvc,animated: true, completion: nil)
//    }
//
//    func checkLocationPermission2(){
//        let status = CLLocationManager.authorizationStatus()
//        if status == CLAuthorizationStatus.denied || status == CLAuthorizationStatus.restricted {
//            print("noo")
//            let alter = UIAlertController(title: "위치권한 설정이 '안함'으로 되어있습니다.", message: "앱 설정 화면으로 가시겠습니까? \n '아니오'를 선택하시면 앱이 종료됩니다.", preferredStyle: UIAlertController.Style.alert)
//            let logOkAction = UIAlertAction(title: "네", style: UIAlertAction.Style.default){
//                (action: UIAlertAction) in
//                if #available(iOS 10.0, *) {
//                    UIApplication.shared.open(NSURL(string:UIApplication.openSettingsURLString)! as URL)
//                } else {
//                    UIApplication.shared.openURL(NSURL(string: UIApplication.openSettingsURLString)! as URL)
//                }
//            }
//            let logNoAction = UIAlertAction(title: "아니오", style: UIAlertAction.Style.destructive){
//                (action: UIAlertAction) in
//                exit(0)
//            }
//            alter.addAction(logNoAction)
//            alter.addAction(logOkAction)
//            self.present(alter, animated: true, completion: nil)
//            
//        }else{
//           print("already okay")
//        }
//    }
}
