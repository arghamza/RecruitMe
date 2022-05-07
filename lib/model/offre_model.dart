class OffreModel {
 

   String? recruiteruid;
  String? titre;
  String? entreprise;
  String? poste;
  String? domaine;
  String? details;
  List<String>? competences;

  OffreModel(
      {
      this.recruiteruid ,
      this.titre,
      this.entreprise,
      this.domaine,
      this.poste,
      this.details,
      this.competences});
  //data from server
  factory OffreModel.fromMap(map) {
    return OffreModel(

     
      recruiteruid: map["recruiteruid"],
      titre: map["titre"],
      entreprise: map["entreprise"],
      poste: map["poste"],
      domaine: map["domaine"],
      details: map["details"],
      competences: map["competences"],
    );
  }
  //sending data to our server
  Map<String, dynamic> toMap() {
    return {

      
      'recruiteruid' : recruiteruid , 
      'titre': titre,
      'entreprise': entreprise,
      'poste': poste,
      'domaine': domaine,
      'details': details,
      'competences': competences

    };
  }
}
