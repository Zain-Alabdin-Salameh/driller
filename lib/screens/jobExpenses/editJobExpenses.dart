import 'package:driller/controllers/database_helper.dart';
import 'package:driller/models/models.dart';
import 'package:driller/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditJobExpensesScreen extends StatefulWidget {
  final JobExpenses jobExpenses;
  const EditJobExpensesScreen({Key? key, required this.jobExpenses})
      : super(key: key);

  @override
  _EditJobExpensesScreenState createState() => _EditJobExpensesScreenState();
}

class _EditJobExpensesScreenState extends State<EditJobExpensesScreen> {
  TextEditingController countController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  DateTime selectedDate = DateTime.utc(2000, 1, 1);
  String jobId = '';
  String componentId = '';
  late List<Job> jobs;
  late List<StorageComponent> components;
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
    List<Job> jb = await DBProvider.db.getAllJobs();
    List<StorageComponent> sc = await DBProvider.db.getAllStorageComponents();
    jobs = jb;
    jobId = widget.jobExpenses.job_id;
    components = sc;
    componentId = widget.jobExpenses.component_id;
    countController.text = widget.jobExpenses.count.toString();
    dobController.text = widget.jobExpenses.date;
    setState(() {
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
            "Job Expenses",
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
                  "Add Job Expenses Informations",
                  style: AppFonts.titleFont,
                )),
                const SizedBox(
                  height: 80,
                ),
                done == 'done'
                    ? Row(
                        children: [
                          Text(
                            'Job :',
                            style: AppFonts.appBarFont,
                          ),
                          Expanded(
                            child: DropdownButton(
                                dropdownColor: AppColors.backgroundColor,
                                value: jobId,
                                items: jobs
                                    .map((e) => DropdownMenuItem(
                                          value: e.id.toString(),
                                          child: Text(e.title,
                                              style: AppFonts.appBarFont),
                                        ))
                                    .toList(),
                                onChanged: (val) {
                                  setState(() {
                                    jobId = val.toString();
                                  });
                                }),
                          ),
                        ],
                      )
                    : const Center(child: CircularProgressIndicator()),
                const SizedBox(
                  height: 20,
                ),
                done == 'done'
                    ? Row(
                        children: [
                          Text(
                            'Component :',
                            style: AppFonts.appBarFont,
                          ),
                          Expanded(
                            child: DropdownButton(
                                dropdownColor: AppColors.backgroundColor,
                                value: componentId,
                                items: components
                                    .map((e) => DropdownMenuItem(
                                          value: e.id.toString(),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(e.name,
                                                  style: AppFonts.appBarFont),
                                              Text(e.date,
                                                  style: AppFonts.appBarFont),
                                            ],
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (val) {
                                  setState(() {
                                    componentId = val.toString();
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
                  controller: countController,
                  cursorColor: AppColors.brightFontColor,
                  style: AppFonts.appBarFont,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      fillColor: AppColors.brightFontColor,
                      labelText: "Count",
                      labelStyle: AppFonts.appBarFont),
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
                    widget.jobExpenses.component_id = componentId;
                    widget.jobExpenses.job_id = jobId;
                    widget.jobExpenses.date = dobController.text;
                    widget.jobExpenses.count = int.parse(countController.text);
                    DBProvider.db.updateJobExpenses(widget.jobExpenses);
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
