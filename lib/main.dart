import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super Juice Calculator',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: const Color.fromARGB(255, 254, 230, 0)),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: const Color.fromARGB(255, 61, 60, 60),
          filled: true,
          hintStyle: TextStyle(color: const Color.fromARGB(255, 249, 227, 28).withOpacity(0.5)),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: const Color.fromARGB(255, 80, 78, 78)),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      home: SimpleTextInput(),
    );
  }
}

class SimpleTextInput extends StatefulWidget {
  @override
  _SimpleTextInputState createState() => _SimpleTextInputState();
}

class _SimpleTextInputState extends State<SimpleTextInput> {
  TextEditingController _controller = TextEditingController();
  String _result = '';
  bool _showText = false;

  void _calculate() {
    if (_controller.text.isNotEmpty) {
      double amount = double.parse(_controller.text);
      int calculated = (amount / 16.5).ceil();
      _result = calculated.toString();
      _showText = true;
    } else {
      _result = '';
      _showText = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Super Juice Calculator'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Amount of Super lemon juice you want to make (ml)',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter amount in mls',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 247, 226, 33)),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow),
        borderRadius: BorderRadius.circular(10.0),
                )
              ),
              controller: _controller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(5),
              ],
              onTap: () {
                setState(() {
                  _result = '';
                  _showText = false;
                });
              },
            ),
          ),
          SizedBox(height: 16.0),
          Center(
            child: ElevatedButton(
              onPressed: _calculate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
              ),
              child: Text('DO IT'),
            ),
          ),
          if (_showText)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'You will need:',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                SizedBox(height: 8.0),
                ListTile(
                  leading: Icon(Icons.fiber_manual_record, size: 16.0, color: Colors.yellow),
                  title: Text('$_result grams of lemon zest', style: TextStyle(color: Colors.yellow)),
                ),
                ListTile(
                  leading: Icon(Icons.fiber_manual_record, size: 16.0, color: Colors.yellow),
                  title: Text('$_result grams of citric acid', style: TextStyle(color: Colors.yellow)),
                ),
                ListTile(
                  leading: Icon(Icons.fiber_manual_record, size: 16.0, color: Colors.yellow),
                  title: Text('${_controller.text} mls of water', style: TextStyle(color: Colors.yellow)),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
