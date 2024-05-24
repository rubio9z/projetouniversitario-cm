import 'package:flutter/material.dart';
import 'package:projetoapp/presentation/pages/views/home_view.dart';

import '../../../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _emailNode = FocusNode();
  final FocusNode _senhaNode = FocusNode();

  String _email = "";
  String _senha = "";

  _mensagemDeErro(String mensagem) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          mensagem,
          style: TextStyle(
            color: Colors.red,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  _emailValido() {
    if (_email.trim().length == 0) return false;

    final exp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    return exp.hasMatch(_email);
  }

  _senhaValida() {
    return _senha.trim().length > 0;
  }

  _onPressedParaBotaoAcessar() {
    if (_emailValido() && _senhaValida()) {
      return () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeView(),
            ),
          );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text("Chico Currency"),
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.amber, fontSize: 20),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              focusNode: _emailNode,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_senhaNode),
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.email,
                  ),
                  labelText: 'Informe o email'),
            ),
            Visibility(
              visible: !_emailValido(),
              child: _mensagemDeErro('Um email correto é obrigatório!'),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              focusNode: _senhaNode,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                setState(() {
                  _senha = value;
                });
              },
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.security,
                  ),
                  labelText: 'Informe a senha'),
            ),
            Visibility(
              visible: !_senhaValida(),
              child: _mensagemDeErro('A senha é obrigatória!'),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
                bottom: 15,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.amber,
                textStyle: TextStyle(fontSize: 20),
                padding:
                    EdgeInsets.only(top: 25, bottom: 25, left: 40, right: 40),
              ),
              onPressed: _onPressedParaBotaoAcessar(),
              child: const Text('Acessar'),
            ),
          ],
        ),
      ),
    );
  }
}
