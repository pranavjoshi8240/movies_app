import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/flutter_toast.dart';

class Networking {
  // var token = 'Your_Token_Here';
  var token = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNzg5MzNmZWNiYWI3YWRmNTUzNWE4YzczNzgwNWQ4MyIsInN1YiI6IjY1OTY0YjRmMzI2ZWMxNTY3OTA2YzFlOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.JMxoghpeAz1b3OtKIr7gbad6FoEkBOHxUOZSMA-QlB8';

  get(String urls) async {
    var data;
    Map<String, String> headers = {
      // 'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      var response = await http.get(Uri.parse(urls), headers: headers);
      data = await returnResponse(response);
    } catch (e) {
      print(e);
    }
    return data;
  }

  post(urls, body) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var response = await http.post(Uri.parse(urls), headers: headers, body: body);
    var data = await returnResponse(response);
    return data;
  }

  returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        print('Api get received');
        return json.decode(response.body.toString());

      case 201:
        print('Api Post received');
        // flutterToastMessage(json.decode(response.body)['message'] ?? "Success");
        return json.decode(response.body.toString());

      case 400:
        flutterToastMessage(json.decode(response.body)['message'] ?? "Bad Request");
        throw BadRequestException(json.decode(response.body)['message'] ?? "Bad Request");

      case 401:
        flutterToastMessage(json.decode(response.body)['message'] ?? "Unauthorised");
        throw UnauthorisedException(json.decode(response.body)['message'] ?? "Unauthorised");

      case 403:
        flutterToastMessage(json.decode(response.body)['message'] ?? "Forbidden");
        throw UnauthorisedException(response.body.toString());

      case 422:
        flutterToastMessage(json.decode(response.body)['message'] ?? "Something went wrong....");
        throw UnauthorisedException(
            json.decode(response.body)['message'] ?? "Something went wrong....");
      case 500:
      default:
        flutterToastMessage(
            "Error occurred while Communication with Server with StatusCode : ${response.statusCode}",
            color: Colors.redAccent);
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

class AppException implements Exception {
  final dynamic _message;
  final dynamic _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}
