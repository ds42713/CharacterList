//
//  ContentView.swift
//  CharacterList
//
//  Created by Pongsakorn Praditkanok on 16/9/2563 BE.
//  Copyright © 2563 Ds42713. All rights reserved.
//

import SwiftUI
import Alamofire
import struct Kingfisher.KFImage
import SwiftUIRefresh

struct ContentView: View {
    @State var CharacterData:[Result] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.CharacterData, id: \.id) { item in
                    NavigationLink(destination:
                        VStack(alignment: .leading) {
                            KFImage(URL(string: item.image))
                            Text("Name : \(item.name)")
                            Text("Status : \(item.status.rawValue)")
                            Text("Species : \(item.species.rawValue)")
                            Text("Gender : \(item.gender.rawValue)")
                    }
                    ) {
                        HStack {
                            Text("Name : \(item.name)")
                        }
                    }
                }
            }.navigationBarTitle("Character")
                .onAppear { self.feeddata() }
        }
    }
    func feeddata()  {
        let url = "https://rickandmortyapi.com/api/character/"
        AF.request(url, method: .get).responseJSON { (response) in
            switch response.result {
            case .success: print(response.value)
            do {
                let result = try JSONDecoder().decode(APICharacter.self, from: response.data!)
                self.CharacterData.removeAll()
                self.CharacterData = result.results
            } catch{
                print(error.localizedDescription)
                }
            case .failure(let err) : print(err.responseCode)
                
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

