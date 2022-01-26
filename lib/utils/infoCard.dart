import 'package:driller/controllers/database_helper.dart';
import 'package:driller/models/models.dart';
import 'package:driller/utils/utils.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final void Function() editcallback;
  final void Function() deletecallback;

  const InfoCard(
      {Key? key,
      required this.data,
      required this.editcallback,
      required this.deletecallback})
      : super(key: key);

  List<Widget> getData() {
    List<Widget> info = [];
    var d = data.forEach((key, value) {
      info.add(Column(
        children: [
          Row(
            children: [
              Text(
                key + " : ",
                style: AppFonts.infoCardFont,
              ),
              Text(
                value.toString(),
                style: AppFonts.infoCardFont,
              )
            ],
          ),
          Divider(
            thickness: 1,
            color: AppColors.appBarColor,
          )
        ],
      ));
    });
    return info;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: getData(),
              ),
            ),
            Column(
              children: [
                IconButton(
                    onPressed: editcallback, icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: deletecallback, icon: const Icon(Icons.delete)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class JobInfoCard extends StatefulWidget {
  final Job job;
  final void Function() editcallback;
  final void Function() deletecallback;
  const JobInfoCard(
      {Key? key,
      required this.job,
      required this.editcallback,
      required this.deletecallback})
      : super(key: key);

  @override
  _JobInfoCardState createState() => _JobInfoCardState();
}

class _JobInfoCardState extends State<JobInfoCard> {
  late Client client;
  late Worker worker;
  String done = '';
  @override
  void initState() {
    // TODO: implement initState
    initData();
    super.initState();
  }

  void initData() async {
    client = await DBProvider.db.getClientById(int.parse(widget.job.clientId));
    worker = await DBProvider.db.getWorkerById(int.parse(widget.job.workerId));
    done = 'done';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "title : ",
                          style: AppFonts.infoCardFont,
                        ),
                        Text(
                          widget.job.title.toString(),
                          style: AppFonts.infoCardFont,
                        )
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColors.appBarColor,
                    ),
                    Row(
                      children: [
                        Text(
                          "description : ",
                          style: AppFonts.infoCardFont,
                        ),
                        Text(
                          widget.job.description.toString(),
                          style: AppFonts.infoCardFont,
                        )
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColors.appBarColor,
                    ),
                    Row(
                      children: [
                        Text(
                          "drillerNo : ",
                          style: AppFonts.infoCardFont,
                        ),
                        Text(
                          widget.job.drillerNo.toString(),
                          style: AppFonts.infoCardFont,
                        )
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColors.appBarColor,
                    ),
                    Row(
                      children: [
                        Text(
                          "worker : ",
                          style: AppFonts.infoCardFont,
                        ),
                        done == 'done'
                            ? Text(
                                worker.name.toString(),
                                style: AppFonts.infoCardFont,
                              )
                            : Container()
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColors.appBarColor,
                    ),
                    Row(
                      children: [
                        Text(
                          "client : ",
                          style: AppFonts.infoCardFont,
                        ),
                        done == 'done'
                            ? Text(
                                client.name.toString(),
                                style: AppFonts.infoCardFont,
                              )
                            : Container()
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColors.appBarColor,
                    )
                  ]),
            ),
            Column(
              children: [
                IconButton(
                    onPressed: widget.editcallback,
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: widget.deletecallback,
                    icon: const Icon(Icons.delete)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SalaryCard extends StatefulWidget {
  final Salary salary;
  final void Function() editcallback;
  final void Function() deletecallback;
  const SalaryCard(
      {Key? key,
      required this.salary,
      required this.editcallback,
      required this.deletecallback})
      : super(key: key);

  @override
  _SalaryCardState createState() => _SalaryCardState();
}

class _SalaryCardState extends State<SalaryCard> {
  late Worker worker;
  String done = '';
  @override
  void initState() {
    // TODO: implement initState
    initData();
    super.initState();
  }

  void initData() async {
    worker =
        await DBProvider.db.getWorkerById(int.parse(widget.salary.workerId));
    done = 'done';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "worker : ",
                          style: AppFonts.infoCardFont,
                        ),
                        done == 'done'
                            ? Text(
                                worker.name.toString(),
                                style: AppFonts.infoCardFont,
                              )
                            : Container()
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColors.appBarColor,
                    ),
                    Row(
                      children: [
                        Text(
                          "balance : ",
                          style: AppFonts.infoCardFont,
                        ),
                        Text(
                          widget.salary.balance.toString(),
                          style: AppFonts.infoCardFont,
                        )
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColors.appBarColor,
                    ),
                    Row(
                      children: [
                        Text(
                          "paied : ",
                          style: AppFonts.infoCardFont,
                        ),
                        Text(
                          widget.salary.paied.toString(),
                          style: AppFonts.infoCardFont,
                        )
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColors.appBarColor,
                    ),
                    Row(
                      children: [
                        Text(
                          "date : ",
                          style: AppFonts.infoCardFont,
                        ),
                        Text(
                          widget.salary.date.toString(),
                          style: AppFonts.infoCardFont,
                        )
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColors.appBarColor,
                    ),
                  ]),
            ),
            Column(
              children: [
                IconButton(
                    onPressed: widget.editcallback,
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: widget.deletecallback,
                    icon: const Icon(Icons.delete)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class JobExpensesCard extends StatefulWidget {
  final JobExpenses jobExp;
  final void Function() editcallback;
  final void Function() deletecallback;
  const JobExpensesCard(
      {Key? key,
      required this.jobExp,
      required this.editcallback,
      required this.deletecallback})
      : super(key: key);

  @override
  _JobExpensesCardState createState() => _JobExpensesCardState();
}

class _JobExpensesCardState extends State<JobExpensesCard> {
  late Job job;
  late StorageComponent storageComponent;
  String done = '';
  @override
  void initState() {
    // TODO: implement initState
    initData();
    super.initState();
  }

  void initData() async {
    job = await DBProvider.db.getJobById(int.parse(widget.jobExp.job_id));
    storageComponent = await DBProvider.db
        .getStorageComponentById(int.parse(widget.jobExp.component_id));
    done = 'done';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "job : ",
                          style: AppFonts.infoCardFont,
                        ),
                        done == 'done'
                            ? Text(
                                job.title.toString(),
                                style: AppFonts.infoCardFont,
                              )
                            : Container()
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColors.appBarColor,
                    ),
                    Row(
                      children: [
                        Text(
                          "component : ",
                          style: AppFonts.infoCardFont,
                        ),
                        done == 'done'
                            ? Text(
                                storageComponent.name,
                                style: AppFonts.infoCardFont,
                              )
                            : Container()
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColors.appBarColor,
                    ),
                    Row(
                      children: [
                        Text(
                          "count : ",
                          style: AppFonts.infoCardFont,
                        ),
                        Text(
                          widget.jobExp.count.toString(),
                          style: AppFonts.infoCardFont,
                        )
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColors.appBarColor,
                    ),
                    Row(
                      children: [
                        Text(
                          "date : ",
                          style: AppFonts.infoCardFont,
                        ),
                        Text(
                          widget.jobExp.date,
                          style: AppFonts.infoCardFont,
                        )
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColors.appBarColor,
                    ),
                  ]),
            ),
            Column(
              children: [
                IconButton(
                    onPressed: widget.editcallback,
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: widget.deletecallback,
                    icon: const Icon(Icons.delete)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
