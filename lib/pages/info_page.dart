import 'package:ssr/html.dart';
import 'package:ssr/ssr.dart';
import 'package:vtgm/dataproviders/info_message_repository.dart';
import 'package:vtgm/dataproviders/team_fund_repository.dart';
import 'package:vtgm/domain/info_messages.dart';
import 'package:vtgm/domain/team_fund.dart';
import 'package:vtgm/pages/component/base_page.dart';

void infoPage(SsrRequest request, SsrResponse response) {
  TeamFund teamFund = getTeamFund();
  InfoMessages messages = getInfoMessages();
  RootPage page = basePage("""
      <h1>Infos</h1>
      <h2>Mannschaftskasse: ${teamFund.currentBudget} Euro</h2>
      <div>
      <h2>Messages</h2>
      ${messages.infoMessages.map((it)=> """
          <div>
            <p style="font-size: 16px; font-weight: bold;">Message from ${it.reportDate}</p>
            <p>${it.message}</p>
          </div>
          """).join()}
      </div>

      """);
  okHtmlResponse(response, page);
}
