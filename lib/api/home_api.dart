import 'package:ssr/ssr.dart';
import 'package:vtgm/pages/home_page.dart';

void editableOverviewTableHandler(SsrRequest request, SsrResponse response){
    response.setStatus(200);
    response.write(editableOverviewTableComponent());
}

void overviewTableHandler(SsrRequest request, SsrResponse response){
    response.setStatus(200);
    response.write(overviewTableComponent());
}
