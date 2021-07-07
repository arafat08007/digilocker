import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:googledriveclone_flutter/services/AppException.dart';
import 'package:http/http.dart' as http;
class BaseClient {
  //GET
  static const TIME_OUT =30;
  Future<dynamic> get(String baseUrl, String api) async{
    var url = Uri.parse(baseUrl+api);
    try {
      var response = await http.get(url).timeout(Duration(seconds:TIME_OUT ));
      return _processResponse(response);
    }
    on SocketException{
      throw FetchdataException('No Internet connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('Api not responding', url.toString());
    }

  }
//post
  Future<dynamic> post(String baseUrl, String api, dynamic payloadObj) async{
    var url = Uri.parse(baseUrl+api);
    var payload = json.decode(payloadObj);
    try {
      var response = await http.post(url, body: payload).timeout(Duration(seconds:TIME_OUT ));
      return _processResponse(response);
      //HttpClient httpClient = new HttpClient();
    }
    on SocketException{
      throw FetchdataException('No Internet connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('Api not responding', url.toString());
    }
    finally {
      throw UnAutorizedException (' Unauthorized ',url.toString());

    }
  }
  //delete
  Future<Map<String, dynamic>> commonDel(String url, Map jsonMap) async{
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.deleteUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    print(reply);
    httpClient.close();
    Map<String, dynamic>map = json.decode(reply);
    return map;
  }

  dynamic _processResponse (http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
        break;
      case 400:
        throw BadRequestException(utf8.decode(response.bodyBytes), response.request.url.toString());
        break;
      case 401:
        break;
      case 403:
        throw UnAutorizedException(utf8.decode(response.bodyBytes), response.request.url.toString());
        break;
      case 500:
      default:
        throw FetchdataException('Error occured ${response.statusCode}', response.request.url.toString());


    }

  }

  //POST

}