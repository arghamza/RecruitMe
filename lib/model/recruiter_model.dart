class RecruiterModel {
  String? useruid;
  String? linkedin;
  String? entreprise;
  String? poste;

  RecruiterModel(
      {this.useruid = '',
      this.entreprise = '',
      this.poste = '',
      this.linkedin = ''});
  //data from server
  factory RecruiterModel.fromMap(map) {
    return RecruiterModel(
        useruid: map["useruid"],
        linkedin: map["linkedin"],
        entreprise: map["entreprise"],
        poste: map["poste"]);
  }
  //sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'useruid': useruid,
      'linkedin': linkedin,
      'entreprise': entreprise,
      'poste': poste,
    };
  }
}
