enum Endpoints {
  home("/"),
  infoPage("/info"),
  rolesOverview("/roles"),
  rolesEdit("/roles/edit"),
  personAdministration("/person/administration"),
  apiPersonUpdate("/api/person/update"),
  apiPersonAdd("/api/person/add"),
  apiPersonDelete("/api/person/delete"),
  apiRoleAdd("/api/roles/edit/add"),
  apiRoleDelete("/api/roles/edit/delete"),
  apiFundSave("/api/fund/save"),
  apiInfoMessageAdd("/api/infomessage/add"),
  componentEditableOverview("/api/component/overview/editable"),
  componentOverview("/api/component/overview"),
  componentTeamFundContent("/api/component/teamfund"),
  componentTeamFundContentEditable("/api/component/teamfund/editable"),
  componentInfoPageMessageAdd("/api/component/message/add"),
  componentInfoPageHeading("/api/component/infopage/heading");

  const Endpoints(this.path);
  final String path;
}
