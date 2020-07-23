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
    
    @ObservedObject var timer = TimeCounter()
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Color(red: rTarget, green: gTarget, blue: bTarget)
                    Text("Match this color")
                }
                VStack {
                    ZStack(alignment: .center) {
                        Color(red: rGuess, green: gGuess, blue: bGuess)
                        Text("\(timer.counter)")
                            .font(Font.system(.body, design: .monospaced))
                            .padding(.all, 5)
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .mask(Circle())
                    }
                    Text("R: \(Int(rGuess * 255))  G: \(Int(gGuess * 255))  B: \(Int(bGuess * 255))")
                }
            }
            
            Button("Hit me") {
                showAlert = true
                timer.killTimer()
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Your score"), message: Text(String(computeScore())))
            }
            .padding(.top)
            
            VStack {
                RGBSlider(value: $rGuess, textColor: .red)
                RGBSlider(value: $gGuess, textColor: .green)
                RGBSlider(value: $bGuess, textColor: .blue)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
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
            CustomSlider(thumbColor: UIColor(textColor),
                         minTrackColor: UIColor(textColor),
                         maxTrackColor: .clear,
                         value: $value)
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

class TimeCounter: ObservableObject {
  var timer: Timer?
  @Published var counter = 0

  @objc func updateCounter() {
    counter += 1
  }
    
    init() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                     selector: #selector(updateCounter), userInfo: nil,
                                     repeats: true)
    }
    
    func killTimer() {
      timer?.invalidate()
      timer = nil
    }
}

struct CustomSlider: UIViewRepresentable {
//    typealias UIViewType = UISlider
    
    let thumbColor: UIColor
    let minTrackColor: UIColor
    let maxTrackColor: UIColor

    @Binding var value: Double
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        
        slider.thumbTintColor = thumbColor
        slider.minimumTrackTintColor = minTrackColor
        slider.maximumTrackTintColor = maxTrackColor
        slider.value = Float(value)
        
        slider.addTarget(context.coordinator,
                         action: #selector(CustomSliderCoordinator.updateColorUISlider(_:)),
                         for: .valueChanged)
        
        return slider
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.value = Float(value)
    }
    
    func makeCoordinator() -> CustomSliderCoordinator {
        return CustomSliderCoordinator(self)
    }
}

class CustomSliderCoordinator: NSObject {
    var parent: CustomSlider
    
    init(_ parent: CustomSlider) {
        self.parent = parent
    }
    
    @objc func updateColorUISlider(_ sender: UISlider) {
        parent.value = Double(sender.value)
    }
}
