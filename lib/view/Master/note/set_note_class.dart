import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tr_app/controller/set_note_class_controller.dart';
import 'package:tr_app/res/api_url.dart';
import 'package:tr_app/view/Master/drower_master.dart';
import 'package:tr_app/utils/utils.dart';
import 'package:tr_app/res/color.dart';

class ClassNote extends StatelessWidget {
  final ValueNotifier<TextDirection> _textDir =
      ValueNotifier(TextDirection.ltr);
  ClassNote({Key? key}) : super(key: key);
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  var controller = Get.put(ClassNoteController(EndPointMaster.setNoteClass));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Class Note",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: primaryColorS,
        automaticallyImplyLeading: false,  
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      drawer: MyDrowerMaster(
        initi: 2,
        onMenueTap: (page) {
          Get.off;
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "assets/images/exam.png",
                  height: 50,
                ),
                Text(
                  controller.name,
                  style: const TextStyle(
                      fontSize: 30,
                      color: primaryColorS,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  controller.level,
                  style: const TextStyle(
                      fontSize: 30,
                      color:primaryColorS,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(
              color: primaryColorS,
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: controller.notekey,
              autovalidateMode: AutovalidateMode.always,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  color:primarylightColorS,
                  borderRadius: BorderRadius.circular(29),
                ),
                child: ValueListenableBuilder<TextDirection>(
                  valueListenable: _textDir,
                  builder: (context, value, child) =>
                  TextFormField(
                    textDirection: value,
                    onChanged: (input) {
                      if (input.trim().length < 2) {
                        final dir = Utils.getDirection(input);
                        if (dir != value) _textDir.value = dir;
                      }
                    },
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    controller: controller.textcontroller,
                    validator: (value) {
                      return controller.validateNote(value!);
                    },
                    maxLines: 3,
                    decoration: const InputDecoration(
                        hintText: "Write your note her...",
                        hintStyle: TextStyle(color: primaryColorS),
                        icon: Icon(
                          Icons.edit,
                          color:primaryColorS,
                          size: 25,
                        ),
                        border: InputBorder.none),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Obx(() {
              if (controller.isloading.value) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: primaryColorS,
                ));
              }
              return MaterialButton(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                color: primarylightColorS,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 10,
                onPressed: () async {
                  if (controller.chickNote()) {
                    await controller.send(context);
                    if (!controller.isloading.value) {
                      Utils.flushBarSuccessfulMessage("${controller.level}  ${controller.name}\nDone add the note successfully", context);
                    }
                    Future.delayed(Duration(seconds: 3), () {
                      Get.close(1);
                    });
                  }
                },
                child: const Text("Submit", style: TextStyle(color: primaryColorS)),
              );
            }),
          ],
        ),
      ),
    );
  }
}







//  Get.snackbar("ملاحظات", "تم اضافة الملاحظة بنجاح",
//                           duration: const Duration(seconds: 10),
//                           snackStyle: SnackStyle.FLOATING,
//                           barBlur: 30,
//                           dismissDirection: DismissDirection.horizontal,
//                           messageText: const Text(
//                             "تم اضافة الملاحظة بنجاح",
//                             textDirection: TextDirection.rtl,
//                             style: TextStyle(
//                               color:primaryColorS,
//                               fontSize: 20,
//                             ),
//                           ),
//                           padding: const EdgeInsets.only(left: 30, right: 10),
//                            icon: const Icon(
//                               Icons.check_circle,
//                               size: 25,
//                               color: Color.fromARGB(255, 21, 160, 26),
//                             ),
//                             titleText: Text(
//                               "${controller.level}  ${controller.name}",
//                               textDirection: TextDirection.rtl,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 25,
//                               ),
//                             ));