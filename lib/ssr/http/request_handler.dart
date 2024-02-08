import 'dart:io';
import 'package:vtgm/ssr/http/auth.dart';

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
  AuthRole minimumRole = AuthRole.admin;

  RequestHandler({
    required this.method,
    required this.path,
    required this.handler,
  });

  RequestHandler setMinimumRole(AuthRole minimumRole){
    this.minimumRole = minimumRole;
    return this;
  }

  bool isResponsible(HttpRequest request){
    return request.method == method.key && request.uri.path == path;
  }

  void handle(HttpRequest request, SsrResponse response) {
    handler(request, response);
  }
}
