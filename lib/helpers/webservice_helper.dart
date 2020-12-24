import 'dart:convert';

import 'package:http/http.dart' as http;

class WebserviceHelper {
  static String _httpProtocol;
  static String _ip;
  static String _portNum;
  static String _rootDir;

  static const String _HTTP_PROTOCOL_LOCAL = "http://";
  static const String _HTTP_PROTOCOL_BETA = "https://";
  static const String _HTTP_PROTOCOL_PROD = "https://";

  static const String _IP_LOCAL = "";
  static const String _IP_BETA = "";
  static const String _IP_PROD = "jsonplaceholder.typicode.com";

  static const String _PORT_NUM_LOCAL = "";
  static const String _PORT_NUM_BETA = "";
  static const String _PORT_NUM_PROD = "";

  static const String _ROOT_DIR_LOCAL = "";
  static const String _ROOT_DIR_BETA = "";
  static const String _ROOT_DIR_PROD = "";

  static String getBaseUrl() {
    String urlResult;
    eFlavor mCurrFlavor = eFlavor.PROD;

    switch (mCurrFlavor) {
      case eFlavor.LOCAL:
        _httpProtocol = _HTTP_PROTOCOL_LOCAL;
        _ip = _IP_LOCAL;
        _portNum = _PORT_NUM_LOCAL;
        _rootDir = _ROOT_DIR_LOCAL;
        break;
      case eFlavor.BETA:
        _httpProtocol = _HTTP_PROTOCOL_BETA;
        _ip = _IP_BETA;
        _portNum = _PORT_NUM_BETA;
        _rootDir = _ROOT_DIR_BETA;
        break;
      case eFlavor.PROD:
        _httpProtocol = _HTTP_PROTOCOL_PROD;
        _ip = _IP_PROD;
        _portNum = _PORT_NUM_PROD;
        _rootDir = _ROOT_DIR_PROD;
        break;
    }

    urlResult = _httpProtocol + _ip;

    if (_portNum.isNotEmpty) {
      urlResult += ":" + _portNum;
    }

    if (_rootDir.isNotEmpty) {
      urlResult += "/" + _rootDir;
    }

    return urlResult;
  }

  static Future<String> get(String endpoint) async {
    try {
      final http.Response response = await http
          .get(getBaseUrl() + endpoint)
          .timeout(const Duration(seconds: 5));

      print("==============================");
      print("WS Url: ${getBaseUrl()}$endpoint");

      return response.body;
    } catch (e) {
      // TODO: show Toast
      return null;
    }
  }

  static Future<String> post(
      String endpoint, Map<String, String> params) async {
    try {
      final http.Response response = await http
          .post(
            getBaseUrl() + endpoint,
            body: params,
          )
          .timeout(const Duration(seconds: 5));

      return response.body;
    } catch (e) {
      // TODO: show Toast
      return null;
    }
  }
}

enum eFlavor { LOCAL, BETA, PROD }
