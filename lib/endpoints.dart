enum Endpoints {
  home("/"),
  rolesOverview("/roles"),
  rolesEdit("/roles/edit"),
  personAdd("/person/add"),
  personManager("/person/update"),
  personDelete("/person/delete"),
  personAdministration("/person/administration"),
  apiPersonAdd("/person/add"),
  apiPersonCheckUpdate("/person/check"),
  apiPersonDelaysUpdate("/person/delays"),
  apiPersonDelete("/person/delete"),
  apiRoleAdd("/roles/edit/add"),
  apiRoleDelete("/roles/edit/delete");

  const Endpoints(this.path);
  final String path;
}
