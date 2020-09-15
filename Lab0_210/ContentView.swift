//
//  ContentView.swift
//  Lab0_210
//
//  Created by Helwan Mandé on 2020-09-14.
//  Copyright © 2020 Helwan Mandé. All rights reserved.
//Utilisation du tutoriel a l'adresse : https://medium.com/@suragch/minimal-client-server-example-for-ios-and-node-js-2ef123a0debb

import SwiftUI
import Alamofire

struct ContentView: View {
    
    let urlDemarrerJeu = "http://localhost:3000/api/v1/jeu/demarrerJeu"
    let urlRedemarrerJeu = "http://localhost:3000/api/v1/jeu/redemarrerJeu"
    
    @State var dataString: String
    @State var name: String
    @State var resultats: String
    var body: some View {
        
        VStack{
            
            Image("ets")
                .resizable()
                .frame(width: 200, height: 200)
                .cornerRadius(12)
            HStack{
                Text("JeuDeDés-Node-Express-TS-TDD-LOG210")
                    .font(.title)
                    
            }
            
            
            
            TextField("Nom du nouveau joueur", text: $name)
                
                .padding()
            
            
            
            Button(action: {
                self.demarrer(name: self.name)
            }){
                Text("Démarrer")
                  .padding(.vertical, 10)
                                            .padding(.horizontal, 30)
                                            .foregroundColor(.white)
                                                      .background(Color.gray)
                                                      .clipShape(Capsule())

            }
         
       
            Button(action: {
                self.redemarrerJeu()
            }){
                Text("Redémarrer")
                 .padding(.vertical, 10)
                              .padding(.horizontal, 30)
                              .foregroundColor(.white)
                                        .background(Color.gray)
                                        .clipShape(Capsule())
                    
            }
               .padding()
          
            
            Button(action: {
                self.joueur(name: self.name)
            }){
                Text("Jouer!")
                .padding(.vertical, 10)
                .padding(.horizontal, 30)
                .foregroundColor(.white)
                          .background(Color.gray)
                          .clipShape(Capsule())
            }
            .padding()
            
            
            Text("Joueur")
                .bold()
            
            VStack (){
                
                Text("\(name)")
                Text("Résultats et Debug")
                    .bold()
                    .padding()
                Text("\(self.resultats)")
            }
        }
    }
    func joueur (name: String) {
        guard let url  = URL(string: "http://localhost:3000/api/v1/jeu/jouer/\(name)") else {return}
        var request = URLRequest(url: url)
        request.setValue("Keep-Alive", forHTTPHeaderField: "Connection")
        request.setValue("Cache-Control", forHTTPHeaderField: "no-cache")
        
        request.setValue("/api/v1/jeu/redemarrerJeu", forHTTPHeaderField: "Accept")
        request.setValue("/api/v1/jeu/redemarrerJeu", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error)")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                self.resultats =  String(data: data, encoding: .utf8)!
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            self.resultats =  String(data: data, encoding: .utf8)!
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        task.resume()
    }
    
    //aide :
    //https://stackoverflow.com/questions/26364914/http-request-in-swift-with-post-method
    func demarrer (name: String) {
        
        guard let url  = URL(string: urlDemarrerJeu) else {return}
        var request = URLRequest(url: url)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        //permet de POST avec le bon parametre
        components.queryItems = [
            //@State
            URLQueryItem(name: "nom", value: name)
        ]
        request.httpMethod = "POST"
        let query = components.url!.query
        
        
        request.httpBody = Data(query!.utf8)
        
        //POS la requete avec le bon parametres (name="nom")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error)")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                // check for http errors
                self.resultats =  String(data: data, encoding: .utf8)!
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            let responseString = String(data: data, encoding: .utf8)
            self.resultats =  String(data: data, encoding: .utf8)!
            print("responseString = \(responseString)")
        }
        task.resume()
    }
    func redemarrerJeu (){
        
        guard let url  = URL(string: urlRedemarrerJeu) else {return}
        var request = URLRequest(url: url)
        request.setValue("Keep-Alive", forHTTPHeaderField: "Connection")
        request.setValue("Cache-Control", forHTTPHeaderField: "no-cache")
        
        request.setValue("/api/v1/jeu/redemarrerJeu", forHTTPHeaderField: "Accept")
        request.setValue("/api/v1/jeu/redemarrerJeu", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error)")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                self.resultats =  String(data: data, encoding: .utf8)!
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            let responseString = String(data: data, encoding: .utf8)
            self.resultats =  String(data: data, encoding: .utf8)!
            print("responseString = \(responseString)")
        }
        task.resume()
    }
    
    
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(dataString: "", name: "", resultats: "")
    }
}



