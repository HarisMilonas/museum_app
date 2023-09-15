import 'dart:typed_data';

import 'package:museum_app/db/db_helper.dart';
import 'package:museum_app/models/exhibit.dart';

class ExhibitController extends Exhibit {
  ExhibitController(
      {required super.eidos,
      required super.thesi,
      required super.paratiriseis,
      required super.troposapoktisis,
      required super.pic1,
      required super.pic2,
      required super.pic3,
      required super.pic4});

  Future<void> rawInsert() async {
    final db = await SQLHelper.db();
    // Insert a new record into the exhibits table
    try {
      await db.rawInsert(
        '''
      INSERT INTO exhibits(
        omada, aa, aagenkat, aaeidkat, eidos, diastaseis,
        proelefsi, chronologisi, thesi, paratiriseis, troposapoktisis,
        pic1, picname1, pic2, picname2, pic3, picname3,
        pic4, picname4, category, exhibitscol
      ) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      ''',
        [
          'Sample Omada',
          1,
          'Sample Aagenkat',
          'Sample Aaeidkat',
          'Sample Eidos',
          'Sample Diastaseis',
          'Sample Proelefsi',
          'Sample Chronologisi',
          'Sample Thesi',
          'Sample Paratiriseis',
          'Sample Troposapoktisis',
          Uint8List.fromList([1, 2, 3]), // Replace with your binary data
          'Sample Picname1',
          Uint8List.fromList([4, 5, 6]), // Replace with your binary data
          'Sample Picname2',
          Uint8List.fromList([7, 8, 9]), // Replace with your binary data
          'Sample Picname3',
          Uint8List.fromList([10, 11, 12]), // Replace with your binary data
          'Sample Picname4',
          'Sample Category',
          'Sample Exhibitscol',
        ],
      );

      // Close the database when you're done
      await db.close();
      print("Data Saved Successfully!");
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }
}
