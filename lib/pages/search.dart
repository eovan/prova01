import '../components/Rodape.dart';
import 'package:flutter/material.dart';

import '../class/Deputados.dart';
import '../components/fetch_api.dart';
import 'HomePage.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.title}) : super(key: key);

  static const routeName = 'search';

  final String title;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<List<Deputado>> _futureDeputados;
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
    final String campo = args['campo'];
    _futureDeputados = buscarDeputados(campo);
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : searchResults.isNotEmpty
              ? DeputadosList(deputados: searchResults)
              : FutureBuilder<List<Deputado>>(
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
      bottomNavigationBar: RodaPe(indiceAtual: 1),
    );
  }
}
