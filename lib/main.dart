import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url:'https://zszfjgerxxzydnpmfslo.supabase.co',
    anonKey:'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpzemZqZ2VyeHh6eWRucG1mc2xvIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTUwMjQxMDUsImV4cCI6MjAxMDYwMDEwNX0.M6JtYqPv7G5GzuUCDDry_637PTaQOWAKX5WdbhmJGHQ',
    debug: true
  );
  runApp(const App());
}

