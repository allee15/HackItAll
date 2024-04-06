//
//  ExpenseRoundupScreen.swift
//  HackItAlll
//
//  Created by Alexia Aldea on 06.04.2024.
//

import SwiftUI

struct ExpenseRoundupScreen: View {
    @StateObject private var viewModel = ExpenseRoundupViewModel()
    @EnvironmentObject private var navigation: Navigation
    let index: Int
    
    var body: some View {
        VStack(spacing: 0) {
            BackButton(text: "Transfer")
                .padding(.bottom, 8)
                .padding(.horizontal, 24)
                .modifier(GlobalPositionModifier())
                .onPreferenceChange(GlobalFrameKey.self) { value in
                    viewModel.globalFrame = value
                }
                .onTapGesture(coordinateSpace: .global) { location in
                    viewModel.printInfo(location: location)
                    navigation.pop(animated: true)
                }
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    switch index {
                    case 0:
                        CircluarDiagramView(
                            expensesRoundup: viewModel.expensesRoundupFirst
                        )
                        .padding(40)
                        
                        VStack(spacing: 10) {
                            ForEach(viewModel.expensesRoundupFirst, id: \.id) { item in
                                ExpenseCardView(expenseRoundup: item)
                                    .modifier(GlobalPositionModifier())
                                    .onPreferenceChange(GlobalFrameKey.self) { value in
                                        viewModel.globalFrame = value
                                    }
                                    .onTapGesture(coordinateSpace: .global) { location in
                                        viewModel.printInfo(location: location)
                                        navigation.push(TransactionsScreen(transactions: transactionsFirstCard).asDestination(),
                                                        animated: true)
                                    }
                            }
                        }
                    case 1:
                        CircluarDiagramView(
                            expensesRoundup: viewModel.expensesRoundupSecond
                        )
                        .padding(40)
                        
                        VStack(spacing: 10) {
                            ForEach(viewModel.expensesRoundupSecond, id: \.id) { item in
                                ExpenseCardView(expenseRoundup: item)
                                    .modifier(GlobalPositionModifier())
                                    .onPreferenceChange(GlobalFrameKey.self) { value in
                                        viewModel.globalFrame = value
                                    }
                                    .onTapGesture(coordinateSpace: .global) { location in
                                        viewModel.printInfo(location: location)
                                        navigation.push(TransactionsScreen(transactions: transactionsSecondCard).asDestination(),
                                                        animated: true)
                                    }
                            }
                        }
                    case 2:
                        CircluarDiagramView(
                            expensesRoundup: viewModel.expensesRoundupThird
                        )
                        .padding(40)
                        
                        VStack(spacing: 10) {
                            ForEach(viewModel.expensesRoundupThird, id: \.id) { item in
                                ExpenseCardView(expenseRoundup: item)
                                    .modifier(GlobalPositionModifier())
                                    .onPreferenceChange(GlobalFrameKey.self) { value in
                                        viewModel.globalFrame = value
                                    }
                                    .onTapGesture(coordinateSpace: .global) { location in
                                        viewModel.printInfo(location: location)
                                        navigation.push(TransactionsScreen(transactions: transactionsThirdCard).asDestination(),
                                                        animated: true)
                                    }
                            }
                        }
                    default:
                        EmptyView()
                    }
                }
                .padding(.horizontal, 15)
                .padding(.bottom, 20)
            }.padding(.top, 20)
        }.background(Color.bgPrimary)
    }
}

struct CircluarDiagramView: View {
    
    let expensesRoundup: [ExpenseRoundup]
    
    var body: some View {
        ZStack {
            ForEach(Array(expensesRoundup.enumerated()), id: \.element.id) { index, element in
                let startingIndex = getStartingOffset(index: index)
                Circle()
                    .trim(from: startingIndex, to: startingIndex + CGFloat(element.amount))
                    .stroke(element.color, lineWidth: 40)
            }
        }
        .padding(.horizontal, 20)
        .rotationEffect(.degrees(-90))
    }
    
    private func getStartingOffset(index: Int) -> CGFloat {
        var sum: CGFloat = 0
        let entries = expensesRoundup
        
        for i in (0..<entries.count) {
            if i == index {
                break
            }
            sum += CGFloat(entries[i].percentage)/100
        }
        return sum
    }
}

struct ExpenseCardView: View {
    let expenseRoundup: ExpenseRoundup
    
    var body: some View {
        HStack(spacing: 10) {
            Circle()
                .stroke(expenseRoundup.color, lineWidth: 4)
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 24)
            
            Text(expenseRoundup.item)
                .foregroundStyle(Color(hex: "#414764"))
                .font(.KronaOne.regular(size: 16))
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 5) {
                let formattedNumber = String(format: "%.2f", expenseRoundup.amount)
                Text("\(formattedNumber) RON")
                    .foregroundStyle(Color(hex: "#414764"))
                    .font(.KronaOne.regular(size: 16))
                
                HStack(spacing: 8) {
                    Text("\(expenseRoundup.percentage)%")
                        .foregroundStyle(expenseRoundup.color)
                        .font(.KronaOne.regular(size: 12))
                    
                    Text("See more")
                        .underline()
                        .foregroundStyle(Color.white)
                        .font(.KronaOne.regular(size: 12))
                }
            }
        }.padding(.all, 16)
            .background(Color(hex: "#C2B5D8").opacity(0.8))
            .cornerRadius(16, corners: .allCorners)
    }
}

