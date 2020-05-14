//
//  PassportSettingsView.swift
//  ACHNBrowserUI
//
//  Created by Matt Bonney on 5/9/20.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import SwiftUI
import SwiftUIKit
import Backend

struct PassportSettingsView: View {
    @ObservedObject var appUserDefaults = AppUserDefaults.shared

    var body: some View {
        Form {

            Section(header: SectionHeaderView(text: "Name", icon: "pencil.and.ellipsis.rectangle")) {

                TextField("Your Island's Name", text: $appUserDefaults.islandName)
                    .font(.system(.headline, design: .rounded))
                    .multilineTextAlignment(.center)
            }

            Section(header: SectionHeaderView(text: "Details", icon: "info.circle")) {
                HStack {
                    Text("Hemisphere")
                    Spacer()
                    Picker(selection: $appUserDefaults.hemisphere, label: Text("Hemisphere")) {
                        ForEach(Hemisphere.allCases, id: \.self) { hemisphere in
                            Text(hemisphere.rawValue.capitalized)
                                .tag(hemisphere)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(maxWidth: 200)
                    .padding(.trailing, -8)
                }

                Picker(selection: $appUserDefaults.fruit, label: Text("Native Fruit")) {
                    ForEach(Fruit.allCases, id: \.self) { fruit in
                        HStack {
                            Image(fruit.rawValue.capitalized)
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 30, height: 30)
                            Text(fruit.rawValue.capitalized)
                                .tag(fruit)
                        }
                    }
                }
            }

            Section(header: SectionHeaderView(text: "Infrastructure", icon: "bag"), footer: island) {
                Picker(selection: $appUserDefaults.residentService,
                       label: Text("Resident Services")) {
                        ForEach(Infrastructure.ResidentService.allCases, id: \.self) { service in
                            Text(service.rawValue.capitalized)
                                .tag(service)
                        }
                }

                Picker(selection: $appUserDefaults.nookShop, label: Text("Nook Shop")) {
                    ForEach(Infrastructure.NookShop.allCases, id: \.self) { shop in
                        Text(shop.rawValue)
                            .tag(shop)
                    }
                }

                Picker(selection: $appUserDefaults.ableSisters,
                       label: Text("Able Sisters")) {
                        ForEach(Infrastructure.AbleSisters.allCases, id: \.self) { sisters in
                            Text(sisters.rawValue.capitalized)
                                .tag(sisters)
                        }
                }
            }

        }
        .navigationBarTitle("Island")
        .listStyle(GroupedListStyle())
        .environment(\.horizontalSizeClass, .regular)
    }

    var island: some View {
        VStack {
            Spacer()
            Image("Island")
                .renderingMode(.template)
                .foregroundColor(Color.acSecondaryBackground)
                .padding(.top)
        }
    }

}

struct PassportSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { PassportSettingsView() }
    }
}
