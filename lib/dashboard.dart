import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff7F84BE),

      appBar: AppBar(
        title: Text("Signup"),
      ),


      body: Center(

        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[


              SizedBox(height: 10),
              ButtonTheme(
                minWidth: 180.0,
                height: 50.0,

                child: RaisedButton(
                    child: const Text("Go Back"), color: Colors.deepPurpleAccent,
                    onPressed: ()
                    {
                      Navigator.pop(context);
                    }
                ),
              ),

            ]),

      ),

    );

  }
}

class StatelessWidget {
}



///////////////////////////////////////////////////////////////////////////


