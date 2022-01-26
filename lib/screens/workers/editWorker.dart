import 'package:driller/controllers/database_helper.dart';
import 'package:driller/models/models.dart';
import 'package:driller/utils/utils.dart';
import 'package:flutter/material.dart';

class EditWrkerScreen extends StatefulWidget {
  final Worker worker;
  const EditWrkerScreen({Key? key, required this.worker}) : super(key: key);

  @override
  _EditWrkerScreenState createState() => _EditWrkerScreenState();
}

class _EditWrkerScreenState extends State<EditWrkerScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String machineNo = "1";
  late List<DrillingMachine> drillinngMachines;
  @override
  void initState() {
    super.initState();
    nameController.text = widget.worker.name;
    phoneController.text = widget.worker.phoneNumber;
  }

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
                "Edite Worker Informations",
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
                    labelStyle: AppFonts.infoCardFont),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: phoneController,
                style: AppFonts.appBarFont,
                decoration: InputDecoration(
                    labelText: "Phone number",
                    labelStyle: AppFonts.infoCardFont),
              ),
              MaterialButton(
                onPressed: () {
                  widget.worker.name = nameController.text;
                  widget.worker.phoneNumber = phoneController.text;
                  DBProvider.db.updateWorker(widget.worker);
                  Navigator.pop(context, true);
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
