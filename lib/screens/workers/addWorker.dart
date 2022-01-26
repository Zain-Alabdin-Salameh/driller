import 'package:driller/controllers/database_helper.dart';
import 'package:driller/models/models.dart';
import 'package:driller/utils/utils.dart';
import 'package:flutter/material.dart';

class AddWorkerScreen extends StatefulWidget {
  const AddWorkerScreen({Key? key}) : super(key: key);

  @override
  _AddWorkerScreenState createState() => _AddWorkerScreenState();
}

class _AddWorkerScreenState extends State<AddWorkerScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String machineNo = "1";
  late List<DrillingMachine> drillinngMachines;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: Text(
          "WORKERS",
          style: AppFonts.appBarFont,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Center(
                  child: Text(
                "Add Worker Informations",
                style: AppFonts.titleFont,
              )),
              const SizedBox(
                height: 80,
              ),
              TextFormField(
                controller: nameController,
                cursorColor: AppColors.brightFontColor,
                style: AppFonts.appBarFont,
                decoration: InputDecoration(
                    fillColor: AppColors.brightFontColor,
                    labelText: "Name",
                    labelStyle: AppFonts.appBarFont),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: phoneController,
                style: AppFonts.appBarFont,
                decoration: InputDecoration(
                    labelText: "Phone number", labelStyle: AppFonts.appBarFont),
              ),
              MaterialButton(
                onPressed: () {
                  Worker worker = Worker(
                      id: 1,
                      name: nameController.text,
                      phoneNumber: phoneController.text,
                      drillerNo: "1");
                  DBProvider.db.newWorker(worker);
                  Navigator.pop(context, true);
                  setState(() {});
                },
                child: Text(
                  "Save",
                  style: AppFonts.appBarFont,
                ),
                color: AppColors.appBarColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
