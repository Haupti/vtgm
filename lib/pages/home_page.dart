import '../ssr/server.dart';
import '../ssr/component.dart';
import 'base_page.dart';
import '../dataproviders/repository.dart';
import '../ssr/response.dart';
import 'dart:io';
import '../ssr/root_page.dart';
import '../domain.dart';

void homePage(HttpRequest request, SsrResponse response) {
  List<Person> persons = getPeople();
  RootPage page = basePage([
    UnorderedList(
      persons.map((p) {
        Style? style;
        if(p.checked){
          style = Style(textDecoration: "line-through");
        }
        return ListItem(text: p.name, style: style);
      }).toList()
    )
  ]);
  okHtmlResponse(response, page);
}