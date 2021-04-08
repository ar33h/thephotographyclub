import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Designs extends StatefulWidget {
  @override
  _DesignsState createState() => _DesignsState();
}

class _DesignsState extends State<Designs> {
  
  String imageUrl;

  uploadImageToFirebase() async
  {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
    PickedFile image;

    //Check Permissions
    await Permission.photos.request();       
    var permissionStatus = await Permission.photos.status;

    if(permissionStatus.isGranted)
    {
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);
      
      if(image != null)
      {
        //Upload to Firebase
        var snapshot = await _storage.ref().child('Designs/$imageFileName').putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
          Fluttertoast.showToast(msg: "Image Uploaded!");
        });
        
      }
      else
      {
        print("No path received!");
      }
    }
    else
    {
      print("Grant Permissions and try again!");
    }
   
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
         child: Column(
          //  mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           
           children: <Widget>[

            Container(
              child: Text("Graphic Designs/Artworks", style: GoogleFonts.montserrat(
                  fontSize: 27.0,
                  fontWeight: FontWeight.w600,
              )),
            ),
            
            SizedBox(height: 20,),

            Container(
              padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
              
              child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vulputate elementum libero, suscipit placerat lorem iaculis in. Sed tincidunt sem nibh, quis feugiat justo efficitur non. In molestie viverra turpis vitae consectetur. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Suspendisse eu porta nulla.", style: GoogleFonts.montserrat(
                  fontSize: 15.0,
                  height: 1.5,
                  fontWeight: FontWeight.w400),

                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 30,),

            ElevatedButton(
              onPressed: uploadImageToFirebase, 
              child: Text("UPLOAD", style: GoogleFonts.nunito(fontSize: 20.0, fontWeight: FontWeight.w700,
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

           ]
         )
        )
      )
    );
  }
}