import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<http.Response> postData(Map<String, dynamic> data) async {
  // Map<String, dynamic> data = {
  //   "name": "jhon doe",
  //   "email": "postmethod@test.com"
  // };

  final result =
      await http.post(Uri.parse("http://192.168.0.123:8082/api/user/insert"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data));
  print(result.statusCode);
  print(result.body);
  return result;
}

Future<http.Response> updateData(int id, Map<String, dynamic> data) async {
  // var data= {};
  final result =
      await http.put(Uri.parse("http://192.168.0.123:8082/api/user/update/$id"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data));

  print(result.statusCode);
  print(result.body);
  return result;
}

Future<http.Response> deleteData(id) async {
  final result = await http.delete(
    Uri.parse("http://192.168.0.123:8082/api/user/delete/$id"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  print(id);
  print(result.statusCode);
  print(result.body);
  return result;
}
