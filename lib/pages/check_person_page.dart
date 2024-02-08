import 'package:vtgm/dataproviders/repository.dart';
import 'base_page.dart';
import '../ssr/html/component.dart';
import '../ssr/http/response.dart';
import '../ssr/http/server.dart';
import 'dart:io';
import '../ssr/html/root_page.dart';
import '../domain.dart';
import '../ssr/html/style.dart';

void checkPersonPage(HttpRequest request, SsrResponse response) {
  List<Person> persons = getPeople();
  Style style = Style(display:"flex", flexDirection: "row-reverse", justifyContent: "left");
  RootPage page = basePage([
    H1(text: "Check", style: Style(fontSize: "24px")),
    Form(formInputs: 
      persons.map((Person p) => 
        FormInput(type: "checkbox", name:p.name,labelText: p.name, required: false, checked: p.checked, style: style)
      ).toList()
    ,
    action:"/person/check",
    submitButtonText: "check",
    )
  ]);
  okHtmlResponse(response, page);
}
