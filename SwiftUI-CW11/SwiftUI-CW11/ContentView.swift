//
//  ContentView.swift
//  SwiftUI-CW11
//
//  Created by NasserAlsaqabi on 05/01/2021.
//

import SwiftUI
struct Field{
    var player: String // لمعرفة اسم اللاعب
    var enabled: Bool // للتأكد من أنه لم يتم استخدام هذا المربع من قبل لاعب آخر
}


struct ContentView: View {
    @State var fields: [[Field]] = .init(repeating: .init(repeating: Field(player: "",enabled: true), count: 3), count: 3)
//    var fields = [
//        [
//            Field(player: "", enabled: true),
//            Field(player: "", enabled: true),
//            Field(player: "", enabled: true)
//        ],
//        [
//            Field(player: "", enabled: true),
//            Field(player: "", enabled: true),
//            Field(player: "", enabled: true)
//        ],
//        [
//            Field(player: "", enabled: true),
//            Field(player: "", enabled: true),
//            Field(player: "", enabled: true)
//        ],
//
//    ]
    @State var playerTurn: String = "X"
    @State var winner = ""
    @State var winStatus = false
    @State var drawCounter = 0
    
    func checkWinner(){
        let r1 = fields[0][0].player == playerTurn && fields[0][1].player == playerTurn && fields[0][2].player == playerTurn
        let r2 = fields[1][0].player == playerTurn && fields[1][1].player == playerTurn && fields[1][2].player == playerTurn
        let r3 = fields[2][0].player == playerTurn && fields[2][1].player == playerTurn && fields[2][2].player == playerTurn
        
        let c1 = fields[0][0].player == playerTurn && fields[1][0].player == playerTurn && fields[2][0].player == playerTurn
        let c2 = fields[0][1].player == playerTurn && fields[1][1].player == playerTurn && fields[2][2].player == playerTurn
        let c3 = fields[0][2].player == playerTurn && fields[1][2].player == playerTurn && fields[2][2].player == playerTurn
        
        let d1 = fields[0][0].player == playerTurn && fields[1][1].player == playerTurn && fields[2][2].player == playerTurn
        let d2 = fields[0][2].player == playerTurn && fields[1][1].player == playerTurn && fields[2][0].player == playerTurn
        
        if r1 || r2 || r3 || c1 || c2 || c3 || d1 || d2 {
            winner = ("\(playerTurn) win")
            winStatus = true
        }
        else if drawCounter == 9 {
            winner = "Draw"
            winStatus = true
        }
    }
    var body: some View {
        VStack(spacing: 10){
            ForEach(0 ..< 3){ r in //لعمل ٣ مربعات بالعرض
                HStack(spacing: 10){
                    ForEach(0 ..< 3){ c in // لعمل ٣ مربعات بالطول
                        Button(action: { // تعين كل مربع بزر
                            if fields[r][c].enabled{
                                fields[r][c].player = playerTurn
                                drawCounter += 1
                                checkWinner()
                                if winStatus == false
                                playerTurn = playerTurn == "X" ? "O" : "X" // اختيار اذا كان اللاعب X أو O
                            }
                        }, label: {
                            Text(fields[r][c].player)
                                .font(.system(size: 60))
                                .foregroundColor(.black)
                                //.foregroundColor(Color(red: 0, green: 0, blue: 0, alpha: 1)))
                                .frame(width: 90, height: 90, alignment: .center)
                                .background(Color.white)
                        })
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
