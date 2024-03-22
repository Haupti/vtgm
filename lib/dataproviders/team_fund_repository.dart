import 'dart:io';
import "dart:convert";

import 'package:vtgm/domain/team_fund.dart';

File teamFundFile = File("data/team_fund.json");

TeamFund getTeamFund(){
  if(!teamFundFile.existsSync()){
    return TeamFund(currentBudget: 0);
  }
  String jsonArrayString = teamFundFile.readAsStringSync();
  if(jsonArrayString.isEmpty){
    return TeamFund(currentBudget: 0);
  }

  dynamic jsonTeamFund = jsonDecode(jsonArrayString);
  final teamFund = TeamFund.fromJson(jsonTeamFund);
  return teamFund;
}

void saveTeamFund(TeamFund responsibilities){
  if(!teamFundFile.existsSync()){
    teamFundFile.createSync(recursive: true);
  }
  String jsonArrayString = jsonEncode(responsibilities);
  teamFundFile.writeAsStringSync(jsonArrayString);
}
