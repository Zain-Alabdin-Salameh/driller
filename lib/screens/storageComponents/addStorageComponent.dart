import 'package:driller/controllers/database_helper.dart';
import 'package:driller/models/models.dart';
import 'package:driller/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddStorageComponentScreen extends StatefulWidget {
  const AddStorageComponentScreen({Key? key}) : super(key: key);

  @override
  _AddStorageComponentScreenState createState() =>
      _AddStorageComponentScreenState();
}

class _AddStorageComponentScreenState extends State<AddStorageComponentScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController countController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  DateTime selectedDate = DateTime.utc(2000, 1, 1);
  @override
  void initState() {
    super.initState();
  }

  _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildCupertinoDatePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePicker(context);
    }
  }

  buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked != null)
                  setState(() {
                    selectedDate = picked;
                    dobController.text = picked.toString();
                  });
              },
              initialDateTime: selectedDate,
              minimumYear: 1900,
              maximumYear: DateTime.now().year,
            ),
          );
        });
  }

  buildMaterialDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );
    if (picked != null)
      setState(() {
        selectedDate = picked;
        dobController.text = picked.toString();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.appBarColor,
          title: Text(
            "SALARIES",
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
                  "Add Salary Informations",
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
                      labelText: "name",
                      labelStyle: AppFonts.appBarFont),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: countController,
                  cursorColor: AppColors.brightFontColor,
                  style: AppFonts.appBarFont,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      fillColor: AppColors.brightFontColor,
                      labelText: "count",
                      labelStyle: AppFonts.appBarFont),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: priceController,
                  style: AppFonts.appBarFont,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "price", labelStyle: AppFonts.appBarFont),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () => _selectDate(context),
                  child: IgnorePointer(
                    child: TextFormField(
                      controller: dobController,
                      style: AppFonts.appBarFont,
                      decoration: InputDecoration(
                          labelText: "Date", labelStyle: AppFonts.appBarFont),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    StorageComponent storageComponent = StorageComponent(
                        id: 1,
                        name: nameController.text,
                        count: int.parse(countController.text),
                        price: int.parse(priceController.text),
                        date: dobController.text);
                    DBProvider.db.newStorageComponent(storageComponent);
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
        ));
  }
}
