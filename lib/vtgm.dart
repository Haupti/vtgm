import 'dart:io';
import 'dart:convert';
import 'ssr/server.dart';
import 'ssr/response.dart';
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

void homeEndpoint(HttpRequest request, SsrResponse response) {
  List<Person> persons = getPeople();
  RootPage page = basePage([
    UnorderedList(
      persons.map((p) {
        return ListItem(text: p.name, style: Style(textDecoration: "line-through"));
      }).toList()
    )
  ]);
  okHtmlResponse(response, page);
}

void addPersonEndpoint(HttpRequest request, SsrResponse response) {
  RootPage page = basePage([
    Form(formInputs: [
      FormInput(type: "text", name:"name",labelText: "name:")
    ],
    action:"/person/add",
    submitButtonText: "save"
    )
  ]);
  okHtmlResponse(response, page);
}

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

void addPersonFormEndpoint(HttpRequest request, SsrResponse response) async {
  String requestBody = await utf8.decodeStream(request);
  Map<String, String> params =formPostBodyToMap(requestBody);
  List<Person> persons = getPeople();
  String? name = params["name"];
  if(name == null){
    print("error: name parameter is required but not in request body");
    return;
  }
  persons.add(Person(name));
  savePeople(persons);
  response.setStatus(301).setLocationHeader("/person/add");
}

void vtgm(List<String> _) {
  List<RequestHandler> handlers = [
    RequestHandler(method: RequestMethod.mGet, path: "/", handler: homeEndpoint),
    RequestHandler(method: RequestMethod.mGet, path: "/person/add", handler: addPersonEndpoint),
    RequestHandler(method: RequestMethod.mPost, path: "/person/add", handler: addPersonFormEndpoint)
  ];
  server(8080, handlers);
}
