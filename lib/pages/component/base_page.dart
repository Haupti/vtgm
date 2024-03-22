import 'package:ssr/html.dart';
import 'package:vtgm/pages/component/navbar.dart';


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

RootPage basePage(String mainSection) {
  Style style = Style(padding: "10px 10px 0 10px");
  return RootPage(title: "VTGM", elems: [Div(children: [sectionMain(mainSection)], style: style)], customRoot: vtgmRoot);
}

Component sectionMain(String content){
    return Component.fromHtmlString("""
      <div style="max-width: 1000px; margin: auto;">
          $content
      </div>
    """);
}
