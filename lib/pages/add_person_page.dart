import 'base_page.dart';
import '../ssr/html/component.dart';
import '../ssr/http/response.dart';
import '../ssr/http/server.dart';
import 'dart:io';
import '../ssr/html/root_page.dart';
import '../ssr/html/style.dart';

void addPersonPage(HttpRequest request, SsrResponse response) {
  RootPage page = basePage([
    H1(text: "Add", style: Style(fontSize: "24px")),
    Form(formInputs: [
      FormInput(type: "text", name:"name",labelText: "name:")
    ],
    action:"/person/add",
    submitButtonText: "save"
    )
  ]);
  okHtmlResponse(response, page);
}
