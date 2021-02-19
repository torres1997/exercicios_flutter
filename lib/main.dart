//Cotação referenciada no dia 18/02/2020 pelo google.com

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
          primarySwatch: Colors.amber,
          inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.amber),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.amber,
            ),
          ),
        )
      ),
      home: MyHomePage(),
        debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _reaisController = TextEditingController();
  TextEditingController _dolarController = TextEditingController();
  TextEditingController _euroController = TextEditingController();


  _widgetTextField(TextEditingController controller, String label, String prefix, Function onChange){
    return TextFormField(
      keyboardType: TextInputType.number,
      style: TextStyle(
        color: Colors.amber,
        fontSize: 25,
      ),
      onChanged: onChange,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.amber,
        ),
        prefixText: prefix,

        border:
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.5),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
      ),
      controller: controller,
    );
  }

  reset(){
    setState(() {
      _reaisController.text = '';
      _euroController.text = '';
      _dolarController.text = '';
    });
  }


  void _realChanges(String text) {
    double real = double.parse(_reaisController.text);
    double dolarConv;
    double  euroConv;

    dolarConv = real * 0.18;
    euroConv = real * 0.15;

    _dolarController.text = dolarConv.toStringAsFixed(2);
    _euroController.text = euroConv.toStringAsFixed(2);
  }

  void _dolarChanges(String text) {
    double dolar = double.parse(_dolarController.text);
    double realConv;
    double euroConv;

    realConv = dolar * 5.43;
    euroConv = dolar * 0.83;

    _reaisController.text = realConv.toStringAsFixed(2);
    _euroController.text = euroConv.toStringAsFixed(2);
  }

  void _euroChanges(String text) {
    double euro = double.parse(_euroController.text);
    double dolarConv;
    double realConv;

    dolarConv = euro * 1.21;
    realConv = euro * 6.56;

    _dolarController.text = dolarConv.toStringAsFixed(2);
    _reaisController.text = realConv.toStringAsFixed(2);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Conversor de Moedas', style: TextStyle(color: Colors.white)),

        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              color: Colors.white,
              onPressed: (){
                reset();
              }
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(
            Icons.monetization_on,
            size: 150,
            color: Colors.amber,
          ),
          Container(
            height: 75,
            child: _widgetTextField(_reaisController,"Reais", "R\$", _realChanges)
          ),
          Container(
            height: 75,
              child: _widgetTextField(_dolarController,"Dólares", "U\$", _dolarChanges)
          ),
          Container(
              child: _widgetTextField(_euroController,"Euro", "EU\$", _euroChanges)
          ),
        ],
      ),
    );
  }

}
