import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:projects/data_layer/end_points.dart';

const String baseUrl = "https://codeforces.com/api/";
void getUserData(
  List<String> handles, {
   String key = "ec97f3af54076393ef2d1caf5a464dd844441695", // left intentionally 
  String secret = "2e3912de870201acbd393b7b4fa4176daf4a6cde", // // left intentionally 
}) async {
  String endPoint = EndPoints.user.info;
  Map<String, String> params = getRequestParams(
    key: key,
    secret: secret,
    params: {"handles": handles[0]},
    endPoint: endPoint,
  );

  dynamic response = await Dio().get(
    baseUrl + endPoint,
    queryParameters: params,
  );

  print(response);
}

Map<String, String> getRequestParams({
  String key = "",
  String secret = "",
  Map<String, String> params = const {},
  String endPoint = "",
}) {
  int randNum = getRandomNum();

  params["apiKey"] = key;
  params["time"] = getCurrTime().toString();
  params["apiSig"] = randNum.toString() +
      getSha512(
        randNum.toString() +
            '/' +
            endPoint +
            '?' +
            sortParamsLexo(params) +
            "#" +
            secret,
      ).toString();
  return params;
}

String getCurrTime() {
  return ((DateTime.now().millisecondsSinceEpoch) / 1000).ceil().toString();
}

int getRandomNum({
  int min = 111111,
  int max = 999999,
}) {
  return min + Random().nextInt(max - min);
}

String sortParamsLexo(Map<String, dynamic> params) {
  List<String> paramsList = [];
  params.forEach((key, value) {
    paramsList.add(key + "=" + value);
  });
  paramsList.sort((a, b) => a.toString().compareTo(b.toString()));

  String newParams = "";
  for (int i = 0; i < paramsList.length; i++) {
    newParams += paramsList[i];
    if (i != paramsList.length - 1) {
      newParams += '&';
    }
  }
  return newParams;
}

String getSha512(String str) {
  return sha512.convert(utf8.encode(str)).toString();
}
