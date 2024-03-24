import 'package:ssr/ssr.dart';
import 'package:vtgm/api/parse_form_post.dart';
import 'package:vtgm/api/util.dart';
import 'package:vtgm/dataproviders/info_message_repository.dart';
import 'package:vtgm/dataproviders/team_fund_repository.dart';
import 'package:vtgm/domain/info_messages.dart';
import 'package:vtgm/domain/team_fund.dart';
import 'package:vtgm/pages/info_page.dart';

void componentTeamFundContentHandler(SsrRequest request, SsrResponse response) {
  response.setStatus(200);
  response.write(componentTeamFundContent());
}

void componentInfoPageMessageAdd(SsrRequest request, SsrResponse response) {
  response.setStatus(200);
  response.write(infoPageMessageAddComponent());
}

void componentInfoPageHeading(SsrRequest request, SsrResponse response) {
  response.setStatus(200);
  response.write(infoPageHeadingComponent());
}

void componentTeamFundContentEditableHandler(
    SsrRequest request, SsrResponse response) {
  response.setStatus(200);
  response.write(componentTeamFundContentEditable());
}

void apiInfoMessageAdd(SsrRequest request, SsrResponse response) async {
  Map<String, String> params = await parseFormData(request);
  String? messagetext = params["messagetext"];
  if (messagetext == "" || messagetext == null) {
    response.setStatus(400);
    response.close();
    return;
  }
  InfoMessages messages = getInfoMessages();
  InfoMessage newMessage =
      InfoMessage(message: urlDecode(messagetext), reportDate: prettyDateNow());
  messages.infoMessages.add(newMessage);
  saveInfoMessages(messages);
  response.setStatus(200);
  response.write(infoPageHeadingWithNewMessageComponent(newMessage));
}

void apiFundSaveEndpoint(SsrRequest request, SsrResponse response) async {
  Map<String, String> params = await parseFormData(request);

  String? fund = params["budget"];
  if (fund == null || fund == "") {
    response.setStatus(400);
    response.close();
    return;
  }

  TeamFund teamFund = getTeamFund();
  teamFund.currentBudget = int.parse(fund);
  saveTeamFund(teamFund);
  response.setStatus(200);
  response.close();
}
