import 'dart:io';
import 'ssr/server.dart';
import 'ssr/request_handler.dart';


String root(String content){
  return """
    <!DOCTYPE HTML>
    <html lang="en">
      <head>
        <META charset="UTF-8">
        <META name="viewport" content="width=device-width, initial-scale=1.0">
        <title> VTGM </title>
      </head>
      <body>
        $content
      </body>
    </html>
  """;
}

void homeEndpoint(HttpRequest request) {
  okResponse(request.response, root("hi"), ContentType.html);
}

void vtgm(List<String> _) {
  List<RequestHandler> handlers = [
    RequestHandler(method: RequestMethod.mGet, path: "/", handler: homeEndpoint)
  ];
  server(8080, handlers);
}
