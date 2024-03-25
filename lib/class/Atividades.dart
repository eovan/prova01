class Atividades {
  List<Atividade>? dados;

  Atividades({this.dados});

  Atividades.fromJson(Map<String, dynamic> json) {
    if (json['dados'] != null) {
      dados = <Atividade>[];
      json['dados'].forEach((v) {
        dados!.add(Atividade.fromJson(v));
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

class Atividade {
  String? dataHoraInicio;
  String? dataHoraFim;
  String? situacao;
  String? descricao;

  Atividade(
      {required this.dataHoraInicio,
      required this.dataHoraFim,
      required this.situacao,
      required this.descricao});

  Atividade.fromJson(Map<String, dynamic> json) {
    dataHoraInicio = json['dataHoraInicio'];
    dataHoraFim = json['dataHoraFim'];
    situacao = json['situacao'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dataHoraInicio'] = this.dataHoraInicio;
    data['dataHoraFim'] = this.dataHoraFim;
    data['situacao'] = this.situacao;
    data['descricao'] = this.descricao;
    return data;
  }
}
