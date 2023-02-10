import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../app/add_announcement_screen.dart';
import 'profile_screen_collective.dart';
import 'profile_screen_singular.dart';

import '../costumwidgets/LowerAppBar.dart';

class EditProfileCollective extends StatefulWidget {
  @override
  State<EditProfileCollective> createState() => _EditProfileCollectiveState();
}

class _EditProfileCollectiveState extends State<EditProfileCollective> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _name = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _phoneNo = new TextEditingController();
  final TextEditingController _address = new TextEditingController();

  bool _nameValid = false;
  bool _emailValid = false;
  bool _phoneNoValid = false;
  bool _addressValid = false;

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
          _currentItemSelected = snapshot.data()!['category'];
          _address.text = snapshot.data()!['fullAddress'];
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
    if (Platform.isAndroid) {
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
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ProfileScreenCollective()));
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
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8.0,
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
                        Image
                            .file
                          (imageXFile!)
                            .image,
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
                    height: 40,
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
                  ),
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
                  ),
                  SizedBox(
                    height: 30,
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
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _address,
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
                      hintText: "Morada",
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
                      errorText: _addressValid ? 'Morada não pode ficar em branco' : null,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_name.text == '' || _email.text.isEmpty || _phoneNo.text.isEmpty || _address.text.isEmpty) {
                        setState(() {
                          _name.text.isEmpty ? _nameValid = true : _nameValid = false;
                          _email.text.isEmpty ? _emailValid = true : _emailValid = false;
                          _phoneNo.text.isEmpty ? _phoneNoValid = true : _phoneNoValid = false;
                          _address.text.isEmpty ? _addressValid = true : _addressValid = false;
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
                            'fullAddress': _address.text,
                            'category': _currentItemSelected,
                            'role': 'collective',
                            'editedAt': Timestamp.now(),
                          });
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ProfileScreenCollective()));
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
                            'fullAddress': _address.text,
                            'category': _currentItemSelected,
                            'role': 'collective',
                            'editedAt': Timestamp.now(),
                          });
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ProfileScreenCollective()));
                        } catch (error) {
                          Fluttertoast.showToast(msg: error.toString());
                        }
                      }
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CriarAnuncio()));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    } else if (Platform.isIOS) {
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
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ProfileScreenSingular()));
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
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8.0,
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
                        Image
                            .file
                          (imageXFile!)
                            .image,
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
                    height: 40,
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
                  ),
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
                  ),
                  SizedBox(
                    height: 30,
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
                          builder: (context) =>
                              CupertinoActionSheet(
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
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _address,
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
                      hintText: "Morada",
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
                      errorText: _addressValid ? 'Morada não pode ficar em branco' : null,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_name.text == '' || _email.text.isEmpty || _phoneNo.text.isEmpty || _address.text.isEmpty) {
                        setState(() {
                          _name.text.isEmpty ? _nameValid = true : _nameValid = false;
                          _email.text.isEmpty ? _emailValid = true : _emailValid = false;
                          _phoneNo.text.isEmpty ? _phoneNoValid = true : _phoneNoValid = false;
                          _address.text.isEmpty ? _addressValid = true : _addressValid = false;
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
                            'fullAddress': _address.text,
                            'category': _currentItemSelected,
                            'role': 'collective',
                            'editedAt': Timestamp.now(),
                          });
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ProfileScreenCollective()));
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
                            'fullAddress': _address.text,
                            'category': _currentItemSelected,
                            'role': 'collective',
                            'editedAt': Timestamp.now(),
                          });
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ProfileScreenCollective()));
                        } catch (error) {
                          Fluttertoast.showToast(msg: error.toString());
                        }
                      }
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CriarAnuncio()));
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

        _currentItemSelected = items[index];
        print('Item selecionado: $_currentItemSelected');
      },
    ),
  );
}

