import '../components/Rodape.dart';
import 'package:flutter/material.dart';

import '../class/Deputados.dart';
import '../class/Membros.dart';
import '../components/fetch_api.dart';
import 'HomePage.dart';
import 'details.dart';

class Membros extends StatefulWidget {
  const Membros({Key? key, required this.title}) : super(key: key);

  static const routeName = 'membros';

  final String title;

  @override
  _MembrosState createState() => _MembrosState();
}

class _MembrosState extends State<Membros> {
  late Future<List<Membro>> _futureMembros;
  bool showSearch = false;
  bool isLoading = false;
  List<Deputado> searchResults = [];

  @override
  void initState() {
    super.initState();
  }

  void handleSearch(String searchTerm) {
    setState(() {
      isLoading = true;
    });

    buscarDeputados(searchTerm).then((results) {
      setState(() {
        isLoading = false;
        searchResults = results;
      });
    });
  }

  void clearSearch() {
    setState(() {
      showSearch = false;
      searchResults = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context)!.settings.arguments as Map;
    final int id = args['id'];
    _futureMembros = fetchMembros(id);
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
      body: FutureBuilder<List<Membro>>(
        future: _futureMembros,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('An error has occurred!');
          } else if (snapshot.hasData) {
            return MembrosList(membros: snapshot.data!);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: RodaPe(indiceAtual: 2),
    );
  }
}

class MembrosList extends StatelessWidget {
  const MembrosList({Key? key, required this.membros}) : super(key: key);

  final List<Membro> membros;

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
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing:
                    10, // Espaçamento entre os itens na horizontal
                childAspectRatio: 0.68),
            itemCount: membros.length,
            itemBuilder: (context, index) {
              final membro = membros[index];
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
                                'id': membros[index].id,
                                'nome': membros[index].nome,
                                'siglaPartido': membros[index].siglaPartido,
                                'siglaUf': membros[index].uf,
                                'urlFoto': membros[index].urlFoto,
                                'email': membros[index].email,
                              },
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    "${membro.urlFoto}",
                                    width: MediaQuery.of(context).size.width *
                                        0.26,
                                    height: MediaQuery.of(context).size.height *
                                        0.13,
                                    alignment: Alignment.center,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${membro.nome}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color.fromRGBO(0, 0, 0, 0.7),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "${membro.siglaPartido}",
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
    );
  }
}
