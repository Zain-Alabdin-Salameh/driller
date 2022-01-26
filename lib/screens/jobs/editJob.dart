import 'package:driller/controllers/database_helper.dart';
import 'package:driller/models/models.dart';
import 'package:driller/utils/utils.dart';
import 'package:flutter/material.dart';

class EditJobScreen extends StatefulWidget {
  final Job job;
  const EditJobScreen({Key? key, required this.job}) : super(key: key);

  @override
  _EditJobScreenState createState() => _EditJobScreenState();
}

class _EditJobScreenState extends State<EditJobScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String drillerNo = '';
  String workerId = '';
  String clientId = '';
  late List<DrillingMachine> drillers;
  late List<Worker> workers;
  late List<Client> clients;
  String done = '';
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    List<DrillingMachine> ds = await DBProvider.db.getAllMachines();
    List<Worker> ws = await DBProvider.db.getAllWorkers();
    List<Client> cs = await DBProvider.db.getAllClients();
    drillers = ds;
    workers = ws;
    clients = cs;
    drillerNo = widget.job.drillerNo;
    workerId = widget.job.workerId;
    clientId = widget.job.clientId;
    titleController.text = widget.job.title;
    descriptionController.text = widget.job.description;
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
            "JOBS",
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
                  "Add Job Informations",
                  style: AppFonts.titleFont,
                )),
                const SizedBox(
                  height: 80,
                ),
                TextFormField(
                  controller: titleController,
                  cursorColor: AppColors.brightFontColor,
                  style: AppFonts.appBarFont,
                  decoration: InputDecoration(
                      fillColor: AppColors.brightFontColor,
                      labelText: "Title",
                      labelStyle: AppFonts.appBarFont),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 5,
                  style: AppFonts.appBarFont,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      labelText: "Description",
                      labelStyle: AppFonts.appBarFont),
                ),
                SizedBox(
                  height: 20,
                ),
                done == 'done'
                    ? Row(
                        children: [
                          Text(
                            'Client :',
                            style: AppFonts.appBarFont,
                          ),
                          Expanded(
                            child: DropdownButton(
                                dropdownColor: AppColors.backgroundColor,
                                value: clientId,
                                items: clients
                                    .map((e) => DropdownMenuItem(
                                          value: e.id.toString(),
                                          child: Text(e.name,
                                              style: AppFonts.appBarFont),
                                        ))
                                    .toList(),
                                onChanged: (val) {
                                  setState(() {
                                    clientId = val.toString();
                                  });
                                  print(clientId);
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
                                  print(workerId);
                                }),
                          ),
                        ],
                      )
                    : const Center(child: CircularProgressIndicator()),
                SizedBox(
                  height: 20,
                ),
                done == 'done'
                    ? Row(
                        children: [
                          Text(
                            'Drilling Machine :',
                            style: AppFonts.appBarFont,
                          ),
                          Expanded(
                            child: DropdownButton(
                                hint: Text(
                                  'Choose',
                                  style: AppFonts.appBarFont,
                                ),
                                dropdownColor: AppColors.backgroundColor,
                                value: drillerNo,
                                items: drillers
                                    .map((e) => DropdownMenuItem(
                                          value: e.drillerNo.toString(),
                                          onTap: () {
                                            setState(() {
                                              drillerNo = e.drillerNo;
                                            });
                                          },
                                          child: Text(
                                            e.drillerNo,
                                            style: AppFonts.appBarFont,
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (String? val) {
                                  drillerNo = val!;
                                  setState(() {
                                    drillerNo;
                                  });
                                }),
                          ),
                        ],
                      )
                    : const Center(child: CircularProgressIndicator()),
                MaterialButton(
                  onPressed: () {
                    widget.job.title = titleController.text;
                    widget.job.description = descriptionController.text;
                    widget.job.drillerNo = drillerNo;
                    widget.job.workerId = workerId;
                    widget.job.clientId = clientId;
                    DBProvider.db.updateJob(widget.job);
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
