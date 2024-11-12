import SwiftUI

struct ContentView: View {
    @State private var score = 0
    @State private var targetPosition = CGPoint(x: 150, y: 150)
    @State private var timeRemaining = 30
    @State private var isGameOver = false

    var body: some View {
        ZStack {
            Image("image")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Text("Score: \(score)")
                    .font(.largeTitle)
                    .padding()
                
                Text("Time: \(timeRemaining)")
                    .font(.title2)
                    .padding()
                
                Spacer()
            }
            
            Circle()
                .fill(Color.red)
                .frame(width: 100, height: 100)
                .position(targetPosition)
                .onTapGesture {
                    score += 1
                    moveTarget()
                }
            
            if isGameOver {
                VStack {
                    Text("Game Over!")
                        .font(.largeTitle)
                        .padding()
                    Text("Final Score: \(score)")
                        .font(.title)
                    Button("Play Again") {
                        resetGame()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .background(Color.cyan.opacity(0.8))
                .cornerRadius(20)
                .padding()
            }
        }
        .onAppear {
            startGame()
        }
    }
    
    private func moveTarget() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let randomX = CGFloat.random(in: 50...(screenWidth - 50))
        let randomY = CGFloat.random(in: 150...(screenHeight - 150))
        targetPosition = CGPoint(x: randomX, y: randomY)
    }
    
    private func startGame() {
        score = 0
        timeRemaining = 30
        isGameOver = false
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer.invalidate()
                isGameOver = true
            }
        }
        
        moveTarget()
    }
    
    private func resetGame() {
        startGame()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
