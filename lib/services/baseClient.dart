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