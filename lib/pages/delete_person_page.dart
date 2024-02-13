import 'package:vtgm/dataproviders/repository.dart';
import 'base_page.dart';
import 'package:ssr/ssr.dart';
import 'package:ssr/html.dart';
import '../domain.dart';

void deletePersonPage(SsrRequest request, SsrResponse response) {
  List<Person> persons = getPeople();
  Style style = Style(display: "flex", flexDirection: "row-reverse", justifyContent: "left");
  RootPage page = basePage([
    H1(text: "Delete", style: Style(fontSize: "24px")),
    Form(
      formInputs: persons.map((Person p) => FormInput(type: "checkbox", name: p.name, labelText: p.name, required: false, style: style)).toList(),
      action: "/person/delete",
      submitButtonText: "delete",
    )
  ]);
  okHtmlResponse(response, page);
}
