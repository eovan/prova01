import '../components/Rodape.dart';
import '../pages/membros.dart';

import '../class/Comicao.dart';
import 'package:flutter/material.dart';

import '../components/fetch_api.dart';
import 'details.dart';
import 'search.dart';

class Comicoes extends StatefulWidget {
  const Comicoes({Key? key}) : super(key: key);
  static const routeName = 'comicoes';

  @override
  _ComicoesState createState() => _ComicoesState();
}

class _ComicoesState extends State<Comicoes> {
  late Future<List<Comicao>> _futureComicoes;
  bool showSearch = false;
  @override
  void initState() {
    super.initState();
    _futureComicoes = fetchComicao();
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
            : Text('Comições'),
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
      body: FutureBuilder<List<Comicao>>(
        future: _futureComicoes,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('An error has occurred!');
          } else if (snapshot.hasData) {
            return DeputadosList(comicoes: snapshot.data!);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: RodaPe(indiceAtual: 2),
    );
  }
}

class DeputadosList extends StatelessWidget {
  const DeputadosList({Key? key, required this.comicoes}) : super(key: key);

  final List<Comicao> comicoes;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Text(
            'Comições',
            style: TextStyle(fontSize: 30),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.99,
          height: MediaQuery.of(context).size.height * 0.80,
          child: ListView.builder(
            itemCount: comicoes.length,
            itemBuilder: (context, index) {
              final comicao = comicoes[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.98,
                          height: MediaQuery.of(context).size.height * 0.10,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 43, 157, 228)),
                            onPressed: () => Navigator.pushNamed(
                              context,
                              Membros.routeName,
                              arguments: {
                                'id': comicoes[index].id,
                              },
                            ),
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Text(
                                  '${comicao.nome}',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
