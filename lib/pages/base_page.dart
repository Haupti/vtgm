import 'package:ssr/ssr.dart';
import 'package:ssr/html.dart';

Component navBar() {
  var brand = Component.fromHtmlString("""<a href="/" class="navbar-brand mr-2">TGM H5</a>""");
  var overview = Component.fromHtmlString("""<a href="/" class="btn btn-link">overview</a>""");
  var personCheck = Component.fromHtmlString("""<a href="/person/update" class="btn btn-link">manager</a>""");
  var personDelete = Component.fromHtmlString("""<a href="/person/delete" class="btn btn-link">delete member</a>""");
  var personAdd = Component.fromHtmlString("""<a href="/person/add" class="btn btn-link">add member</a>""");
  AuthRole currentRole = getCurrentAuthorizedUserRole();
  List<Component> visibleAnchors = [];
  if (currentRole == AuthRole.basic) {
    visibleAnchors = [brand, overview];
  } else if (currentRole == AuthRole.mod) {
    visibleAnchors = [brand, overview, personCheck];
  } else if (currentRole == AuthRole.admin) {
    visibleAnchors = [brand, overview, personCheck, personDelete, personAdd];
  }
  return Component.fromHtmlString("""
  <header class="navbar" style="padding: 16px 16px 0 16px;">
    <section class="navbar-section">
      ${renderMany(visibleAnchors)}
    </section>
  </header>
  <div class="divider"></div>
  """);
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
          <div>
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
