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
                <h2>Budget: <input type="number" name="budget" value="${teamFund.currentBudget}"/> Euro</h2>
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
      <div id="$swapId" style="display: flex; gap: 10px;">
          <h2>Budget: ${teamFund.currentBudget} Euro</h2>
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
          <h2>Budget: ${teamFund.currentBudget} Euro</h2>
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
                <button
                    class="btn btn-success"
                    hx-post="${Endpoints.apiInfoMessageAdd.path}"
                    hx-swap="outerHTML"
                    hx-target="#$messageAddSwapId"
                    hx-include="[name='messagetext']"
                    >Save
                </button>
                <button
                    class="btn btn-primary"
                    hx-get="${Endpoints.componentInfoPageHeading.path}"
                    hx-swap="outerHTML"
                    hx-target="#$messageAddSwapId"
                    ><i class="icon icon-cross"></i>
                </button>
            </div>
          </div>
      </div>
          """;
}

String infoMessageComponent(InfoMessage message) {
  return """
          <div class="tile">
            <div class="tile-icon">
                <figure class="avatar avatar-lg" data-initial="i"></figure>
            </div>
            <div class="tile-content">
              <p class="tile-title text-large text-bold">Info ${message.reportDate}</p>
              <p class="tile-subtitle">${message.message}</p>
            </div>
          </div>
          """;
}

String infoPageHeadingWithNewMessageComponent(InfoMessage message) {
  return [infoPageHeadingComponent(), infoMessageComponent(message)].join();
}

String infoPageHeadingComponent() {
  String messageAddSwapId = "infoPageMessageAddPlaceholder";
  return """
      <div id="$messageAddSwapId" style="margin: 0 0 20px 0;">
          <button
            hx-get="${Endpoints.componentInfoPageMessageAdd.path}"
            hx-target="#$messageAddSwapId"
            hx-swap="outerHTML"
            class="btn btn-primary">
            New Info
          </button>
      </div>
          """;
}

void infoPage(SsrRequest request, SsrResponse response) {
  InfoMessages messages = getInfoMessages();
  RootPage page = basePage("""
      <h1>Infos</h1>
      <div style="display: flex; width: 100%;">
        <div style="width: 70%;">
            ${infoPageHeadingComponent()}
            ${messages.infoMessages.reversed.map(infoMessageComponent).join()}
        </div>
      ${componentTeamFundContent()}
      </div>
      """);
  okHtmlResponse(response, page);
}
