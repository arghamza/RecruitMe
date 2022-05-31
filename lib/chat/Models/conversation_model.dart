class ConversationModel {
  String id;
  String applicantId;
  String applicantFullName;
  String applicantImg;
  String recruiterId;
  String recruiterFullName;
  String recruiterImg;
  String lastText;

  ConversationModel(
      {required this.id,
      required this.applicantId,
      required this.applicantFullName,
      this.applicantImg = '',
      required this.recruiterId,
      required this.recruiterFullName,
      this.recruiterImg = '',
      required this.lastText});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'recruiterId': recruiterId,
      'recruiterFullName': recruiterFullName,
      'applicantId': applicantId,
      'applicantFullName': applicantFullName,
      'lastText': lastText,
    };
  }
}
