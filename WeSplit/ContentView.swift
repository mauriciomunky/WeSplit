//
//  ContentView.swift
//  WeSplit
//
//  Created by Maurício Costa on 03/01/23.
//

import SwiftUI

struct ContentView: View {
    @FocusState var valorEmFoco: Bool
    @State private var valorDaConta = 0.0
    @State private var numeroDePessoas = 2
    @State private var gorjeta = 20
    let porcentagemGorjeta = [0, 5, 10, 15, 20]
    var pessoas: Double { return Double(numeroDePessoas + 2)}
    var gorjetaEscolhida: Double { return Double(gorjeta)}
    var valorGorjeta: Double {return Double(valorDaConta/100 * gorjetaEscolhida)}
    var totalDaConta: Double {return (valorDaConta + valorGorjeta)}
    var totalPorPessoa: Double { return totalDaConta/pessoas}
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Valor da Conta", value: $valorDaConta, format: .currency(code: Locale.current.currencyCode ?? "BRL"))
                        .keyboardType(.decimalPad)
                        .focused($valorEmFoco)
                    Picker("Número de pessoas", selection: $numeroDePessoas) {
                        ForEach(2..<100) {
                            Text("\($0) pessoas")
                        }
                    }.pickerStyle(.automatic)
                }
                Section {
                    Picker("Porcentagem da Gorjeta", selection: $gorjeta) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.automatic)
                } header: {
                    Text("Qual a porcentagem da gorjeta?")
            }
                Section {
                    Text(valorGorjeta.formatted(.currency(code: Locale.current.currencyCode ?? "BRL")))
                } header: {
                    Text("Valor da gorjeta")
                }
                Section {
                    Text(totalDaConta.formatted(.currency(code: Locale.current.currencyCode ?? "BRL")))
                } header: {
                    Text("Total da conta")
                }
            Section {
                Text(totalPorPessoa, format: .currency(code: Locale.current.currencyCode ?? "BRL"))
            } header: {
                Text("Valor por pessoa")
            }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                
                Button("Fechar") {
                    valorEmFoco = false
                }
            }
        }
    } 
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
