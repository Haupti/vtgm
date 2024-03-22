enum Endpoints {
  home("/"),
  rolesOverview("/roles"),
  rolesEdit("/roles/set"),
  personAdd("/person/add"),
  personManager("/person/update"),
  personDelete("/person/delete"),
  apiPersonAdd("/person/add"),
  apiPersonCheckUpdate("/person/check"),
  apiPersonDelaysUpdate("/person/delays"),
  apiRolesEditAdd("/roles/set/add"),
  apiPersonDelete("/person/delete");

  const Endpoints(this.path);
  final String path;
}
