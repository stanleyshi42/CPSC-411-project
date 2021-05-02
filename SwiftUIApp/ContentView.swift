// Stanley Shi

import SwiftUI

struct ContentView: View {
    @State private var score: Int = 0
    @State private var highScore : Int = 0
    @State private var timeRemaining : Int = 5
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var gameOver : Bool = false
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 10) {
                HStack() {
                    Text("Score: \(score)").frame(maxWidth: geo.size.width*0.50, maxHeight: .infinity).background(Color.green).padding(10)
                    
                    //Called every 1 second
                    Text("Time: \(timeRemaining)").onReceive(timer) { _ in
                        if timeRemaining > 0 {
                            timeRemaining -= 1
                        }
                        if timeRemaining <= 0 {
                            gameOver = true
                            if score > highScore{
                                highScore = score
                            }
                        }
                    }
                    .frame(maxWidth: geo.size.width*0.50, maxHeight: .infinity)
                    .background(Color.yellow)
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .fixedSize(horizontal: false, vertical: true)
                .background(Color.green)
                
                //Build 5 rows of buttons
                buildHStack()
                buildHStack()
                buildHStack()
                buildHStack()
                buildHStack()
                
                if(gameOver){
                    VStack() {
                        
                        Text("Game Over")
                            .frame(width: geo.size.width, height: 30)
                            .background(Color.red)
                        Text("High Score: \(highScore)")
                            .frame(width: geo.size.width, height: 30)
                            .background(Color.yellow)
                        
                        Button("Play Again", action: {
                            timeRemaining = 5
                            score = 0
                            gameOver = false
                        })
                        .frame(width: geo.size.width, height: 30)
                        .background(Color.green)
                        .foregroundColor(Color.black)
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: Alignment.top)
            .background(Color.white)
        }
    }
    
    func buildHStack() -> some View{
        return AnyView(HStack(spacing: 10) {
            buildButton()
            buildButton()
            buildButton()
            buildButton()
            buildButton()
        }
        .frame(maxWidth: .infinity, alignment: Alignment.center))
    }
    
    func buildButton() -> some View {
        //Instantiate a random boolean
        //If true, generate a green button
        //If false, generate a red button
        let rand = Bool.random()
        
        return AnyView(Button(" ", action: {
            if(rand){
                score += 1
                timeRemaining = 5
            }
            else{
                timeRemaining = 0
            }
        })
        .frame(width: 50,height: 50)
        .background(rand ? Color.green : Color.red))    //50% chance for green button, 50% for red
        .disabled(gameOver)     //Disables button on game over
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
