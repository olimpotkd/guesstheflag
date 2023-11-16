//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Carlos Reynoso on 10/11/23.
//

import SwiftUI

struct ContentView: View {
  @State private var showingScore = false
  @State private var scoreTitle = ""
    
  @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
  
  @State private var correctAnswer = Int.random(in: 0...2)
  
  @State private var score = 0;
  @State private var roundsLeft = 5
  
  @State private var showFinalScore = false
  
  func resetGame() {
    score = 0;
    roundsLeft = 5
    countries.shuffle();
  }
  
  func flagTapped(_ number: Int) {
    if (number == correctAnswer) {
      scoreTitle = "Correct"
      score += 20
    } else {
      scoreTitle = "Wrong"
    }
    
    roundsLeft -= 1
    
    
    if(roundsLeft == 0) {
      showFinalScore = true
    } else {
      showingScore = true
    }
  }
  
  func askQuestion() {
    countries.shuffle()
    correctAnswer = Int.random(in:0...2)
  }
  
  func endGame() {
    
  }
  
  var body: some View {
    ZStack {
      
      RadialGradient(stops: [
        .init(color: .pink, location: 0.3),
        .init(color: .white, location:0.3),
        .init(color: .white, location:0.31),
        .init(color: .black, location: 0.31),
      ], center: .top, startRadius: 80, endRadius: 700)
      .ignoresSafeArea()
      
      VStack {
        Spacer()
        Text("Guess the Flag")
          .font(.largeTitle.bold())
          .foregroundStyle(.white)
        
        VStack(spacing: 15) {
          Text("Tap the flag of")
            .foregroundStyle(.secondary)
            .font(.subheadline.weight(.heavy))
          
          Text(countries[correctAnswer])
            .font(.largeTitle.weight(.semibold))
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .padding(.vertical, 20)
        .background(.regularMaterial)
        .clipShape(.rect(cornerRadius: 20))
        
        ForEach(0..<3) { number in
          Button {
            flagTapped(number)
          } label: {
            Image(countries[number])
          }
          .border(.gray) //Added by me
          .clipShape(.capsule)
          .shadow(radius: 5)
        }
        .alert(scoreTitle, isPresented: $showingScore){
          Button("Continue", action: askQuestion)
        } message: {
          Text("Your score is \(score)")
        }
        .alert("Game Over!", isPresented: $showFinalScore){
          Button("End", action: resetGame)
        } message: {
          Text("Final score \(score)")
        }
        
        Spacer()
        Spacer()
        
       
        Text("Score: \(score)")
          .foregroundStyle(.white)
          .font(.title.bold())
        
        Spacer()
      }
      .padding()
      
    }
  }
}

#Preview {
  ContentView()
}
