import 'dart:io';
import '../ssr/http/response.dart';
import 'parse_form_post.dart';
import '../dataproviders/repository.dart';
import '../domain.dart';

void addPersonFormEndpoint(HttpRequest request, SsrResponse response) async {
  response.setStatus(301).setLocationHeader("/person/add");
  Map<String, String> params = await parseFormData(request);
  List<Person> persons = getPeople();
  String? name = params["name"];
  if(name == null){
    print("error: name parameter is required but not in request body");
    return;
  }
  persons.add(Person(name));
  savePeople(persons);
}

void checkPersonFormEndpoint(HttpRequest request, SsrResponse response) async {
  response.setStatus(301).setLocationHeader("/person/update");
  Map<String, String> params = await parseFormData(request);
  List<Person> persons = getPeople();
  for(var p in persons){
    if(params[p.name] == "on"){
      p.checked = true;
    } else if(params[p.name] == null){
      p.checked = false;
    }
  }
  savePeople(persons);
}

void deletePersonFormEndpoint(HttpRequest request, SsrResponse response) async {
  response.setStatus(301).setLocationHeader("/person/delete");
  Map<String, String> params = await parseFormData(request);
  List<Person> persons = getPeople();
  List<Person> filtered = [];
  for(var p in persons){
    if(params[p.name] != "on"){
      filtered.add(p);
    } 
  }
  savePeople(filtered);
}

void delaysPersonFormEndpoint(HttpRequest request, SsrResponse response) async {
  response.setStatus(301).setLocationHeader("/person/update");
  Map<String, String> params = await parseFormData(request);
  print(params);
  List<Person> persons = getPeople();
  for(var p in persons){
    int delays = int.parse(params["${p.name}-delays"] ?? "0");
    p.currentDelays = delays;
  }
  savePeople(persons);
}