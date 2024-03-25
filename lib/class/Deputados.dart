class Deputados {
  List<Deputado>? dados;

  Deputados({this.dados});

  Deputados.fromJson(Map<String, dynamic> json) {
    if (json['dados'] != null) {
      dados = <Deputado>[];
      json['dados'].forEach((v) {
        dados!.add(Deputado.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dados != null) {
      data['dados'] = this.dados!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Deputado {
  int? id;
  String? uri;
  String? nome;
  String? siglaPartido;
  String? uriPartido;
  String? siglaUf;
  int? idLegislatura;
  String? urlFoto;
  String? email;

  Deputado({
    this.id,
    this.uri,
    this.nome,
    this.siglaPartido,
    this.uriPartido,
    this.siglaUf,
    this.idLegislatura,
    this.urlFoto,
    this.email,
  });

  Deputado.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uri = json['uri'];
    nome = json['nome'];
    siglaPartido = json['siglaPartido'];
    uriPartido = json['uriPartido'];
    siglaUf = json['siglaUf'];
    idLegislatura = json['idLegislatura'];
    urlFoto = json['urlFoto'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uri'] = this.uri;
    data['nome'] = this.nome;
    data['siglaPartido'] = this.siglaPartido;
    data['uriPartido'] = this.uriPartido;
    data['siglaUf'] = this.siglaUf;
    data['idLegislatura'] = this.idLegislatura;
    data['urlFoto'] = this.urlFoto;
    data['email'] = this.email;
    return data;
  }
}
