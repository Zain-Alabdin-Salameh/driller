import 'package:driller/controllers/database_helper.dart';
import 'package:driller/models/models.dart';
import 'package:driller/utils/utils.dart';
import 'package:flutter/material.dart';

class AddClient extends StatefulWidget {
  const AddClient({Key? key}) : super(key: key);

  @override
  _AddClientState createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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
                "Add Client Informations",
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
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Phone number", labelStyle: AppFonts.appBarFont),
              ),
              MaterialButton(
                onPressed: () {
                  Client client = Client(
                    id: 1,
                    name: nameController.text,
                    phoneNumber: phoneController.text,
                  );
                  DBProvider.db.newClient(client);
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
