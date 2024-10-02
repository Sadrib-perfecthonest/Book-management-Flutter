//http://192.168.0.104:9096/books/
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookAddScreen extends StatefulWidget {
  final String token;

  BookAddScreen({required this.token});

  @override
  _BookAddScreenState createState() => _BookAddScreenState();
}

class _BookAddScreenState extends State<BookAddScreen> {
  final _formKey = GlobalKey<FormState>();
  String id = '';
  String title = '';
  String author = '';
  int pages = 0;
  String content = '';

  Future<void> _addBook() async {
    final url = Uri.parse('http://192.168.0.104:9096/books/');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.token}'
      },
      body: json.encode({
        'id': id,
        'title': title,
        'author': author,
        'pages': pages,
        'content': content
      }),
    );
    Fluttertoast.showToast(msg: 'Book added successfully');
    Navigator.of(context).pushNamed('/bookList', arguments: widget.token);

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add book')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'id'),
                onChanged: (value) {
                  id = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the book id';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  title = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the book title';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Author'),
                onChanged: (value) {
                  author = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the book author';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Pages'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  pages = int.parse(value);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the number of pages';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Content'),
                onChanged: (value) {
                  content = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the book content';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addBook();
                  }
                },
                child: Text('Add Book'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
