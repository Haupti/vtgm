import 'dart:convert';

String prettyDateNow() {
  final now = DateTime.now();
  return "${now.day}.${now.month}.${now.year}, ${now.hour}:${now.minute}";
}

String convertUserText(String text) {
  return HtmlEscape().convert(text).replaceAll("\n", "<br>");
}
