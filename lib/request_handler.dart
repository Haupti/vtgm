import 'dart:io';

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
  final void Function(HttpRequest request) handler;

  RequestHandler({
    required this.method,
    required this.path,
    required this.handler,
  });

  bool isResponsible(HttpRequest request){
    return request.method == method.key && request.uri.path == path;
  }

  void handle(HttpRequest request) {
    handler(request);
  }
}
