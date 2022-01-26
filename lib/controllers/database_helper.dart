import 'package:driller/models/models.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  late Database _database;

  Future<Database> get database async {
    // if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String documentsDirectory = await getDatabasesPath();
    String path = documentsDirectory + "driller.db";
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE drilling_machines ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
          "drillerNo TEXT NOT NULL"
          ");");
      await db.execute("CREATE TABLE workers ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
          "name TEXT NOT NULL,"
          "phoneNumber TEXT NOT NULL,"
          "drillerNo TEXT NOT NULL"
          ")");
      await db.execute("CREATE TABLE job ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
          "title TEXT,"
          "description TEXT NOT NULL,"
          "drillerNo TEXT NOT NULL,"
          "workerId TEXT NOT NULL,"
          "clientId TEXT NOT NULL"
          ")");
      await db.execute("CREATE TABLE clients ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
          "name TEXT NOT NULL,"
          "phoneNumber TEXT NOT NULL"
          ")");
      await db.execute("CREATE TABLE salaries ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
          "workerId TEXT NOT NULL,"
          "balance TEXT NOT NULL,"
          "paied TEXT NOT NULL,"
          "date TEXT NOT NULL"
          ")");
      await db.execute("CREATE TABLE storage_components ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
          "name TEXT NOT NULL,"
          "count INTEGER NOT NULL,"
          "price INTEGER NOT NULL,"
          "date TEXT NOT NULL"
          ")");
      await db.execute("CREATE TABLE job_expenses ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
          "job_id TEXT NOT NULL,"
          "component_id TEXT NOT NULL,"
          "count INTEGER NOT NULL,"
          "date TEXT NOT NULL"
          ")");
    });
  }

//machines functions
  newMachine(DrillingMachine newDrillingMachines) async {
    final db = await database;
    var res = await db.insert("drilling_machines", newDrillingMachines.toMap());
    return res;
  }

  getMachineById(int id) async {
    final db = await database;
    var res =
        await db.query("drilling_machines", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? DrillingMachine.fromMap(res.first) : Null;
  }

  Future<List<DrillingMachine>> getAllMachines() async {
    final db = await database;
    var res = await db.query("drilling_machines");
    List<DrillingMachine> list =
        res.map((c) => DrillingMachine.fromMap(c)).toList();
    return list;
  }

  updateMachine(DrillingMachine newDrillingMachine) async {
    final db = await database;
    var res = await db.update("drilling_machines", newDrillingMachine.toMap(),
        where: "id = ?", whereArgs: [newDrillingMachine.id]);
    return res;
  }

  deleteMachine(int id) async {
    final db = await database;
    db.delete("drilling_machines", where: "id = ?", whereArgs: [id]);
  }

//clients functions
  newClient(Client newClient) async {
    final db = await database;
    var res = await db.insert("clients", newClient.toMap());
    return res;
  }

  getClientById(int id) async {
    final db = await database;
    var res = await db.query("clients", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Client.fromMap(res.first) : Null;
  }

  Future<List<Client>> getAllClients() async {
    final db = await database;
    var res = await db.query("clients");
    List<Client> list =
        res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
    return list;
  }

  updateClient(Client newClient) async {
    final db = await database;
    var res = await db.update("clients", newClient.toMap(),
        where: "id = ?", whereArgs: [newClient.id]);
    return res;
  }

  deleteClient(int id) async {
    final db = await database;
    db.delete("clients", where: "id = ?", whereArgs: [id]);
  }

//workers functions
  newWorker(Worker newWorker) async {
    final db = await database;
    var res = await db.insert("workers", newWorker.toMap());
    return res;
  }

  getWorkerById(int id) async {
    final db = await database;
    var res = await db.query("workers", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Worker.fromMap(res.first) : Null;
  }

  Future<List<Worker>> getAllWorkers() async {
    final db = await database;
    var res = await db.query("workers");
    List<Worker> list = res.map((c) => Worker.fromMap(c)).toList();
    return list;
  }

  updateWorker(Worker newClient) async {
    final db = await database;
    var res = await db.update("workers", newClient.toMap(),
        where: "id = ?", whereArgs: [newClient.id]);
    return res;
  }

  deleteWorker(int id) async {
    final db = await database;
    db.delete("workers", where: "id = ?", whereArgs: [id]);
  }

//----------------------jobs-------------------
  newJob(Job job) async {
    final db = await database;
    var res = await db.insert("job", job.toMap());
    return res;
  }

  getJobById(int id) async {
    final db = await database;
    var res = await db.query("job", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Job.fromMap(res.first) : Null;
  }

  Future<List<Job>> getAllJobs() async {
    final db = await database;
    var res = await db.query("job");
    List<Job> list = res.map((c) => Job.fromMap(c)).toList();
    return list;
  }

  updateJob(Job newjob) async {
    final db = await database;
    var res = await db
        .update("job", newjob.toMap(), where: "id = ?", whereArgs: [newjob.id]);
    return res;
  }

  deleteJob(int id) async {
    final db = await database;
    db.delete("job", where: "id = ?", whereArgs: [id]);
  }

//----------------------salaries------------------
  newSalary(Salary salary) async {
    final db = await database;
    var res = await db.insert("salaries", salary.toMap());
    return res;
  }

  getSalaryId(int id) async {
    final db = await database;
    var res = await db.query("salaries", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Salary.fromMap(res.first) : Null;
  }

  Future<List<Salary>> getAllSalaries() async {
    final db = await database;
    var res = await db.query("salaries");
    List<Salary> list = res.map((c) => Salary.fromMap(c)).toList();
    return list;
  }

  updateSalary(Salary newsalary) async {
    final db = await database;
    var res = await db.update("salaries", newsalary.toMap(),
        where: "id = ?", whereArgs: [newsalary.id]);
    return res;
  }

  deleteSalary(int id) async {
    final db = await database;
    db.delete("salaries", where: "id = ?", whereArgs: [id]);
  }

//------------storage components------------
  newStorageComponent(StorageComponent sc) async {
    final db = await database;
    var res = await db.insert("storage_components", sc.toMap());
    return res;
  }

  getStorageComponentById(int id) async {
    final db = await database;
    var res =
        await db.query("storage_components", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? StorageComponent.fromMap(res.first) : Null;
  }

  Future<List<StorageComponent>> getAllStorageComponents() async {
    final db = await database;
    var res = await db.query("storage_components");
    List<StorageComponent> list =
        res.map((c) => StorageComponent.fromMap(c)).toList();
    return list;
  }

  updateStorageComponent(StorageComponent newStorageComponent) async {
    final db = await database;
    var res = await db.update("storage_components", newStorageComponent.toMap(),
        where: "id = ?", whereArgs: [newStorageComponent.id]);
    return res;
  }

  deleteStorageComponent(int id) async {
    final db = await database;
    db.delete("storage_components", where: "id = ?", whereArgs: [id]);
  }
  //-------------job expenses-----------------

  newJobExpenses(JobExpenses je) async {
    final db = await database;
    var res = await db.insert("job_expenses", je.toMap());
    return res;
  }

  getJobExpensesById(int id) async {
    final db = await database;
    var res = await db.query("job_expenses", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? JobExpenses.fromMap(res.first) : Null;
  }

  Future<List<JobExpenses>> getAllJobExpenses() async {
    final db = await database;
    var res = await db.query("job_expenses");
    List<JobExpenses> list = res.map((c) => JobExpenses.fromMap(c)).toList();
    return list;
  }

  updateJobExpenses(JobExpenses newJobExpenses) async {
    final db = await database;
    var res = await db.update("job_expenses", newJobExpenses.toMap(),
        where: "id = ?", whereArgs: [newJobExpenses.id]);
    return res;
  }

  deleteJobExpenses(int id) async {
    final db = await database;
    db.delete("job_expenses", where: "id = ?", whereArgs: [id]);
  }
}
