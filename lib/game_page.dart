
import 'package:flutter/material.dart';
import 'package:tictactoe/homePage.dart';
import '../constants/colors.dart';

// ignore: must_be_immutable
class GameScreen extends StatefulWidget {

  String player1;
  String player2;
  GameScreen({required this.player1, required this.player2});
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  
  bool oTurn = true;
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];
  List<int> matchedIndexes = [];
  int attempts = 0;

  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  String resultDeclaration = '';
  bool winnerFound = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        widget.player1,
                        style: TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.bold),
                      ),
                      Text(
                        oScore.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),

                      ),
                    ],
                  ),
                  SizedBox(width: 40),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        widget.player2,
                        style: TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.bold),

                      ),
                      Text(
                        xScore.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),

                      ),
                    ],
                  ),
                ],
              )),
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            width: 5,
                            color: MainColor.primaryColor,
                          ),
                          color: matchedIndexes.contains(index)
                              ? MainColor.accentColor
                              : MainColor.secondaryColor,
                        ),
                        child: Center(
                          child: Text(
                            displayXO[index],
                            style: TextStyle(color: MainColor.primaryColor,fontSize: 25),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(resultDeclaration,
                    style: TextStyle(color: Colors.white,fontSize: 30,),
                     ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
        Row(children: [
           ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
            onPressed: () {
              _clearBoard();
              attempts++;
            },
            child: Text(
               'Play Again!',
              style: TextStyle(fontSize: 28, color: Colors.black),
            ),
          ),
          SizedBox(width: 30,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
            onPressed: () {
              _clearBoard();
             _clearScore();
             Navigator.push(context, MaterialPageRoute(builder: (context)=>homePage()));
             
            },
            child: Text(
              "Start",
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
          )
        ],)
          ],
        ),
      ),
    );
  }

  void _tapped(int index) {
   

      setState(() {
        if (oTurn && displayXO[index] == '') {
          displayXO[index] = 'O';
          filledBoxes++;
        } else if (!oTurn && displayXO[index] == '') {
          displayXO[index] = 'X';
          filledBoxes++;
        }

        oTurn = !oTurn;
        _checkWinner();
      });
  
  }

  void _checkWinner() {
    // check 1st row
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[0] + ' Wins!';
        matchedIndexes.addAll([0, 1, 2]);
      
        _updateScore(displayXO[0]);
      });
    }

    // check 2nd row
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[3] + ' Wins!';
        matchedIndexes.addAll([3, 4, 5]);
      
        _updateScore(displayXO[3]);
      });
    }

    // check 3rd row
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[6] + ' Wins!';
        matchedIndexes.addAll([6, 7, 8]);
        _updateScore(displayXO[6]);
      });
    }

    // check 1st column
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[0] + ' Wins!';
        matchedIndexes.addAll([0, 3, 6]);
        _updateScore(displayXO[0]);
      });
    }

    // check 2nd column
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[1] + ' Wins!';
        matchedIndexes.addAll([1, 4, 7]);
        _updateScore(displayXO[1]);
      });
    }

    // check 3rd column
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[2] + ' Wins!';
        matchedIndexes.addAll([2, 5, 8]);
        _updateScore(displayXO[2]);
      });
    }

    // check diagonal
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[0] + ' Wins!';
        matchedIndexes.addAll([0, 4, 8]);
        _updateScore(displayXO[0]);
      });
    }

    // check diagonal
    if (displayXO[6] == displayXO[4] &&
        displayXO[6] == displayXO[2] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[6] + ' Wins!';
        matchedIndexes.addAll([6, 4, 2]);
        _updateScore(displayXO[6]);
      });
    }
    if (!winnerFound && filledBoxes == 9) {
      setState(() {
        resultDeclaration = 'Nobody Wins!';
      });
    }
  }

  void _updateScore(String winner) {
    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
    winnerFound = true;
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
      resultDeclaration = '';
      matchedIndexes = [];
    });
    filledBoxes = 0;
  }

  void _clearScore(){
    setState(() {
      oScore= 0;
      xScore = 0;
    });
  }


}