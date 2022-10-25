import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weeldonatedproject/costumwidgets/LowerAppBar.dart';


class AnuncioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF283593),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 2, color: Colors.white),
            ),
          ),
        ),
        backgroundColor: Color(0xFF283593),
        title: Text(
          '           WELL DONATED',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            buildcard1(),
            SizedBox(
              height: 20,
            ),
            buildcard2(),
            SizedBox(
              height: 80,
            ),
            buildcard3(),
            SizedBox(
              height: 50,
            ),
            buildcard5(),
            SizedBox(
              height: 50,
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
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildcard1() => Container(
        width: 350,
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'marliese-streefland-2l0CWTpcChI-unsplash.jpg',
                  height: 280,
                  width: 650,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ],
        ),
      );

  Widget buildcard2() => Container(
        width: 350,
        child: Column(
          children: [
            Row(
              children: <Widget>[
                SizedBox(
                  width: 30,
                ),
                Text(
                  'Coleira de Cão',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 30,
                ),
                Text(
                  'Coleira de Cão',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      );

  Widget buildcard4() => Container(
        width: 250,
        child: TextField(
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: TextStyle(
            color: Colors.white,
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
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ),
      );

  Widget buildcard3() => Container(
        child: Column(
          children: [
            Row(
              children: <Widget>[
                SizedBox(
                  width: 30,
                ),
                buildcard4(),
                SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'DOAR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget buildcard6() => Container(

        color: Color(0xFF9FA8DA),
        width: 350,
        child: Column(
          children: [
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Sociedade Protetora \ndos Animais do Porto',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 50,),
                  Icon(Icons.account_circle_rounded,
                      color: Color(0xFF283593),
                      size: 80,),

                ],
              ),
            ),
            Container(
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      height: 30,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Mais Informações',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildcard5() => Container(
        child: Column(
          children: [
            Row(
              children: <Widget>[
                SizedBox(
                  width: 30,
                ),
                buildcard6(),
              ],
            ),
          ],
        ),
      );
}
