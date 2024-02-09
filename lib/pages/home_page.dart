import '../ssr/http/server.dart';
import '../ssr/html/component.dart';
import 'base_page.dart';
import '../dataproviders/repository.dart';
import '../ssr/http/response.dart';
import 'dart:io';
import '../ssr/html/root_page.dart';
import '../domain.dart';
import '../ssr/html/style.dart';

void homePage(HttpRequest request, SsrResponse response) {
  Style headerStyle = Style(textAlign: "left", padding: "0 8px 0 0", borderBottom: "1px solid black");
  Style dataStyle = Style(textAlign: "left", padding: "0 8px 0 0");
  Style checkedStyle = Style(textAlign: "center");
  List<Person> persons = getPeople();
  RootPage page = basePage([
    H1(text: "Statistics", style: Style(fontSize: "24px")),
    Table(rows: [
      TableRow(tableData: [
        TableHeader(text: "name",style: headerStyle),
        TableHeader(text: "strength workout",style: headerStyle),
        TableHeader(text: "delays",style: headerStyle)
      ]),
      ...persons.map((Person p) =>
        TableRow(tableData:[
          TableData(text: p.name, style: dataStyle),
          TableData(text: p.checked ? "done" : " ", style: checkedStyle),
          TableData(text: "${p.currentDelays}"),
        ])
      ).toList(),
    ])
  ]);
  okHtmlResponse(response, page);
}