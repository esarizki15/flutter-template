// ignore: file_names
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class HttpService {
  static final HttpService _instance = HttpService.internal();
  HttpService.internal();
  factory HttpService() => _instance;

  final LocalStorage storage = LocalStorage('myapp');
  Map<String, String> headers = {};
  final JsonDecoder _decoder = const JsonDecoder();
  static const _baseUrl = "https://api.publicapis.org/";

  Future<dynamic> get(String desturl, {Map<String, String>? headers}) {
    Map<String, String> myHeaders = <String, String>{};
    myHeaders['Content-type'] = 'application/json; charset=UTF-8';
    myHeaders['Accept'] = 'application/json';
    myHeaders['X-Auth-Token'] = 'storage.getItem("authKey")';

    Uri url = Uri.parse(_baseUrl + desturl);
    return http.get(url, headers: myHeaders).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400) {
        throw Exception("Error while fetching data");
      }
      return _decoder.convert(response.body);
    }, onError: (error) {
      throw Exception(error.toString());
    });
  }

  Future<dynamic> post(String desturl,
      {Map<String, String>? headers, body, encoding}) {
    body ??= {};

    Map<String, String> myHeaders = <String, String>{};
    myHeaders['Content-type'] = 'application/json; charset=UTF-8';
    myHeaders['Accept'] = 'application/json';
    myHeaders['X-Auth-Token'] = 'storage.getItem("authKey")';

    Uri url = Uri.parse(_baseUrl + desturl);
    return http
        .post(url,
            body: json.encode(body), headers: myHeaders, encoding: encoding)
        .then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400) {
        throw Exception("Error while fetching data");
      }

      return _decoder.convert(response.body);
    }, onError: (error) {
      throw Exception(error.toString());
    });
  }
}
