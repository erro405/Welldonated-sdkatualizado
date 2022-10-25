import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weeldonatedproject/app/emailValidator.dart';
import 'package:weeldonatedproject/app/forget_password.dart';
import 'package:weeldonatedproject/app/mainpage.dart';

import '../costumwidgets/butaosubmit.dart';

enum EmailPageFormType { signIn, register }

class EmailPageForm extends StatefulWidget with EmailandPasswordValidator {

  @override
  _EmailPageFormState createState() => _EmailPageFormState();
}

class _EmailPageFormState extends State<EmailPageForm> {
  TextEditingController _emailController = TextEditingController ( ) ;
  TextEditingController _passwordController = TextEditingController ( ) ;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();


  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  EmailPageFormType _formType = EmailPageFormType.signIn;

  bool _submited = false;

  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  static Future<User?> loginUsingEmailPawword({required String email, required String password, required BuildContext context}) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;

    } on FirebaseException catch(e){
      if(e.code == "user-not-found"){
        print("Nenhum utilizador com essas cardenciáis");
      }
    }

    return user;
  }

  void _toggleFormType() {
    setState(() {
      _submited = false;
      _formType = _formType == EmailPageFormType.signIn
          ? EmailPageFormType.register
          : EmailPageFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailPageFormType.signIn
        ? 'Iniciar Sessão '
        : 'Crie a sua conta';
    final secondaryText = _formType == EmailPageFormType.signIn
        ? 'Deseja criar uma conta?'
        : 'Já tem uma conta?';

   // bool submitEnabel = widget.emailValidator.isValid(_email) &&
      //  widget.passwordValidator.isValid(_password);

    bool emailValid = _submited && !widget.emailValidator.isValid(_email);
    bool passwordValid = _submited && !widget.emailValidator.isValid(_email);

    return [
      Text(
        'Iniciar Sessão',
        style: TextStyle(
          color: Colors.deepOrange,
          fontSize: 30,
          fontWeight: FontWeight.w700,
        ),
      ),
      SizedBox(
        height: 20,
      ),
      TextField(
        controller: _emailController,
        focusNode: _emailFocusNode,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          hintText: 'E-mail',
          errorText: emailValid ? 'Email não pode estar vazio' : null,
        ),
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        onChanged: (email) => _updateState(),
        onEditingComplete: _emailEditingComplete,
      ),
      SizedBox(
        height: 8,
      ),
      TextField(
        controller: _passwordController,
        focusNode: _passwordFocusNode,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.key,
            color: Colors.grey,
          ),
          border: OutlineInputBorder(),
          hintText: 'Password',
          errorText: passwordValid ? 'Password não pode estar vazio!' : null,
        ),
        obscureText: true,
        textInputAction: TextInputAction.done,
        onChanged: (password) => _updateState(),
        //onEditingComplete: _submit,
      ),
      SizedBox(
        height: 1,
      ),
      TextButton(
        child: Text(
          'Esqueceu-se da password?',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => esquecerPass()));
        },
      ),
      ButaoSubmit(
        text: primaryText,
        onPressed: () async{
          User? user = await loginUsingEmailPawword(email: _emailController.text, password: _passwordController.text, context: context);
          print(user);
          if(user != null){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=> MainPage()));
          }
        },
        //submitEnabel ? _submit : null,
      ),
      SizedBox(
        height: 8,
      ),

    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        //mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildChildren(),
      ),
    );
  }

  void _updateState() {
    setState(() {});
  }
}
