import 'package:flutter/material.dart';
import 'package:weeldonatedproject/app/pagina2.dart';


class esquecerPass extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1a237e),
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
                  height: 40,
                ),
                Text(
                  'WELL DONATED',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    wordSpacing: 4.0,
                    letterSpacing: 2.0,
                    fontFamily: 'Poppins',
                    fontSize: 33.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Text(
                    'Coloque o seu email e enviaremos um ligação para restaurar a sua palavra-passe',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 10,
                    ),
                    filled: true,
                    fillColor: Color(0xff3949AB),
                    hintText: "Email",
                    hintStyle: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.3,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
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
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Enviar',
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
                  height: 65,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Ainda não tens conta?',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => pagina2()));
                      },
                      child: Text(
                        'Regista-te',
                        style: TextStyle(
                          fontFamily: 'Segoi UI',
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}