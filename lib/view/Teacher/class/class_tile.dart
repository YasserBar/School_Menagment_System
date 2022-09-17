import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/model/class_model.dart';
import 'package:tr_app/view/Teacher/set_files_teacher.dart';
import 'package:tr_app/view/Teacher/note/set_note_class.dart';
import 'package:tr_app/view/Teacher/lecture/lectures.dart';
import 'package:tr_app/res/color.dart';

class ClaatileT extends StatelessWidget {
  final ModelClass listclass;
  final String type;
  const ClaatileT(this.listclass, this.type);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          height: 80,
      padding: const EdgeInsets.all(10),
      child: TextButton(
          onPressed: () {
            if (type == "Valuation") {
              Get.to(() => LecturesList(), arguments: listclass.id.toString());
            }
            if (type == "note") {
              Get.to(() => ClassNote(), arguments: [
                listclass.id.toString(),
                listclass.level.toString(),
                listclass.roomName.toString(),
              ]);
            }
            if (type == "file") {
              Get.to(() => const SendFile(), arguments: [
                listclass.id.toString(),
                listclass.level.toString(),
                listclass.roomName.toString(),
              ]);
            }
          },
          style: TextButton.styleFrom(
            side: const BorderSide(color: primaryColorS, width: 2.0),
            primary: primaryColorS,
            backgroundColor: primarylightColorS,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                flex: 2,
                child: Icon(
                  Icons.groups,
                  size: 25.0,
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: FittedBox(
                    child: Text(
                      listclass.roomName,
                      style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: FittedBox(
                    child: Text(
                      listclass.level,
                      style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          )),
    ));
  }
}
