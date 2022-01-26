import 'package:driller/controllers/database_helper.dart';
import 'package:driller/models/models.dart';
import 'package:driller/screens/workers/addWorker.dart';
import 'package:driller/screens/workers/editWorker.dart';
import 'package:driller/utils/infoCard.dart';
import 'package:driller/utils/utils.dart';
import 'package:flutter/material.dart';

class WorkersScreen extends StatefulWidget {
  const WorkersScreen({Key? key}) : super(key: key);

  @override
  _WorkersScreenState createState() => _WorkersScreenState();
}

class _WorkersScreenState extends State<WorkersScreen> {
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
        centerTitle: true,
      ),
      body: FutureBuilder<List<Worker>>(
          future: DBProvider.db.getAllWorkers(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Worker>> snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: [
                  ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      Worker item = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InfoCard(
                            data: item.toMap(),
                            editcallback: () {
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditWrkerScreen(worker: item)))
                                  .then((value) {
                                setState(() {});
                              });
                            },
                            deletecallback: () async {
                              var res =
                                  await DBProvider.db.deleteWorker(item.id);
                              print(res);
                              setState(() {});
                            }),
                      );
                    },
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 8,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              Colors.black.withOpacity(0),
                              Colors.black.withOpacity(0.1),
                              Colors.black.withOpacity(0.3),
                              Colors.black.withOpacity(0.5)
                            ])),
                      ))
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.appBarColor,
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddWorkerScreen())).then((value) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
