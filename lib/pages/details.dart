import '../class/Gastos.dart';
import '../components/fetch_api.dart';
import 'package:flutter/material.dart';
import '../components/Atividades.dart';
import '../components/fetch_api.dart';
import '../components/Gastos.dart';

class Details extends StatelessWidget {
  const Details({super.key});
  static const routeName = 'details';

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context)!.settings.arguments as Map;
    final String? nome = args['nome'];
    final int? id = args['id'];
    final String? siglaPartido = args['siglaPartido'];
    final String? siglaUf = args['siglaUf'];
    final String? urlFoto = args['urlFoto'];
    final String? email = args['email'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 34, 118, 1),
        title: Text('Informações sobre ${nome}'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/fundo_detalhes.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              color: Color.fromRGBO(0, 0, 0, 0.5),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.78,
              height: MediaQuery.of(context).size.width * 1.28,
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      width: 3,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    )),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.20,
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 3),
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(100, 100)),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          "${urlFoto}",
                          width: MediaQuery.of(context).size.width * 0.28,
                          height: MediaQuery.of(context).size.height * 0.10,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                          ),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width * 0.74,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 30),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    color: Color.fromRGBO(0, 0, 0, 0.5),
                                  ),
                                ),
                              ),
                              width: MediaQuery.of(context).size.width * 0.37,
                              child: widget_descricao('Nome:', 0, nome),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 30),
                              width: MediaQuery.of(context).size.width * 0.37,
                              child: widget_descricao('UF:', 0, siglaUf),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                          ),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width * 0.74,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    color: Color.fromRGBO(0, 0, 0, 0.5),
                                  ),
                                ),
                              ),
                              width: MediaQuery.of(context).size.width * 0.37,
                              child:
                                  widget_descricao('Partido:', 0, siglaPartido),
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(left: 8, top: 10),
                              width: MediaQuery.of(context).size.width * 0.37,
                              child: widget_descricao('E-mail:', 0, email),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      child: Text(
                        "Gastos de ${nome}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Gastos(id: id),
                    ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Atividades recentes'),
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Atividades(
                                      id: id,
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: Text('Fechar'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.history),
                      label: Text('Histórico'),
                      style: ButtonStyle(
                        textStyle: MaterialStateProperty.all<TextStyle>(
                            TextStyle(fontSize: 20)),
                        iconSize: MaterialStateProperty.all<double>(28),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

widget_descricao(String? texto, double distancia, String? valor) {
  return Container(
    margin: EdgeInsets.only(top: distancia),
    child: Column(
      children: [
        Text(
          "${texto}",
          style: TextStyle(fontSize: 17),
        ),
        Text(
          '${valor}',
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}
