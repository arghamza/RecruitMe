class OffreModel {
  String? useruid;
  String? titre;
  String? entreprise;
  String? poste;
  String? domaine;
  String? details;
  List<dynamic>? competences;
  String? offerId;

  OffreModel(
      {this.useruid,
      this.titre,
      this.entreprise,
      this.domaine,
      this.poste,
      this.details,
      this.competences,
      this.offerId});
  //data from server
  factory OffreModel.fromMap(map) {
    return OffreModel(
      useruid: map["useruid"],
      titre: map["titre"],
      entreprise: map["entreprise"],
      poste: map["poste"],
      domaine: map["domaine"],
      details: map["details"],
      competences: map["competences"],
      offerId: map["offerId"],
    );
  }
  //sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'useruid': useruid,
      'titre': titre,
      'entreprise': entreprise,
      'poste': poste,
      'domaine': domaine,
      'details': details,
      'competences': competences,
      'offerId': offerId
    };
  }
}
