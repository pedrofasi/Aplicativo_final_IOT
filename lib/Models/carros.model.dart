class Carros {
  int id;
  String placa;
  String chassi;
  String kmporlitro;
  String codigofk;

  Carros({this.id, this.placa, this.chassi, this.kmporlitro, this.codigofk});

  Carros.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    placa = json['placa'];
    chassi = json['chassi'];
    kmporlitro = json['kmporlitro'];
    codigofk = json['codigofk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['placa'] = this.placa;
    data['chassi'] = this.chassi;
    data['kmporlitro'] = this.kmporlitro;
    data['codigofk'] = this.codigofk;
    return data;
  }
}