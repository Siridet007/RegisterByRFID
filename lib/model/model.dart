// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this
import 'dart:convert';
class PersonnalRegister {
  String? personId;
  String? code;

  PersonnalRegister({this.personId, this.code});

  PersonnalRegister.fromJson(Map<String, dynamic> json) {
    personId = json['person_id'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['person_id'] = this.personId;
    data['code'] = this.code;
    return data;
  }

  static List<PersonnalRegister>? fromJsonList(List list) {
    //if (list == null) return null;
    return list.map((item) => PersonnalRegister.fromJson(item)).toList();
  }
}

//List<ListRegister> registerListFromJson(String str) => List<ListRegister>.from(json.decode(str).map((x) => ListRegister.fromJson(x)));

//String registerListToJson(List<ListRegister> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListRegister {
  String? personId;
  String? code;
  String? name;
  String? nickname;
  String? nameT;
  String? lNameT;
  String? nameE;
  String? lNameE;
  String? nicknameE;
  String? flagwork;
  String? position;
  String? prefix;
  String? startwork;
  String? pOSICODE;
  String? sectionCode;
  String? serviceName;
  String? company;
  String? doctime;
  String? doctime1;

  ListRegister(
      {this.personId,
      this.code,
      this.name,
      this.nickname,
      this.nameT,
      this.lNameT,
      this.nameE,
      this.lNameE,
      this.nicknameE,
      this.flagwork,
      this.position,
      this.prefix,
      this.startwork,
      this.pOSICODE,
      this.sectionCode,
      this.serviceName,
      this.company,
      this.doctime,
      this.doctime1});

  ListRegister.fromJson(Map<String, dynamic> json) {
    personId = json['person_id'];
    code = json['code'];
    name = json['name'];
    nickname = json['nickname'];
    nameT = json['Name_T'];
    lNameT = json['LName_T'];
    nameE = json['Name_E'];
    lNameE = json['LName_E'];
    nicknameE = json['Nickname_E'];
    flagwork = json['Flagwork'];
    position = json['Position'];
    prefix = json['Prefix'];
    startwork = json['Startwork'];
    pOSICODE = json['POSI_CODE'];
    sectionCode = json['section_code'];
    serviceName = json['Service_Name'];
    company = json['company'];
    doctime = json['doctime'];
    doctime1 = json['doctime1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['person_id'] = this.personId;
    data['code'] = this.code;
    data['name'] = this.name;
    data['nickname'] = this.nickname;
    data['Name_T'] = this.nameT;
    data['LName_T'] = this.lNameT;
    data['Name_E'] = this.nameE;
    data['LName_E'] = this.lNameE;
    data['Nickname_E'] = this.nicknameE;
    data['Flagwork'] = this.flagwork;
    data['Position'] = this.position;
    data['Prefix'] = this.prefix;
    data['Startwork'] = this.startwork;
    data['POSI_CODE'] = this.pOSICODE;
    data['section_code'] = this.sectionCode;
    data['Service_Name'] = this.serviceName;
    data['company'] = this.company;
    data['doctime'] = this.doctime;
    data['doctime1'] = this.doctime1;
    return data;
  }

  static List<ListRegister>? fromJsonList(List list) {
    //if (list == null) return null;
    return list.map((item) => ListRegister.fromJson(item)).toList();
  }
}

class SerchByCard {
  String? personId;
  String? code;
  String? name;
  String? nickname;
  String? nameT;
  String? lNameT;
  String? nameE;
  String? lNameE;
  String? nicknameE;
  String? flagwork;
  String? position;
  String? prefix;
  String? startwork;
  String? pOSICODE;
  String? sectionCode;
  String? serviceName;
  String? company;

  SerchByCard(
      {this.personId,
      this.code,
      this.name,
      this.nickname,
      this.nameT,
      this.lNameT,
      this.nameE,
      this.lNameE,
      this.nicknameE,
      this.flagwork,
      this.position,
      this.prefix,
      this.startwork,
      this.pOSICODE,
      this.sectionCode,
      this.serviceName,
      this.company});

  SerchByCard.fromJson(Map<String, dynamic> json) {
    personId = json['person_id'];
    code = json['code'];
    name = json['name'];
    nickname = json['nickname'];
    nameT = json['Name_T'];
    lNameT = json['LName_T'];
    nameE = json['Name_E'];
    lNameE = json['LName_E'];
    nicknameE = json['Nickname_E'];
    flagwork = json['Flagwork'];
    position = json['Position'];
    prefix = json['Prefix'];
    startwork = json['Startwork'];
    pOSICODE = json['POSI_CODE'];
    sectionCode = json['section_code'];
    serviceName = json['Service_Name'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['person_id'] = this.personId;
    data['code'] = this.code;
    data['name'] = this.name;
    data['nickname'] = this.nickname;
    data['Name_T'] = this.nameT;
    data['LName_T'] = this.lNameT;
    data['Name_E'] = this.nameE;
    data['LName_E'] = this.lNameE;
    data['Nickname_E'] = this.nicknameE;
    data['Flagwork'] = this.flagwork;
    data['Position'] = this.position;
    data['Prefix'] = this.prefix;
    data['Startwork'] = this.startwork;
    data['POSI_CODE'] = this.pOSICODE;
    data['section_code'] = this.sectionCode;
    data['Service_Name'] = this.serviceName;
    data['company'] = this.company;
    return data;
  }

  static List<SerchByCard>? fromJsonList(List list) {
    //if (list == null) return null;
    return list.map((item) => SerchByCard.fromJson(item)).toList();
  }
}

class SerchByCardNew {
  String? personId;
  String? code;
  String? name;
  String? pName;
  String? deptName;
  String? startWork;
  String? age;
  String? flagWork;
  String? deptCode;
  String? nickName;

  SerchByCardNew(
      {this.personId,
      this.code,
      this.name,
      this.pName,
      this.deptName,
      this.startWork,
      this.age,
      this.flagWork,
      this.deptCode,
      this.nickName});

  SerchByCardNew.fromJson(Map<String, dynamic> json) {
    personId = json['person_id'];
    code = json['Code'];
    name = json['name'];
    pName = json['P_Name'];
    deptName = json['DeptName'];
    startWork = json['StartWork'];
    age = json['Age'];
    flagWork = json['FlagWork'];
    deptCode = json['DeptCode'];
    nickName = json['NickName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['person_id'] = this.personId;
    data['Code'] = this.code;
    data['name'] = this.name;
    data['P_Name'] = this.pName;
    data['DeptName'] = this.deptName;
    data['StartWork'] = this.startWork;
    data['Age'] = this.age;
    data['FlagWork'] = this.flagWork;
    data['DeptCode'] = this.deptCode;
    data['NickName'] = this.nickName;
    return data;
  }

  static List<SerchByCardNew>? fromJsonList(List list) {
    //if (list == null) return null;
    return list.map((item) => SerchByCardNew.fromJson(item)).toList();
  }
}
