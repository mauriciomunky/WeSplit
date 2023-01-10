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
    var pessoas: Double { return Double(numeroDePessoas + 2)}
    var gorjetaEscolhida: Double { return Double(gorjeta)}
    var valorGorjeta: Double {return Double(valorDaConta/100 * gorjetaEscolhida)}
    var totalDaConta: Double {return (valorDaConta + valorGorjeta)}
    var totalPorPessoa: Double { return totalDaConta/pessoas}
    var moeda : FloatingPointFormatStyle<Double>.Currency {
        return FloatingPointFormatStyle<Double>.Currency(code: Locale.current.currencyCode ?? "BRL")
    }
    
    var body: some View {
        VStack() {
                Form {
                    Text("Valor da Conta")
                        .font(.body)
                        .foregroundColor(Color.gray)
                        .padding(.bottom, -100.0)
                        .frame(height: -1.0)
                    TextField("Valor da Conta", value: $valorDaConta, format: moeda)
                        .padding(.top, -20.0)
                        .keyboardType(.decimalPad)
                        .focused($valorEmFoco)
                    Picker("Número de pessoas", selection: $numeroDePessoas) {
                        ForEach(2..<100) {
                            Text("\($0) pessoas")
                        }
                    }.padding(.top, -20.0).pickerStyle(.automatic)
                    Picker("Porcentagem da Gorjeta", selection: $gorjeta) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.automatic)
                }.frame(height: /*@START_MENU_TOKEN@*/200.0/*@END_MENU_TOKEN@*/).toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Fechar") {
                                valorEmFoco = false
                        }
                    }
            }
                VStack(alignment: .leading) {
                    Section {
                        Text(valorGorjeta.formatted(moeda)).font(.title)
                    } header: {
                        Text("Valor da gorjeta").font(.headline)
                    }
                    Section {
                        Text(totalDaConta.formatted(moeda)).font(.title)
                    } header: {
                        Text("Total da conta").font(.headline)
                    }
                    Section {
                        Text(totalPorPessoa, format: moeda).font(.title)
                    } header: {
                        Text("Valor por pessoa").font(.headline)
                    }
                    Spacer()
                    Spacer()
                }
                .padding(.all, 50.0)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
