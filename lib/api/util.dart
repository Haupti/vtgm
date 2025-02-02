String prettyDateNow() {
  final now = DateTime.now();
  return "${now.day}.${now.month}.${now.year}, ${now.hour}:${now.minute}";
}
