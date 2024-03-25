import '../class/Atividades.dart';
import 'package:flutter/material.dart';

import 'fetch_api.dart';

class Atividades extends StatefulWidget {
  const Atividades({super.key, this.id});
  final int? id;
  @override
  State<Atividades> createState() => _AtividadesState();
}

class _AtividadesState extends State<Atividades> {
  late Future<List<Atividade>> _futureAtividade;
  @override
  void initState() {
    super.initState();
    _futureAtividade = fetchAtividades(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Atividade>>(
      future: _futureAtividade,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('An error has occurred: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return MostraAtividades(atividades: snapshot.data!);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class MostraAtividades extends StatelessWidget {
  const MostraAtividades({super.key, required this.atividades});
  final List<Atividade> atividades;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color.fromRGBO(0, 0, 0, 0.5),
          ),
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.74,
      height: MediaQuery.of(context).size.width * 0.55,
      child: ListView.builder(
        itemCount: atividades.length,
        itemBuilder: (context, index) {
          final ativdd = atividades[index];
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.5)))),
            child: Column(
              children: [
                Text(
                  "Descrição: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
                Text("${ativdd.descricao}"),
                Text(
                  "Início: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
                Text("${ativdd.dataHoraInicio}"),
                Text(
                  "Fim: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("${ativdd.dataHoraFim}"),
                Text(
                  "Situação: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
                Text("${ativdd.situacao}"),
              ],
            ),
          );
        },
      ),
    );
  }
}
