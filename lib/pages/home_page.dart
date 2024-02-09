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
  Style headerStyle = Style(color: "white", textAlign: "left", padding: "15px", border: "1px solid #54585d", backgroundColor: "#54585d");
  Style dataStyle = Style(textAlign: "left", padding: "5px 15px");
  Style checkedStyle = Style(textAlign: "center", padding: "5px 15px");
  Style tableStyle = Style(borderCollapse: "collapse");
  Style bodyRowStyle = Style(border: "1px solid #54585d", padding: "1px");
  List<Person> persons = getPeople();
  RootPage page = basePage([
    H1(text: "Statistics", style: Style(fontSize: "24px")),
    Table(style: tableStyle, rows: [
      TableHeader(children: 
        [TableRow(tableData: [
          TableData(text: "name",style: headerStyle),
          TableData(text: "strength workout",style: headerStyle),
          TableData(text: "delays",style: headerStyle)
        ])
      ]),
      ...persons.map((Person p) =>
        TableRow(style: bodyRowStyle,tableData:[
          TableData(text: p.name, style: dataStyle),
          TableData(text: p.checked ? "done" : " ", style: checkedStyle),
          TableData(text: "${p.currentDelays}", style: dataStyle),
        ])
      ).toList(),
    ])
  ]);
  okHtmlResponse(response, page);
}