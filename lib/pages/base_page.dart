import '../ssr/component.dart';
import '../ssr/root_page.dart';

Component navBar() {
  return Div(children: [
    Anchor(href:"/",text:"home"),
    Anchor(href:"/person/add",text:"add person"),
    Anchor(href:"/person/check",text:"check person"),
    Anchor(href:"/person/delete",text:"delete person"),
  ], style: Style(display: "flex", gap: "10px"));
}

RootPage basePage(List<Component> children){
  return RootPage([
    navBar(),
    ...children
  ]);
}
