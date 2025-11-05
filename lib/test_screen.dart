import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: Colors.blue,
            child: const Center(child: Text('Header')),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                Container(
                  color: Colors.green,
                  child: const Center(child: Text('Expanded Content')),
                ),
                // Add more list items here if needed
              ],
            ),
          ),
          Container(
            color: Colors.yellow,
            child: const Center(child: Text('Footer')),
          ),
        ],
      ),
    );
  }
}
