
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weeldonatedproject/app/mainpage.dart';
import 'dart:io' show File, Platform;
import 'LowerAppBar.dart';

class pagina10 extends StatefulWidget {
  CriarAnuncio createState() => CriarAnuncio();
}

class CriarAnuncio extends State<pagina10> {

  File? image;
  UploadTask? uploadTask;

  Future pickImage(ImageSource source)async {
    try {
   final image = await ImagePicker().pickImage( source: source);
  if (image == null) return;
  final imageTemporary = File(image.path);
  setState(() => this.image = imageTemporary);
  } on PlatformException catch(e){
      print("Falha ao carregar a imagem :$e");
    }
    }

    Future uploadFile() async{
    if(image == null) return;

    final imagename = basename(image!.path);
    final destination = 'file/$imagename';

    FirebaseApi.uploadFile(destination, image!);
  }



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

  int index = 0;


    TextEditingController data1 = new TextEditingController();
    TextEditingController data2 = new TextEditingController();
    TextEditingController data3 = new TextEditingController();
    TextEditingController data4 = new TextEditingController();
    TextEditingController data5 = new TextEditingController();
    TextEditingController data6 = new TextEditingController();



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
                      MaterialPageRoute(builder: (context) => MainPage()));
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
                  SizedBox(
                    height: 30,
                  ),
                 image != null? Image.file(image!, width: 260, height: 260, fit: BoxFit.cover,) : FlutterLogo(size: 160,),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () => pickImage(ImageSource.gallery),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                  ),
                  SizedBox(
                    height: 38.0,
                  ),
                  TextFormField(
                    controller: data1,
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
                      controller: data2,
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
                      data: Theme.of(context).copyWith(
                          canvasColor: Color(0xff3949ab)),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton(
                              underline: SizedBox(),
                              isExpanded: true,
                              value: dropdownvalue,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              iconSize: 35,
                              iconDisabledColor: Colors.white,
                              iconEnabledColor: Colors.white,
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Poppins',
                                color: Colors.white,
                              ), onChanged: (String? value) {  },
                              ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 38.0,
                  ),
                  TextFormField(
                    controller: data3,
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
                    controller: data4,
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
                    controller: data5,
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
                    onPressed: () {
                       uploadFile();
                       Map <String,dynamic> data = {"fild1":data1.text,"fild2":data2.text,"fild3":data3.text,"fild4":data4.text,"fild5":data5.text,};
                       FirebaseFirestore.instance.collection("post").add(data);
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
                context, MaterialPageRoute(builder: (context) => pagina10()));
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
                      MaterialPageRoute(builder: (context) => MainPage()));
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
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                    padding:
                    EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                    child: CupertinoButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            items[index],
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
                    onPressed: () {},
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
                context, MaterialPageRoute(builder: (context) => pagina10()));
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
        print('Item selecionado: $item');
      },
    ),
  );
}

class FirebaseApi{
  static UploadTask? uploadFile(String destination, File image) {
    try{
    final ref = FirebaseStorage.instance.ref(destination);

    return ref.putFile(image);
  }on FirebaseException catch(e)
  {
return null;
  }
  }}
