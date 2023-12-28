import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyWidget extends StatelessWidget {
  // Replace this URL with the actual API endpoint
  static const apiUrl = 'https://api.example.com/data';

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return json.decode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // If the Future is still running, show a loading indicator
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // If an error occurred, display an error message
          return Text('Error: ${snapshot.error}');
        } else {
          // If the Future is complete, display the data
          final data = snapshot.data;
          return Text('Data: $data');
        }
      },
    );
  }
}
