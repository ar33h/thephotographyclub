import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  
  navigateToLogin() async 
  {
    Navigator.pushReplacementNamed(context, "Login");
  }
  navigateToRegister() async 
  {
    Navigator.pushReplacementNamed(context, "Sign-Up");
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE4382C),
       body: Container(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              // SizedBox(height: 130.0),

              Container(
                alignment: Alignment.center ,
                child: Image(image: AssetImage("assets/logo.png"), height: 80, fit: BoxFit.contain,),
              ),

              SizedBox(height: 40.0),
              
              Container(
                child: Text("Offical Photography Club of", style: GoogleFonts.montserrat(
                  color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.w400, letterSpacing: 1,
                )),
              ),
              
              SizedBox(height: 8.0),

              RichText(
                text: TextSpan(
                  text: "Symbiosis Institute of Technology, Pune", 
                  style: GoogleFonts.montserrat(
                    color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17.0,),
                  )
              ),

              

              SizedBox(height: 40.0),
            
              //Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  ElevatedButton(
                     
                    onPressed: navigateToLogin, 
                    child: Text("LOGIN", style: GoogleFonts.nunito(fontSize: 18.0,fontWeight: FontWeight.w700,
                                color: Colors.white
                    )),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.only(left:30, right:30)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),)
                    ),
                    )
                  ),

                  SizedBox(width: 22.0),
                
                  ElevatedButton(
                    onPressed: navigateToRegister, 
                    child: Text("SIGN-UP", style: GoogleFonts.nunito(fontSize: 18.0,fontWeight: FontWeight.w700,
                                color: Colors.black
                    )),
                    style: ButtonStyle( 
                      padding: MaterialStateProperty.all(EdgeInsets.only(left:30, right:30)),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return Colors.white;
                      }
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),),
                    ),
                    )
                  ),

                ],
              )
            ]
         )
       )
    );
  }
}
