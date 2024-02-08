import "component.dart";

String root(String content){
  return """
    <!DOCTYPE HTML>
    <html lang="en">
      <head>
        <META charset="UTF-8">
        <META name="viewport" content="width=device-width, initial-scale=1.0">
        <title> VTGM </title>
      </head>
      <body>
        $content
      </body>
    </html>
  """;
}

class RootPage {
  List<Component> elems;
  RootPage(this.elems);
  String renderPage(){
    return root(renderMany(elems));
  }
}
