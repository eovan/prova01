import '../class/Gastos.dart';
import '../components/fetch_api.dart';
import 'package:flutter/material.dart';

class Gastos extends StatefulWidget {
  final int? id;
  const Gastos({super.key, this.id});

  @override
  State<Gastos> createState() => _GastosState();
}

class _GastosState extends State<Gastos> {
  late Future<List<Despesa>> _futureDespesa;
  @override
  void initState() {
    super.initState();
    _futureDespesa = fetchDespesas(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Despesa>>(
      future: _futureDespesa,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('An error has occurred!');
        } else if (snapshot.hasData) {
          return MostraGasto(despesas: snapshot.data!);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class MostraGasto extends StatelessWidget {
  const MostraGasto({super.key, required this.despesas});
  final List<Despesa> despesas;

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
      height: MediaQuery.of(context).size.width * 0.35,
      child: ListView.builder(
        itemCount: despesas.length,
        itemBuilder: (context, index) {
          final gasto = despesas[index];
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.5)))),
            child: Column(
              children: [
                Text(
                  "Serviço: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
                Text("${gasto.tipoDespesa}"),
                Text(
                  "Custo: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("R\$ ${gasto.valorDespesa},00"),
              ],
            ),
          );
        },
      ),
    );
  }
}
