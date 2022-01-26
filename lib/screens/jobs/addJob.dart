import 'package:driller/controllers/database_helper.dart';
import 'package:driller/models/models.dart';
import 'package:driller/utils/utils.dart';
import 'package:flutter/material.dart';

class AddJob extends StatefulWidget {
  const AddJob({Key? key}) : super(key: key);

  @override
  _AddJobState createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> {
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
    drillerNo = drillers[0].drillerNo;
    workerId = workers[0].id.toString();
    clientId = clients[0].id.toString();
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
                    Job job = Job(
                        id: 1,
                        title: titleController.text,
                        description: descriptionController.text,
                        drillerNo: drillerNo,
                        workerId: workerId.toString(),
                        clientId: clientId.toString());
                    DBProvider.db.newJob(job);
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
