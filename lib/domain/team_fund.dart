class TeamFund {
    int currentBudget;
    TeamFund({required this.currentBudget});

  Map<String, dynamic> toJson() {
    return {
      "currentBudget": currentBudget,
    };
  }

  static TeamFund fromJson(Map<String, dynamic> jsonNode) {
    return TeamFund(
      currentBudget: jsonNode["currentBudget"],
    );
  }
}

