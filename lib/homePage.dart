import 'package:flutter/material.dart';

import 'GameScreen.dart';
// import 'game_page.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController player1Controller = TextEditingController();
  final TextEditingController player2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF323D5B),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Enter players name",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),),
            SizedBox(height: 20,),
            Padding(padding: EdgeInsets.all(15),
            child: TextFormField(controller: player1Controller,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),
              ),
              focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),
              ),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),),
              hintText: "player1 name",
              hintStyle: TextStyle(color: Colors.white)
            ),
            validator: (value){
              if(value == null || value.isEmpty){
                return "please enter name";
              }return null;
            },
            ),),

            Padding(padding: EdgeInsets.all(15),
            child: TextFormField(controller: player2Controller,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),
              ),
              focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),
              ),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),),
              hintText: "player2 name",
              hintStyle: TextStyle(color: Colors.white)
            ),
            validator: (value){
              if(value == null || value.isEmpty){
                return "please enter name";
              }return null;
            },
            ),),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                if(_formKey.currentState!.validate()){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Gamescreen(player1: player1Controller.text,
                  player2:player2Controller.text)));
                }
              },
              child: Container(decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(vertical: 17, horizontal: 20),
              child: Text("start",style: TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.bold),),
              ),
            )

          ],
        )),
    );
  }
}