import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../app/add_announcement_screen.dart';
import 'profile_screen_singular.dart';

import '../costumwidgets/LowerAppBar.dart';

class EditProfileSingular extends StatefulWidget {

  @override
  State<EditProfileSingular> createState() => _EditProfileSingularState();
}

class _EditProfileSingularState extends State<EditProfileSingular> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _name = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _phoneNo = new TextEditingController();

  bool _nameValid = false;
  bool _emailValid = false;
  bool _phoneNoValid = false;

  String? image = '';
  File? imageXFile;

  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async
    {
      if(snapshot.exists) {
        setState(() {
          _name.text = snapshot.data()!['name'];
          _email.text = snapshot.data()!['email'];
          image = snapshot.data()!['userImage'];
          _phoneNo.text = snapshot.data()!['phoneNumber'];
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDataFromDatabase();
  }

  void _showImageDialog() {
    showDialog(
        context: context,
        builder: (context)
        {
          return AlertDialog(
            title: Text("Por favor escolha uma opcão"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: ()
                  {
                    _getFromCamera();
                  },
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.deepOrange,
                        ),
                      ),
                      Text(
                        "Camera",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: ()
                  {
                    _getFromGallery();
                  },
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.image,
                          color: Colors.deepOrange,
                        ),
                      ),
                      Text(
                        "Galeria",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  void _getFromCamera() async {

    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _getFromGallery() async {

    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _cropImage(filePath) async {

    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);

    if (croppedImage != null) {
      setState(() {
        imageXFile = File(croppedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3949ab),
        actions: [
          Builder(builder: (BuildContext context) {
            return IconButton(
              alignment: Alignment.centerRight,
              icon: const Icon(
                Icons.close,
                size: 35.0,
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreenSingular()));

              },
            );
          }),
        ],
        bottom: PreferredSize(
            child: Container(
              color: Colors.white,
              height: 3.0,
            ),
            preferredSize: Size.fromHeight(5.0)),
        elevation: 0.0,
        title: Text(
          'Editar Perfil',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Segoi UI',
            fontSize: 23,
          ),
        ),
      ),
      body: Container(
        color: Color(0xff1a237e),
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                GestureDetector(
                  onTap: () {
                    _showImageDialog();
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.deepOrange,
                    minRadius: 80.0,
                    child: CircleAvatar(
                      radius: 75.0,
                      backgroundImage: imageXFile == null
                          ?
                      NetworkImage(
                          image!
                      )
                          :
                      Image.file
                        (imageXFile!).image,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Clique para editar',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                TextFormField(
                  controller: _name,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 9,
                      horizontal: 10,
                    ),
                    filled: true,
                    fillColor: Color(0xff3949AB),
                    hintText: "Nome",
                    hintStyle: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.3,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.4,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    errorText: _nameValid ? 'Nome não pode ficar em branco' : null,
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontFamily: 'Poppins',
                  ),
                ), //EMAIL
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  enabled: false,
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 9,
                      horizontal: 10,
                    ),
                    filled: true,
                    fillColor: Color(0xff3949AB),
                    hintText: "Email",
                    hintStyle: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.3,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.4,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    errorText: _emailValid ? 'E-mail não pode ficar em branco' : null,
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontFamily: 'Poppins',
                  ),
                ), //EMAIL
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _phoneNo,
                  keyboardType: TextInputType.phone,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 9,
                      horizontal: 10,
                    ),
                    filled: true,
                    fillColor: Color(0xff3949AB),
                    hintText: "Telemóvel",
                    hintStyle: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.3,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.4,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    errorText: _phoneNoValid ? 'Telemóvel não pode ficar em branco' : null,
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontFamily: 'Poppins',
                  ),
                ), //TELEMOVEL
                SizedBox(
                  height: 60,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_name.text == '' || _email.text.isEmpty || _phoneNo.text.isEmpty) {
                      setState(() {
                        _name.text.isEmpty ? _nameValid = true : _nameValid = false;
                        _email.text.isEmpty ? _emailValid = true : _emailValid = false;
                        _phoneNo.text.isEmpty ? _phoneNoValid = true : _phoneNoValid = false;
                      });
                    } else if (imageXFile == null) {
                      try {
                        final User? user = _auth.currentUser;
                        final _uid = user!.uid;
                        FirebaseFirestore.instance.collection('users')
                            .doc(_uid)
                            .set({
                          'id': _uid,
                          'userImage': image,
                          'name': _name.text,
                          'email': _email.text,
                          'phoneNumber': _phoneNo.text,
                          'role': 'singular',
                          'editedAt': Timestamp.now(),
                        });
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ProfileScreenSingular()));
                      } catch (error) {
                        Fluttertoast.showToast(msg: error.toString());
                      }
                    } else {
                      try {
                        final ref = FirebaseStorage.instance.ref().child(
                            'userImages').child(DateTime.now().toString() +
                            '.jpg');
                        await ref.putFile(imageXFile!);
                        image = await ref.getDownloadURL();

                        final User? user = _auth.currentUser;
                        final _uid = user!.uid;
                        FirebaseFirestore.instance.collection('users')
                            .doc(_uid)
                            .set({
                          'id': _uid,
                          'userImage': image,
                          'name': _name.text,
                          'email': _email.text,
                          'phoneNumber': _phoneNo.text,
                          'role': 'singular',
                          'editedAt': Timestamp.now(),
                        });
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ProfileScreenSingular()));
                      } catch (error) {
                        Fluttertoast.showToast(msg: error.toString());
                      }
                    }
                    //Navigator.push(context, MaterialPageRoute(
                        //builder: (context) => ProfileScreenSingular()));
                  },
                  child: Text(
                    'Editar',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffef6C00),
                    fixedSize: Size(170, 50),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Lowerappbar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFF9800),
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CriarAnuncio()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  );
  }
}

