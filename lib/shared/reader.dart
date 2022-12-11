import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';

class DefineReader<T> {
  static const questionsPath = 'assets/defines/questions.json';

  Future<String> load(String path) async {
    WidgetsFlutterBinding.ensureInitialized();
    return await rootBundle.loadString(path);
  }

  Future<List<T>> parse(
    String path,
    T Function(Map<String, dynamic>) mapper,
  ) async {
    final String response = await load(path);
    final parsed = jsonDecode(response).cast<Map<String, dynamic>>();

    return parsed.map<T>(mapper).toList();
  }
}
