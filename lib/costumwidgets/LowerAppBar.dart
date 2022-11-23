import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weeldonatedproject/profile/profile_screen_collective.dart';
import 'package:weeldonatedproject/profile/profile_screen_singular.dart';
import '../posts_feed/feed_screen.dart';

class Lowerappbar extends StatefulWidget {
  @override
  _LowerappbarState createState() => _LowerappbarState();
}

class _LowerappbarState extends State<Lowerappbar> {

  String? role = '';

  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async
    {
      if(snapshot.exists) {
        setState(() {
          role = snapshot.data()!['role'];
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

  @override
  Widget build(BuildContext context) {
    final placeholder = Opacity(
      opacity: 0,
      child: IconButton(
        icon: Icon(Icons.no_cell),
        onPressed: null,
      ),
    );

    return BottomAppBar(
      shape: const  CircularNotchedRectangle(),
      color: Colors.white,
      child: IconTheme(
      data:IconThemeData(color:Theme.of(context).colorScheme.onPrimary),
      //child: Padding(padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => FeedScreen()));
            },
                icon: Icon(Icons.home,
                color: Colors.orange,
                size: 30,),),
            IconButton(onPressed: (){
              if (role == 'collective') {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreenCollective()));
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreenSingular()));
              }
            },
              icon: Icon(Icons.account_circle,
                color: Colors.orange,
              size: 30,),),
          ],
        ),
      ),
    );
  }

  Widget buildTabItem({required int index,
    required Icon icon}) {
    return IconButton(
      icon: icon,
      onPressed: () {},
    );
  }
}
