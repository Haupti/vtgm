String prettyDateNow() {
  final now = DateTime.now();
  return "${now.day}.${now.month}.${now.year}, ${now.hour}:${now.minute}";
}

String urlDecode(String urlEncodedString) {
  return urlEncodedString
      .replaceAll("%20", " ")
      .replaceAll("%21", "!")
      .replaceAll("%22", '"')
      .replaceAll("%23", "#")
      .replaceAll("%24", "\$")
      .replaceAll("%25", "%")
      .replaceAll("%26", "&")
      .replaceAll("%27", "'")
      .replaceAll("%28", "(")
      .replaceAll("%29", ")")
      .replaceAll("%2A", "*")
      .replaceAll("%2B", "+")
      .replaceAll("%2C", ",")
      .replaceAll("%2D", "-")
      .replaceAll("%2E", ".")
      .replaceAll("%2F", "/")
      .replaceAll("%3A", ":")
      .replaceAll("%3B", ";")
      .replaceAll("%3C", "<")
      .replaceAll("%3D", "=")
      .replaceAll("%3E", ">")
      .replaceAll("%3F", "?")
      .replaceAll("%40", "@")
      .replaceAll("%5B", "[")
      .replaceAll("%5C", "\\")
      .replaceAll("%5D", "]")
      .replaceAll("%5E", "^")
      .replaceAll("%60", '`');
}
