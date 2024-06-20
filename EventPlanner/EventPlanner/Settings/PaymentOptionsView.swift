//
//  PaymentOptionsView.swift
//  EventPlanner
//
//  Created by Marko Jovanov on 19.6.24.
//

import SwiftUI

struct PaymentOptionsView: View {
    let creditCards = ["Visa **** 1234", "MasterCard **** 5678"]
    let bankAccounts = ["NLB **** 1111", "HalkBank **** 2222"]

    var body: some View {
        VStack {
            List {
                Section(header: Text("Credit Cards")) {
                    ForEach(creditCards, id: \.self) { card in
                        HStack {
                            Image(systemName: "creditcard.fill")
                                .foregroundColor(.blue)
                            Text(card)
                        }
                    }
                }

                Section(header: Text("Bank Accounts")) {
                    ForEach(bankAccounts, id: \.self) { account in
                        HStack {
                            Image(systemName: "banknote.fill")
                                .foregroundColor(.green)
                            Text(account)
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationBarTitle("Payment Options")
        .navigationViewWrapped()
    }
}

#Preview {
    PaymentOptionsView()
}
