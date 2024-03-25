import '../components/Rodape.dart';

import '../class/Deputados.dart';
import 'package:flutter/material.dart';

import '../components/fetch_api.dart';
import 'details.dart';
import 'search.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  static const routeName = '/';
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Deputado>> _futureDeputados;
  bool showSearch = false;
  @override
  void initState() {
    super.initState();
    _futureDeputados = fetchDeputados();
  }

  bool searchVisible = false;
  TextEditingController searchController = TextEditingController();

  void handleSearch(String searchTerm) {
    // Aqui você pode implementar a lógica para realizar a pesquisa
    Navigator.pushNamed(
      context,
      SearchPage.routeName,
      arguments: {
        'campo': searchTerm,
      },
    );
    // Atualize o estado, se necessário
  }

  void clearSearch() {
    setState(() {
      showSearch = false;
      searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 34, 118, 1),
        title: showSearch
            ? TextField(
                onSubmitted: handleSearch,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Digite sua pesquisa',
                  hintStyle: TextStyle(color: Colors.white70),
                ),
              )
            : Text(widget.title),
        actions: [
          if (showSearch)
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: clearSearch,
            )
          else
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  showSearch = true;
                });
              },
            ),
        ],
      ),
      body: FutureBuilder<List<Deputado>>(
        future: _futureDeputados,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('An error has occurred!');
          } else if (snapshot.hasData) {
            return DeputadosList(deputados: snapshot.data!);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: RodaPe(indiceAtual: 0),
    );
  }
}

class DeputadosList extends StatelessWidget {
  const DeputadosList({Key? key, required this.deputados}) : super(key: key);

  final List<Deputado> deputados;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 1,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
              'Deputados',
              style: TextStyle(fontSize: 30),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.99,
            height: MediaQuery.of(context).size.height * 0.80,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing:
                      10, // Espaçamento entre os itens na horizontal
                  childAspectRatio: 0.68),
              itemCount: deputados.length,
              itemBuilder: (context, index) {
                final deputado = deputados[index];
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.20,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.31,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 43, 157, 228),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                    color: Color.fromRGBO(48, 108, 172, 1),
                                    width: 5,
                                  ),
                                ),
                              ),
                              onPressed: () => Navigator.pushNamed(
                                context,
                                Details.routeName,
                                arguments: {
                                  'id': deputados[index].id,
                                  'nome': deputados[index].nome,
                                  'siglaPartido': deputados[index].siglaPartido,
                                  'siglaUf': deputados[index].siglaUf,
                                  'urlFoto': deputados[index].urlFoto,
                                  'email': deputados[index].email,
                                },
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      "${deputado.urlFoto}",
                                      width: MediaQuery.of(context).size.width *
                                          0.26,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.13,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${deputado.nome}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Color.fromRGBO(0, 0, 0, 0.7),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "${deputado.siglaPartido}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Color.fromRGBO(0, 0, 0, 0.7),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
