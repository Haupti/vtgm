import 'package:vtgm/dataproviders/repository.dart';
import 'base_page.dart';
import 'package:ssr/ssr.dart';
import 'package:ssr/html.dart';
import 'dart:io';
import '../domain.dart';

void managePersonPage(HttpRequest request, SsrResponse response) {
  List<Person> persons = getPeople();
  Style style = Style(display:"flex", flexDirection: "row-reverse", justifyContent: "left", gap: "10px");
  RootPage page = basePage([
    H1(text: "Update", style: Style(fontSize: "24px")),
    Div(children: [
      H2(text: "unpaid delays"),
      Div(style: Style( margin: "0 5vw 0 0"), children: [
        Form(formInputs: 
          persons.map((Person p) => 
            FormInput(type: "checkbox", name:p.name,labelText: p.name, required: false, checked: p.checked, style: style)
          ).toList()
        ,
        action:"/person/check",
        submitButtonText: "check",
        )
      ]),
      Div(children: [
        H2(text: "unpaid delays"),
        Form(formInputs: 
          persons.map((Person p) => 
            FormInput(type: "number", name:"${p.name}-delays",labelText: p.name, required: true, value: "${p.currentDelays}", style: style)
          ).toList()
        ,
        action:"/person/delays",
        submitButtonText: "update",
        )
      ]),
    ])
  ]);
  okHtmlResponse(response, page);
}
