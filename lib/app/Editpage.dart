import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import 'package:weeldonatedproject/costumwidgets/LowerAppBar.dart';
import 'package:weeldonatedproject/app/add_announcement_screen.dart';

import '../post_details/post_detail_screen.dart';
import '../posts_feed/editar_post_page.dart';
import '../posts_feed/feed_screen.dart';

class Editpage extends StatefulWidget {
  State<Editpage> createState() => _EditpageState();
}

class _EditpageState extends State<Editpage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _titlePost = new TextEditingController();
  final TextEditingController _description = new TextEditingController();
  final TextEditingController _amount = new TextEditingController();
  final TextEditingController _location = new TextEditingController();
  final TextEditingController _phoneNum = new TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF283593),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 2, color: Colors.white),
            ),
          ),
        ),
        backgroundColor: Colors.indigo,
        title: Text('Anúncios ativos'),
        actions: [
          Icon(
            Icons.close,
          ),
          Icon(
            Icons.close,
            color: Colors.indigo,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("posts")
                  .where("id", isEqualTo: _auth.currentUser!.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.data!.docs.isNotEmpty) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {


                        //var doc = snapshot.data.docs[index]['postId'];


                        return
                            //GestureDetector(
                            //onTap: () {
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailScreen(snapshot.data!.docs[index]['postId'])));
                            //},
                            //child:
                            Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: const Color(0xff9fa8da),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // We overlap the image and the button by
                                // creating a Stack object:
                                Stack(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      child: Image.network(
                                        snapshot.data!.docs[index]['postImage'],
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 8, right: 8, bottom: 8),
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                         _titlePost.text =
                                          snapshot.data.docs[index]['title'];
                                          _description.text =
                                          snapshot.data.docs[index]['description'];
                                          _amount.text = snapshot.data.docs[index]['amount'];
                                          _location.text =
                                          snapshot.data.docs[index]['location'];
                                          _phoneNum.text =
                                          snapshot.data.docs[index]['phoneNumber'];


                                          showDialog(
                                            context: context,
                                            builder: (context) => Dialog(
                                              child: Container(
                                                //color: Colors.indigo,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                  color: Colors.indigo,
                                                  boxShadow: [BoxShadow(color: Colors.indigo, spreadRadius: 15),]
                                                  ),
                                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                               // child: Container(
                                                child: ListView(children: [
                                                  TextFormField(
                                                    controller: _titlePost,
                                                    cursorColor: Colors.white,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                        vertical: 8,
                                                        horizontal: 10,
                                                      ),
                                                      filled: true,
                                                      fillColor:
                                                          Color(0xff3949AB),
                                                      hintText: "Título",
                                                      hintStyle: TextStyle(
                                                        fontSize: 20.0,
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white,
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 1.3,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0)),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 1.3,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0)),
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
                                                      controller: _description,
                                                      maxLines: 5,
                                                      cursorColor: Colors.white,
                                                      textAlignVertical:
                                                          TextAlignVertical.top,
                                                      textAlign: TextAlign.left,
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                          vertical: 10,
                                                          horizontal: 6,
                                                        ),
                                                        filled: true,
                                                        fillColor:
                                                            Color(0xff3949ab),
                                                        hintText: "Descrição",
                                                        hintStyle: TextStyle(
                                                          fontSize: 21.0,
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.white,
                                                            width: 1.3,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0)),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.white,
                                                            width: 1.3,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0)),
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
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(5.0),
                                                      ),
                                                      color: Color(0xff3949ab),
                                                    ),
                                                    child: Theme(
                                                      data: Theme.of(context)
                                                          .copyWith(
                                                              canvasColor: Color(
                                                                  0xff3949ab)),
                                                      child:
                                                          DropdownButtonHideUnderline(
                                                        child: ButtonTheme(
                                                          alignedDropdown: true,
                                                          child: DropdownButton<
                                                              String>(
                                                            underline:
                                                                SizedBox(),
                                                            isExpanded: true,
                                                            icon: const Icon(Icons
                                                                .keyboard_arrow_down),
                                                            iconSize: 35,
                                                            iconDisabledColor:
                                                                Colors.white,
                                                            iconEnabledColor:
                                                                Colors.white,
                                                            items: items.map(
                                                                (String items) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: items,
                                                                child:
                                                                    Text(items),
                                                              );
                                                            }).toList(),
                                                            style: TextStyle(
                                                              fontSize: 20.0,
                                                              fontFamily:
                                                                  'Poppins',
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            onChanged:
                                                                (newValueSelected) {
                                                              setState(() {
                                                                _currentItemSelected =
                                                                    newValueSelected!;
                                                                category =
                                                                    newValueSelected;
                                                              });
                                                            },
                                                            value:
                                                                _currentItemSelected,
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
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                        vertical: 8,
                                                        horizontal: 10,
                                                      ),
                                                      filled: true,
                                                      fillColor:
                                                          Color(0xff3949AB),
                                                      hintText: "Quantidade",
                                                      hintStyle: TextStyle(
                                                        fontSize: 20.0,
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white,
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 1.3,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0)),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 1.3,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0)),
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
                                                  Divider(
                                                      thickness: 2.0,
                                                      color: Colors.white70),
                                                  SizedBox(
                                                    height: 30.0,
                                                  ),
                                                  TextFormField(
                                                    controller: _location,
                                                    cursorColor: Colors.white,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                        vertical: 8,
                                                        horizontal: 10,
                                                      ),
                                                      filled: true,
                                                      fillColor:
                                                          Color(0xff3949AB),
                                                      hintText: "Localidade",
                                                      hintStyle: TextStyle(
                                                        fontSize: 20.0,
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white,
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 1.3,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0)),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 1.3,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0)),
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
                                                    controller: _phoneNum,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    cursorColor: Colors.white,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                        vertical: 8,
                                                        horizontal: 10,
                                                      ),
                                                      filled: true,
                                                      fillColor:
                                                          Color(0xff3949AB),
                                                      hintText:
                                                          "Contacto Telefónico",
                                                      hintStyle: TextStyle(
                                                        fontSize: 20.0,
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white,
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 1.3,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0)),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 1.3,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0)),
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
                                                    child: Text(
                                                      'Editar Anúncio',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 22.0,
                                                        fontFamily: 'Poppins',
                                                      ),
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary:
                                                          Color(0xffef6C00),
                                                      fixedSize: Size(250, 50),
                                                    ),
                                                    onPressed: () {
                                                      snapshot.data!.docs[index]
                                                          .reference
                                                          .update({
                                                        "title" : _titlePost.text,
                                                        "description" : _description.text,
                                                        "amount" : _amount.text,
                                                        "location" : _location.text,
                                                        "phoneNum" : _phoneNum.text,
                                                      }).whenComplete(() => Navigator.pop(context));
                                                    },
                                                  ),
                                                ]),
                                              ),
                                            ),
                                           // ),
                                          );
                                        },
                                        child: Text('Editar'),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.orange,
                                        ),
                                      ),

                                      SizedBox(
                                        width: 10,
                                      ),

                                      // FirebaseAuth.instance.currentUser!.uid == _auth.id
                                      // ?

                                      ElevatedButton(
                                        onPressed: () {
                                          deletedata(snapshot.data!.docs[index]
                                              ['postId']);
                                        },
                                        child: Text('Eliminar'),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                        //);
                      },
                    );
                  }
                } else {
                  return const Center(
                    child: Text('Sem anúncios!'),
                  );
                }
                return const Center(
                  child: Text('Sem anúncios!'),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Lowerappbar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CriarAnuncio()));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }

  deletedata(id) async {
    await FirebaseFirestore.instance.collection('posts').doc(id).delete();
  }

  //editardata(id, value) async{
  //await FirebaseFirestore.instance.collection('posts').doc(id).update();
  //}
}
