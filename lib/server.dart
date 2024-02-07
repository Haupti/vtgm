import 'dart:io';
import 'request_handler.dart';

void defaultHandleNotFound(HttpRequest request){
  request.response.statusCode = 404;
  request.response.headers.add(HttpHeaders.contentTypeHeader ,ContentType.html);
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
          h.handle(request);
          request.response.close();
          break;
        }
      }
      if(!isHandled){
        defaultHandleNotFound(request);
      }
  });
}


void okResponse(HttpResponse response, String body, ContentType contentType){
  response.contentLength = body.length;
  response.statusCode = 200;
  response.headers.contentType = ContentType.html;
  response.write(body);
}
