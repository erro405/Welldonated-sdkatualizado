import 'package:flutter/material.dart';
import 'package:weeldonatedproject/app/AuthemricationServices.dart';
import 'package:weeldonatedproject/app/mainpage.dart';
import 'package:weeldonatedproject/app/pagina2.dart';


class pagina3 extends StatelessWidget {


  final AuthenticationService _auth = AuthenticationService();

  final _key = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
              Navigator.push(context, MaterialPageRoute(builder: (context) => pagina2()));
            },
          );
        }),
        title: Text(
          'Voltar',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'Segoi UI',
            fontSize: 20,
          ),
        ),
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
                Text(
                  'Registar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    wordSpacing: 4.0,
                    letterSpacing: 2.0,
                    fontFamily: 'Poppins',
                    fontSize: 30.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 17.0,
                ),
                ElevatedButton(
                  child: Image.asset('individual.png'),
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    fixedSize: Size(120, 120),
                    shape:  CircleBorder(),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Adicionar fotografia',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white70,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                TextFormField(
                  controller: _nameController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 6,
                    ),
                    filled: true,
                    fillColor: Color(0xff1a237e),
                    hintText: "Nome completo",
                    hintStyle: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Poppins',
                      color: Colors.white70,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white70,
                        width: 1.3,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white70,
                        width: 1.3,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontFamily: 'Poppins',
                  ),
                ), //NOME
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  controller: _emailContoller,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 6,
                    ),
                    filled: true,
                    fillColor: Color(0xff1a237e),
                    hintText: "E-mail",
                    hintStyle: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Poppins',
                      color: Colors.white70,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white70,
                        width: 1.3,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white70,
                        width: 1.3,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontFamily: 'Poppins',
                  ),
                ), //EMAIL
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 6,
                    ),
                    filled: true,
                    fillColor: Color(0xff1a237e),
                    hintText: "Telemóvel",
                    hintStyle: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Poppins',
                      color: Colors.white70,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white70,
                        width: 1.3,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white70,
                        width: 1.3,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontFamily: 'Poppins',
                  ),
                ), //TELEMOVEL
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 6,
                    ),
                    filled: true,
                    fillColor: Color(0xff1a237e),
                    hintText: "Palavra-passe",
                    hintStyle: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Poppins',
                      color: Colors.white70,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white70,
                        width: 1.3,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white70,
                        width: 1.3,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontFamily: 'Poppins',
                  ),
                ), //PASS
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  obscureText: true,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 6,
                    ),
                    filled: true,
                    fillColor: Color(0xff1a237e),
                    hintText: "Confirmar Palavra-passe",
                    hintStyle: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Poppins',
                      color: Colors.white70,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white70,
                        width: 1.3,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white70,
                        width: 1.3,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontFamily: 'Poppins',
                  ),
                ), //PASS
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'Ao clicar em registar, está a concordar com os Termos e Condições da Well Donated',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    wordSpacing: 1.0,
                    letterSpacing: 0.5,
                    fontFamily: 'Poppins',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: (){
                    createUser();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                  },
                  child: Text(
                    'Registar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffef6C00),
                    fixedSize: Size(200, 50),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }

  void createUser()async{
    dynamic result = await _auth.createNewUser(
    _emailContoller.text , _passwordController.text ) ;
    if (result==null) {
    print('Email não é valido') ;
    } else {
    print(result.toString() ) ;
    _nameController.clear();
    _emailContoller.clear();
    _passwordController.clear();
    }
  }
}

