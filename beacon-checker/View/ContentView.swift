//
//  ContentView.swift
//  beacon-checker
//
//  Created by 宮地篤士 on 2020/09/21.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
//    @EnvironmentObject var viewmodel: BeaconLocation
    @ObservedObject var lm = BeaconLocation()
    
    

    var body: some View {
        VStack{
            Text("Beacon Scanner")
                .fontWeight(.heavy)
            Text("TIME: \(self.lm.timestamp)")
//            Text(self.lm.uuid)
            HStack{
                Text("Major: \(self.lm.major)")
                Text("Minor: \(self.lm.minor)")
            }.padding(.vertical, 40)
            
            Text("RSSI: \(self.lm.rssi)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 30.0)
            Button(action: {self.lm.startScan()}){
                Text("Scan!")
                    .foregroundColor(Color.white)
                    .padding(EdgeInsets(
                    top: 10, leading: 40, bottom: 10, trailing: 40
                    ))
                    .background(Color.black)
                    .cornerRadius(10)
            }.padding(.bottom, 20)
            Button(action: {self.lm.stopScan()}){
                Text("Stop!")
                    .foregroundColor(Color.white)
                    .padding(EdgeInsets(
                    top: 10, leading: 40, bottom: 10, trailing: 40
                    ))
                    .background(Color.black)
                    .cornerRadius(10)
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
