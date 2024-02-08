import 'dart:io';
import 'ssr/server.dart';
import 'ssr/request_handler.dart';
import 'ssr/root_page.dart';
import 'ssr/component.dart';



void homeEndpoint(HttpRequest request) {
  okHtmlResponse(request.response, RootPage([Paragraph(text: "hi")]));
}

void vtgm(List<String> _) {
  List<RequestHandler> handlers = [
    RequestHandler(method: RequestMethod.mGet, path: "/", handler: homeEndpoint)
  ];
  server(8080, handlers);
}
