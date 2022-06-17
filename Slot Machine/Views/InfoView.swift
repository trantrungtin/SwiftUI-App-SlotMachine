//
//  InfoView.swift
//  Slot Machine
//
//  Created by Tin Tran on 17/06/2022.
//

import SwiftUI

struct InfoView: View {
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            LogoView()
            Spacer()
            Form {
                Section(header: Text("About the application")) {
                    FormRawView(firstItem: "Application", secondItem: "Slot Machine")
                    FormRawView(firstItem: "Platforms", secondItem: "iPhone, iPad, Mac")
                    FormRawView(firstItem: "Developer", secondItem: "Tin Tran")
                    FormRawView(firstItem: "Copyright", secondItem: "© 2022 All rights reserved.")
                    FormRawView(firstItem: "Version", secondItem: "1.0.0")
                }
            }
            .font(.system(.body, design: .rounded))
        }
        .padding(.top, 40)
        .overlay(
            Button(action: {
                stopSound()
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark.circle")
                    .font(.title)
            }
                .padding(.top, 30)
                .padding(.trailing, 20)
                .accentColor(.secondary)
            , alignment: .topTrailing
        )
        .onAppear {
            playSoundFile(.background)
        }
    }
}

struct FormRawView: View {
    var firstItem: String
    var secondItem: String
    var body: some View {
        HStack {
            Text(firstItem).foregroundColor(.gray)
            Spacer()
            Text(secondItem)
        }
    }
}


// MARK: - PREVIEW
struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}

