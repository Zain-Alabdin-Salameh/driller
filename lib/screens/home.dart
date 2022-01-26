import 'package:driller/screens/clients/clients.dart';
import 'package:driller/screens/drillingMachines/DrillingMahines.dart';
import 'package:driller/screens/jobExpenses/jobExpenses.dart';
import 'package:driller/screens/jobs/jobs.dart';
import 'package:driller/screens/salaries/salaries.dart';
import 'package:driller/screens/storageComponents/storageComponents.dart';
import 'package:driller/screens/workers/workers.dart';
import 'package:driller/utils/utils.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Center(
          child: Text(
            "Driller",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.clickableFontColor,
                fontSize: 35,
                fontFamily: "Prototype"),
          ),
        ),
        backgroundColor: AppColors.appBarColor,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.clickableFontColor, width: 2),
                      borderRadius: BorderRadius.circular(25)),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const DrillingMachinesScreen()));
                    },
                    child: Text(
                      "drilling machines",
                      textAlign: TextAlign.center,
                      style: AppFonts.titleFont,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.clickableFontColor, width: 2),
                      borderRadius: BorderRadius.circular(25)),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WorkersScreen()));
                    },
                    child: Text(
                      "workers",
                      textAlign: TextAlign.center,
                      style: AppFonts.titleFont,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.clickableFontColor, width: 2),
                      borderRadius: BorderRadius.circular(25)),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ClientScreen()));
                    },
                    child: Text(
                      "clients",
                      textAlign: TextAlign.center,
                      style: AppFonts.titleFont,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.clickableFontColor, width: 2),
                      borderRadius: BorderRadius.circular(25)),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const JobsScreen()));
                    },
                    child: Text(
                      "jobs",
                      textAlign: TextAlign.center,
                      style: AppFonts.titleFont,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.clickableFontColor, width: 2),
                      borderRadius: BorderRadius.circular(25)),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SalariesScreen()));
                    },
                    child: Text(
                      "slalries",
                      textAlign: TextAlign.center,
                      style: AppFonts.titleFont,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.clickableFontColor, width: 2),
                      borderRadius: BorderRadius.circular(25)),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const StorageComponentsScreen()));
                    },
                    child: Center(
                      child: Text(
                        "Storage Component",
                        textAlign: TextAlign.center,
                        style: AppFonts.titleFont,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.clickableFontColor, width: 2),
                      borderRadius: BorderRadius.circular(25)),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const JobExpensesScreen()));
                    },
                    child: Text(
                      "Job Expenses",
                      textAlign: TextAlign.center,
                      style: AppFonts.titleFont,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
