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
     var totalPorPessoa: Double {
        let pessoas = Double(numeroDePessoas + 2)
        let gorjetaEscolhida = Double(gorjeta)
        let valorGorjeta = valorDaConta/100 * gorjetaEscolhida
        let totalDaConta = valorDaConta + valorGorjeta
        let valorPorPessoa = totalDaConta/pessoas
        return valorPorPessoa
    }
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
                        ForEach(porcentagemGorjeta, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Qual a porcentagem da gorjeta?")
            }
            Section {
                Text(totalPorPessoa, format: .currency(code: Locale.current.currencyCode ?? "BRL"))
                }
            }
        }.navigationTitle("WeSplit")
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
