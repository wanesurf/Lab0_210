//
//  ContentView.swift
//  Lab0_210
//
//  Created by Helwan Mandé on 2020-09-14.
//  Copyright © 2020 Helwan Mandé. All rights reserved.
//Utilisation du tutoriel a l'adresse : https://medium.com/@suragch/minimal-client-server-example-for-ios-and-node-js-2ef123a0debb

import SwiftUI

struct ContentView: View {
    
    let server = "http://localhost:3000"
    
    @State var dataString: String
    var body: some View {
        VStack{
            
            Button(action: {
               self.sendRequestButtonTappled()
                //test ouvrir page sur navigateur safari
//                guard let url = URL(string: self.server) else { return }
//                                                      UIApplication.shared.open(url)
            }){
                Text("Récuperer")
           
            }
        }
    }
 
     func sendRequestButtonTappled () -> String {
        
          guard let url  = URL(string: server) else {return ""}
        
        
        
        // background task to make request with URLSession
               let task = URLSession.shared.dataTask(with: url) {
                   (data, response, error) in
                   if let error = error {
                       print(error)
                       return
                   }
                   guard let data = data else {return}
                   guard let dataString = String(data: data, encoding: String.Encoding.utf8) else {return}
                self.dataString = dataString
                   // update the UI if all went OK
//                   DispatchQueue.main.async {
//                       self.serverResponseLabel.text = dataString
//                   }
               }
               // start the task
               task.resume()
        print(dataString)
        return dataString
           }
        
    
}

//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}


