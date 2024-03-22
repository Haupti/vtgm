
import 'package:ssr/html.dart';
import 'package:ssr/ssr.dart';
import 'package:vtgm/pages/component/base_page.dart';

void infoPage(SsrRequest request, SsrResponse response) {
  RootPage page = basePage(""" """) ;
  okHtmlResponse(response, page);
}
