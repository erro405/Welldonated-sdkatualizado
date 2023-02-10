import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../costumwidgets/LowerAppBar.dart';
import '../posts_feed/feed_screen.dart';

class CriarAnuncio extends StatefulWidget {
  @override
  State<CriarAnuncio> createState() => _CriarAnuncioState();
}

class _CriarAnuncioState extends State<CriarAnuncio> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _titlePost = new TextEditingController();
  final TextEditingController _description = new TextEditingController();
  final TextEditingController _amount = new TextEditingController();
  final TextEditingController _location = new TextEditingController();
  final TextEditingController _phoneNum = new TextEditingController();

  bool _titleValid = false;
  bool _descriptionValid = false;
  bool _amountValid = false;
  bool _locationValid = false;
  bool _phoneNumValid = false;

  File? imageFile;
  String? imageUrl;

  String dropdownvalue = 'Selecione a Categoria';
  final items = [
    'Selecione a Categoria',
    'Mobiliário',
    'Animais',
    'Alimentação',
    'Vestuário',
    'Cultura',
    'Educação',
    'Saúde',
    'Outros',
  ];

  var _currentItemSelected = "Selecione a Categoria";
  var category = "Selecione a Categoria";
  var index = 0;

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
        sourcePath: filePath, maxHeight: 1920, maxWidth: 1080);

    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            Builder(builder: (BuildContext context) {
              return IconButton(
                alignment: Alignment.centerRight,
                icon: const Icon(
                  Icons.close,
                  size: 35.0,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FeedScreen()));
                },
              );
            }),
          ],
          backgroundColor: Color(0xff3949ab),
          bottom: PreferredSize(
              child: Container(
                color: Colors.white,
                height: 3.0,
              ),
              preferredSize: Size.fromHeight(8.0)),
          elevation: 0.0,
          title: Text(
            'Anunciar um artigo',
            textAlign: TextAlign.end,
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
                children: <Widget>[
                  imageFile == null
                      ?
                  ElevatedButton(
                    onPressed: () {
                      _showImageDialog();
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          size: 34.0,
                          color: Color(0xff1a237e),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Carregar fotografias',
                          style: TextStyle(
                            color: Color(0xff1a237e),
                            fontSize: 20.0,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      fixedSize: Size(290, 50),
                    ),
                  )
                    :
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.file(imageFile!).image,
                        )
                      ),
                    ),
                  SizedBox(
                    height: 38.0,
                  ),
                  TextFormField(
                    controller: _titlePost,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 10,
                      ),
                      filled: true,
                      fillColor: Color(0xff3949AB),
                      hintText: "Título",
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
                          width: 1.3,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      errorText: _titleValid ? 'Título não pode ficar em branco' : null,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'Poppins',
                    ),
                  ), //Título
                  SizedBox(
                    height: 40.0,
                  ),
                  Card(
                    child: TextFormField(
                      controller: _description,
                      maxLines: 5,
                      cursorColor: Colors.white,
                      textAlignVertical: TextAlignVertical.top,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 6,
                        ),
                        filled: true,
                        fillColor: Color(0xff3949ab),
                        hintText: "Descrição",
                        hintStyle: TextStyle(
                          fontSize: 21.0,
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
                            width: 1.3,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        errorText: _descriptionValid ? 'Descrição não pode ficar em branco' : null,
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ), //descriçao
                  SizedBox(
                    height: 40.0,
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
                      data: Theme.of(context)
                          .copyWith(canvasColor: Color(0xff3949ab)),
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
                    height: 38.0,
                  ),
                  TextFormField(
                    controller: _amount,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 10,
                      ),
                      filled: true,
                      fillColor: Color(0xff3949AB),
                      hintText: "Quantidade",
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
                          width: 1.3,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      errorText: _amountValid ? 'Quantidade não pode ficar em branco' : null,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'Poppins',
                    ),
                  ), // quantidade
                  SizedBox(
                    height: 30.0,
                  ),
                  Divider(thickness: 2.0, color: Colors.white70),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    controller: _location,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 10,
                      ),
                      filled: true,
                      fillColor: Color(0xff3949AB),
                      hintText: "Localidade",
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
                          width: 1.3,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      errorText: _locationValid ? 'Localidade não pode ficar em branco' : null,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'Poppins',
                    ),
                  ), //localidade
                  SizedBox(
                    height: 35.0,
                  ),
                  TextFormField(
                    controller: _phoneNum,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 10,
                      ),
                      filled: true,
                      fillColor: Color(0xff3949AB),
                      hintText: "Contacto Telefónico",
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
                          width: 1.3,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      errorText: _phoneNumValid ? 'Contacto Telefónico não pode ficar em branco' : null,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'Poppins',
                    ),
                  ), //contacto telefonico
                  SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (imageFile == null) {
                        Fluttertoast.showToast(msg: "Selecione uma fotografia");
                        return;
                      } else if (_titlePost.text.isEmpty || _description.text.isEmpty || _amount.text.isEmpty || _location.text.isEmpty || _phoneNum.text.isEmpty) {
                        setState(() {
                          _titlePost.text.isEmpty ? _titleValid = true : _titleValid = false;
                          _description.text.isEmpty ? _descriptionValid = true : _descriptionValid = false;
                          _amount.text.isEmpty ? _amountValid = true : _amountValid = false;
                          _location.text.isEmpty ? _locationValid = true : _locationValid = false;
                          _phoneNum.text.isEmpty ? _phoneNumValid = true : _phoneNumValid = false;
                        });
                      } else {
                        try {
                          final ref = FirebaseStorage.instance.ref().child(
                              'postImages').child(DateTime.now().toString() +
                              '.jpg');
                          await ref.putFile(imageFile!);
                          imageUrl = await ref.getDownloadURL();

                          final User? user = _auth.currentUser;
                          final _uid = user!.uid;
                          final String _postId = const Uuid().v1();

                          FirebaseFirestore.instance.collection('posts').doc(
                              _postId).set({
                            'id': _uid,
                            'postId': _postId,
                            'postImage': imageUrl,
                            "title": _titlePost.text,
                            "description": _description.text,
                            "amount": _amount.text,
                            "category": _currentItemSelected,
                            "location": _location.text,
                            "phoneNumber": _phoneNum.text,
                            'createAt': Timestamp.now(),
                          });
                          Navigator.canPop(context)
                              ? Navigator.pop(context)
                              : null;
                        } catch (error) {
                          Fluttertoast.showToast(msg: error.toString());
                        }
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => FeedScreen()));
                      }
                    },
                    child: Text(
                      'Publicar anúncio',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffef6C00),
                      fixedSize: Size(250, 50),
                    ),
                  ),
                  SizedBox(
                    height: 60.0,
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CriarAnuncio()));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    } else if (Platform.isIOS) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            Builder(builder: (BuildContext context) {
              return IconButton(
                alignment: Alignment.centerRight,
                icon: const Icon(
                  Icons.close,
                  size: 35.0,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FeedScreen()));
                },
              );
            }),
          ],
          backgroundColor: Color(0xff3949ab),
          bottom: PreferredSize(
              child: Container(
                color: Colors.white,
                height: 3.0,
              ),
              preferredSize: Size.fromHeight(8.0)),
          elevation: 0.0,
          title: Text(
            'Anunciar um artigo',
            textAlign: TextAlign.end,
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
                children: <Widget>[
                  imageFile == null
                      ?
                      ElevatedButton(
                      onPressed: () {
                        _showImageDialog();
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            size: 34.0,
                            color: Color(0xff1a237e),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Carregar fotografias',
                            style: TextStyle(
                              color: Color(0xff1a237e),
                              fontSize: 20.0,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        fixedSize: Size(290, 50),
                      ),
                    )
                        :
                    Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.indigo,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.file(imageFile!).image,
                        )
                    ),
                  ),
                  SizedBox(
                    height: 38.0,
                  ),
                  TextFormField(
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 13,
                        horizontal: 10,
                      ),
                      filled: true,
                      fillColor: Color(0xff3949AB),
                      hintText: "Título",
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
                          width: 1.3,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      errorText: _titleValid ? 'Título não pode ficar em branco' : null,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Card(
                    child: TextFormField(
                      maxLines: 5,
                      cursorColor: Colors.white,
                      textAlignVertical: TextAlignVertical.top,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 6,
                        ),
                        filled: true,
                        fillColor: Color(0xff3949ab),
                        hintText: "Descrição",
                        hintStyle: TextStyle(
                          fontSize: 21.0,
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
                            width: 1.3,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        errorText: _descriptionValid ? 'Descrição não pode ficar em branco' : null,
                      ),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ), //descriçao
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    width: 380,
                    height: 60,
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
                    padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                    child: CupertinoButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            category,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white60,
                          )
                        ],
                      ),
                      onPressed: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) => CupertinoActionSheet(
                            actions: [buildPicker()],
                            cancelButton: CupertinoActionSheetAction(
                              child: Text('Confirmar'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 38.0,
                  ),
                  TextFormField(
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 13,
                        horizontal: 10,
                      ),
                      filled: true,
                      fillColor: Color(0xff3949AB),
                      hintText: "Quantidade",
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
                          width: 1.3,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      errorText: _amountValid ? 'Quantidade não pode ficar em branco' : null,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'Poppins',
                    ),
                  ), // quantidade
                  SizedBox(
                    height: 30.0,
                  ),
                  Divider(thickness: 2.0, color: Colors.white70),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 13,
                        horizontal: 10,
                      ),
                      filled: true,
                      fillColor: Color(0xff3949AB),
                      hintText: "Localidade",
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
                          width: 1.3,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      errorText: _locationValid ? 'Localidade não pode ficar em branco' : null,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'Poppins',
                    ),
                  ), //localidade
                  SizedBox(
                    height: 35.0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 13,
                        horizontal: 10,
                      ),
                      filled: true,
                      fillColor: Color(0xff3949AB),
                      hintText: "Contacto Telefónico",
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
                          width: 1.3,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      errorText: _phoneNumValid ? 'Contacto Telefónico não pode ficar em branco' : null,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'Poppins',
                    ),
                  ), //contacto telefonico
                  SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (imageFile == null) {
                        Fluttertoast.showToast(msg: "Selecione uma fotografia");
                        return;
                      } else if (_titlePost.text.isEmpty || _description.text.isEmpty || _amount.text.isEmpty || _location.text.isEmpty || _phoneNum.text.isEmpty) {
                        setState(() {
                          _titlePost.text.isEmpty ? _titleValid = true : _titleValid = false;
                          _description.text.isEmpty ? _descriptionValid = true : _descriptionValid = false;
                          _amount.text.isEmpty ? _amountValid = true : _amountValid = false;
                          _location.text.isEmpty ? _locationValid = true : _locationValid = false;
                          _phoneNum.text.isEmpty ? _phoneNumValid = true : _phoneNumValid = false;
                        });
                      } else {
                        try {
                          final ref = FirebaseStorage.instance.ref().child(
                              'postImages').child(DateTime.now().toString() +
                              '.jpg');
                          await ref.putFile(imageFile!);
                          imageUrl = await ref.getDownloadURL();

                          final User? user = _auth.currentUser;
                          final _uid = user!.uid;
                          final String _postId = const Uuid().v1();

                          FirebaseFirestore.instance.collection('posts').doc(
                              _postId).set({
                            'id': _uid,
                            'postId': _postId,
                            'postImage': imageUrl,
                            "title": _titlePost.text,
                            "description": _description.text,
                            "amount": _amount.text,
                            "category": _currentItemSelected,
                            "location": _location.text,
                            "phoneNumber": _phoneNum.text,
                            'createAt': Timestamp.now(),
                          });
                          Navigator.canPop(context)
                              ? Navigator.pop(context)
                              : null;
                        } catch (error) {
                          Fluttertoast.showToast(msg: error.toString());
                        }
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => FeedScreen()));
                      }
                    },
                    child: Text(
                      'Publicar anúncio',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffef6C00),
                      fixedSize: Size(250, 50),
                    ),
                  ),
                  SizedBox(
                    height: 60.0,
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CriarAnuncio()));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    }
    throw new Container();
  }

  Widget buildPicker() => SizedBox(
        height: 200,
        child: CupertinoPicker(
          looping: false,
          backgroundColor: Color(0xff1a237e),
          itemExtent: 35,
          children: items
              .map(
                (item) => Center(
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 23, color: Colors.white60),
                  ),
                ),
              )
              .toList(),
          onSelectedItemChanged: (index) {
            setState(() => this.index = index);

            final item = items[index];
            setState(() {
              _currentItemSelected = item!;
              category = item;
            });
            print('Item selecionado: $item');
          },
        ),
      );
}

class FirebaseApi {
  static UploadTask? uploadFile(String destination, File image) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(image);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}
