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
  List<int> pic1;
  String? picname1;
  List<int> pic2;
  String? picname2;
  List<int> pic3;
  String? picname3;
  List<int> pic4;
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


  


}
