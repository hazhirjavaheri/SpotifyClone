//
//  PlayListView.swift
//  SpotifyClone
//
//  Created by Hajir Javaheri on 6/7/1400 AP.
//

import SwiftUI

struct PlayListView: View {
    @EnvironmentObject var playback: Playback
    @Binding var offset: CGFloat
    let height = UIScreen.main.bounds.size.height
    let ratio = UIScreen.main.bounds.size.height / 896
    let minOffset: CGFloat = -410
    let gredientHeight: CGFloat = 100.0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            GeometryReader { geo -> AnyView? in
                offset = max(geo.frame(in: .global).minY, -height / 2)
                return nil
            }
            VStack(spacing: 0) {
                LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)
                    .frame(height: gredientHeight * ratio)
                VStack(spacing: 0) {
                    ForEach(playback.playlist) { song in
                       PlayListItem(song: song)
                            .transition(.slide)
                    }
                    Rectangle()
                        .frame(height: 300 * ratio, alignment: .center)
                }
                .background(Color.black)
            }
            .padding(.top, 390 * ratio)
        }
        .ignoresSafeArea(edges: .all)
        .onAppear(perform: {
            NotificationCenter.default.addObserver(
                forName: NSNotification.Name("Finish"), object: nil, queue: .main) { _ in
                playback.finished = true
                playback.next()
            }
        })
    }
}

struct PlayListView_Previews: PreviewProvider {
    static let playback = Playback()

    static var previews: some View {
        PlayListView(offset: .constant(0))
            .environmentObject(playback)
    }
}
