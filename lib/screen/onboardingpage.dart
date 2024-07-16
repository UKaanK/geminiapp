import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geminialapp/screen/myhomepage.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  "You AI Assistant",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue
                  ),
                ),
                SizedBox(height: 16,),
                Text(
                  "Using this software, you can ask you questions and receive articles using artificial intelligence assistant",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.background==Colors.black ? Colors.white:Colors.black
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),
            Image.asset("assets/images/splashscreen.png"),
            SizedBox(height: 30,),
            ElevatedButton(
              
              onPressed: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(),), (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
                ),
                padding: EdgeInsets.symmetric(vertical: 16,horizontal: 32)
              ),
             child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Contiune",style: TextStyle(color: Colors.black),),
                SizedBox(height: 8,),
                Icon(Icons.arrow_forward,color: Colors.black,)
              ],
            ))
          ],
        ),
      ),
    );
  }
}