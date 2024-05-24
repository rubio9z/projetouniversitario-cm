import 'dart:convert';
// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double _quantia = 1.0;
  String? _deMoeda = 'BRL';
  String? _paraMoeda = 'USD';
  double _resultado = 0.0;
  String _resultadoString = '';

  Future<void> _converteMoeda() async {
    final url =
        'https://economia.awesomeapi.com.br/json/last/$_deMoeda-$_paraMoeda';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final double taxaDeConversao =
          double.parse(data['${_deMoeda!}${_paraMoeda!}']['bid']);

      setState(() {
        _resultado = _quantia * taxaDeConversao;
        _resultadoString = _resultado.toStringAsFixed(2);
      });
    } else {
      throw Exception('Falha ao carregar dados.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
      ),
      backgroundColor: Colors.blueGrey[900],
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.only(
            top: 100,
            bottom: 20,
            left: 30,
            right: 30,
          ),
          child: Column(
            children: [
              Image.asset(
                'assets/logo.png',
                width: 150,
                height: 150,
              ),
              SizedBox(height: 40),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: 30,
                        height: 56,
                        child: DropdownButton<String>(
                          menuMaxHeight: 200,
                          iconEnabledColor: Colors.amber,
                          isExpanded: true,
                          underline: Container(
                            height: 1,
                            color: Colors.amber,
                          ),
                          value: _deMoeda,
                          onChanged: (String? newValue) {
                            setState(() {
                              _deMoeda = newValue;
                            });
                          },
                          items: <String>[
                            'BRL',
                            'USD',
                            'EUR',
                            'GBP',
                            'JPY',
                            'CAD',
                            'ILS',
                            'AUD',
                            'KRW',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _quantia = double.parse(value);
                          });
                        },
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 56,
                        child: DropdownButton<String>(
                          menuMaxHeight: 200,
                          iconEnabledColor: Colors.amber,
                          isExpanded: true,
                          underline: Container(
                            height: 1,
                            color: Colors.amber,
                          ),
                          value: _paraMoeda,
                          onChanged: (String? newValue) {
                            setState(() {
                              _paraMoeda = newValue;
                            });
                          },
                          items: <String>[
                            'BRL',
                            'USD',
                            'EUR',
                            'GBP',
                            'JPY',
                            'CAD',
                            'ILS',
                            'AUD',
                            'KRW',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.amber,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 11),
                        child: Text(
                          textAlign: TextAlign.center,
                          ' $_resultadoString',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.amber,
                  textStyle: TextStyle(fontSize: 20),
                  padding:
                      EdgeInsets.only(top: 25, bottom: 25, left: 40, right: 40),
                ),
                onPressed: _converteMoeda,
                child: const Text('Converter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
