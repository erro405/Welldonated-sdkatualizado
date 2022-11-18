import 'package:flutter/material.dart';
import 'package:weeldonatedproject/app/emailpage.dart';
import 'package:weeldonatedproject/profile_screen/profile_screen.dart';

import '../posts_feed/feed_screen.dart';



class Lowerappbar extends StatefulWidget {
  @override
  _LowerappbarState createState() => _LowerappbarState();
}

class _LowerappbarState extends State<Lowerappbar> {
  @override
  Widget build(BuildContext context) {
    final placeholder = Opacity(
      opacity: 0,
      child: IconButton(
        icon: Icon(Icons.no_cell),
        onPressed: null,
      ),
    );

    return
    BottomAppBar(
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
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
