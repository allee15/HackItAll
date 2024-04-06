//
//  HomeScreen.swift
//  iosApp
//
//  Created by Alexia Aldea on 06.04.2024.
//

import SwiftUI
import SwiftUIBottomSheet

struct HomeScreen: View {
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject private var navigation: Navigation
    @State var showDetails: Bool = false
    @State var showBottomSheet: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    self.showBottomSheet = true
                } label: {
                    Image(.icAccount)
                        .resizable()
                        .frame(width: 24, height: 24)
                }.modifier(GlobalPositionModifier())
                    .onPreferenceChange(GlobalFrameKey.self) { value in
                        viewModel.globalFrame = value
                    }
                    .onTapGesture(coordinateSpace: .global) { location in
                        viewModel.globalTap = location
                        viewModel.printInfo()
                    }
                
                Spacer()
                
                Text("Your cards")
                    .font(.KronaOne.regular(size: 20))
                    .foregroundStyle(Color.white)
                
                Spacer()
            }.padding(.top, 12)
            
            Spacer(minLength: 48)
            
            CardsCarouselView(
                showDetails: $showDetails,
                cards: viewModel.cards,
                selectedCard: Binding(get: {
                    viewModel.selectedCard
                }, set: { card in
                    viewModel.selectedCard = card
                })
            ).modifier(GlobalPositionModifier())
                .onPreferenceChange(GlobalFrameKey.self) { value in
                    viewModel.globalFrame = value
                }
                .onTapGesture(coordinateSpace: .global) { location in
                    viewModel.globalTap = location
                    viewModel.printInfo()
                }
            
            ShowDetailsButtonView(showDetails: $showDetails) {
                self.showDetails.toggle()
            }.padding(.vertical, 16)
                .modifier(GlobalPositionModifier())
                .onPreferenceChange(GlobalFrameKey.self) { value in
                    viewModel.globalFrame = value
                }
                .onTapGesture(coordinateSpace: .global) { location in
                    viewModel.globalTap = location
                    viewModel.printInfo()
                }
            
            HStack {
                Text("Balance: \(viewModel.selectedCard.balance) RON")
                    .font(.KronaOne.regular(size: 16))
                    .foregroundStyle(Color.white)
                    .padding(.bottom, 8)
                
                Spacer(minLength: 24)
            }
            
            HStack(spacing: 16) {
                ForEach(0..<3) { index in
                    switch index {
                    case 0:
                        WidgetActionView(icon: .icSend,
                                         text: "Transfer",
                                         action: {
                            navigation.push(TransferScreen().asDestination(), animated: true)
                        }).modifier(GlobalPositionModifier())
                            .onPreferenceChange(GlobalFrameKey.self) { value in
                                viewModel.globalFrame = value
                            }
                            .onTapGesture(coordinateSpace: .global) { location in
                                viewModel.globalTap = location
                                viewModel.printInfo()
                            }
                    case 1:
                        WidgetActionView(icon: .icCredit,
                                         text: "Loans") {
                            navigation.push(NewLoanScreen().asDestination(), animated: true)
                        }.modifier(GlobalPositionModifier())
                            .onPreferenceChange(GlobalFrameKey.self) { value in
                                viewModel.globalFrame = value
                            }
                            .onTapGesture(coordinateSpace: .global) { location in
                                viewModel.globalTap = location
                                viewModel.printInfo()
                            }
                    case 2:
                        WidgetActionView(icon: .icExpense,
                                         text: "Expense Roundup") {
                            navigation.push(ExpenseRoundupScreen(index: viewModel.selectedCard.id).asDestination(), animated: true)
                        }.modifier(GlobalPositionModifier())
                            .onPreferenceChange(GlobalFrameKey.self) { value in
                                viewModel.globalFrame = value
                            }
                            .onTapGesture(coordinateSpace: .global) { location in
                                viewModel.globalTap = location
                                viewModel.printInfo()
                            }
                    default:
                        EmptyView()
                    }
                }
            }.padding(.bottom, 16)
            
            let transactions = viewModel.getTransactionsForCard()
            let firstTransactions = Array(transactions.prefix(4))
            TransactionsView(transactions: firstTransactions) {
                navigation.push(TransactionsScreen(transactions: transactions).asDestination(),
                                animated: true)
            }.modifier(GlobalPositionModifier())
                .onPreferenceChange(GlobalFrameKey.self) { value in
                    viewModel.globalFrame = value
                }
                .onTapGesture(coordinateSpace: .global) { location in
                    viewModel.globalTap = location
                    viewModel.printInfo()
                }
        }.padding(.horizontal, 20)
            .background(Color.bgPrimary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container, edges: [.bottom, .leading, .trailing])
            .bottomSheet(
                isPresented: $showBottomSheet,
                config: BottomSheetConfig(
                    kind: .tapDismiss,
                    background: Color.bgBottomSheet,
                    handleColor: Color.init(hex: "#EDEDED"),
                    handlePosition: .inside,
                    topBarCornerRadius: 16,
                    sizeChangeRequest: .constant(0)
                ),
                content: {
                    BottomSheetView {
                        showBottomSheet = false
                        navigation.push(BiometricScreen().asDestination(), animated: true)
                    }
                }
            )
    }
}

struct ShowDetailsButtonView: View {
    @Binding var showDetails: Bool
    let action: () -> ()
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 4) {
                Image(!showDetails ? .icShowDetails : .icHideDetails)
                    .resizable()
                    .frame(width: 16, height: 16)
                
                Text(!showDetails ? "Show details" : "Hide details")
                    .font(.KronaOne.regular(size: 10))
                    .foregroundStyle(Color.bgPrimary)
            }.padding(.leading, 8)
                .padding(.trailing, 16)
                .background(Color.bgSecondary)
                .cornerRadius(16, corners: .allCorners)
        }
    }
}

struct WidgetActionView: View {
    let icon: ImageResource
    let text: String
    let action: () -> ()
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 8) {
                Image(icon)
                    .resizable()
                    .frame(width: 20, height: 20)
                
                Text(text)
                    .font(.KronaOne.regular(size: 10))
                    .foregroundStyle(Color.white)
                    .fixedSize(horizontal: false, vertical: true)
            }.padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(Color.bgWidget.opacity(0.61))
                .cornerRadius(16, corners: .allCorners)
        }
    }
}

struct TransactionsView: View {
    let transactions: [Transaction]
    let action: () -> ()
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Latest transactions")
                    .font(.KronaOne.regular(size: 12))
                    .foregroundStyle(Color.white)
                
                Spacer()
                
                Button {
                    action()
                } label: {
                    Text("See all")
                        .underline()
                        .font(.KronaOne.regular(size: 12))
                        .foregroundStyle(Color.white)
                }
            }
            
            ScrollView(showsIndicators: false) {
                ForEach(transactions) { transaction in
                    TransactionWidgetView(transaction: transaction)
                }
            }
        }.padding(.vertical, 16)
            .padding(.horizontal, 12)
            .background(Color.bgSecondary.opacity(0.32))
            .cornerRadius(16, corners: .allCorners)
            .padding(.bottom, 4)
    }
}

struct TransactionWidgetView: View {
    let transaction: Transaction
    
    var body: some View {
        HStack(spacing: 0) {
            Image(.icWallet)
                .resizable()
                .frame(width: 24, height: 24)
                .padding(.trailing, 8)
            
            Text(transaction.name)
                .font(.KronaOne.regular(size: 12))
                .foregroundStyle(Color.black)
            
            Spacer(minLength: 24)
            
            Text(transaction.amount + " RON")
                .font(.KronaOne.regular(size: 12))
                .foregroundStyle(Color.black)
        }.padding(.all, 12)
            .background(Color.bgSecondary)
            .cornerRadius(16, corners: .allCorners)
    }
}

struct BottomSheetView: View {
    let action: () -> ()
    var body: some View {
        VStack {
            Spacer(minLength: 24)
            Button {
                action()
            } label: {
                HStack(spacing: 8) {
                    Image(.icBiometrics)
                        .resizable()
                        .frame(width: 32, height: 32)
                    Text("Configure biometric behaviour")
                        .font(.KronaOne.regular(size: 12))
                        .foregroundStyle(Color.black)
                    
                }.padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(Color.bgSecondary)
                    .cornerRadius(16, corners: .allCorners)
            }.padding(.vertical, 44)
            
            Spacer(minLength: 24)
        }
    }
}

#Preview {
    HomeScreen()
}
