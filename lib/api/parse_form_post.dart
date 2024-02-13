import 'package:ssr/ssr.dart';

Map<String, String> formPostBodyToMap<T>(String formPostBody) {
  List<String> params = formPostBody.split("&");
  Map<String, String> result = {};
  for (var param in params) {
    List<String> keyValuePair = param.split("=");
    if (keyValuePair.length == 2) {
      result[keyValuePair[0]] = keyValuePair[1];
    } else {
      print("error parsing request body (form post): $keyValuePair");
    }
  }
  return result;
}

Future<Map<String, String>> parseFormData<T>(SsrRequest request) async {
  if (request.requestData != null) {
    Map<String, String> params = formPostBodyToMap(request.requestData!);
    return params;
  } else {
    return {};
  }
}
