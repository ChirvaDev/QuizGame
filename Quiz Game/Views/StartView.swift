//
//  StartingView.swift
//  Quiz Game
//
//  Created by Pro on 03.08.2023.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(colors: [Color("Color1"), .black], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea(.all)
                withAnimation{
                    content
                }
            }
        }
    }
    
    var content: some View{
        VStack {
            Spacer()
            
            Image("illustrations-1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .padding(.vertical, -20)
            
            Text("Quiz Game".uppercased())
                .foregroundColor(.white)
                .font(.largeTitle.weight(.black))
            
            Spacer()
            
            NavigationLink{
                QuestionView()
            } label: {
                HStack{
                    Image(systemName: "play.circle.fill")
                        .foregroundColor(Color("Color2"))
                    
                    Text("Start" .uppercased())
                        .foregroundColor(.white)
                        .font(.title2.weight(.black))
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .fill(.ultraThinMaterial)
                )
            }
            .buttonStyle(.plain)
            
            Spacer()
        }
        .font(.title.weight(.black))
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
