class Despesas {
  List<Despesa>? dados;

  Despesas({this.dados});

  Despesas.fromJson(Map<String, dynamic> json) {
    if (json['dados'] != null) {
      dados = <Despesa>[];
      json['dados'].forEach((v2) {
        dados!.add(Despesa.fromJson(v2));
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

class Despesa {
  String? tipoDespesa;
  double? valorDespesa;

  Despesa({required this.tipoDespesa, required this.valorDespesa});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tipoDespesa'] = this.tipoDespesa;
    data['valorDocumento'] = this.valorDespesa;
    return data;
  }

  Despesa.fromJson(Map<String, dynamic> json) {
    tipoDespesa = json['tipoDespesa'];
    valorDespesa = json['valorDocumento'];
  }
}
