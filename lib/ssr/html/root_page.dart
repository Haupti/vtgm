import 'component.dart';

String root(String content){
  return """
    <!DOCTYPE HTML>
    <html lang="en">
      <head>
        <META charset="UTF-8">
        <META name="viewport" content="width=device-width, initial-scale=1.0">
        <title> VTGM </title>
        <style>
          @import url('https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap');
          * {
            color: #2e2e2e;
            font-family: 'Roboto', sans-serif;
            font-weight: 400;
            font-style: normal;
          }
        </style>
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
