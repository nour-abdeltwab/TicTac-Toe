import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/constants/colors.dart';
import 'package:tictactoe/homePage.dart';
// ignore: must_be_immutable
class Gamescreen extends StatefulWidget {
   String player1;
   String player2;
   Gamescreen({required this.player1, required this.player2});

  @override
  State<Gamescreen> createState() => _GamescreenState();
}

class _GamescreenState extends State<Gamescreen> {
  late List<List<String>>  _board;
  late String _currentPlayer;
  late String _winner;
  late bool _gameover;
  int oScore = 0;
  int xScore = 0;
  @override 
  void initState(){
    super.initState();
    _board = List.generate(3, (_) => List.generate(3, (_)=>""));
    _currentPlayer = "X";
    _winner = "";
    _gameover = false;
  }
  void _resetGame(){
    setState(() {
      _board = List.generate(3, (_) => List.generate(3, (_)=>""));
      _currentPlayer = "X";
      _winner = "";
      _gameover = false;
    });
  }
    void _updateScore() {
    // if (winner == 'O') {
    //   oScore++;
    // } else if (winner == 'X') {
    //   xScore++;
    // }
    setState(() {
      _winner == "X" ? xScore++ : _winner == "O" ? oScore++ : "" ;
    });
  }
  void _makeMove(int row, int col){
    if(_board[row][col] != "" || _gameover){return;}
    setState(() {
      _board[row][col]= _currentPlayer;

      if(_board[row][0]== _currentPlayer && _board[row][1]== _currentPlayer && _board[row][2] == _currentPlayer){
        _winner = _currentPlayer;
        _gameover = true;
        _updateScore();
      }else if(_board[0][col]== _currentPlayer && _board[1][col]== _currentPlayer && _board[2][col] == _currentPlayer){
        _winner = _currentPlayer;
        _gameover = true;
      }else if(_board[0][0]== _currentPlayer && _board[1][1]== _currentPlayer && _board[2][2] == _currentPlayer){
        _winner = _currentPlayer;
        _gameover = true;
      }else if(_board[0][2]== _currentPlayer && _board[1][1]== _currentPlayer && _board[2][0] == _currentPlayer){
        _winner = _currentPlayer;
        _gameover = true;
      }
      _currentPlayer = _currentPlayer == "X" ? "O" : "X";
      if(!_board.any((row) => row.any((cell) => cell ==""))){
        _gameover= true;
        _winner = "it`s a tie";
      }

      if(_winner != ""){
        AwesomeDialog(context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        btnOkText: "play again",
        title: _winner == "X" ? widget.player1 + " win!" : _winner == "O" ? widget.player2 + ' win!' : 'it`s a tie',
        btnOkOnPress: (){_resetGame();}
        )..show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: SingleChildScrollView(
      child: Column(
        children: [SizedBox(height: 70,),
        SizedBox(height: 120, child: Column(
          children: [Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Turn: ',style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),),
            Text(
              _currentPlayer =="X"?widget.player1 + "($_currentPlayer)": widget.player2 +"($_currentPlayer)",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: _currentPlayer == "X"?MainColor.greencolor: Colors.amber),)

          ],),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.player1,
                        style: TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.bold),
                      ),
                      Text(
                        oScore.toString(),
                        // style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
                        //  _winner =="X"? "($xScore++)":" ($xScore)",
                        // "_updateScore()",

                      ),
                    ],
                  ),
                  SizedBox(width: 40),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.player2,
                        style: TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.bold),

                      ),
                      Text(
                        // xScore.toString(),
                        // style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
                        "2"


                      ),
                    ],
                  ),
          ],)
          ],
          
        ),),
        SizedBox(height: 20,),
        Container(decoration: BoxDecoration(
          color: Color(0xff5f6b84),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(5),
        child: GridView.builder(
          itemCount:9,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), itemBuilder: (context, index){
            int row =index ~/3;
            int col = index % 3 ;
            return GestureDetector(
              onTap: ()=> _makeMove(row, col),
              child: Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: MainColor.primaryColor,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text(_board[row][col],
                style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold, color: _board[row][col] == "X"? MainColor.greencolor: Colors.amber),
                ),),
              ),
            );
          }),
        ),
        SizedBox(height: 30,),
        InkWell(onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>homePage()));
          widget.player1= "";
          widget.player2 = "";
        },
        child: Container(
          decoration: BoxDecoration(color: Colors.green,
          borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.symmetric(vertical: 18,horizontal: 20),
          child: Text("restart", style: TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.bold),),
        ),
        )
        ],
      ),
    ),);
  }
}