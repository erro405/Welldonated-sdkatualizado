
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weeldonatedproject/active_posts/edit_active_announcement_screen.dart';
import 'package:weeldonatedproject/costumwidgets/LowerAppBar.dart';
import 'package:weeldonatedproject/app/add_announcement_screen.dart';

class ViewDonationAnnouncements extends StatefulWidget {

  final String postId;
  const ViewDonationAnnouncements(this.postId);

  @override
  State<ViewDonationAnnouncements> createState() => _ViewDonationAnnouncementsState();
}

class _ViewDonationAnnouncementsState extends State<ViewDonationAnnouncements> {

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
        title: Text('Ofertas ativas'),
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
                  .doc(widget.postId)
                  .collection('donateIntention')
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
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index){
                        return Padding(
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
                                  Padding(
                                    padding: EdgeInsets.only(top: 8,left: 8, right: 8, bottom: 8),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(snapshot.data!.docs[index]['name'],
                                              style: TextStyle(color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(snapshot.data!.docs[index]['email'],
                                              style: TextStyle(color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                      height: 5
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(snapshot.data!.docs[index]['phoneNumber'],
                                          style: TextStyle(color: Colors.white,
                                              fontSize: 15),
                                        ),
                                        SizedBox(
                                          width: 180,
                                        ),
                                        Text('Quantidade: ' + snapshot.data!.docs[index]['amount'],
                                          style: TextStyle(color: Colors.white,
                                              fontSize: 15),
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
                  return Center(
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage(
                              'icon_tempo.png',
                            ),
                          ),
                          Text(
                            'Sem Intenção de Doaçãoes',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                  );
                }
                return Center(
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage(
                            'icon_tempo.png',
                          ),
                        ),
                        Text(
                          'Sem Intenção de Doaçãoes',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
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
}
