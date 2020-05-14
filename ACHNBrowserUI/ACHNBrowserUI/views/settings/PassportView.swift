//
//  PassportView.swift
//  ACHNBrowserUI
//
//  Created by Matt Bonney on 5/9/20.
//  Copyright © 2020 Thomas Ricouard. All rights reserved.
//

import SwiftUI
import Backend

struct PassportView: View {
    @ObservedObject var appUserDefaults = AppUserDefaults.shared
    private var cornerRadius: CGFloat = 22

    var passportLabel: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("PASSPORT ")
                .font(.system(.caption, design: .rounded))
                .fontWeight(.black)
                .kerning(0.5)
                .foregroundColor(Color.acSecondaryText)
                .rotationEffect(.degrees(-2))
                .padding(10)
            Divider()
        }
    }

    var passportInfo: some View {
        VStack(alignment: .leading) {

            HStack {
                Text(appUserDefaults.islandName == "" ? "Island Name" : appUserDefaults.islandName)
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(Color.acText)

                Spacer()

                appUserDefaults.fruit.image
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 32)
            }

            HStack {
                residentServiceProgress
                Spacer()
                nookShopProgress
                Spacer()
                ableSistersProgress
            }
            .frame(maxWidth: .infinity)
        }
        .padding([.horizontal, .bottom])
        .padding(.top, 10)
    }

    var body: some View {
        VStack {

            passportLabel
            passportInfo

        }
//        .background(Color.acBackground)
//        .padding(12)
        .background(innerBackground)
        .padding(12)
        .background(outerBackground)
        .safeHoverEffect(.automatic)
    }

    var nookShopProgress: some View {

        var dots: [String] = []
        switch appUserDefaults.nookShop {
        case .tent:
            dots.append(contentsOf: ["circle.fill", "circle", "circle"])
        case .crany:
            dots.append(contentsOf: ["circle.fill", "circle.fill", "circle"])
        case .upraded:
            dots.append(contentsOf: ["circle.fill", "circle.fill", "circle.fill"])
        }

        return HStack(spacing: 2) {
            Image("icon-present")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(height: 22)
            ForEach(dots, id: \.self) { dot in
                Image(systemName: dot)
            }
        }
        .font(.system(size: 12, weight: .bold, design: .rounded))
        .foregroundColor(Color.acText)
    }

    var residentServiceProgress: some View {
        var dots: [String] = []
        switch appUserDefaults.residentService {
        case .tent:
            dots.append(contentsOf: ["circle.fill", "circle"])
        case .building:
            dots.append(contentsOf: ["circle.fill", "circle.fill"])
        }

        return HStack(spacing: 2) {
            Image("icon-leaf")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(height: 22)
            ForEach(dots, id: \.self) { dot in
                Image(systemName: dot)
            }
        }
        .font(.system(size: 12, weight: .bold, design: .rounded))
        .foregroundColor(Color.acText)
    }

    var ableSistersProgress: some View {
        var dots: [String] = []
        switch appUserDefaults.ableSisters {
        case .visiting:
            dots.append(contentsOf: ["circle.fill", "circle"])
        case .shop:
            dots.append(contentsOf: ["circle.fill", "circle.fill"])
        }

        return HStack(spacing: 2) {
            Image("icon-top")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(height: 22)
            ForEach(dots, id: \.self) { dot in
                Image(systemName: dot)
            }
        }
        .font(.system(size: 12, weight: .bold, design: .rounded))
        .foregroundColor(Color.acText)
    }

    var outerBackground: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .foregroundColor(Color.acTertiaryBackground)
            .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 4)
    }

    var innerBackground: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.acSecondaryBackground
            Image("Island")
                .renderingMode(.template)
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .foregroundColor(Color.acBackground)
                .frame(maxWidth: 100)
                .padding(.bottom, -10)
        }
        .mask(RoundedRectangle(cornerRadius: cornerRadius * 0.7, style: .continuous))
        .shadow(radius: 1)
    }

}

struct PassportView_Previews: PreviewProvider {
    static var previews: some View {
        PassportView()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.white)
    }
}
