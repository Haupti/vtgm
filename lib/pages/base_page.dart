import 'package:vtgm/ssr/http/auth.dart';

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

  var home =  Anchor(href:"/",text:"home", style: aStyle);
  var personCheck =  Anchor(href:"/person/update",text:"manage", style: aStyle);
  var personDelete =  Anchor(href:"/person/delete",text:"delete person", style: aStyle);
  var personAdd =  Anchor(href:"/person/add",text:"add person", style: aStyle);
  AuthRole currentRole = getCurrentAuthorizedUserRole();
  var visibleAnchors = [];
  if(currentRole == AuthRole.basic){
    visibleAnchors = [home];
  } else if( currentRole == AuthRole.mod){
    visibleAnchors = [home, personCheck];
  } else if( currentRole == AuthRole.admin){
    visibleAnchors = [home, personCheck, personDelete, personAdd];
  }
  return Div(children: [
    Paragraph(text: "H5 TGM VB"),
    ...visibleAnchors
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
