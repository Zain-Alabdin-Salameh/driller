import 'package:driller/controllers/database_helper.dart';
import 'package:driller/models/models.dart';
import 'package:driller/utils/utils.dart';
import 'package:flutter/material.dart';

class EditeClientScreen extends StatefulWidget {
  final Client client;
  const EditeClientScreen({Key? key, required this.client}) : super(key: key);

  @override
  _EditeClientScreenState createState() => _EditeClientScreenState();
}

class _EditeClientScreenState extends State<EditeClientScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String machineNo = "1";
  late List<DrillingMachine> drillinngMachines;
  @override
  void initState() {
    super.initState();
    nameController.text = widget.client.name;
    phoneController.text = widget.client.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: Text(
          "CLIENTS",
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
                "Edite client Informations",
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
                  widget.client.name = nameController.text;
                  widget.client.phoneNumber = phoneController.text;
                  DBProvider.db.updateClient(widget.client);
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
