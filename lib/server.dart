import 'dart:io';
import "dart:convert";
import 'request_handler.dart';

void defaultHandleNotFound(HttpRequest request){
  request.response.statusCode = 404;
  request.response.headers.add(HttpHeaders.contentTypeHeader ,ContentType.html.value);
  request.response.write("<h1> page not found </h1>");
  request.response.close();
}

void server(int port, List<RequestHandler> handlers) async {
  HttpServer server = await HttpServer.bind("localhost", port);
  await server.forEach((HttpRequest request) {
      bool isHandled = false;
      for (final h in handlers) {
        if(h.isResponsible(request)){
          isHandled = true;

          authWrapper(request, h);
          request.response.close();
          break;
        }
      }
      if(!isHandled){
        defaultHandleNotFound(request);
      }
  });
}

void sendWWWAuthenticate(HttpRequest request){
  request.response.statusCode = 401;
  request.response.headers.add(HttpHeaders.wwwAuthenticateHeader, "Basic realm=\"vtgmRealm\", charset=\"UTF-8\"");
  request.response.close();
}

void authWrapper(HttpRequest request, RequestHandler handler){
  String? authHeader = request.headers.value(HttpHeaders.authorizationHeader);
  if(authHeader == null || !authHeader.contains(RegExp(r'Basic .*'))){
    sendWWWAuthenticate(request);
    return;
  }
  RegExp rgx = RegExp(r'(?<=Basic ).*');
  RegExpMatch? match = rgx.firstMatch(authHeader);
  if(match == null){
    sendWWWAuthenticate(request);
    return;
  }
  String? authToken = match[0];
  if(authToken == null){
      sendWWWAuthenticate(request);
      return;
  }
  String decodedAuth = utf8.decode(base64.decode(authToken));
  print(decodedAuth);
  if(decodedAuth != "user:token"){
      sendWWWAuthenticate(request);
      return;
  }
  handler.handle(request);
}

void okResponse(HttpResponse response, String body, ContentType contentType){
  response.contentLength = body.length;
  response.statusCode = 200;
  response.headers.contentType = ContentType.html;
  response.write(body);
}
