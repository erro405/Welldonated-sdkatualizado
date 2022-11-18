import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weeldonatedproject/posts_feed/feed_screen.dart';

class CredentialsCollective extends StatefulWidget {
  @override
  State<CredentialsCollective> createState() => _CredentialsCollectiveState();
}

class _CredentialsCollectiveState extends State<CredentialsCollective> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _nameController = TextEditingController(text: "");
  final TextEditingController _emailTextController = TextEditingController(text: "");
  final TextEditingController _passwordController = TextEditingController(text: "");
  final TextEditingController _addressTextController = TextEditingController(text: "");
  final TextEditingController _phoneNumController = TextEditingController(text: "");

  File? imageFile;
  String? imageUrl;

  String dropdownvalue = 'Selecione a Categoria';
  final items = [
    'Selecione a Categoria',
    'Animal',
    'Apoio à vítima',
    'Apoio à criança',
    'Arte e Cultura',
    'Deficiência visual',
    'Deficiência motora',
    'Desporto',
    'Educação',
    'Idosos',
    'Juventude',
    'Lazer',
    'Música',
    'Religião',
    'Saúde',
    'Voluntariado',
    'Outros',
  ];

  var _currentItemSelected = "Selecione a Categoria";
  var category = "Selecione a Categoria";
  var index = 0;

  void _showImageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Por favor escolha uma opcão"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
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
                  onTap: () {
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
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _getFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);

    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                _showImageDialog();
              },
              child: CircleAvatar(
                radius: 75.0,
                backgroundColor: Colors.white,
                backgroundImage: imageFile == null
                    ? AssetImage("imagens/avatar.png")
                    : Image.file(imageFile!).image,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            TextFormField(
              controller: _nameController,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 6,
                ),
                filled: true,
                fillColor: Color(0xff1a237e),
                hintText: "Nome da Instituição",
                hintStyle: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Poppins',
                  color: Colors.white70,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white70,
                    width: 1.3,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white70,
                    width: 1.3,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(
              height: 18.0,
            ),
            TextFormField(
              controller: _emailTextController,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 6,
                ),
                filled: true,
                fillColor: Color(0xff1a237e),
                hintText: "E-mail",
                hintStyle: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Poppins',
                  color: Colors.white70,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white70,
                    width: 1.3,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white70,
                    width: 1.3,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(
              height: 18.0,
            ),
            Container(
              width: 350,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 1.3,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
                color: Color(0xff3949ab),
              ),
              child: Theme(
                data:
                    Theme.of(context).copyWith(canvasColor: Color(0xff3949ab)),
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton<String>(
                      underline: SizedBox(),
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      iconSize: 35,
                      iconDisabledColor: Colors.white,
                      iconEnabledColor: Colors.white,
                      items: items.map((String items) {
                        return DropdownMenuItem<String>(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                      onChanged: (newValueSelected) {
                        setState(() {
                          _currentItemSelected = newValueSelected!;
                          category = newValueSelected;
                        });
                      },
                      value: _currentItemSelected,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 18.0,
            ),
            TextFormField(
              controller: _addressTextController,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 6,
                ),
                filled: true,
                fillColor: Color(0xff1a237e),
                hintText: "Localidade",
                hintStyle: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Poppins',
                  color: Colors.white70,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white70,
                    width: 1.3,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white70,
                    width: 1.3,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(
              height: 18.0,
            ),
            TextFormField(
              controller: _phoneNumController,
              keyboardType: TextInputType.number,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 6,
                ),
                filled: true,
                fillColor: Color(0xff1a237e),
                hintText: "Contacto",
                hintStyle: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Poppins',
                  color: Colors.white70,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white70,
                    width: 1.3,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white70,
                    width: 1.3,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(
              height: 18.0,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 6,
                ),
                filled: true,
                fillColor: Color(0xff1a237e),
                hintText: "Palavra-passe",
                hintStyle: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Poppins',
                  color: Colors.white70,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white70,
                    width: 1.3,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white70,
                    width: 1.3,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(
              height: 28.0,
            ),
            Text(
              'Ao clicar em Registar, está a concordar com os Termos do Serviço e com a Política de Privacidade da Well Donated',
              textAlign: TextAlign.center,
              style: TextStyle(
                wordSpacing: 1.0,
                letterSpacing: 0.5,
                fontFamily: 'Poppins',
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
            SizedBox(
              height: 38.0,
            ),
            ElevatedButton(
              onPressed: () async {
                if (imageFile == null) {
                  Fluttertoast.showToast(msg: "Selecione uma fotografia");
                  return;
                }
                try {
                  final ref = FirebaseStorage.instance
                      .ref()
                      .child('userImages')
                      .child(DateTime.now().toString() + '.jpg');
                  await ref.putFile(imageFile!);
                  imageUrl = await ref.getDownloadURL();
                  await _auth.createUserWithEmailAndPassword(
                    email: _emailTextController.text.trim().toLowerCase(),
                    password: _passwordController.text.trim(),
                  );
                  final User? user = _auth.currentUser;
                  final _uid = user!.uid;
                  FirebaseFirestore.instance.collection('users').doc(_uid).set({
                    'id': _uid,
                    'userImage': imageUrl,
                    'name': _nameController.text,
                    'email': _emailTextController.text,
                    'phoneNumber': _phoneNumController.text,
                    'fullAddress': _addressTextController.text,
                    'category': _currentItemSelected,
                    'role': 'collective',
                    'createAt': Timestamp.now(),
                  });
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                } catch (error) {
                  Fluttertoast.showToast(msg: error.toString());
                }
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FeedScreen()));
              },
              child: Text(
                'Criar conta',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontFamily: 'Poppins',
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xffef6C00),
                fixedSize: Size(200, 50),
              ),
            ),
          ],
        ));
  }
}
