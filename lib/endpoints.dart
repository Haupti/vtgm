enum Endpoints {
  home("/"),
  rolesOverview("/roles"),
  rolesEdit("/roles/edit"),
  personAdd("/person/add"),
  personManager("/person/update"),
  personDelete("/person/delete"),
  personAdministration("/person/administration"),
  apiPersonUpdate("/api/person/update"),
  apiPersonAdd("/api/person/add"),
  apiPersonCheckUpdate("/api/person/check"),
  apiPersonDelaysUpdate("/api/person/delays"),
  apiPersonDelete("/api/person/delete"),
  apiRoleAdd("/api/roles/edit/add"),
  apiRoleDelete("/api/roles/edit/delete"),
  componentEditableOverview("/api/component/overview/editable"),
  componentOverview("/api/component/overview");

  const Endpoints(this.path);
  final String path;
}
