
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weeldonatedproject/costumwidgets/LowerAppBar.dart';
import 'package:weeldonatedproject/app/add_announcement_screen.dart';

import '../post_details/post_detail_screen.dart';
import '../posts_feed/editar_post_page.dart';

class Editpage extends StatefulWidget {
  State<Editpage> createState() => _EditpageState();
}

  final FirebaseAuth _auth = FirebaseAuth.instance;

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
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("posts")
                  .where("id", isEqualTo: _auth.currentUser!.uid)
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
                        return
                          //GestureDetector(
                          //onTap: () {
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailScreen(snapshot.data!.docs[index]['postId'])));
                          //},
                          //child:
                        Padding(
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
                                        ElevatedButton(onPressed: ()
                                        {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditarAnuncio(snapshot.data!.docs[index]['postId'])));
                                        },
                                          child:
                                          Text('Editar'),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.orange,
                                          ),
                                        ),

                                        SizedBox(width: 10,),

                                         // FirebaseAuth.instance.currentUser!.uid == _auth.id
                                           // ?

                                        ElevatedButton(onPressed: ()
                                        {
                                              deletedata(snapshot.data!.docs[index]['postId']);
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => CriarAnuncio()));
        },
          child: const Icon(Icons.add,
      color: Colors.white,)

        ),

    );
  }

  deletedata(id) async{
    await FirebaseFirestore.instance.collection('posts').doc(id).delete();
  }

  //editardata(id, value) async{
    //await FirebaseFirestore.instance.collection('posts').doc(id).update();
  //}

}
