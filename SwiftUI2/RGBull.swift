//
//  RGBull.swift
//  SwiftUI2
//
//  Created by Anton Efimenko on 19.07.2020.
//

import SwiftUI

struct RGBullView: View {
    
    let rTarget = Double.random(in: 0..<1)
    let gTarget = Double.random(in: 0..<1)
    let bTarget = Double.random(in: 0..<1)
    
    @State var rGuess: Double
    @State var gGuess: Double
    @State var bGuess: Double
    
    @State var showAlert = false
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Color(red: rTarget, green: gTarget, blue: bTarget)
                    Text("Match this color")
                }
                VStack {
                    Color(red: rGuess, green: gGuess, blue: bGuess)
                    Text("R: \(Int(rGuess * 255))  G: \(Int(gGuess * 255))  B: \(Int(bGuess * 255))")
                }
            }
            Button("Hit me") {
                showAlert = true
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Your score"), message: Text(String(computeScore())))
            }
            .padding(.top)
            
            RGBSlider(value: $rGuess, textColor: .red)
            RGBSlider(value: $gGuess, textColor: .green)
            RGBSlider(value: $bGuess, textColor: .blue)
        }
        .padding()
    }
    
    func computeScore() -> Int {
      let rDiff = rGuess - rTarget
      let gDiff = gGuess - gTarget
      let bDiff = bGuess - bTarget
      let diff = sqrt((rDiff * rDiff + gDiff * gDiff
        + bDiff * bDiff) / 3.0)
      return lround((1.0 - diff) * 100.0)
    }
}

struct RGBSlider: View {
    @Binding var value: Double
    let textColor: Color
    
    var body: some View {
        HStack {
            Text("0").foregroundColor(textColor)
            Slider(value: $value)
            Text("255").foregroundColor(textColor)
        }
    }
}

struct RGBullView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RGBullView(rGuess: 0.4, gGuess: 0.3, bGuess: 0.6)
                .previewDevice("iPhone SE (2nd generation)")
                .previewLayout(.fixed(width: 568, height: 320))
        }
    }
}
