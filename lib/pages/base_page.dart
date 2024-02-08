import '../ssr/component.dart';
import '../ssr/root_page.dart';

Component navBar() {
  return Div(children: [
    Anchor(href:"/",text:"home"),
    Anchor(href:"/person/add",text:"add person"),
  ], style: Style(display: "flex", gap: "10px"));
}

RootPage basePage(List<Component> children){
  return RootPage([
    navBar(),
    ...children
  ]);
}
