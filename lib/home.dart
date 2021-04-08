import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tpc_sit/before_after.dart';
import 'package:tpc_sit/designs.dart';
import 'package:tpc_sit/feed.dart';
import 'package:tpc_sit/wallpaper.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isLoggedIn = false;

  checkAuthentication() async
  {
    _auth.authStateChanges().listen((user) {
      if(user == null)
      {
        Navigator.pushReplacementNamed(context, "Start");
      }
    });
  }

  getUser() async
  {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if(firebaseUser != null)
    {
      setState(() {
        this.user = firebaseUser;
        this.isLoggedIn = true;
      });
    }
  }

  logout() async
  {
    _auth.signOut();
  }

  navigateToWallWed()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> WallWed()));
  }

  navigateToBA()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> BeforeAfter()));
  }

  navigateToFeed()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> Feed()));
  }

  navigateToDesigns()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> Designs()));
  }

  @override
  void initState()
  {
    this.checkAuthentication();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TPC", style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFFE4382C),
      ),

       
       
       body: Padding(
         padding: EdgeInsets.only(top: 25.0),
        child: Container(
         
         child: !isLoggedIn? CircularProgressIndicator():

         Column(
          
          //  mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           
           children: <Widget>[

            Container(
              child: Text("Hi ${user.displayName}!", style: GoogleFonts.montserrat(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w600,
              )),
            ),
             SizedBox(height:16.0),

             Container(
              child: Text("UPLOAD YOUR CLICKS & DESIGNS", style: GoogleFonts.montserrat(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
              )),
            ),
              SizedBox(height:60.0),
             Center(
               
               //Wallpaper Wednesday
               child: ElevatedButton(
              onPressed: navigateToWallWed, 
              child: Text("Wallpaper Wednesday", style: GoogleFonts.nunito(fontSize: 20.0, fontWeight: FontWeight.w700,
                          color: Colors.white
              )),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFFE4382C)),
                padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(60, 10, 60, 10)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),)
              ),
              )
              ),
             ),

              SizedBox(height:18.0),

              //Before/After Series
               ElevatedButton(
              onPressed: navigateToBA, 
              child: Text("Before/After Series", style: GoogleFonts.nunito(fontSize: 20.0, fontWeight: FontWeight.w700,
                          color: Colors.white
              )),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFFE4382C)),
                padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(80, 10, 80, 10)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),)
              ),
              )
              ),

              SizedBox(height:18.0),

              //Feed/Story Features
               ElevatedButton(
              onPressed: navigateToFeed, 
              child: Text("Feed/Story Features", style: GoogleFonts.nunito(fontSize: 20.0, fontWeight: FontWeight.w700,
                          color: Colors.white
              )),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFFE4382C)),
                padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(80, 10, 80, 10)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),)
              ),
              )
              ),

              SizedBox(height:18.0),

              //Graphic Designs/Creative Artworks
               ElevatedButton(
              onPressed: navigateToDesigns, 
              child: Text("Graphic Designs/Artworks", style: GoogleFonts.nunito(fontSize: 20.0, fontWeight: FontWeight.w700,
                          color: Colors.white
              )),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFFE4382C)),
                padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(50, 10, 50, 10)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),)
              ),
              )
              ),



                SizedBox(height:150.0), 

               ElevatedButton(
              
              onPressed: logout, 
              child: Text("LOG-OUT", style: GoogleFonts.nunito(fontSize: 13.0, fontWeight: FontWeight.w700,
                          color: Color(0xFFE4382C)
              )),
              style: ButtonStyle(
                
                backgroundColor: MaterialStateProperty.all(Colors.white),
                padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(40, 10, 40, 10)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Color(0xFFE4382C)),
                  )
              ),
              )
              )
             
           ],
         )
       ),
       )
    );
  }
}