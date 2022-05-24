class ApplicantModel {
  String? useruid;
  String? domaine;
  String? poste;
  String? entreprise;
  int? expYears;
  String? linkedin;
  String? cv;

  ApplicantModel(
      {this.useruid,
      this.domaine,
      this.poste,
      this.entreprise,
      this.expYears,
      this.linkedin,
      this.cv});
  //data from server
  factory ApplicantModel.fromMap(map) {
    return ApplicantModel(
      useruid: map["useruid"],
      domaine: map["domaine"],
      poste: map["poste"],
      entreprise: map["entreprise"],
      expYears: map["expYears"],
      linkedin: map["linkedin"],
      cv: map["cv"],
    );
  }
  //sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'useruid': useruid,
      'domaine': domaine,
      'poste': poste,
      'entreprise': entreprise,
      'expYears': expYears,
      'linkedin': linkedin,
      'cv': cv
    };
  }
}
