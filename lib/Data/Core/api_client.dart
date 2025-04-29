import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'api_constants.dart';

abstract class BaseApiService {
  const BaseApiService();
  dynamic get(String path, {Map<dynamic, dynamic>? params});
  dynamic post(String path, {Map<dynamic, dynamic>? params});
  dynamic deleteWithBody(String path, {Map<dynamic, dynamic>? params});
  dynamic upload(String path, requestType);
}

class ApiClient extends BaseApiService {
  final Client client;

  const ApiClient(this.client);

  @override
  dynamic get(String path, {Map<dynamic, dynamic>? params}) async {
    final response = await client.get(
      getPath(path, params),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

   @override
  dynamic post(String path, {Map<dynamic, dynamic>? params}) async {
    final f = getPath(path, null);
    debugPrint(f.toString());
    debugPrint(params.toString());

    final response = await client.post(
      getPath(path, null),
      body: jsonEncode(params),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    return response;
    
    // if (response.statusCode == 200) {
    //   return json.decode(response.body);
    // } else if (response.statusCode == 401) {
    // } else {
    //   throw Exception(response.reasonPhrase);
    // }
  }

  @override
  dynamic deleteWithBody(String path, {Map<dynamic, dynamic>? params}) async {
    Request request = Request('DELETE', getPath(path, null));
    request.headers[HttpHeaders.contentTypeHeader] = 'application/json';
    request.body = jsonEncode(params);
    final response = await client.send(request).then(
          (value) => Response.fromStream(value),
        );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      //todo
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  @override
  dynamic upload(String path, requestType) async {
    // MultipartRequest request =
    //     MultipartRequest(requestType, getPath(path, null));
    // final response =
    //     await client.send(request).then((value) => Response.fromStream(value));
  }

  // Uri getPath(String path, Map<dynamic, dynamic>? params) {
  //   var paramsString = '';
  //   if (params?.isNotEmpty ?? false) {
  //     params?.forEach((key, value) {
  //       paramsString += '&$key=$value';
  //     });
  //   }
  //   if (paramsString == '') {
  //     return Uri.parse('${ApiConstants.baseUrl}$path');
  //   } else {
  //     return Uri.parse('${ApiConstants.baseUrl}$path/$paramsString');
  //   }
  // }
  Uri getPath(String path, Map<dynamic, dynamic>? params) {
    return Uri.parse(ApiConstants.baseUrl + path)
        .replace(queryParameters: params?.map((key, value) => MapEntry(key.toString(), value.toString())));
  }

}
