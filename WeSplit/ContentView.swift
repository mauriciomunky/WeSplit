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
    var moeda : FloatingPointFormatStyle<Double>.Currency {
        return FloatingPointFormatStyle<Double>.Currency(code: Locale.current.currencyCode ?? "BRL")
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Valor da Conta", value: $valorDaConta, format: moeda)
                        .keyboardType(.decimalPad)
                        .focused($valorEmFoco)
                    Picker("Número de pessoas", selection: $numeroDePessoas) {
                        ForEach(2..<100) {
                            Text("\($0) pessoas")
                        }
                    }.pickerStyle(.automatic)
                    Picker("Porcentagem da Gorjeta", selection: $gorjeta) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.automatic)
                } .navigationTitle("WeSplit")
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Fechar") {
                                valorEmFoco = false
                            }
                        }
                    }
                VStack {
                        Section {
                            Text(valorGorjeta.formatted(moeda))
                        } header: {
                            Text("Valor da gorjeta")
                        }
                        Section {
                            Text(totalDaConta.formatted(moeda))
                        } header: {
                            Text("Total da conta")
                        }
                        Section {
                            Text(totalPorPessoa, format: moeda)
                        } header: {
                            Text("Valor por pessoa")
                        }
                        Spacer()
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
