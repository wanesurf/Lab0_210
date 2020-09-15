//
//  ContentView.swift
//  Lab0_210
//
//  Created by Helwan Mandé on 2020-09-14.
//  Copyright © 2020 Helwan Mandé. All rights reserved.
//Utilisation du tutoriel a l'adresse : https://medium.com/@suragch/minimal-client-server-example-for-ios-and-node-js-2ef123a0debb

import SwiftUI

struct ContentView: View {
    
    let routeDemarrerJeu = "http://localhost:3000/api/v1/jeu/demarrerJeu"
    
    @State var dataString: String
    @State var name: String
    var body: some View {
      
        VStack{
            
            HStack{
                Text("JeuDeDés-Node-Express-TS-TDD-LOG210")
            }
            
         
    
            TextField("Nom du nouveau joueur", text: $name)
                
                        .padding()
                
                
            
            Button(action: {
                self.demarrer(name: self.name)
            }){
                Text("Démarrer")
            }
            .padding()
            Button(action: {
                 print("")
            }){
                Text("Redémarrer")
            }
            .padding()
            
            Text("Joueurs")
            .bold()
            
            HStack (){
                
                Text("\(name)")
            }
        }
    }
    
    func demarrer (name: String) {
         guard let url  = URL(string: routeDemarrerJeu) else {return}
         var request = URLRequest(url: url)
        
//        request.setValue("/demarrerJeu", forHTTPHeaderField: "Accept")
//                request.setValue("/demarrerJeu", forHTTPHeaderField: "Content-Type")
                request.httpMethod = "POST"
        let postString = "cadcad"
            request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error)")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        task.resume()
    }
    func redemarrerJeu (){
        
         guard let url  = URL(string: routeDemarrerJeu) else {return}
         var request = URLRequest(url: url)
        request.setValue("Keep-Alive", forHTTPHeaderField: "Connection")
        request.setValue("Cache-Control", forHTTPHeaderField: "no-cache")
        
        request.setValue("/api/v1/jeu/redemarrerJeu", forHTTPHeaderField: "Accept")
         request.setValue("/api/v1/jeu/redemarrerJeu", forHTTPHeaderField: "Content-Type")
         request.httpMethod = "GET"
         //let postString = "name=henry&message=HelloWorld"
       //  request.httpBody = postString.data(using: .utf8)
         let task = URLSession.shared.dataTask(with: request) { data, response, error in
             guard let data = data, error == nil else {
                 print("error=\(error)")
                 return
             }
             if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                 print("statusCode should be 200, but is \(httpStatus.statusCode)")
                 print("response = \(response)")
             }
             let responseString = String(data: data, encoding: .utf8)
             print("responseString = \(responseString)")
         }
         task.resume()
    }
 

        
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(dataString: "", name: "")
    }
}


