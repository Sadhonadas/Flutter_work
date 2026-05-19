import 'package:flutter/material.dart';
import 'package:my_project/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://mqijkogzwhstvzzpfnhw.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1xaWprb2d6d2hzdHZ6enBmbmh3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg5MTkyNDksImV4cCI6MjA5NDQ5NTI0OX0.N4h-hQcqtWGFugIzr0x0dGaScQAuOpThcOTeFvKXJRk',
    );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark(),
      home:LoginPage(),
    );
  }
}