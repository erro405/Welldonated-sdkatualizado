import 'package:flutter/material.dart';
import 'package:weeldonatedproject/app/choose_user_screen.dart';
import 'components/heading_text.dart';
import 'components/info.dart';

class SignUpScreenSingular extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3949ab),
        elevation: 0.0,
        leadingWidth: 25,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            alignment: Alignment.centerLeft,
            icon: const Icon(
              Icons.navigate_before_outlined,
              size: 40.0,
            ),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseUserScreen()));
            },
          );
        }),
      ),
      body: Container(
        color: Color(0xff3949ab),
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HeadText(),
                Credentials(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}