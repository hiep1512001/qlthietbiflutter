import 'package:bvnd115app/ui/DSThietBi/chitietthietbi.dart';
import 'package:bvnd115app/ui/DSThietBi/dsThietBi.dart';
import 'package:bvnd115app/ui/DangNhap/Login.dart';
import 'package:bvnd115app/ui/ThemThietBi/ThemThietBi.dart';
import 'package:bvnd115app/ui/TrangChu/trangChu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://ivjlncskuwbzzcxhdgta.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml2amxuY3NrdXdienpjeGhkZ3RhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQ2ODc1MDgsImV4cCI6MjA2MDI2MzUwOH0.fzpi9JBfbfwUqXRbo9aK0D9hJSv3bNpYflbTYaNw7xI',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
        child: MaterialApp(
      title: 'Bệnh viện nhân dân 115',
      home: SafeArea(child: DangNhap()),
      debugShowCheckedModeBanner: false,
    ));
  }
}
