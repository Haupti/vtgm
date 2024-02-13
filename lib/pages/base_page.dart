import 'package:ssr/ssr.dart';
import 'package:ssr/html.dart';

Component navBar() {
  Style aStyle = Style(
    backgroundColor: "white",
    color: "black",
    border: "2px solid #bcc5d4",
    boxShadow: "3px 3px #bcc5d4",
    textDecoration: "none",
    padding: "4px 8px",
  );

  Style wrapperStyle = Style(
    display: "flex",
    gap: "10px",
    padding: "0 0 10px 10px",
    borderBottom: "2px solid black",
    alignItems: "center",
    justifyContent: "start",
  );

  var home = Anchor(href: "/", text: "home", style: aStyle);
  var personCheck = Anchor(href: "/person/update", text: "manage", style: aStyle);
  var personDelete = Anchor(href: "/person/delete", text: "delete person", style: aStyle);
  var personAdd = Anchor(href: "/person/add", text: "add person", style: aStyle);
  AuthRole currentRole = getCurrentAuthorizedUserRole();
  var visibleAnchors = [];
  if (currentRole == AuthRole.basic) {
    visibleAnchors = [home];
  } else if (currentRole == AuthRole.mod) {
    visibleAnchors = [home, personCheck];
  } else if (currentRole == AuthRole.admin) {
    visibleAnchors = [home, personCheck, personDelete, personAdd];
  }
  return Div(children: [Paragraph(text: "H5 TGM VB"), ...visibleAnchors], style: wrapperStyle);
}

String vtgmRoot(String title, String content) {
  return """
    <!DOCTYPE HTML>
    <html lang="en">
      <head>
        <META charset="UTF-8">
        <META name="viewport" content="width=device-width, initial-scale=1.0">
        <title> $title </title>
        <link rel="stylesheet" href="https://unpkg.com/spectre.css/dist/spectre.min.css">
        <link rel="stylesheet" href="https://unpkg.com/spectre.css/dist/spectre-icons.min.css">
        <style>
        </style>
        </head>
      <body>
        ${navBar().render()}
          <div style="margin: auto;">
            $content
          </div>
      <script src="https://unpkg.com/htmx.org@1.9.10" integrity="sha384-D1Kt99CQMDuVetoL1lrYwg5t+9QdHe7NLX/SoJYkXDFfX37iInKRy5xLSi8nO7UC" crossorigin="anonymous"></script>
      </body>
    </html>
  """;
}

RootPage basePage(List<Component> children) {
  Style style = Style(padding: "10px 10px 0 10px");
  return RootPage(title: "VTGM", elems: [Div(children: children, style: style)], customRoot: vtgmRoot);
}
