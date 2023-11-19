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
  String? thesi;
  String? paratiriseis;
  String? troposapoktisis;
  BlobPic? pic1;
  String? picname1;
  BlobPic? pic2;
  String? picname2;
  BlobPic? pic3;
  String? picname3;
  BlobPic? pic4;
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
    this.thesi,
    this.paratiriseis,
    this.troposapoktisis,
    this.pic1,
    this.picname1,
    this.pic2,
    this.picname2,
    this.pic3,
    this.picname3,
    this.pic4,
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
      'pic1': pic1 != null ? pic1!.toMap() : null,
      'picname1': picname1,
      'pic2': pic2 != null ? pic2!.toMap() : null,
      'picname2': picname2,
      'pic3': pic3 != null ? pic3!.toMap() : null,
      'picname3': picname3,
      'pic4': pic4 != null ? pic4!.toMap() : null,
      'picname4': picname4,
      'category': category,
      'exhibitscol': exhibitscol,
    };
  }

  // Create an Exhibit object from a map
  factory Exhibit.fromMap(Map<String, dynamic> map) {
    try {
      var item = Exhibit(
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
        pic1: map['pic1'] != null ? BlobPic.fromMap(map['pic1']) : null,
        picname1: map['picname1'],
        pic2: map['pic2'] != null ? BlobPic.fromMap(map['pic2']) : null,
        picname2: map['picname2'],
        pic3: map['pic3'] != null ? BlobPic.fromMap(map['pic3']) : null,
        picname3: map['picname3'],
        pic4: map['pic4'] != null ? BlobPic.fromMap(map['pic4']) : null,
        picname4: map['picname4'],
        category: map['category'],
        exhibitscol: map['exhibitscol'],
      );
      return item;
    } catch (e) {
      print("We caught and error! ${e.toString()}");
      return Exhibit(eidos: '');
    }
  }
}

class BlobPic {
  String? type;
  Uint8List? data;

  BlobPic({this.type, this.data});

  // Convert BlobPic object to a Map
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'data': data,
    };
  }

  // Create a BlobPic object from a Map
  static BlobPic fromMap(Map<String, dynamic> map) {
    //add them to a list int because it sees it as a list<dynamic> otherwise
    List<int> data = [];
    for (var item in map['data']) {
      data.add(item);
    }
    return BlobPic(
      type: map['type'],
      data: Uint8List.fromList(data),
    );
  }
}
