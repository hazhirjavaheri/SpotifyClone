//
//  ContentView.swift
//  SpotifyClone
//
//  Created by Hajir Javaheri on 6/7/1400 AP.
//

import SwiftUI

enum Tab {
    case home, search, library, premium
}

struct ContentView: View {
    @EnvironmentObject var playback: Playback
    @State private var selection: Tab = .library

    init() {
        UITabBar.appearance().barTintColor = UIColor.black
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                Text("Home")
                    .tabItem { Label("Home", systemImage: "house.fill")
                    }.tag(Tab.home)
                Text("Search")
                    .tabItem { Label("Search", systemImage: "magnifyingglass")
                    }.tag(Tab.search)
                PlayListPage()
                    .tabItem { Label("Your Library", systemImage: "star")
                    }.tag(Tab.library)
                Text("Premium")
                    .tabItem { Label("Premium", systemImage: "person.circle")
                    }.tag(Tab.premium)
            }
            .accentColor(.white)
            .font(.system(size: 40))
            
            if let _ = playback.currentSong {
                MiniPlayer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Playback())
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        ContentView()
            .environmentObject(Playback())
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
    }
}
