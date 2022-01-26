import 'package:driller/controllers/database_helper.dart';
import 'package:driller/models/models.dart';
import 'package:driller/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditSalaryScreen extends StatefulWidget {
  final Salary salary;
  const EditSalaryScreen({Key? key, required this.salary}) : super(key: key);

  @override
  _EditSalaryScreenState createState() => _EditSalaryScreenState();
}

class _EditSalaryScreenState extends State<EditSalaryScreen> {
  TextEditingController balanceController = TextEditingController();
  TextEditingController paiedController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  DateTime selectedDate = DateTime.utc(2000, 1, 1);
  String workerId = '';
  late List<Worker> workers;
  String done = '';
  @override
  void initState() {
    initData();
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

  void initData() async {
    List<Worker> ws = await DBProvider.db.getAllWorkers();
    workers = ws;
    workerId = widget.salary.workerId;
    setState(() {
      balanceController.text = widget.salary.balance.toString();
      paiedController.text = widget.salary.paied.toString();
      dobController.text = widget.salary.date;
      done = 'done';
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
                  "Edit Salary Informations",
                  style: AppFonts.titleFont,
                )),
                const SizedBox(
                  height: 80,
                ),
                done == 'done'
                    ? Row(
                        children: [
                          Text(
                            'Worker :',
                            style: AppFonts.appBarFont,
                          ),
                          Expanded(
                            child: DropdownButton(
                                dropdownColor: AppColors.backgroundColor,
                                value: workerId,
                                items: workers
                                    .map((e) => DropdownMenuItem(
                                          value: e.id.toString(),
                                          child: Text(e.name,
                                              style: AppFonts.appBarFont),
                                        ))
                                    .toList(),
                                onChanged: (val) {
                                  setState(() {
                                    workerId = val.toString();
                                  });
                                }),
                          ),
                        ],
                      )
                    : const Center(child: CircularProgressIndicator()),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: balanceController,
                  cursorColor: AppColors.brightFontColor,
                  style: AppFonts.appBarFont,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      fillColor: AppColors.brightFontColor,
                      labelText: "Balance",
                      labelStyle: AppFonts.appBarFont),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: paiedController,
                  style: AppFonts.appBarFont,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Paied", labelStyle: AppFonts.appBarFont),
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
                    widget.salary.workerId = workerId;
                    widget.salary.balance = balanceController.text;
                    widget.salary.paied = paiedController.text;
                    widget.salary.date = dobController.text;
                    DBProvider.db.updateSalary(widget.salary);
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
