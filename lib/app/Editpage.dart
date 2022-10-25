
import 'package:flutter/material.dart';
import 'package:weeldonatedproject/costumwidgets/LowerAppBar.dart';
import 'package:weeldonatedproject/app/pagina10.dart';

class Editpage extends StatelessWidget {
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
      body: Center(
        child: ListView(
          children: [
            buildcard1(),
            buildcard2(),
          ],
        ),
      ),
      bottomNavigationBar: Lowerappbar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => pagina10()));
        },
          child: const Icon(Icons.add,
      color: Colors.white,)

        ),
    );
  }

  Widget buildcard1() => Container(
        child: Card(
          color: Color(0xFF9FA8DA),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    'marliese-streefland-2l0CWTpcChI-unsplash.jpg',
                    height: 310,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              Container(

                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Coleira de Cão',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Descrição: Coleira de Cão ',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 4,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Editar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Eliminar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
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
        ),
      );

  Widget buildcard2() => Card(
        color: Color(0xFF9FA8DA),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'marliese-streefland-2l0CWTpcChI-unsplash.jpg',
                  height: 310,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            Container(
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Cãozito Fixolas',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Descrição: cãozito Fixolas cãozito Fixolas',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 4,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Editar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Eliminar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
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
}
