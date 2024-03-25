import '../class/Atividades.dart';
import '../class/Comicao.dart';
import '../class/Membros.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:remove_diacritic/remove_diacritic.dart';
import '../class/Deputados.dart';
import '../class/Gastos.dart';

Future<List<Deputado>> buscarDeputados(String tipo) async {
  // Chamada à API para buscar todos os bioinsumos
  List<Deputado>? deputados = await fetchDeputados();

  // Converter as palavras-chave para sequências normalizadas sem acentos
  tipo = removeDiacritics(tipo);

  // Filtrar os bioinsumos pelo tipo de fertilizante e cultura
  List<Deputado>? DeputadosFiltrados = deputados
      .where((deputados) =>
          deputados.nome!.toLowerCase().contains(tipo.toLowerCase()) ||
          deputados.siglaPartido!.toLowerCase().contains(tipo.toLowerCase()) ||
          deputados.siglaUf!.toLowerCase().contains(tipo.toLowerCase()) ||
          deputados.email!.toLowerCase().contains(tipo.toLowerCase()))
      .toList();

  return DeputadosFiltrados;
}

Future<List<Atividade>> fetchAtividades(int? id) async {
  final response = await http.get(Uri.parse(
      'https://dadosabertos.camara.leg.br/api/v2/deputados/${id}/eventos?ordem=ASC&ordenarPor=dataHoraInicio'));

  if (response.statusCode == 200) {
    final jsonDecoded = jsonDecode(response.body);
    final AtividadeJson = jsonDecoded['dados'] as List<dynamic>;

    return AtividadeJson.map((json) => Atividade.fromJson(json)).toList();
  } else {
    throw Exception('Failed to fetch deputados');
  }
}

Future<List<Despesa>> fetchDespesas(int? id) async {
  final response = await http.get(Uri.parse(
      'https://dadosabertos.camara.leg.br/api/v2/deputados/${id}/despesas?ordem=ASC&ordenarPor=mes'));

  if (response.statusCode == 200) {
    final jsonDecoded = jsonDecode(response.body);
    final despesaJson = jsonDecoded['dados'] as List<dynamic>;

    return despesaJson.map((json) => Despesa.fromJson(json)).toList();
  } else {
    throw Exception('Failed to fetch deputados');
  }
}

Future<List<Deputado>> fetchDeputados() async {
  final response = await http
      .get(Uri.parse('https://dadosabertos.camara.leg.br/api/v2/deputados'));

  if (response.statusCode == 200) {
    final jsonDecoded = jsonDecode(response.body);
    final deputadosJson = jsonDecoded['dados'] as List<dynamic>;

    return deputadosJson.map((json) => Deputado.fromJson(json)).toList();
  } else {
    throw Exception('Failed to fetch deputados');
  }
}

Future<List<Comicao>> fetchComicao() async {
  final response = await http.get(Uri.parse(
      'https://dadosabertos.camara.leg.br/api/v2/orgaos?ordem=ASC&ordenarPor=id'));

  if (response.statusCode == 200) {
    final jsonDecoded = jsonDecode(response.body);
    final ComicaoJson = jsonDecoded['dados'] as List<dynamic>;

    return ComicaoJson.map((json) => Comicao.fromJson(json)).toList();
  } else {
    throw Exception('Failed to fetch deputados');
  }
}

Future<List<Membro>> fetchMembros(int? id) async {
  final response = await http.get(Uri.parse(
      'https://dadosabertos.camara.leg.br/api/v2/orgaos/${id}/membros'));

  if (response.statusCode == 200) {
    final jsonDecoded = jsonDecode(response.body);
    final despesaJson = jsonDecoded['dados'] as List<dynamic>;

    return despesaJson.map((json) => Membro.fromJson(json)).toList();
  } else {
    throw Exception('Failed to fetch deputados');
  }
}
