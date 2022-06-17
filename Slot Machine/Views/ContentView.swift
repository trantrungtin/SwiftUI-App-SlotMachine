//
//  ContentView.swift
//  Slot Machine
//
//  Created by Tin Tran on 17/06/2022.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES

    // MARK: - BODY
    var body: some View {
        ZStack {
            // MARK: - BACKGROUND
            LinearGradient(gradient: Gradient(colors: [colorPink, colorPurple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            // MARK: - INTERFACE
            VStack(alignment: .center, spacing: 5) {
                // MARK: - HEADER
                LogoView()
                Spacer()

                // MARK: - SCORE
                HStack {
                    HStack {
                        Text("Your\nCoins".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.trailing)
                        
                        Text("100")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    }
                    .modifier(ScoreContainerModifier())
                    
                    Spacer()
                    
                    HStack {
                        Text("200")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                        
                        Text("High\nScore".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.leading)
                        
                    }
                    .modifier(ScoreContainerModifier())
                }

                // MARK: - SLOT MACHINE
                VStack(alignment: .center, spacing: 0) {
                    ZStack {
                        ReelView()
                        Image("gfx-bell")
                            .resizable()
                            .modifier(ImageModifier())
                    }
                    
                    HStack(alignment: .center, spacing: 0) {
                        ZStack {
                            ReelView()
                            Image("gfx-seven")
                                .resizable()
                                .modifier(ImageModifier())
                        }
                        
                        Spacer()
                        
                        ZStack {
                            ReelView()
                            Image("gfx-cherry")
                                .resizable()
                                .modifier(ImageModifier())
                        }
                    }
                    
                    Button(action: {
                        
                    }) {
                        Image("gfx-spin")
                            .renderingMode(.original)
                            .resizable()
                            .modifier(ImageModifier())
                    }
                }
                .layoutPriority(2)

                // MARK: - FOOTER
                
                Spacer()
                
                HStack {
                    HStack {
                        // MARK: - BET 20
                        Button(action: {
                            
                        }) {
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .modifier(BetNumberModifier())
                            
                        }
                        .modifier(BetCapsuleModifier())
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(0)
                            .modifier(CasinoChipsModifier())
                    }
                    
                    HStack {
                        // MARK: - BET 10
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(1)
                            .modifier(CasinoChipsModifier())
                        
                        Button(action: {
                            
                        }) {
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundColor(.yellow)
                                .modifier(BetNumberModifier())
                            
                        }
                        .modifier(BetCapsuleModifier())
                        
                    }
                }
            }
            .overlay(
                Button(action: {

                }) {
                    Image(systemName: "arrow.2.circlepath.circle")
                }
                    .modifier(ButtonModifier()),
                alignment: .topLeading
            )
            .overlay(
                Button(action: {

                }) {
                    Image(systemName: "info.circle")
                }
                    .modifier(ButtonModifier()),
                alignment: .topTrailing
            )
            .padding()
            .frame(maxWidth: 720)

            // MARK: - POPUP
        } //: ZSTACK
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
