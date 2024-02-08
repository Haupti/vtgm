import 'package:vtgm/dataproviders/repository.dart';
import 'base_page.dart';
import '../ssr/component.dart';
import '../ssr/response.dart';
import '../ssr/server.dart';
import 'dart:io';
import '../ssr/root_page.dart';
import '../domain.dart';

void checkPersonPage(HttpRequest request, SsrResponse response) {
  List<Person> persons = getPeople();
  Style style = Style(display:"flex", flexDirection: "row-reverse", justifyContent: "left");
  RootPage page = basePage([
    Form(formInputs: 
      persons.map((Person p) => 
        FormInput(type: "checkbox", name:p.name,labelText: p.name, required: false, checked: p.checked, style: style)
      ).toList()
    ,
    action:"/person/check",
    submitButtonText: "save",
    )
  ]);
  okHtmlResponse(response, page);
}
