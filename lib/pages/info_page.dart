import 'package:ssr/html.dart';
import 'package:ssr/ssr.dart';
import 'package:vtgm/dataproviders/info_message_repository.dart';
import 'package:vtgm/dataproviders/team_fund_repository.dart';
import 'package:vtgm/domain/info_messages.dart';
import 'package:vtgm/domain/team_fund.dart';
import 'package:vtgm/endpoints.dart';
import 'package:vtgm/pages/component/base_page.dart';

String componentTeamFundContentEditable() {
  TeamFund teamFund = getTeamFund();
  String swapId = "mannschaftsKasseContainerId";
  return """
      <div id="$swapId" style="width: 100%;">
        <form hx-swap="none" hx-post="${Endpoints.apiFundSave.path}">
            <div style="display: flex; justify-content: space-between;">
                <h2>Mannschaftskasse: <input type="number" name="budget" value="${teamFund.currentBudget}"/> Euro</h2>
                <div style="display: flex; gap:5px;">
                  <input type="submit" value="Save" class="btn btn-success">
                  <button
                      class="btn btn-primary"
                      hx-get="${Endpoints.componentTeamFundContent.path}"
                      hx-target="#$swapId"
                      hx-swap="outerHTML"
                      ><i class="icon icon-cross"></i>
                  </button>
                </div>
            </div>
        </form>
      </div>
      """;
}

String componentTeamFundContent() {
  String swapId = "mannschaftsKasseContainerId";
  TeamFund teamFund = getTeamFund();
  AuthRole currentRole = getCurrentAuthorizedUserRole();
  if (currentRole == AuthRole.mod || currentRole == AuthRole.admin) {
    return """
      <div id="$swapId" style="display: flex; justify-content: space-between; width: 100%;">
          <h2>Mannschaftskasse: ${teamFund.currentBudget} Euro</h2>
          <button
            class="btn btn-primary"
            hx-get="${Endpoints.componentTeamFundContentEditable.path}"
            hx-swap="outerHTML"
            hx-target="#$swapId"
            ><i class="icon icon-edit"></i>
          </button>
      </div>
      """;
  } else {
    return """
          <h2>Mannschaftskasse: ${teamFund.currentBudget} Euro</h2>
      """;
  }
}

String infoPageMessageAddComponent() {
  String messageAddSwapId = "infoPageMessageAddPlaceholder";
  return """
      <div id="$messageAddSwapId">
          <div class="tile">
            <div class="tile-icon">
                <figure class="avatar avatar-lg" data-initial="i"></figure>
            </div>
            <div class="tile-content">
                <p class="tile-title text-large"> New Info Message </p>
                <textarea class="form-input" name="messagetext" rows="5" cols="60" placeholder="New message here..."></textarea>
            </div>
            <div class="tile-action">
                <button class="btn btn-success">Save</button>
            </div>
          </div>
      </div>
          """;
}

String infoPageHeadingComponent() {
  String messageAddSwapId = "infoPageMessageAddPlaceholder";
  return """
      <div id="$messageAddSwapId" style="display: flex; justify-content: space-between;">
          <h2>Messages</h2>
          <button 
            hx-get="${Endpoints.componentInfoPageMessageAdd.path}"
            hx-target="#$messageAddSwapId"
            hx-swap="outerHTML"
            class="btn btn-action btn-primary btn-lg s-circle">
              <i class="icon icon-plus"></i>
          </button>
      </div>
          """;
}

void infoPage(SsrRequest request, SsrResponse response) {
  InfoMessages messages = getInfoMessages();
  RootPage page = basePage("""
      <h1>Infos</h1>
      ${componentTeamFundContent()}
      ${infoPageHeadingComponent()}
      ${messages.infoMessages.map((it) => """
          <div class="tile">
            <div class="tile-icon">
              <i class="icon icon-file centered"></i>
            </div>
            <div class="tile-content">
              <p class="tile-title">Message from ${it.reportDate}</p>
              <p class="tile-subtitle">${it.message}</p>
            </div>
          </div>
          """).join()}
      """);
  okHtmlResponse(response, page);
}
