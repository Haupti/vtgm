import 'dart:convert';
import 'dart:io';

import 'package:vtgm/domain/info_messages.dart';

File infoMessagesFile = File("data/info_messages.json");

InfoMessages getInfoMessages() {
  if (!infoMessagesFile.existsSync()) {
    return InfoMessages(infoMessages: []);
  }
  String jsonArrayString = infoMessagesFile.readAsStringSync();
  if (jsonArrayString.isEmpty) {
    return InfoMessages(infoMessages: []);
  }
  List<dynamic> jsonMessages = jsonDecode(jsonArrayString);

  List<InfoMessage> infoMessages = [];
  for (final jsonTodo in jsonMessages) {
    try {
      infoMessages.add(InfoMessage.fromJson(jsonTodo));
    } catch (e) {
      print("ERROR: could not read from file: $e");
      exit(1);
    }
  }
  return InfoMessages(infoMessages: infoMessages);
}

void saveInfoMessages(InfoMessages infoMessages) {
  if (!infoMessagesFile.existsSync()) {
    infoMessagesFile.createSync(recursive: true);
  }
  String jsonArrayString = jsonEncode(infoMessages.infoMessages);
  infoMessagesFile.writeAsStringSync(jsonArrayString);
}
