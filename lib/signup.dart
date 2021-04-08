import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';



class SignUp extends StatefulWidget {

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey <FormState> _formKey = GlobalKey<FormState>();

  String _name, _email, _password;

  checkAuthentication() async
  {
    _auth.authStateChanges().listen((user) {
        if(user!=null)
        {
          Navigator.pushReplacementNamed(context, "Home");
        }
    });
  }

  @override
  void initState()
  {
    super.initState();
    this.checkAuthentication();
  }


  signup() async
  {
      if(_formKey.currentState.validate())
      {
        _formKey.currentState.save();
        try
        {
          UserCredential user = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
          if(user!=null)
          {
            await _auth.currentUser.updateProfile(displayName: _name);
          }
        }
        on FirebaseAuthException catch (e)
        {
          showError(e.message);
        }
      }
  }

  showError(String errormessage)
  {
    showDialog(
      context: context, 
      builder: (BuildContext context)
      {
        return AlertDialog(
          title: Text("Invalid Credentials!"),
          content: Text(errormessage),

          actions: <Widget>[
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text("Okay"))
          ],
        );
      }  
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4382C),
      body: SingleChildScrollView(
              child: Container(
          child: Column(
            children: <Widget>[

                SizedBox(height: 150.0),

                Container(
                  alignment: Alignment.center ,
                  child: Image(image: AssetImage("assets/logo.png"), height: 80, fit: BoxFit.contain,),
                ),

                SizedBox(height: 30,),

                Container(
                  child: Form(
                    key: _formKey,
                    child: Column
                    (
                      children: <Widget>[
                        //Name
                        Container(
                          child: TextFormField(
                            validator: (input)
                            {
                              if(input.isEmpty)
                                return "Enter your Name!";
                            },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Name",
                                prefixIcon: Icon(Icons.person)
                              ),

                              onSaved: (input) => _name = input
                            

                          ),
                        
                        ),
                        SizedBox(height: 12.0),
                        //Email
                        Container(
                          child: TextFormField(
                            validator: (input)
                            {
                              if(input.isEmpty)
                                return "Enter your E-Mail!";
                            },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "E-Mail",
                                prefixIcon: Icon(Icons.email)
                              ),

                              onSaved: (input) => _email = input
                            

                          )
                        
                        ),

                              SizedBox(height: 12.0),
                              //Password
                              Container(
                                child: TextFormField(
                                  validator: (input)
                                  {
                                    if(input.length < 6)
                                      return "Password must atleast 6 charactes!";
                                  }, 
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Password",
                                      prefixIcon: Icon(Icons.lock)
                                    ),
                                    
                                    obscureText: true,
                                    onSaved: (input) => _password = input,
                                  

                                )
                              ),
                              
                              SizedBox(height: 40.0,),
                              ElevatedButton(
                              onPressed: signup, 
                              child: Text("SIGN-UP", style: GoogleFonts.nunito(fontSize: 20.0, fontWeight: FontWeight.w700,
                                          color: Colors.black
                              )),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(70, 10, 70, 10)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),)
                              ),
                              )
                              )
                            ],
                    ) 
                        )
                  
                )
            ]
                )
          ),
      )      
    );
    
  }
}
