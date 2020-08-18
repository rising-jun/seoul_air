//
//  MainViewController.swift
//  FirstMVVMproject
//
//  Created by 김동준 on 2020/07/16.
//  Copyright © 2020 김동준. All rights reserved.
//

import UIKit
import SnapKit
import CoreLocation
class SplashViewController : UIViewController,CLLocationManagerDelegate{
   
    private var locationManager: CLLocationManager!
    private var weatherService: WeatherDataService = WeatherDataService()
    private let appNameLabel = UILabel()
    private let appIcon = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(displayP3Red: 0/255, green: 102/255, blue: 255/255, alpha: 1)
        self.view.addSubview(appIcon)
        self.view.addSubview(appNameLabel)
        
        let img = UIImage(named: "splash_icon.png")
        appIcon.image = img
        appIcon.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-420 * view.frame.height / 812)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(150 * view.frame.width / 375)
            make.width.equalTo(76.9 * view.frame.width / 375)
            make.height.equalTo(42.8 * view.frame.height / 812)
        }
        
        appNameLabel.text = "지금, 공기 어때?"
        appNameLabel.font = appNameLabel.font.withSize(28)
        appNameLabel.textColor = .white
        appNameLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-349 * view.frame.height / 812)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(104 * view.frame.width / 375)
            make.width.equalTo(184 * view.frame.width / 375)
            make.height.equalTo(31 * view.frame.height / 812)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
     sleep(2)
        
     locationManager = CLLocationManager()
     locationManager.delegate = self
     locationManager.desiredAccuracy = kCLLocationAccuracyBest

     
    let status = CLLocationManager.authorizationStatus()
    switch status {
        // 1
    case .notDetermined:
        print("notDetermined")
        locationManager.requestWhenInUseAuthorization()
       
        break

        // 2
    case .denied, .restricted:
        print("denied")
        deniedPermission()
        break
    case .authorizedAlways, .authorizedWhenInUse:
        locationManager.startUpdatingLocation()
        print("ok")
        break
    }

        
        
}
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
       
        if status == .authorizedWhenInUse{
            moveToMainScreen()
        }else if status == .denied || status == .restricted{
            deniedPermission()
        }
        
        
    }
    
    private func deniedPermission(){
        let alter = UIAlertController(title: "위치권한 설정이 '안함'으로 되어있습니다.", message: "앱 설정 화면으로 가시겠습니까? \n '아니오'를 선택하시면 앱이 종료됩니다.", preferredStyle: UIAlertController.Style.alert)
        let logOkAction = UIAlertAction(title: "네", style: UIAlertAction.Style.default){
            (action: UIAlertAction) in
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(NSURL(string:UIApplication.openSettingsURLString)! as URL)
            } else {
                UIApplication.shared.openURL(NSURL(string: UIApplication.openSettingsURLString)! as URL)
            }
        }
        let logNoAction = UIAlertAction(title: "아니오", style: UIAlertAction.Style.destructive){
            (action: UIAlertAction) in
            exit(0)
        }
        
        alter.addAction(logNoAction)
        alter.addAction(logOkAction)
        self.present(alter, animated: true, completion: nil)
    }
    
    private func moveToMainScreen(){
        weatherService.bringAirInfoList().bind { (airInfoList) in
            let mvc = MainViewController()
            mvc.modalPresentationStyle = .fullScreen
            mvc.setAirInfoList(airInfoList: airInfoList)
            let coor = self.locationManager.location?.coordinate
            var lat = coor?.latitude ?? 0.0
            var lng = coor?.longitude ?? 0.0
            mvc.setPoint(lat: lat, lng: lng)
            self.present(mvc,animated: true, completion: nil)
        }
    }
    
}

