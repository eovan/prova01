class Membro {
  int? id;
  int? codTitulo;
  int? idLegislatura;
  String? nome;
  String? uf;
  String? siglaPartido;
  String? urlFoto;
  String? email;
  Membro(
      {required this.id,
      required this.codTitulo,
      required this.idLegislatura,
      required this.nome,
      required this.siglaPartido,
      required this.uf,
      required this.urlFoto,
      required this.email});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['codTitulo'] = this.codTitulo;
    data['idLegislatura'] = this.idLegislatura;
    data['nome'] = this.nome;
    data['siglaPartido'] = this.siglaPartido;
    data['siglaUf'] = this.uf;
    data['urlFoto'] = this.urlFoto;
    data['email'] = this.email;
    return data;
  }

  Membro.fromJson(Map<String, dynamic> json) {
    codTitulo = json['codTitulo'];
    idLegislatura = json['idLegislatura'];
    id = json['id'];
    uf = json['siglaUf'];
    siglaPartido = json['siglaPartido'];
    nome = json['nome'];
    urlFoto = json['urlFoto'];
    email = json['email'];
  }
}
