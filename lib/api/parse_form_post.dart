Map<String, String> formPostBodyToMap(String formPostBody){
  List<String> params = formPostBody.split("&");
  Map<String, String> result = {};
  for(var param in params){
    List<String> keyValuePair = param.split("=");
    if(keyValuePair.length == 2){
      result[keyValuePair[0]] = keyValuePair[1];
    }
    else {
      print("error parsing request body (form post): $keyValuePair");
    }
  }
  return result;
}
