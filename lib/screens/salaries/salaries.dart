import 'package:driller/controllers/database_helper.dart';
import 'package:driller/models/models.dart';
import 'package:driller/screens/salaries/addSalary.dart';
import 'package:driller/screens/salaries/editSalary.dart';
import 'package:driller/utils/infoCard.dart';
import 'package:driller/utils/utils.dart';
import 'package:flutter/material.dart';

class SalariesScreen extends StatefulWidget {
  const SalariesScreen({Key? key}) : super(key: key);

  @override
  _SalariesScreenState createState() => _SalariesScreenState();
}

class _SalariesScreenState extends State<SalariesScreen> {
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
        centerTitle: true,
      ),
      body: FutureBuilder<List<Salary>>(
          future: DBProvider.db.getAllSalaries(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Salary>> snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: [
                  ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      Salary item = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SalaryCard(
                            salary: item,
                            editcallback: () {
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditSalaryScreen(salary: item)))
                                  .then((value) {
                                setState(() {});
                              });
                            },
                            deletecallback: () async {
                              var res =
                                  await DBProvider.db.deleteSalary(item.id);
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
                  MaterialPageRoute(builder: (context) => const AddSalary()))
              .then((value) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
