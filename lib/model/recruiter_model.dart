

class RecruiterModel {
  String? useruid;
  String? linkedin;
  String? entreprise;
  String? poste;
  List<String>? offres;

  RecruiterModel(
      {this.useruid, this.entreprise, this.poste, this.linkedin, this.offres});
  //data from server
  factory RecruiterModel.fromMap(map) {
    return RecruiterModel(
        useruid: map["useruid"],
        linkedin: map["linkedin"],
        entreprise: map["entreprise"],
        poste: map["poste"],
        offres: map["offres"]);
  }
  //sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'useruid': useruid,
      'linkedin': linkedin,
      'entreprise': entreprise,
      'poste': poste,
      'offres': offres
    };
  }
}
