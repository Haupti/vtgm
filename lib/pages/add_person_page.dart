import 'base_page.dart';
import '../ssr/component.dart';
import '../ssr/response.dart';
import '../ssr/server.dart';
import 'dart:io';
import '../ssr/root_page.dart';

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
