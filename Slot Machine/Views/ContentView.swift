//
//  ContentView.swift
//  Slot Machine
//
//  Created by Tin Tran on 17/06/2022.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    @State private var showingInfoView = false
    @State private var highscore: Int = UserDefaults.standard.integer(forKey: keyHighScore)
    @State private var coins: Int = 100
    @State private var betAmount: Int = 10
    @State private var reels: Array = [0, 1, 2]
    @State private var isActiveBet10: Bool = true
    @State private var isActiveBet20: Bool = false
    @State private var showingModel: Bool = false
    @State private var animatingSymbol: Bool = false
    @State private var animatingModel: Bool = false
    let symbols = ["gfx-bell", "gfx-cherry", "gfx-coin", "gfx-grape", "gfx-seven", "gfx-strawberry"]
    
    // MARK: - FUNCTIONS
    
    private func spinReels() {
        reels = reels.map({_ in
            Int.random(in: 0...symbols.count-1)
        })
    }
    
    private func checkWinning() {
        if reels[0] == reels[1] && reels[1] == reels[2] && reels[2] == reels[0] {
            playerWins()
            if coins > highscore {
                newHighScore()
            }
        } else {
            playerLoses()
        }
    }
    
    private func playerWins() {
        coins += betAmount * 10
    }
    
    private func newHighScore() {
        highscore = coins
        UserDefaults.standard.set(highscore, forKey: keyHighScore)
    }
    
    private func playerLoses() {
        coins -= betAmount
    }
    
    private func activateBet20() {
        betAmount = 20
        isActiveBet20 = true
        isActiveBet10 = false
    }
    
    private func activateBet10() {
        betAmount = 10
        isActiveBet20 = false
        isActiveBet10 = true
    }
    
    private func isGameOver() {
        if coins <= 0 {
            showingModel = true
        }
    }
    
    private func resetGame() {
        UserDefaults.standard.set(0, forKey: keyHighScore)
        highscore = 0
        coins = 100
        activateBet10()
    }

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
                        
                        Text("\(coins)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    }
                    .modifier(ScoreContainerModifier())
                    
                    Spacer()
                    
                    HStack {
                        Text("\(highscore)")
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
                    // MARK: - REEL #1
                    ZStack {
                        ReelView()
                        Image(symbols[reels[0]])
                            .resizable()
                            .modifier(ImageModifier())
                            .opacity(animatingSymbol ? 1 : 0)
                            .offset(y: animatingSymbol ? 0 : -50)
                            .animation(.easeOut(duration: Double.random(in: 0.5...0.7)))
                            .onAppear {
                                self.animatingSymbol.toggle()
                            }
                    }
                    
                    HStack(alignment: .center, spacing: 0) {
                        // MARK: - REEL #2
                        ZStack {
                            ReelView()
                            Image(symbols[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ? 1 : 0)
                                .offset(y: animatingSymbol ? 0 : -50)
                                .animation(.easeOut(duration: Double.random(in: 0.7...0.9)))                                .onAppear {
                                    self.animatingSymbol.toggle()
                                }
                        }
                        
                        Spacer()
                        
                        // MARK: - REEL #3
                        ZStack {
                            ReelView()
                            Image(symbols[reels[2]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ? 1 : 0)
                                .offset(y: animatingSymbol ? 0 : -50)
                                .animation(.easeOut(duration: Double.random(in: 0.9...1.1)))                                .onAppear {
                                    self.animatingSymbol.toggle()
                                }
                        }
                    }
                    
                    // MARK: - SPIN BUTTON
                    Button(action: {
                        withAnimation {
                            self.animatingSymbol = false
                        }
                        
                        self.spinReels()
                        
                        withAnimation {
                            self.animatingSymbol = true
                        }
                        
                        self.checkWinning()
                        self.isGameOver()
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
                            self.activateBet20()
                        }) {
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor(isActiveBet20 ? colorYellow : .white)
                                .modifier(BetNumberModifier())
                            
                        }
                        .modifier(BetCapsuleModifier())
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .offset(x: isActiveBet20 ? 0 : 20)
                            .opacity(isActiveBet20 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                    }
                    
                    Spacer()
                    
                    HStack {
                        // MARK: - BET 10
                        Image("gfx-casino-chips")
                            .resizable()
                            .offset(x: isActiveBet10 ? 0 : -20)
                            .opacity(isActiveBet10 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                        
                        Button(action: {
                            self.activateBet10()
                        }) {
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundColor(isActiveBet10 ? colorYellow : .white)
                                .modifier(BetNumberModifier())
                            
                        }
                        .modifier(BetCapsuleModifier())
                        
                    }
                }
            }
            // MARK: - BUTTONS
            .overlay(
                Button(action: {
                    self.resetGame()
                }) {
                    Image(systemName: "arrow.2.circlepath.circle")
                }
                    .modifier(ButtonModifier()),
                alignment: .topLeading
            )
            .overlay(
                Button(action: {
                    self.showingInfoView = true
                }) {
                    Image(systemName: "info.circle")
                }
                    .modifier(ButtonModifier()),
                alignment: .topTrailing
            )
            .padding()
            .frame(maxWidth: 720)
            .blur(radius: $showingModel.wrappedValue ? 5 : 0, opaque: false)

            // MARK: - POPUP
            if $showingModel.wrappedValue {
                ZStack {
                    colorTransparentBlack.edgesIgnoringSafeArea(.all)
                    VStack(spacing: 0) {
                        Text("GAME OVER")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(colorPink)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        VStack(alignment: .center, spacing: 16) {
                            Image("gfx-seven-reel")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 72)
                            
                            Text("Bad luck! You lost all of the coins. \nLet's play again!")
                                .font(.system(.body, design: .rounded))
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                                .layoutPriority(1)
                            
                            Button(action: {
                                self.showingModel = false
                                self.animatingModel = false
                                self.coins = 100
                                self.activateBet10()
                            }) {
                                Text("New Game".uppercased())
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.semibold)
                                    .accentColor(colorPink)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .frame(minWidth: 180)
                                    .background(
                                        Capsule()
                                            .strokeBorder(lineWidth: 1.75)
                                            .foregroundColor(colorPink)
                                    )
                            }
                            
                        }
                        
                        Spacer()
                    }
                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 260, idealHeight: 280, maxHeight: 320, alignment: .center)
                    .background(.white)
                    .cornerRadius(20)
                    .shadow(color: colorTransparentBlack, radius: 6, x: 0, y: 8)
                    .opacity($animatingModel.wrappedValue ? 1 : 0)
                    .offset(y: $animatingModel.wrappedValue ? 0 : -100)
                    .animation(Animation.spring(response: 0.5, dampingFraction: 1.0, blendDuration: 1.0))
                    .onAppear {
                        self.animatingModel = true
                    }
                }
            }
            
        } //: ZSTACK
        .sheet(isPresented: $showingInfoView) {
            InfoView()
        }
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13 Pro")
    }
}
