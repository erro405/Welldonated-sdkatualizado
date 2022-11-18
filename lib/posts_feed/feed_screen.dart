import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weeldonatedproject/costumwidgets/LowerAppBar.dart';
import 'package:weeldonatedproject/app/add_announcement_screen.dart';

class FeedScreen extends StatefulWidget {
  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  String? amount = '';
  String? category = '';
  String? description = '';
  String? id = '';
  String? location = '';
  String? phoneNo = '';
  String? postImage;
  String? title = '';

  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc()
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          amount = snapshot.data()!['amount'];
          category = snapshot.data()!['category'];
          description = snapshot.data()!['description'];
          id = snapshot.data()!['id'];
          location = snapshot.data()!['location'];
          phoneNo = snapshot.data()!['phoneNumber'];
          postImage = snapshot.data()!['postImage'];
          title = snapshot.data()!['title'];
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

  List<Tab> tab = [
    Tab(
      child: Text(
        'Tudo',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Mobiliário',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Animais',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Alimentação',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Criança',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Vestuário',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Cultura',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Educação',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Saúde',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Cultural',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Outra',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
  ];

  Widget listViewWidget() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        elevation: 16,
        shadowColor: Colors.indigo,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.indigo.shade200, Colors.indigo.shade200],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: const [0.2, 0.9],
          )),
          padding: EdgeInsets.all(5.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  //details
                },
                child: Image.network(
                  postImage!,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title!,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tab.length,
      child: Scaffold(
        backgroundColor: Color(0xFF283593),
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Color(0xFF283593),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: TabBar(
              indicatorColor: Colors.orange,
              isScrollable: true,
              tabs: tab,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              buildcard1(),
              SizedBox(
                height: 10,
              ),
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('posts').snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.active) {
                    if (snapshot.data!.docs.isNotEmpty) {
                      return listViewWidget();
                    }
                  } else {
                    return Center(
                      child: Text('Sem anúncios!'),
                    );
                  }
                  return Center(
                    child: Text('Sem anúncios!'),
                  );
                },
              ),
            ],
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
      ),
    );
  }

  Widget buildcard1() => Container(
        width: 390,
        child: TextField(
          style: TextStyle(
              //  color: Colors.white,
              ),
          decoration: InputDecoration(
            hintText: 'Pesquisar',
            hintStyle: TextStyle(
              color: Colors.white,
            ),
            contentPadding: EdgeInsets.zero,
            filled: true,
            fillColor: Colors.indigo,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ),
      );
}
