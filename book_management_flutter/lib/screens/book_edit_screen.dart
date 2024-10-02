import 'package:book_management_flutter/models/book.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookEditScreen extends StatefulWidget {
  final Book book;
  final String token;

  BookEditScreen({
    required this.book,
    required this.token,
  });

  @override
  _BookEditScreenState createState() => _BookEditScreenState();
}

class _BookEditScreenState extends State<BookEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String author;
  late int pages;
  late String content;

  @override
  void initState() {
    super.initState();
    title = widget.book.title;
    author = widget.book.author;
    pages = widget.book.pages;
    content = widget.book.content;
  }

  Future<void> _updateBook() async {
    final url = Uri.parse('http://192.168.0.104:9096/books/${widget.book.id}');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.token}'
      },
      body: json.encode({
        'title': title,
        'author': author,
        'pages': pages,
        'content': content,
      }),
    );

    if (response.statusCode == 200) {
      // Successfully updated book
      Navigator.of(context).pop();
    } else {
      // Failed to update book
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update book')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: title,
                decoration: InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  title = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: author,
                decoration: InputDecoration(labelText: 'Author'),
                onChanged: (value) {
                  author = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an author';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: pages.toString(),
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
                initialValue: content,
                decoration: InputDecoration(labelText: 'Content'),
                onChanged: (value) {
                  content = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the content';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _updateBook();
                  }
                },
                child: Text('Update Book'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
