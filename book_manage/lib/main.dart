import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(BookManagementApp());
}

class BookManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/bookManagement': (context) => BookManagementScreen(),
      },
    );
  }
}

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.104:9096/Auths/Login'),
      body: jsonEncode({
        'email': emailController.text,
        'password': passwordController.text,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    Navigator.pushNamed(context, '/bookManagement');
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text('Invalid email or password. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: () {
                login(context);
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Create an Account'),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> register(BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.104:9096/Auths/Register'),
      body: jsonEncode({
        'username': usernameController.text,
        'email': emailController.text,
        'password': passwordController.text,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    Navigator.pushNamed(context, '/');
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registration Failed'),
            content: Text('Registration failed. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'username'),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: () {
                register(context);
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

class BookManagementScreen extends StatelessWidget {
  TextEditingController idController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController pagesController = TextEditingController();
  Future<void> addBook(BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.104:9096/books/'),
      body: jsonEncode({
        // Add book data here
        "id": idController.text,
        "title": titleController.text,
        "author": authorController.text,
        "pages": pagesController.text
      }),
      headers: {'Content-Type': 'application/json'},
    );

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Book added successfully'),
    ));
    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to add book'),
      ));
    }
  }

  Future<void> updateBook(BuildContext context) async {
    final response = await http.put(
      Uri.parse('http://192.168.0.104:9096/books/:id'),
      body: jsonEncode({
        // Update book data here
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Book updated successfully'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to update book'),
      ));
    }
  }

  Future<void> getAllBooks(BuildContext context) async {
    final response = await http.get(
      Uri.parse('http://192.168.0.104:9096/books/:id'),
    );

    if (response.statusCode == 200) {
      // Handle response to display all books
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to fetch books'),
      ));
    }
  }

  Future<void> deleteBook(BuildContext context) async {
    final response = await http.delete(
      Uri.parse('http://192.168.0.104:9096/books/:id'),
    );

    if (response.statusCode == 204) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Book deleted successfully'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to delete book'),
      ));
    }
  }

  Future<void> getBookById(BuildContext context) async {
    final response = await http.get(
      Uri.parse('http://192.168.0.104:9096/books/:id'),
    );

    if (response.statusCode == 200) {
      // Handle response to display book details
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to fetch book'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                addBook(context);
              },
              child: Text('Add Book'),
            ),
            ElevatedButton(
              onPressed: () {
                updateBook(context);
              },
              child: Text('Update Book'),
            ),
            ElevatedButton(
              onPressed: () {
                getAllBooks(context);
              },
              child: Text('Get All Books'),
            ),
            ElevatedButton(
              onPressed: () {
                deleteBook(context);
              },
              child: Text('Delete Book'),
            ),
            ElevatedButton(
              onPressed: () {
                getBookById(context);
              },
              child: Text('Get Book by ID'),
            ),
          ],
        ),
      ),
    );
  }
}
