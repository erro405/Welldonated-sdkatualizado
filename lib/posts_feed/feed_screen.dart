import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../app/add_announcement_screen.dart';
import '../app/anonymous_login_profile.dart';
import '../costumwidgets/LowerAppBar.dart';
import '../post_details/post_detail_screen.dart';

class FeedScreen extends StatefulWidget{
  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  TabController? _tabController;

  String categoryPost = "";
  String titlePost = "";

  List<Tab> tab = [
    const Tab(text: 'Tudo'),
    const Tab(text: 'Mobiliário'),
    const Tab(text: 'Animais'),
    const Tab(text: 'Alimentação'),
    const Tab(text: 'Vestuário'),
    const Tab(text: 'Cultura'),
    const Tab(text: 'Educação'),
    const Tab(text: 'Saúde'),
    const Tab(text: 'Outros'),
  ];

  Stream<QuerySnapshot> verifyPost() {
    if (categoryPost.isEmpty || categoryPost.contains("Tudo")) {
      return FirebaseFirestore.instance.collection("posts")
          .where("id", isNotEqualTo: _auth.currentUser!.uid)
          .snapshots();
    } else {
      var data = FirebaseFirestore.instance.collection("posts")
          //.where("id", isNotEqualTo: _auth.currentUser!.uid)
          .where("category", isEqualTo: categoryPost)
          .snapshots();

      return data;
    }
 }

  @override
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
              controller: _tabController,
              indicatorColor: Colors.orange,
              isScrollable: true,
              tabs: tab,
              onTap: (_tabController) async {
                setState(() {
                  categoryPost = tab[_tabController].text!;
                });
              },
            ),
          ),
        ),
        body:
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              buildcard1(),
              const SizedBox(
                height: 10,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: verifyPost(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      const Center(child: CircularProgressIndicator(),);
                    }
                    else
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.data!.docs.isNotEmpty) {
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data!.docs[index]
                                  .data() as Map<String, dynamic>;
                              if (titlePost.isEmpty) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            PostDetailScreen(
                                                data['postId'], data['id'])
                                    ));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5.0),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      color: const Color(0xff9fa8da),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: <Widget>[
                                          Stack(
                                            children: <Widget>[
                                              ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                        10),
                                                    topRight: Radius.circular(
                                                        10)),
                                                child: Image.network(
                                                  snapshot.data!
                                                      .docs[index]['postImage'],
                                                  height: 250,
                                                  width: 650,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                              height: 5
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 8, right: 8, bottom: 8),
                                            child: Row(
                                              children: [
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(snapshot.data!
                                                        .docs[index]['title'],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          fontSize: 20),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(snapshot.data!
                                                        .docs[index]['description'],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text('Quantidade: ' +
                                                        snapshot.data!
                                                            .docs[index]['amount'],
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                      ),
                                                    )
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
                              if (data['title'].toString()
                                  .toLowerCase()
                                  .contains(titlePost.toLowerCase())) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            PostDetailScreen(snapshot.data!
                                                .docs[index]['postId'],
                                                snapshot.data!
                                                    .docs[index]['id'])));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5.0),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      color: const Color(0xff9fa8da),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: <Widget>[
                                          // We overlap the image and the button by
                                          // creating a Stack object:
                                          Stack(
                                            children: <Widget>[
                                              ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                        10),
                                                    topRight: Radius.circular(
                                                        10)),
                                                child: Image.network(
                                                  snapshot.data!
                                                      .docs[index]['postImage'],
                                                  height: 250,
                                                  width: 650,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                              height: 5
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 8, right: 8, bottom: 8),
                                            child: Row(
                                              children: [
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(snapshot.data!
                                                        .docs[index]['title'],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          fontSize: 20),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(snapshot.data!
                                                        .docs[index]['description'],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text('Quantidade: ' +
                                                        snapshot.data!
                                                            .docs[index]['amount'],
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                      ),
                                                    )
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
                              return Container();
                            }
                        );
                      }
                    }
                    else {
                      return const Center(
                        child: Text(
                          'Sem anúncios!',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      );
                    }
                    return const Center(
                      child: Text(
                        'Sem anúncios!',
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
        bottomNavigationBar: Lowerappbar(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFFFF9800),
          child: const Icon(
            Icons.add,
          ),
          onPressed: () {
            if (_auth.currentUser!.isAnonymous) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AnonymousLoginProfile()));
            } else {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CriarAnuncio()));
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
  Widget buildcard1() => Container(
    width: 390,
    child: TextField(
      onChanged: (textEntered) async {
        setState(() {
          titlePost = textEntered;
        });
      },
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
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
    ),
  );
}