import 'package:flutter/material.dart';
import 'package:sql_conn/sql_conn.dart';

class LocalDataBase {
  static Future<void> connect() async {
    debugPrint("Connecting...");
    try {
      await SqlConn.connect(
          ip: "192.168.40.1",
          port: "1433",
          databaseName: "DB_DormitoryAffairs",
          username: "",
          password: "");
      debugPrint("Connected!");
    } catch (e) {
      debugPrint("some thing happened ${e.toString()}");
    }
  }

  static Future<void> read(String query) async {
    var res = await SqlConn.readData(query);
    debugPrint(res.toString());
  }

  static Future<void> write(String query) async {
    var res = await SqlConn.writeData(query);
    debugPrint(res.toString());
  }
}
