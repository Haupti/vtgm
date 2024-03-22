class InfoMessage {
    String message;
    String reportDate;

    InfoMessage({required this.message, required this.reportDate});

    Map<String, dynamic> toJson() {
      return {
        "message": message,
        "reportDate": reportDate,
      };
    }

    static InfoMessage fromJson(Map<String, dynamic> jsonNode) {
      return InfoMessage(
        message: jsonNode["message"],
        reportDate: jsonNode["reportDate"],
      );
    }
}

class InfoMessages {
    List<InfoMessage> infoMessages;

    InfoMessages({required this.infoMessages});
}
