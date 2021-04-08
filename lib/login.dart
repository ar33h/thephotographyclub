import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tpc_sit/signup.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey <FormState> _formKey = GlobalKey<FormState>();

  String _email, _password;
  
  //If user is already logged in
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
  getEmail()
  {
    return _email;
  }

  login() async
  {
    if(_formKey.currentState.validate())
    {
      _formKey.currentState.save();
      try
      {
        await _auth.signInWithEmailAndPassword(email: _email, password: _password);
      }
      catch (e)
      {
        showError(e.errormessage);
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

  navigateToSignUp() async
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUp()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4382C),
      body: SingleChildScrollView(
              child: Container(
          child: Column(
            children: <Widget>[

                SizedBox(height: 200.0),

                Container(
                  alignment: Alignment.center ,
                  child: Image(image: AssetImage("assets/logo.png"), height: 80, fit: BoxFit.contain,),
                ),
                
                SizedBox(height: 50.0),
                
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column
                    (
                      children: <Widget>[
                        Container(
                          child: TextFormField(
                            validator: (input)
                            {
                              if(input.isEmpty)
                                return "Enter your E-Mail!";
                            },
                              decoration: InputDecoration(
                                errorStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(),
                                labelText: "E-Mail",
                                prefixIcon: Icon(Icons.email)
                              ),

                              onSaved: (input) => _email = input
                            

                          )
                        
                        ),


                              SizedBox(height: 12,),
                              Container(
                                child: TextFormField(
                                  validator: (input)
                                  {
                                    if(input.length < 6)
                                      return "Password must be atleast 6 charactes!";
                                  }, 
                                    decoration: InputDecoration(
                                      errorStyle: TextStyle(color: Colors.white),
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
                              onPressed: login, 
                              child: Text("LOGIN", style: GoogleFonts.nunito(fontSize: 20.0, fontWeight: FontWeight.w700,
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
                  
                ),
                SizedBox(height: 12,),
                
                GestureDetector(
                  child: Text("Create an Account", style: GoogleFonts.montserrat(fontSize: 14.0, fontWeight: FontWeight.w400,
                                          color: Colors.white)),
                  onTap: navigateToSignUp,
                )
            ]
            
                )
          ),
      )      
    );
    
  }
}

