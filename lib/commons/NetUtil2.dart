import 'dart:io';
import 'package:async/async.dart';
import 'package:finerit_app_flutter/commons/http_error.dart';
import 'package:finerit_app_flutter/commons/dicts.dart';
import 'package:finerit_app_flutter/commons/toast.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import 'package:dio/dio.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
//此net为为netloading准备的同步net
class NetUtil2 {
  static const String GET = "get";
  static const String POST = "post";
  static const String PUT = "put";
  static const String DELETE = "delete";
  static const String PUT_FILE = "put_file";

  Future get(String url, Function callBack,
      {Map<String, dynamic> params,
        Function errorCallBack=errorCallBack,
        Map<String, String> headers}) async {
    await _request(Api.BASE_URL + url, callBack,
        method: GET,
        params: params,
        errorCallBack: errorCallBack,
        headers: headers);
  }
  static void errorCallBack(Map data){
    requestToast(HttpError.getErrorData(data).toString());
  }
  Future post(String url, Function callBack,
      {Map<String, dynamic> params,
        Function errorCallBack=errorCallBack,
        Map<String, String> headers}) async {
    await _request(Api.BASE_URL + url, callBack,
        method: POST,
        params: params,
        errorCallBack: errorCallBack,
        headers: headers);
  }

   Future delete(String url, Function callBack,
      {Map<String, dynamic> params,
        Function errorCallBack=errorCallBack,
        Map<String, String> headers})  async {
    await _request(Api.BASE_URL + url, callBack,
        method: DELETE,
        params: params,
        errorCallBack: errorCallBack,
        headers: headers);
  }

  Future put(String url, Function callBack,
      {dynamic params,
        Function errorCallBack=errorCallBack,
        Map<String, String> headers}) async {
      _request(Api.BASE_URL + url, callBack,
        method: PUT,
        params: params,
        errorCallBack: errorCallBack,
        headers: headers);
  }

  Future<String> putFile(File uploadFile, Function onSuccess) async {
    var stream = new http.ByteStream(DelegatingStream.typed(uploadFile.openRead()));
    var length = await uploadFile.length();
    var uri =
    Uri.parse("https://avefaaux.api.lncld.net/1.1/files/${basename(uploadFile.path)}");
    String contentType;
    try{
      contentType = Dicts.MIMES[extension(uploadFile.path)];
    }on Exception catch (e) {
      return null;
    }
    var headers = {
      "X-LC-Id": "aveFaAUxq89hJCelmHX33pLU-gzGzoHsz",
      "X-LC-Key": "SX8gmajxVuYL4MvfOCTvV5zR",
      "Content-Type": contentType
    };
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(uploadFile.path));
    request.files.add(multipartFile);
    request.headers.addAll(headers);
    var response = await request.send();
    print(response.statusCode);
    if(response.statusCode == 201){
      response.stream.transform(utf8.decoder).listen(onSuccess);
    }else{
      return "FILE_UPLOAD_ERROR";
    }

  }

  Future _request(String url, Function callBack,
      {String method,
        dynamic params,
        Function errorCallBack=errorCallBack,
        Map<String, String> headers})  async {
    print("<net> url :<" + method + ">" + url);

    if (params != null && params.isNotEmpty) {
      print("<net> params :" + params.toString());
    }

    if (headers != null && headers.isNotEmpty) {
      print("<net> headers :" + headers.toString());
    } else {
      headers = {'finerit_api': "-1"};
    }

    String errorMsg = "";
    int statusCode;

    try {
      Response response;
      if (method == GET) {
        if (params != null && params.isNotEmpty) {
          StringBuffer sb = new StringBuffer("?");
          params.forEach((key, value) {
            sb.write("$key" + "=" + "$value" + "&");
          });
          String paramStr = sb.toString();
          paramStr = paramStr.substring(0, paramStr.length - 1);
          url += paramStr;
        }
        response = await Dio(Options(headers: headers)).get(url);
        print(response);
      } else if (method == POST) {
        if (params != null && params.isNotEmpty) {
          response = await Dio(Options(
              headers: headers,
              contentType: ContentType.parse("application/json")))
              .post(url, data: params);
          print(response);
        } else {
          response = await Dio(Options(
              headers: headers,
              contentType: ContentType.parse("application/json")))
              .post(url);
          print(response);
        }
      } else if (method == PUT) {
        if (params != null && params.isNotEmpty) {
          response = await Dio(Options(
              headers: headers,
              contentType: ContentType.parse("application/json")))
              .put(url, data: params);
          print(response);
        } else {
          response = await Dio(Options(
              headers: headers,
              contentType: ContentType.parse("application/json")))
              .put(url);
          print(response);
        }
      }
      else if (method == DELETE) {
        if (params != null && params.isNotEmpty) {
          response = await Dio(Options(
              headers: headers,
              contentType: ContentType.parse("application/json")))
              .put(url, data: params);
          print(response);
        } else {
          response = await Dio(Options(
              headers: headers,
              contentType: ContentType.parse("application/json")))
              .delete(url);
          print(response);
        }
      }

      statusCode = response.statusCode;

      if (statusCode < 0) {
        errorMsg = "网络请求错误,状态码:" + statusCode.toString();
        _handError(errorCallBack, errorMsg);
        return;
      }

      if (callBack != null) {
        callBack(response.data);
//        print("<net> response data:" + response.data);
      }
    } catch (e) {
      if(e is FlutterError){
        print(e.message);
      }else{
        var errorCallback=errorCallBack;
        try{
          _handError(errorCallBack, e.response.data);
        }
        catch(e){
//          _handError(errorCallback, {"info":"系统错误,麻烦及时联系站长哦"});
        }

      }
    }
  }

  static void _handError(Function errorCallback, Object errorMsg) {
    if (errorCallback != null) {
      errorCallback(errorMsg);
    }
//    print("<net> errorMsg :" + errorMsg);
  }
}
