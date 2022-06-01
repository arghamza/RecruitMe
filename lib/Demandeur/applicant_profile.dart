import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_type_screen/Demandeur/add_info_screen.dart';
import 'package:user_type_screen/model/user_model.dart';

import '../widget/project_app_bar_basic.dart';
import '../widget/rich_text_line.dart';

class ApplicantProfile extends StatefulWidget {
  const ApplicantProfile({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  State<ApplicantProfile> createState() => _ApplicantProfileState();
}

class _ApplicantProfileState extends State<ApplicantProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: projectAppBarBasic(context),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Profile :",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                )),
            const SizedBox(
              height: 10.0,
            ),
            Flexible(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xff35ddaa), width: 5),
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage: widget.user.img == ""
                                  ? const AssetImage("images/avatar.png")
                                  : Image.network(
                                      widget.user.img.toString(),
                                    ).image,
                              minRadius: 30,
                              maxRadius: 60,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              '${widget.user.FirstName} ${widget.user.SecondName}',
                              style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      letterSpacing: .5,
                                      fontSize: 25),
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                children: [
                                  RichTextLine(
                                    text: "${widget.user.email}",
                                    title: 'Email :  ',
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  RichTextLine(
                                    text: widget.user.details!["expYears"]
                                        .toString(),
                                    title: 'Années d\'expérience :  ',
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  RichTextLine(
                                    text: "${widget.user.details!["domaine"]}",
                                    title: 'Domaine :  ',
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  RichTextLine(
                                    text: "${widget.user.details!["poste"]}",
                                    title: 'Poste actuel :  ',
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  RichTextLine(
                                    text: getCompetences(
                                        widget.user.details!["competences"]),
                                    title: 'Compétences :  ',
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ApplicantInfo(
                                                      entreprise:
                                                          widget.user.details![
                                                              "entreprise"],
                                                      domaine: widget.user
                                                          .details!["domaine"],
                                                      poste: widget.user
                                                          .details!["poste"],
                                                      linkedin: widget.user
                                                          .details!["linkedin"],
                                                      expYears: widget.user
                                                          .details!["expYears"]
                                                          .toString(),
                                                      competence:
                                                          widget.user.details![
                                                              "competences"],
                                                      url: widget.user.img,
                                                    )));
                                      },
                                      child: const Icon(
                                        Icons.edit,
                                        color: Color(0xff35ddaa),
                                        size: 40,
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getCompetences(List<dynamic>? list) {
    String cpts = "\n";
    for (String word in list!) {
      cpts += word + " \n ";
    }
    return cpts;
  }
}
