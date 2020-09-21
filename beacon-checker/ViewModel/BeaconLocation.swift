//
//  BeaconLocation.swift
//  beacon-checker
//
//  Created by 宮地篤士 on 2020/09/21.
//

import SwiftUI
import CoreLocation

class BeaconLocation: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var uuid: String = "UUID"
    @Published var major: Int = 0
    @Published var minor: Int = 0
    @Published var rssi: Int = 0
    @Published var timestamp: String = "Please Wait"
    
    //beaconの値取得関係の変数
    var trackLocationManager : CLLocationManager!
    var beaconRegion : CLBeaconRegion!
    
//    let dt = Date()
//    let dateFormatter = DateFormatter()
//    dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")

    
    override init() {
        super.init()
        
        

        // ロケーションマネージャを作成する
        trackLocationManager = CLLocationManager();

        // デリゲートを自身に設定
        trackLocationManager.delegate = self;

        // BeaconのUUIDを設定
        let uuid:UUID? = UUID(uuidString: "00000000-017C-1001-B000-001C4DB7979C")

        //Beacon領域を作成
        beaconRegion = CLBeaconRegion(uuid: uuid!, identifier: "TestBeaconIdentifier")

        // セキュリティ認証のステータスを取得
        let status = CLLocationManager.authorizationStatus()
        // まだ認証が得られていない場合は、認証ダイアログを表示
        if(status == CLAuthorizationStatus.notDetermined) {
            trackLocationManager.requestWhenInUseAuthorization()
        }
    }

    //位置認証のステータスが変更された時に呼ばれる
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        //観測を開始させる
//        trackLocationManager.startMonitoring(for: self.beaconRegion)
//    }

    //観測の開始に成功すると呼ばれる
//    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
//        //観測開始に成功したら、領域内にいるかどうかの判定をおこなう。→（didDetermineState）へ
//        trackLocationManager.requestState(for: self.beaconRegion)
//    }

    //領域内にいるかどうかを判定する
//    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for inRegion: CLRegion) {
//
//        switch (state) {
//        case .inside: // すでに領域内にいる場合は（didEnterRegion）は呼ばれない
//            trackLocationManager.startRangingBeacons(in: beaconRegion)
//            // →(didRangeBeacons)で測定をはじめる
//            break
//
//        case .outside:
//            // 領域外→領域に入った場合はdidEnterRegionが呼ばれる
//            break
//
//        case .unknown:
//            // 不明→領域に入った場合はdidEnterRegionが呼ばれる
//            break
//
//        }
//    }

    //領域に入った時
//    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
//        // →(didRangeBeacons)で測定をはじめる
//        self.trackLocationManager.startRangingBeacons(in: self.beaconRegion)
//    }

    //領域から出た時
//    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
//        //測定を停止する
//        self.trackLocationManager.stopRangingBeacons(in: self.beaconRegion)
//    }
    
    
    // 測定開始
    func startScan(){
        print("Start!")
        self.trackLocationManager.startRangingBeacons(in: self.beaconRegion)
    }
    
    // 測定停止
    func stopScan(){
        print("Stop!!")
        self.trackLocationManager.stopRangingBeacons(in: self.beaconRegion)
    }
    
        

    //領域内にいるので測定をする
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion){
        
        let date = beacons[0].timestamp
//        print(date.toStringWithCurrentLocale())
        self.timestamp = date.toStringWithCurrentLocale()
        self.uuid = beacons[0].proximityUUID.uuidString
        self.major = beacons[0].major.intValue
        self.minor = beacons[0].minor.intValue
        self.rssi = beacons[0].rssi
        print("Start!")
        print(self.uuid)
        print(self.major)
        print(self.minor)
        print(self.rssi)
        /*
         beaconから取得できるデータ
         proximityUUID   :   regionの識別子
         major           :   識別子１
         minor           :   識別子２
         proximity       :   相対距離
         accuracy        :   精度
         rssi            :   電波強度
         */
    }

}

extension Date {
    func toStringWithCurrentLocale() -> String {

        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        return formatter.string(from: self)
    }
}



struct BeaconLocation_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, World!")
    }
}
