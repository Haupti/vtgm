import 'dart:io';
import "dart:convert";

import 'package:vtgm/domain/responsibility.dart';

File responsibilitiesFile = File("data/responsibilities.json");

List<Responsibility> getResponsibilities(){
  if(!responsibilitiesFile.existsSync()){
    return [];
  }
  String jsonArrayString = responsibilitiesFile.readAsStringSync();
  if(jsonArrayString.isEmpty){
    return [];
  }
  List<dynamic> jsonTodos = jsonDecode(jsonArrayString);

  List<Responsibility> responsibilities = [];
  for(final jsonTodo in jsonTodos){
    try{
      responsibilities.add(Responsibility.fromJson(jsonTodo) );
    } catch(e) {
      print("ERROR: could not read from file: $e");
      exit(1);
    }
  }
  return responsibilities;
}

void saveResponsibilities(List<Responsibility> responsibilities){
  if(!responsibilitiesFile.existsSync()){
    responsibilitiesFile.createSync(recursive: true);
  }
  String jsonArrayString = jsonEncode(responsibilities);
  responsibilitiesFile.writeAsStringSync(jsonArrayString);
}
