import '../ssr/server.dart';
import '../ssr/component.dart';
import 'base_page.dart';
import '../dataproviders/repository.dart';
import '../ssr/response.dart';
import 'dart:io';
import '../ssr/root_page.dart';
import '../domain.dart';
import '../ssr/style.dart';

void homePage(HttpRequest request, SsrResponse response) {
  Style headerStyle = Style(textAlign: "left", padding: "0 8px 0 0");
  Style dataStyle = Style(textAlign: "left", padding: "0 8px 0 0");
  Style checkedStyle = Style(textAlign: "center");
  List<Person> persons = getPeople();
  RootPage page = basePage([
    Table(rows: [
      TableRow(tableData: [TableHeader(text: "prepared trainig?",style: headerStyle), TableHeader(text: "name",style: headerStyle)]),
      ...persons.map((Person p) =>
        TableRow(tableData:[
          TableData(text: p.checked ? "X" : " ", style: checkedStyle), TableData(text: p.name, style: dataStyle)
        ])
      ).toList(),
    ])
  ]);
  okHtmlResponse(response, page);
}