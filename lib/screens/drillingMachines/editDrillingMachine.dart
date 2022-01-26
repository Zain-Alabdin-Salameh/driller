import 'package:driller/controllers/database_helper.dart';
import 'package:driller/models/models.dart';
import 'package:driller/utils/utils.dart';
import 'package:flutter/material.dart';

class EditMachineScreen extends StatefulWidget {
  final DrillingMachine machine;
  const EditMachineScreen({Key? key, required this.machine}) : super(key: key);

  @override
  _EditMachineScreenState createState() => _EditMachineScreenState();
}

class _EditMachineScreenState extends State<EditMachineScreen> {
  TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numberController.text = widget.machine.drillerNo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: Text(
          "DRILLING MAHINES",
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
                "Edit Drilling Mahine Informations",
                style: AppFonts.titleFont,
              )),
              const SizedBox(
                height: 80,
              ),
              TextFormField(
                controller: numberController,
                cursorColor: AppColors.brightFontColor,
                style: AppFonts.appBarFont,
                decoration: InputDecoration(
                    fillColor: AppColors.brightFontColor,
                    labelText: "Drilling Mahine Number",
                    labelStyle: AppFonts.appBarFont),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  widget.machine.drillerNo = numberController.text;
                  DBProvider.db.updateMachine(widget.machine);
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
