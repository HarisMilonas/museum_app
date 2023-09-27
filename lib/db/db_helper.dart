import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  // create tables
  static Future<void> createTables(sql.Database database) async {
    await database.execute('''CREATE TABLE exhibits (
  idexhibit INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  omada VARCHAR(45) COLLATE NOCASE DEFAULT NULL,
  aa INTEGER DEFAULT NULL,
  aagenkat VARCHAR(45) COLLATE NOCASE DEFAULT NULL,
  aaeidkat VARCHAR(45) COLLATE NOCASE DEFAULT NULL,
  eidos TEXT COLLATE NOCASE,
  diastaseis VARCHAR(1024) COLLATE NOCASE DEFAULT NULL,
  proelefsi VARCHAR(1024) COLLATE NOCASE DEFAULT NULL,
  chronologisi VARCHAR(1024) COLLATE NOCASE DEFAULT NULL,
  thesi TEXT COLLATE NOCASE,
  paratiriseis TEXT COLLATE NOCASE DEFAULT NULL,
  troposapoktisis TEXT COLLATE NOCASE,
  pic1 BLOB,
  picname1 VARCHAR(45) COLLATE NOCASE DEFAULT NULL,
  pic2 BLOB,
  picname2 VARCHAR(45) COLLATE NOCASE DEFAULT NULL,
  pic3 BLOB,
  picname3 VARCHAR(45) COLLATE NOCASE DEFAULT NULL,
  pic4 BLOB,
  picname4 VARCHAR(45) COLLATE NOCASE DEFAULT NULL,
  category VARCHAR(256) COLLATE NOCASE DEFAULT NULL,
  exhibitscol VARCHAR(45) COLLATE NOCASE DEFAULT NULL
);

''');
  }

// open or Create db
  static Future<sql.Database> db() async {
    return sql.openDatabase("museum.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    }, onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < newVersion) {}
    });
  }

//   static Future<int> createData(Map<String, dynamic> model) async {
//     final db = await SQLHelper.db();
//     // Logger().d(model);
//     final id = await db.insert('service_items', model,
//         conflictAlgorithm: sql.ConflictAlgorithm.replace);
//     return id;
//   }

//   static Future<void> createMultipleData(
//       List<Map<String, dynamic>> models) async {
//     final db = await SQLHelper.db();

//     final batch = db.batch();

//     for (var model in models) {
//       batch.insert("service_items", model);
//     }

//     await batch.commit();
//   }

//   static Future<List<Map<String, dynamic>>> getAllAssignmentData(
//       String assignmentId) async {
//     final db = await SQLHelper.db();
//     if (kDebugMode) {
//       print('we got data from database!');
//     }
//     return db.query('service_items',
//         where: "assignment_id = ?", whereArgs: [assignmentId], orderBy: 'id');
//     // return db.rawQuery(
//     //     "SELECT * FROM service_items WHERE service_id = ? ORDER BY id", [serviceId]);
//   }

//   static Future<List<Map<String, dynamic>>> getAllData(
//       String serviceId, String assignmentId) async {
//     final db = await SQLHelper.db();
//     if (kDebugMode) {
//       print('we got data from database!');
//     }
//     return db.query('service_items',
//         where: "service_id = ? AND assignment_id = ?",
//         whereArgs: [serviceId, assignmentId],
//         orderBy: 'id');
//     // return db.rawQuery(
//     //     "SELECT * FROM service_items WHERE service_id = ? ORDER BY id", [serviceId]);
//   }

//   static Future<List<Map<String, dynamic>>> getSingleData(int id) async {
//     final db = await SQLHelper.db();
//     return db.query('service_items',
//         where: 'id = ? ', whereArgs: [id], limit: 1);
//   }

//   static Future<int> updateData(int? id, Map<String, dynamic> model) async {
//     final db = await SQLHelper.db();

//     final result = await db.update(
//       'service_items',
//       model,
//       where: "id = ?",
//       whereArgs: [id],
//     );
//     return result;
//   }

//   static Future<void> deleteData(int? id) async {
//     final db = await SQLHelper.db();
//     try {
//       await db.delete('service_items', where: "id = ?", whereArgs: [id]);
//     } catch (e) {
//       //some action here
//     }
//   }

//   static Future<void> deleteModel(String assignmentId, String serviceId) async {
//     final db = await SQLHelper.db();
//     try {
//       await db.delete('service_items',
//           where: "assignment_id = ? AND service_id = ?",
//           whereArgs: [assignmentId, serviceId]);
//     } catch (e) {
//       //some action here
//     }
//   }

//   static Future<void> deleteServices(String assignmentId) async {
//     final db = await SQLHelper.db();
//     try {
//       await db.delete('service_items',
//           where: "assignment_id = ?", whereArgs: [assignmentId]);
//     } catch (e) {
//       //some action here
//     }
//   }

//   void resetAutoIncrementID() async {
//     // Step 1: Open the database
//     final db = await SQLHelper.db();

//     // Step 2: Delete all rows from the table
//     await db.delete('service_items');

//     // Step 3: Reset the auto-increment ID
//     await db.rawDelete(
//         "UPDATE SQLITE_SEQUENCE SET SEQ=0 WHERE NAME='service_items'");

//     // Step 4: Close the database
//     await db.close();
//   }

// // Assuming you have a database instance called 'database'

// // Assuming you have a database instance called 'database'

//   Future<bool> checkSerialNumberExists(Object? serialNumber) async {
//     final db = await SQLHelper.db();
//     final jsonColumns = await db.query('service_items');

//     for (final jsonColumn in jsonColumns) {
//       final jsonString = jsonColumn['item_details'].toString();
//       final jsonObject = jsonDecode(jsonString);

//       if (jsonObject is Map<String, dynamic> &&
//           jsonObject.containsKey('serial_number')) {
//         final serialNumberValue = jsonObject['serial_number'];

//         if (serialNumberValue == serialNumber.toString()) {
//           return true; // Serial number found in JSON column
//         }
//       }
//     }
//     return false; // Serial number not found in any JSON column
//   }
}
