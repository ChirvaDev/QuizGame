//
//  QuestionView.swift
//  Quiz Game
//
//  Created by Pro on 03.08.2023.
//

import SwiftUI

struct QuestionView: View {
    @State var randomQwiz: [DataModel] = []
    @State var questionCount = 1
    @State var input: String = ""
    @State var score: Int = 0
    @State var finished = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack{
            if !finished {
                VStack {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "chevron.left")
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .clipShape(Circle())
                                .foregroundColor(Color("Color4"))
                        })
                        
                        Spacer()
                    }
                    if randomQwiz.capacity != 0 {
                        //this means that there are some quiz datamodel avalible
                        Text("Question: \(questionCount)/10") // there will be 10 questions
                            .font(.title.weight(.semibold))
                            .padding(.vertical)
                            .padding(.horizontal, 5)
                            .opacity(0.7)
                        
                        Text("Score: \(score)/10")
                            .font(.title.weight(.semibold))
                            .foregroundColor(Color("Color2"))
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 18, style: .continuous).fill(.ultraThinMaterial))
                        
                        VStack{
                            Spacer()
                            Text(randomQwiz[0].question)
                                .font(.title2.weight(.semibold))
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                            Text(randomQwiz[0].answer)
                                .opacity(0.3)
                                .padding(.vertical, -5)
                            
                            TextField(text: $input){ Text("Type your answer")}
                                .padding(14)
                                .background(RoundedRectangle(cornerRadius: 18, style: .continuous).fill(.ultraThinMaterial))
                                .padding(.vertical)
                            
                            Button{
                                withAnimation{
                                    if (input.lowercased() == randomQwiz[0].answer.lowercased()) {
                                        score += 1
                                    }
                                    refreshQuiz()
                                    input = ""
                                }
                            } label: {
                                HStack{
                                    Image(systemName: "checkmark.circle")
                                        .font(.title2.weight(.semibold))
                                    
                                    Text("Submit")
                                        .font(.title2.weight(.bold))
                                    
                                }
                                .foregroundColor(Color("Color3"))
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 30, style: .continuous)
                                    .fill(.ultraThinMaterial)
                                )
                            }
                            .buttonStyle(.plain)
                            .padding(.vertical, 10)
                            
                            Spacer()
                            
                            HStack{
                                Button{
                                    withAnimation{
                                        refreshQuiz()
                                        score = 0
                                        questionCount = 0
                                    }
                                    
                                } label: {
                                    VStack{
                                        Image(systemName: "flag.2.crossed.fill")
                                            .frame(width: 45, height: 45)
                                            .font(.title2.weight(.semibold))
                                            .foregroundStyle(Color("Color2"))
                                            .padding()
                                            .background(RoundedRectangle(cornerRadius: 50, style: .continuous) .fill(.ultraThinMaterial))
                                        
                                        Text("Restart")
                                            .font(.title2.weight(.semibold))
                                    }
                                }
                                .buttonStyle(.plain)
                                
                                Spacer()
                                
                                Button{
                                    withAnimation{
                                        refreshQuiz()
                                    }
                                } label: {
                                    VStack{
                                        Image(systemName: "chevron.forward")
                                            .frame(width: 45, height: 45)
                                            .font(.title2.weight(.semibold))
                                            .foregroundStyle(Color("Color4"))
                                            .padding()
                                            .background(RoundedRectangle(cornerRadius: 50, style: .continuous) .fill(.ultraThinMaterial))
                                        
                                        Text(questionCount == 10 ? "Finish" : "Next")
                                            .font(.title2.weight(.semibold))
                                    }
                                }
                                .buttonStyle(.plain)
                                
                            }
                            .frame(maxWidth: .infinity)
                            
                            Spacer()
                        }
                    }
                    else {
                        ProgressView().progressViewStyle(.circular)
                    }
                }
                .padding(.horizontal, 20)
                .navigationBarBackButtonHidden(true)
            }
            else {
                ZStack{
                    LinearGradient(colors: [Color("Color1"), .black], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .ignoresSafeArea(.all)
                    VStack{
                        EndView()
                        totalScore
                        HStack{
                            Button{
                                finished = false
                                questionCount = 0
                                score = 0
                                refreshQuiz()
                            } label: {
                                Text("Try again")
                                    .font(.title2)
                                    .fontWeight(.medium)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                                            .fill(.ultraThinMaterial)
                                    )
                                    .padding(.bottom)
                            }
                            .buttonStyle(.plain)
                            .foregroundStyle(Color("Color3"))
                            
                            Button{
                                self.presentationMode.wrappedValue.dismiss()
                            } label: {
                                Text("Finish")
                                    .font(.title2)
                                    .fontWeight(.medium)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                                            .fill(.ultraThinMaterial)
                                    )
                                    .padding(.bottom)
                            }
                            .buttonStyle(.plain)
                            .foregroundStyle(Color("Color2"))
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .fill(.ultraThinMaterial)
                            .padding(.horizontal, 16)
                    )
                    .navigationBarBackButtonHidden(true)
                }
            }
            Spacer()
        }
        .onAppear{
            withAnimation {
                Api().getData { randomQwiz, error in
                    if let randomQwiz = randomQwiz {
                        self.randomQwiz = randomQwiz
                    } else if let error = error {
                        print("Error retrieving data: \(error)")
                    }
                }
            }
        }
    }
    
    var totalScore : some View {
        VStack(spacing: 24){
            Text("Score: \(score)")
                .font(.title2)
                .fontWeight(.semibold)
        }
    }
    
    func refreshQuiz() {
        Api().getData() { randomQwiz, error in
            if let error = error {
                print("Error retrieving data: \(error)")
            } else if let randomQwiz = randomQwiz {
                if questionCount == 10 {
                    finished = true
                } else {
                    questionCount += 1
                }
                self.randomQwiz = randomQwiz
            }
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(
            randomQwiz: [DataModel(id: 1, answer: "plum", question: "A raisin can be called by this other fruit's name when it's added to a pudding or a cake")])
        .preferredColorScheme(.dark)
    }
}

