import 'package:driller/controllers/database_helper.dart';
import 'package:driller/models/models.dart';
import 'package:driller/screens/jobs/addJob.dart';
import 'package:driller/screens/jobs/editJob.dart';
import 'package:driller/utils/infoCard.dart';
import 'package:driller/utils/utils.dart';
import 'package:flutter/material.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({Key? key}) : super(key: key);

  @override
  _JobsScreenState createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
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
        centerTitle: true,
      ),
      body: FutureBuilder<List<Job>>(
          future: DBProvider.db.getAllJobs(),
          builder: (BuildContext context, AsyncSnapshot<List<Job>> snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: [
                  ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      Job item = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: JobInfoCard(
                            job: item,
                            editcallback: () {
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditJobScreen(job: item)))
                                  .then((value) {
                                setState(() {});
                              });
                            },
                            deletecallback: () async {
                              var res = await DBProvider.db.deleteJob(item.id);
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
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddJob()))
              .then((value) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
