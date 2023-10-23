import 'dart:typed_data';


class Exhibit {
  int? idexhibit;
  String? omada;
  int? aa;
  String? aagenkat;
  String? aaeidkat;
  String eidos;
  String? diastaseis;
  String? proelefsi;
  String? chronologisi;
  String thesi;
  String paratiriseis;
  String troposapoktisis;
  Uint8List pic1;
  String? picname1;
  Uint8List pic2;
  String? picname2;
  Uint8List pic3;
  String? picname3;
  Uint8List pic4;
  String? picname4;
  String? category;
  String? exhibitscol;

  Exhibit({
    this.idexhibit,
    this.omada,
    this.aa,
    this.aagenkat,
    this.aaeidkat,
    required this.eidos,
    this.diastaseis,
    this.proelefsi,
    this.chronologisi,
    required this.thesi,
    required this.paratiriseis,
    required this.troposapoktisis,
    required this.pic1,
    this.picname1,
    required this.pic2,
    this.picname2,
    required this.pic3,
    this.picname3,
    required this.pic4,
    this.picname4,
    this.category,
    this.exhibitscol,
  });
  // Convert Exhibit object to a map
  Map<String, dynamic> toMap() {
    return {
      'idexhibit': idexhibit,
      'omada': omada,
      'aa': aa,
      'aagenkat': aagenkat,
      'aaeidkat': aaeidkat,
      'eidos': eidos,
      'diastaseis': diastaseis,
      'proelefsi': proelefsi,
      'chronologisi': chronologisi,
      'thesi': thesi,
      'paratiriseis': paratiriseis,
      'troposapoktisis': troposapoktisis,
      'pic1': pic1,
      'picname1': picname1,
      'pic2': pic2,
      'picname2': picname2,
      'pic3': pic3,
      'picname3': picname3,
      'pic4': pic4,
      'picname4': picname4,
      'category': category,
      'exhibitscol': exhibitscol,
    };
  }

  // Create an Exhibit object from a map
  factory Exhibit.fromMap(Map<String, dynamic> map) {
    return Exhibit(
      idexhibit: map['idexhibit'],
      omada: map['omada'],
      aa: map['aa'],
      aagenkat: map['aagenkat'],
      aaeidkat: map['aaeidkat'],
      eidos: map['eidos'],
      diastaseis: map['diastaseis'],
      proelefsi: map['proelefsi'],
      chronologisi: map['chronologisi'],
      thesi: map['thesi'],
      paratiriseis: map['paratiriseis'],
      troposapoktisis: map['troposapoktisis'],
      pic1: map['pic1'],
      picname1: map['picname1'],
      pic2: map['pic2'],
      picname2: map['picname2'],
      pic3: map['pic3'],
      picname3: map['picname3'],
      pic4: map['pic4'],
      picname4: map['picname4'],
      category: map['category'],
      exhibitscol: map['exhibitscol'],
    );
  }

}
