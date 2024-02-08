import 'dart:io';
import 'ssr/server.dart';
import 'ssr/request_handler.dart';
import 'ssr/root_page.dart';
import 'ssr/component.dart';



Component navBar() {
  return Div(children: [
    Anchor(href:"/",text:"home page"),
    Anchor(href:"/lol",text:"lol page"),
  ], style: Style(display: "flex", gap: "10px"));
}

RootPage basePage(List<Component> children){
  return RootPage([
    navBar(),
    ...children
  ]);
}

void homeEndpoint(HttpRequest request) {
  RootPage page = basePage([
    Paragraph(text: "home page")
  ]);
  okHtmlResponse(request.response, page);
}

void lolEndpoint(HttpRequest request) {
  RootPage page = basePage([
    Paragraph(text: "im on lol")
  ]);
  okHtmlResponse(request.response, page);
}

void vtgm(List<String> _) {
  List<RequestHandler> handlers = [
    RequestHandler(method: RequestMethod.mGet, path: "/", handler: homeEndpoint),
    RequestHandler(method: RequestMethod.mGet, path: "/lol", handler: lolEndpoint)
  ];
  server(8080, handlers);
}
