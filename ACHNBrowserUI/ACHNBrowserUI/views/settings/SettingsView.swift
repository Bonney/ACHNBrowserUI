//
//  SettingsView.swift
//  ACHNBrowserUI
//
//  Created by Thomas Ricouard on 18/04/2020.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import SwiftUI
import SwiftUIKit
import Backend

struct SettingsView: View {
    @EnvironmentObject private var subscriptionManager: SubscriptionManager
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var appUserDefaults = AppUserDefaults.shared

    @State private var passportOffset: CGFloat = -400

    var closeButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark.circle.fill")
                .style(appStyle: .barButton)
                .foregroundColor(.acText)
        })
            .buttonStyle(BorderedBarButtonStyle())
            .accentColor(Color.acText.opacity(0.2))
            .safeHoverEffectBarItem(position: .leading)
    }

    var passport: some View {
        PassportView()
            .padding(.bottom)
            .scaleEffect(self.passportOffset == 0 ? 1.0 : 0.5)
            .opacity(self.passportOffset == 0 ? 1.0 : 0.0)
//            .offset(x: passportOffset, y: 0)
//            .rotationEffect(.degrees(passportOffset == 0 ? 0 : -15))
            .animation(Animation.spring().delay(0.25))
            .onAppear { self.passportOffset = 0 }
            .onDisappear { self.passportOffset = 400 }
    }

    var passportHeader: some View {
        Group {
            if !(appUserDefaults.islandName.isEmpty || appUserDefaults.islandName == "") {
                passport
            } else {
                SectionHeaderView(text: "Set Up Your Passport!", icon: "book.fill")
            }
        }
    }

    var body: some View {
        NavigationView {
            Form {

                Section(header: passportHeader) {
                    NavigationLink(destination: IslandSettingsView()) {
                        Text("Edit Island Details")
                    }
                }

                Section {
                    if UIApplication.shared.supportsAlternateIcons && UIDevice.current.userInterfaceIdiom != .pad {
                        NavigationLink(destination: AppIconPickerView()) {
                            Text("Change App Icon")
                        }
                    }

                    Button(action: {
                        self.subscriptionManager.restorePurchase()
                    }) {
                        if self.subscriptionManager.subscriptionStatus == .subscribed {
                            Text("You're subscribed to AC Helper+")
                                .foregroundColor(.acSecondaryText)
                        } else {
                            Text("Restore Purchase")
                                .foregroundColor(.acHeaderBackground)
                        }
                    }
                    .disabled(subscriptionManager.inPaymentProgress)
                    .opacity(subscriptionManager.inPaymentProgress ? 0.5 : 1.0)
                }
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle(Text("Preferences"))
            .navigationBarItems(leading: closeButton)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(SubscriptionManager.shared)
    }
}
