//
//  TransferScreen.swift
//  HackItAlll
//
//  Created by Alexia Aldea on 06.04.2024.
//

import SwiftUI

struct TransferScreen: View {
    @StateObject private var viewModel = TransferVewModel()
    @EnvironmentObject private var navigation: Navigation
    
    var body: some View {
        VStack(spacing: 0) {
            BackButton(text: "Transfer") {
                navigation.pop(animated: true)
            }.padding(.bottom, 8)
                .padding(.horizontal, 24)
                .modifier(GlobalPositionModifier())
                .onPreferenceChange(GlobalFrameKey.self) { value in
                    viewModel.globalFrame = value
                }
                .onTapGesture(coordinateSpace: .global) { location in
                    viewModel.globalTap = location
                    viewModel.printInfo()
                }
            
            HStack {
                Text("Recent transfers")
                    .font(.KronaOne.regular(size: 12))
                    .foregroundStyle(Color(hex: "#C2B5D8").opacity(0.73))
                    .padding(.bottom, 16)
                    .padding(.horizontal, 24)
                
                Spacer()
            }
            HStack(spacing: 32) {
                Spacer()
                ForEach(0..<3) { index in
                    FriendCardView(index: viewModel.friendsList[index].name) {
                        let telephone = viewModel.friendsList[index].phone
                        let urlString = "tel://\(telephone)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                        if let url = URL(string: urlString ?? "") {
                            if UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        }
                    }
                }
                Spacer()
            }.padding(.bottom, 16)
                .padding(.horizontal, 24)
            
            HStack {
                Text("All contacts")
                    .font(.KronaOne.regular(size: 12))
                    .foregroundStyle(Color(hex: "#C2B5D8").opacity(0.73))
                
                Spacer()
            }.padding(.bottom, 16)
                .padding(.horizontal, 24)
            
            ScrollView(showsIndicators: false) {
                ForEach(viewModel.friendsList, id: \.id) { friend in
                    FriendLargeCardView(name: friend.name, phone: friend.phone) {
                        let telephone = friend.phone
                        let urlString = "tel://\(telephone)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                        if let url = URL(string: urlString ?? "") {
                            if UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)
                    .modifier(GlobalPositionModifier())
                    .onPreferenceChange(GlobalFrameKey.self) { value in
                        viewModel.globalFrame = value
                    }
                    .onTapGesture(coordinateSpace: .global) { location in
                        viewModel.globalTap = location
                        viewModel.printInfo()
                    }
                }
                
                Spacer(minLength: 80)
            }
            
        }.background(Color.bgPrimary)
    }
}

struct FriendCardView: View {
    let index: String
    let action: () -> ()
    var body: some View {
        Button {
            action()
        } label: {
            VStack(spacing: 8) {
                Image(.imgSmiley)
                    .resizable()
                    .frame(width: 64, height: 64)
                    .padding(.all, 12)
                    .background(Color(hex: "#F5F5F5"))
                    .cornerRadius(16, corners: .allCorners)
                
                Text(index)
                    .font(.KronaOne.regular(size: 12))
                    .foregroundStyle(.white)
                    .fixedSize(horizontal: true, vertical: false)
            }
        }
    }
}

struct FriendLargeCardView: View {
    let name: String
    let phone: String
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 8) {
                Image(.imgSmiley)
                    .resizable()
                    .frame(width: 64, height: 64)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(name)
                        .font(.KronaOne.regular(size: 12))
                        .foregroundStyle(Color.bgPrimary)
                    
                    Text(phone)
                        .font(.KronaOne.regular(size: 12))
                        .foregroundStyle(Color.bgPrimary)
                }
                
                Spacer()
            }.padding(.vertical, 8)
                .padding(.horizontal, 8)
                .background(Color(hex: "#D9D9D9"))
                .cornerRadius(12, corners: .allCorners)
        }
    }
}

#Preview {
    TransferScreen()
}
