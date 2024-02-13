import 'base_page.dart';
import 'package:ssr/ssr.dart';
import 'package:ssr/html.dart';

void addPersonPage(SsrRequest request, SsrResponse response) {
  RootPage page = basePage([
    H1(text: "Add", style: Style(fontSize: "24px")),
    Form(formInputs: [FormInput(type: "text", name: "name", labelText: "name:")], action: "/person/add", submitButtonText: "save")
  ]);
  okHtmlResponse(response, page);
}
