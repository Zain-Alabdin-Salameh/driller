class DrillingMachine {
  int id;
  String drillerNo;
  DrillingMachine({required this.id, required this.drillerNo});
  factory DrillingMachine.fromMap(Map<String, dynamic> json) =>
      DrillingMachine(id: json['id'], drillerNo: json['drillerNo']);

  Map<String, dynamic> toMap() => {"drillerNo": drillerNo};
}

class Worker {
  int id;
  String name;
  String phoneNumber;
  String drillerNo;
  Worker(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      required this.drillerNo});
  factory Worker.fromMap(Map<String, dynamic> json) => Worker(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      drillerNo: json['drillerNo']);

  Map<String, dynamic> toMap() =>
      {"name": name, "phoneNumber": phoneNumber, "drillerNo": drillerNo};
}

class Job {
  int id;
  String title;
  String description;
  String drillerNo;
  String workerId;
  String clientId;
  Job(
      {required this.id,
      required this.title,
      required this.description,
      required this.drillerNo,
      required this.workerId,
      required this.clientId});
  factory Job.fromMap(Map<String, dynamic> json) => Job(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      drillerNo: json['drillerNo'],
      workerId: json["workerId"],
      clientId: json["clientId"]);

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
        "drillerNo": drillerNo,
        "workerId": workerId,
        "clientId": clientId
      };
}

class Client {
  int id;
  String name;
  String phoneNumber;
  Client({
    required this.id,
    required this.name,
    required this.phoneNumber,
  });
  factory Client.fromMap(Map<String, dynamic> json) => Client(
        id: json['id'],
        name: json['name'],
        phoneNumber: json['phoneNumber'],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "phoneNumber": phoneNumber,
      };
}

class Salary {
  int id;
  String workerId;
  String balance;
  String paied;
  String date;

  Salary(
      {required this.id,
      required this.workerId,
      required this.balance,
      required this.paied,
      required this.date});
  factory Salary.fromMap(Map<String, dynamic> json) => Salary(
      id: json['id'],
      workerId: json['workerId'],
      balance: json['balance'],
      paied: json['paied'],
      date: json['date']);

  Map<String, dynamic> toMap() =>
      {"workerId": workerId, "balance": balance, "paied": paied, "date": date};
}

class StorageComponent {
  int id;
  String name;
  int count;
  int price;
  String date;

  StorageComponent(
      {required this.id,
      required this.name,
      required this.count,
      required this.price,
      required this.date});
  factory StorageComponent.fromMap(Map<String, dynamic> json) =>
      StorageComponent(
          id: json['id'],
          name: json['name'],
          count: json['count'],
          price: json['price'],
          date: json['date']);

  Map<String, dynamic> toMap() =>
      {"name": name, "count": count, "price": price, "date": date};
}

class JobExpenses {
  int id;
  String job_id;
  int count;
  String component_id;
  String date;

  JobExpenses(
      {required this.id,
      required this.job_id,
      required this.count,
      required this.component_id,
      required this.date});
  factory JobExpenses.fromMap(Map<String, dynamic> json) => JobExpenses(
      id: json['id'],
      job_id: json['job_id'],
      count: json['count'],
      component_id: json['component_id'],
      date: json['date']);

  Map<String, dynamic> toMap() => {
        "job_id": job_id,
        "count": count,
        "component_id": component_id,
        "date": date
      };
}
