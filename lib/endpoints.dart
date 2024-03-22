enum Endpoints {
  home("/"),
  rolesOverview("/roles"),
  rolesEdit("/roles/edit"),
  personAdministration("/person/administration"),
  apiPersonUpdate("/api/person/update"),
  apiPersonAdd("/api/person/add"),
  apiPersonDelete("/api/person/delete"),
  apiRoleAdd("/api/roles/edit/add"),
  apiRoleDelete("/api/roles/edit/delete"),
  componentEditableOverview("/api/component/overview/editable"),
  componentOverview("/api/component/overview");

  const Endpoints(this.path);
  final String path;
}
