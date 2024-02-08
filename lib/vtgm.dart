import 'dart:io';
import 'dart:convert';
import 'ssr/server.dart';
import 'ssr/request_handler.dart';
import 'ssr/root_page.dart';
import 'ssr/component.dart';
import 'domain.dart';
import 'dataproviders/repository.dart';



Component navBar() {
  return Div(children: [
    Anchor(href:"/",text:"home"),
    Anchor(href:"/person/add",text:"add person"),
  ], style: Style(display: "flex", gap: "10px"));
}

RootPage basePage(List<Component> children){
  return RootPage([
    navBar(),
    ...children
  ]);
}

void homeEndpoint(HttpRequest request) {
  List<Person> persons = getPeople();
  RootPage page = basePage([
    UnorderedList(
      persons.map((p) {
        return ListItem(text: p.name, style: Style(textDecoration: "line-through"));
      }).toList()
    )
  ]);
  okHtmlResponse(request.response, page);
}

void addPersonEndpoint(HttpRequest request) {
  RootPage page = basePage([
    Form(formInputs: [
      FormInput(type: "text", name:"name",labelText: "name:")
    ],
    action:"/person/add",
    submitButtonText: "save"
    )
  ]);
  okHtmlResponse(request.response, page);
}

void addPersonFormEndpoint(HttpRequest request) async {
  String requestBody = await utf8.decodeStream(request);
  print(requestBody);
  okResponse(request.response);
}

void vtgm(List<String> _) {
  List<RequestHandler> handlers = [
    RequestHandler(method: RequestMethod.mGet, path: "/", handler: homeEndpoint),
    RequestHandler(method: RequestMethod.mGet, path: "/person/add", handler: addPersonEndpoint),
    RequestHandler(method: RequestMethod.mPost, path: "/person/add", handler: addPersonFormEndpoint)
  ];
  server(8080, handlers);
}
