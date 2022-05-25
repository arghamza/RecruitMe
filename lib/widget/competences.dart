// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

class CompetenceWidget extends StatelessWidget {
  const CompetenceWidget({
    Key? key,
    required this.competencesController,
  }) : super(key: key);

  final TextfieldTagsController competencesController;

  @override
  Widget build(BuildContext context) {
    return TextFieldTags(
      textfieldTagsController: competencesController,
      initialTags: const ['Leadership', 'Flutter'],
      textSeparators: const [' ', ','],
      letterCase: LetterCase.normal,
      validator: (String tag) {
        if (competencesController.getTags!.contains(tag)) {
          return 'you already entered that';
        }
        return null;
      },
      inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
        return ((context, sc, tags, onTagDelete) {
          return Padding(
            padding: const EdgeInsets.all(7.0),
            child: TextField(
              controller: tec,
              focusNode: fn,
              decoration: InputDecoration(
                helperText: 'ajoutez une compétence ...',
                helperStyle: const TextStyle(
                  color: Colors.black,
                ),
                hintText: competencesController.hasTags ? '' : "...",
                errorText: error,
                prefixIconConstraints:
                    BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                prefixIcon: tags.isNotEmpty
                    ? SingleChildScrollView(
                        controller: sc,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: tags.map((String tag) {
                          return Container(
                            decoration: BoxDecoration(
                              // border: Border.all(color:Color.fromARGB(255, 24, 165, 123)),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              color: const Color.fromARGB(255, 190, 244, 227),
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: Text(
                                    tag,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  onTap: () {
                                    print("$tag selected");
                                  },
                                ),
                                const SizedBox(width: 4.0),
                                InkWell(
                                  child: const Icon(
                                    Icons.cancel,
                                    size: 14.0,
                                    color: Colors.black,
                                  ),
                                  onTap: () {
                                    onTagDelete(tag);
                                  },
                                )
                              ],
                            ),
                          );
                        }).toList()),
                      )
                    : null,
              ),
              onChanged: onChanged,
              onSubmitted: onSubmitted,
            ),
          );
        });
      },
    );
  }
}
