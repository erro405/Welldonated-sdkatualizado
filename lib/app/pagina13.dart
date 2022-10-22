
import 'package:flutter/material.dart';
import 'package:weeldonatedproject/app/pagina10.dart';
import 'package:weeldonatedproject/app/pagina18.dart';
import 'Editpage.dart';
import 'LowerAppBar.dart';
import 'emailpage.dart';



class pagina13 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          alignment: Alignment.centerRight,
          icon: const Icon(
            Icons.edit,
            size: 35.0,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => pagina18()));
          },
        ),
        backgroundColor: Color(0xff1a237e),
        actions: [
          Builder(builder: (BuildContext context) {
            return IconButton(
              alignment: Alignment.centerRight,
              icon: const Icon(
                Icons.logout_rounded,
                size: 35.0,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EmailPage()));
              },
            );
          }),
        ],
        elevation: 0.0,
      ),
      body: Container(
        color: Color(0xff1a237e),
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('bombeiros.png'),
                  radius: 65,
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  height: 45,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Color(0xff3949AB),
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'B.V. da Póvoa de Lanhoso',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          wordSpacing: 2.0,
                          letterSpacing: 1.0,
                          fontFamily: 'Poppins',
                          fontSize: 25.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 45,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Color(0xff3949AB),
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Email institucional',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          wordSpacing: 2.0,
                          letterSpacing: 1.0,
                          fontFamily: 'Poppins',
                          fontSize: 25.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 45,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Color(0xff3949AB),
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Telemóvel',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          wordSpacing: 2.0,
                          letterSpacing: 1.0,
                          fontFamily: 'Poppins',
                          fontSize: 25.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 45,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Color(0xff3949AB),
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Morada',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          wordSpacing: 2.0,
                          letterSpacing: 1.0,
                          fontFamily: 'Poppins',
                          fontSize: 25.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 45,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Color(0xff3949AB),
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Código Postal',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          wordSpacing: 2.0,
                          letterSpacing: 1.0,
                          fontFamily: 'Poppins',
                          fontSize: 25.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 45,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Color(0xff3949AB),
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Descrição',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          wordSpacing: 2.0,
                          letterSpacing: 1.0,
                          fontFamily: 'Poppins',
                          fontSize: 25.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 45,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Color(0xff3949AB),
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Área de intervenção',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          wordSpacing: 2.0,
                          letterSpacing: 1.0,
                          fontFamily: 'Poppins',
                          fontSize: 25.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Editpage()));
                  },
                  child: Text(
                    'Gerir anúncios',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffef6C00),
                    fixedSize: Size(180, 50),
                  ),
                ),
                SizedBox(
                  height: 60,
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => pagina10()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

