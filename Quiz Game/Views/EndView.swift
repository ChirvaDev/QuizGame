//
//  EndView.swift
//  Quiz Game
//
//  Created by Pro on 04.08.2023.
//

import SwiftUI

struct EndView: View {
    var body: some View {
        VStack{
            Image("illustrations-2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250)
            
            Text("Quiz Complited!")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.vertical)
                .baselineOffset(5)
        }
    }
}

struct EndView_Previews: PreviewProvider {
    static var previews: some View {
        EndView()
    }
}
