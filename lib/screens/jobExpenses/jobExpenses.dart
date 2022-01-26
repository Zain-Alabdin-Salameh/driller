import 'package:driller/controllers/database_helper.dart';
import 'package:driller/models/models.dart';
import 'package:driller/screens/jobExpenses/addJobExpenses.dart';
import 'package:driller/screens/jobExpenses/editJobExpenses.dart';
import 'package:driller/utils/infoCard.dart';
import 'package:driller/utils/utils.dart';
import 'package:flutter/material.dart';

class JobExpensesScreen extends StatefulWidget {
  const JobExpensesScreen({Key? key}) : super(key: key);

  @override
  _JobExpensesScreenState createState() => _JobExpensesScreenState();
}

class _JobExpensesScreenState extends State<JobExpensesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: Text(
          "JOB EXPENSES",
          style: AppFonts.appBarFont,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<JobExpenses>>(
          future: DBProvider.db.getAllJobExpenses(),
          builder: (BuildContext context,
              AsyncSnapshot<List<JobExpenses>> snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: [
                  ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      JobExpenses item = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: JobExpensesCard(
                            jobExp: item,
                            editcallback: () {
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditJobExpensesScreen(
                                                  jobExpenses: item)))
                                  .then((value) {
                                setState(() {});
                              });
                            },
                            deletecallback: () async {
                              var res = await DBProvider.db
                                  .deleteJobExpenses(item.id);
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
                  builder: (context) => const AddJobExpenses())).then((value) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
