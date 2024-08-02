import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

bool isValidPostalCode(String postalCode) {
  final regex = RegExp(r'^\d{2}-\d{3}$');
  return regex.hasMatch(postalCode);
}

Future<String?> fetchAddress(String postalCode) async {
  try {
    final response = await http.get(
      Uri.parse('http://kodpocztowy.intami.pl/api/$postalCode'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data.first['miejscowosc'] as String?;
    } else {
      throw Exception('Failed to load address');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error fetching address: $e');
    }
    return null;
  }
}