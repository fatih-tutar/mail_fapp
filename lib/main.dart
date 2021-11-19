import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _requestController = TextEditingController();
  String name = "";
  String email = "";
  String subject = "";
  String request = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-posta Gönderme Uygulaması"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Adınızı soyadınız giriniz.',
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'E-posta adresini giriniz.',
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Başlığı yazınız.',
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _requestController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Talebinizi yazınız.',
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 5,
              ),
              const SizedBox(
                height: 5,
              ),
              TextButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width, 40),
                  ),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                onPressed: () {
                  setState(() {
                    name = _nameController.text;
                    email = _emailController.text;
                    subject = _subjectController.text;
                    request = _requestController.text;
                  });
                  sendEmail(
                    name: _nameController.text,
                    email: _emailController.text,
                    subject: _subjectController.text,
                    message: _requestController.text,
                  );
                },
                child: const Text(
                  'Gönder',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    const serviceId = 'service_41b8sdn';
    const templateId = 'template_9kz6hmd';
    const userId = 'user_iswVTgPcbp3CfWhPY6Ovd';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    //final response =
    await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': name,
          'user_email': email,
          'to_email': email,
          'user_subject': subject,
          'user_message': message,
        }
      }),
    );
  }
}

