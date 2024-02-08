import 'dart:io';
import 'response.dart';

enum RequestMethod {
  mGet(key:"GET"),
  mPost(key:"POST"),
  mPut(key:"PUT"),
  mOption(key:"OPTION");

  const RequestMethod({
    required this.key
  });
  final String key;
}

class RequestHandler{
  final RequestMethod method;
  final String path;
  final void Function(HttpRequest request, SsrResponse response) handler;
  bool requiresAuth = true;

  RequestHandler({
    required this.method,
    required this.path,
    required this.handler,
  });

  void setAuthorizationRequired(bool requiresAuth){
    this.requiresAuth = requiresAuth;
  }

  bool isResponsible(HttpRequest request){
    return request.method == method.key && request.uri.path == path;
  }

  void handle(HttpRequest request, SsrResponse response) {
    handler(request, response);
  }
}
