import 'dart:convert';

import 'package:ssr/html.dart';
import 'package:ssr/ssr.dart';
import 'package:vtgm/api/util.dart';
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
      <div id="$swapId" style="margin-bottom: 20px;">
        <form hx-swap="none" hx-post="${Endpoints.apiFundSave.path}">
            <div style="display: flex, flex-wrap: wrap; justify-content: space-between;">
                <p class="text-large text-bold">Budget: <input type="number" min="-999" max="999" name="budget" value="${teamFund.currentBudget}"/> Euro</p>
                <div style="display: flex; gap:5px; justify-content: flex-end;">
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
          <p class="text-large text-bold">Budget: ${teamFund.currentBudget} Euro</p>
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
          <p class="text-large text-bold">Budget: ${teamFund.currentBudget} Euro</p>
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
              <p class="tile-subtitle">${convertUserText(message.message)}</p>
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
      <div id="$messageAddSwapId" style="margin: 0 0 20px 0; float: right;">
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
      <div style="display: flex; flex-wrap; align-items: baseline; justify-content: space-between;">
          <h1>Infos</h1>
          ${componentTeamFundContent()}
      </div>
      <div style="display: flex;">
        <div>
            ${infoPageHeadingComponent()}
            ${messages.infoMessages.reversed.map(infoMessageComponent).join()}
        </div>
      </div>
      """);
  okHtmlResponse(response, page);
}
