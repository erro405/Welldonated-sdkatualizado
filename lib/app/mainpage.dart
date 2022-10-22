import 'package:flutter/material.dart';
import 'package:weeldonatedproject/app/LowerAppBar.dart';
import 'package:weeldonatedproject/app/pagina10.dart';

class MainPage extends StatelessWidget {
  @override
  List<Tab> tab = [
    Tab(
      child: Text(
        'Tudo',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Mobiliário',
        style: TextStyle(
          fontWeight: FontWeight.bold,
            fontSize: 16,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Animais',
        style: TextStyle(
          fontWeight: FontWeight.bold,
            fontSize: 16,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Alimentação',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Criança',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Vestuário',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Cultura',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Educação',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Saúde',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Cultural',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
    Tab(
      child: Text(
        'Outra',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
  ];

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
        body: Center(
          child: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              buildcard1(),
              SizedBox(
                height: 10,
              ),
              buildcard2(),
              buildcard3(),
              buildcard4(),
            ],
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
      ),
    );
  }

  Widget buildcard1() => Container(
        width: 350,
        child: TextField(
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
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
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
                      width:4,
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
            SizedBox(
              height: 20,
            ),
            Container(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Quantidade: unico',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      );

  Widget buildcard3() => Card(
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
            SizedBox(
              height: 20,
            ),
            Container(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Quantidade: unico',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      );

  Widget buildcard4() => Card(
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
            SizedBox(
              height: 20,
            ),
            Container(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Quantidade: unico',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      );
}
