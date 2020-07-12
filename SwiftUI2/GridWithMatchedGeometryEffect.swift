//
//  GridWithMatchedGeometryEffect.swift
//  SwiftUI2
//
//  Created by Anton Efimenko on 12.07.2020.
//

import SwiftUI

struct MatchedGeometryEffect_Previews: PreviewProvider {
    static var previews: some View {
        MatchedGeometryEffect()
    }
}

struct MatchedGeometryEffect: View {
    @State var availableLanguages: [Language] =
    [
        .init(id: 0, name: "English"),
        .init(id: 1, name: "French"),
        .init(id: 2, name: "Russian"),
        .init(id: 3, name: "Spanish"),
        .init(id: 4, name: "German"),
        .init(id: 5, name: "Ukranian"),
        .init(id: 6, name: "Liberian"),
        .init(id: 7, name: "Arabic"),
        .init(id: 8, name: "Korean")
    ]
    
    @State var selectedLanguages: [Language] = []
    
    @Namespace var namespace
    
    let columns: [GridItem] =
    [
        .init(.adaptive(minimum: 100), spacing: 15)
//        .init(.flexible(minimum: 50), spacing: 15),
//        .init(.flexible(minimum: 50), spacing: 15),
//        .init(.flexible(minimum: 50), spacing: 15),
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(availableLanguages) { language in
                        Text(language.name)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
//                            .frame(width: 100, height: 100)
                            .frame(minWidth: 100, minHeight: 100)
                            .background(Color.blue)
                            .cornerRadius(15)
                            .matchedGeometryEffect(id: language.id, in: namespace)
                            .onTapGesture {
                                selectedLanguages.append(language)
                                availableLanguages.remove(
                                    at: availableLanguages.firstIndex(where: { $0.id == language.id })!
                                )
                            }
                    }
                }
                .padding(.all)
                
                HStack {
                    Text("Selected Languages")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.horizontal)
                
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(selectedLanguages) { language in
                        Text(language.name)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .frame(minWidth: 50, minHeight: 50)
                            .padding()
//                            .frame(width: 70, height: 70)
                            .background(Color.green)
                            .cornerRadius(15)
                            .matchedGeometryEffect(id: language.id, in: namespace)
                            .onTapGesture {
                                availableLanguages.append(language)
                                selectedLanguages.remove(
                                    at: selectedLanguages.firstIndex(where: { $0.id == language.id })!
                                )
                            }
                    }
                }
                .padding(.all)
            }
            .navigationTitle("Languages")
            .navigationBarTitleDisplayMode(.inline)
        }
        .animation(.easeInOut)
    }
}

struct Language: Identifiable {
    let id: Int
    let name: String
}
