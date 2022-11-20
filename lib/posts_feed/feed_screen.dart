import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weeldonatedproject/costumwidgets/LowerAppBar.dart';
import 'package:weeldonatedproject/app/add_announcement_screen.dart';
import 'package:weeldonatedproject/post_details/post_detail_screen.dart';

class FeedScreen extends StatefulWidget{

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Tab> tab = [
    const Tab(child: Text('Tudo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),),),
    const Tab(child: Text('Mobiliário', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),),),
    const Tab(child: Text('Animais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),),),
    const Tab(child: Text('Alimentação', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),),),
    const Tab(child: Text('Criança', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),),),
    const Tab(child: Text('Vestuário', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),),),
    const Tab(child: Text('Cultura', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),),),
    const Tab(child: Text('Educação', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),),),
    const Tab(child: Text('Saúde', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),),),
    const Tab(child: Text('Outra', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),),),
  ];

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
              indicatorColor: Colors.orange,
              isScrollable: true,
              tabs: tab,
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
                stream: FirebaseFirestore.instance.collection("posts")
                    .where("id", isNotEqualTo: _auth.currentUser!.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot)
                {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if(snapshot.connectionState == ConnectionState.active){
                    if(snapshot.data!.docs.isNotEmpty){
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index){
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailScreen(snapshot.data!.docs[index]['postId'])));
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
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
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                          child: Image.network(
                                            snapshot.data!.docs[index]['postImage'],
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                        height: 5
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(snapshot.data!.docs[index]['title'],
                                                style: TextStyle(color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(snapshot.data!.docs[index]['description'],
                                                style: TextStyle(color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Text('Quantidade: ' + snapshot.data!.docs[index]['amount'],
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
                        },
                      );
                    }
                  }
                  else{
                    return const Center(child: Text('Sem anúncios!'),);
                  }
                  return const Center(
                    child: Text('Sem anúncios!'),
                  );
                },
              ),
            ],
          ),),
        bottomNavigationBar: Lowerappbar(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFFFF9800),
          child: const Icon(
            Icons.add,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CriarAnuncio()));
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
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
    ),
  );
}