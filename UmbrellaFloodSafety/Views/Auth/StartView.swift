//
//  StartView.swift
//  UmbrellaFloodSafety
//
//  Created by Diana Moya Lapeira on 22/6/24.
//

import SwiftUI

struct StartView: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Image(.firstScreenLogo)
                    .resizable()
                    .frame(width: 300, height: 300)
                Text("Umbrella")
                    .fontWeight(.black)
                    .foregroundStyle(Color(.mainBlue))
                    .font(.custom("Nunito", size: 48))
                Text("Your flood safety companion")
                    .fontWeight(.medium)
                    .foregroundStyle(Color(.mainBlue))
                    .font(.custom("Nunito", size: 22))
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundStyle(Color(.mainBlue))
                    NavigationLink("Get Started", destination: RegisterFirstView())
                        .foregroundStyle(Color(.white))
                        .fontWeight(.bold)
                        .font(.custom("Nunito", size: 18))
                }
                .frame(width: 300, height: 60)
                .padding(.bottom)
                .padding(.top)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color(.mainBlue), lineWidth: 4)
                    NavigationLink("I Already Have An Account", destination: LoginView())
                        .foregroundStyle(Color(.mainBlue))
                        .fontWeight(.bold)
                        .font(.custom("Nunito", size: 18))
                }
                .frame(width: 300, height: 60)
                Spacer()
            }
        }
    }
}

#Preview {
    StartView()
}