import '../ssr/html/component.dart';
import '../ssr/html/root_page.dart';
import '../ssr/html/style.dart';

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
  return Div(children: [
    Paragraph(text: "H5 TGM VB"),
    Anchor(href:"/",text:"home", style: aStyle),
    Anchor(href:"/person/add",text:"add person", style: aStyle),
    Anchor(href:"/person/check",text:"check person", style: aStyle),
    Anchor(href:"/person/delete",text:"delete person", style: aStyle),
  ], style: wrapperStyle);
}

RootPage basePage(List<Component> children){
  Style style = Style(
    padding: "10px 10px 0 10px"
  );
  return RootPage([
    navBar(),
    Div(children: children, style: style)
  ]);
}
