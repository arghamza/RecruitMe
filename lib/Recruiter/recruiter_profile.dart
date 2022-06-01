import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_type_screen/Recruiter/Info_screen.dart';
import 'package:user_type_screen/model/user_model.dart';
import '../widget/project_app_bar_basic.dart';
import '../widget/rich_text_line.dart';

class RecruiterProfile extends StatefulWidget {
  const RecruiterProfile({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  State<RecruiterProfile> createState() => _RecruiterProfileState();
}

class _RecruiterProfileState extends State<RecruiterProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: projectAppBarBasic(context),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Profile :",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  )),
              const SizedBox(
                height: 20.0,
              ),
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xff35ddaa), width: 5),
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
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
                            height: 20.0,
                          ),
                          Expanded(
                            flex: 0,
                            child: Text(
                              '${widget.user.FirstName} ${widget.user.SecondName}',
                              style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      letterSpacing: .5,
                                      fontSize: 30),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Column(
                              children: [
                                RichTextLine(
                                  text: "${widget.user.email}",
                                  title: 'Email :  ',
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                RichTextLine(
                                  text: "${widget.user.details!["entreprise"]}",
                                  title: 'Entreprise actuel :  ',
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                RichTextLine(
                                  text: "${widget.user.details!["poste"]}",
                                  title: 'Poste actuel :  ',
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Info_screen(
                                                    entreprise: widget.user
                                                        .details!["entreprise"],
                                                    poste: widget
                                                        .user.details!["poste"],
                                                    linkedin: widget.user
                                                        .details!["linkedin"],
                                                    url: widget.user.img,
                                                  )));
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Color(0xff35ddaa),
                                      size: 50,
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
            ],
          ),
        ),
      ),
    );
  }
}
