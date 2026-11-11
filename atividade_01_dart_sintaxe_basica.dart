enum Classificacao {
  semAvaliacoes,
  baixa,
  regular,
  alta,
}

void main() {
  const notaMinima = 1;
  const notaMaxima = 5;
  const notaPositiva = 4;

  final notasRecebidas = <String, List<String>>{
    'Agenda UFAPE': ['5', '4', '5', '0', '3', '6'],
    'Biblioteca Digital': ['3', '2', '4', '1'],
    'Mapa do Campus': [],
    'Restaurante Universitário': ['5', '5', '4', '4', '5'],
    'Transporte Universitário': ['0', '6', '-1'],
  };

  final categoriasPorApp = <String, String>{
    'Agenda UFAPE': 'Organização',
    'Biblioteca Digital': 'Serviços',
    'Mapa do Campus': 'Localização',
    'Restaurante Universitário': 'Serviços',
    'Transporte Universitário': 'Serviços',
  };

  final contatosPorApp = <String, String?>{
    'Agenda UFAPE': 'agenda@exemplo.com',
    'Biblioteca Digital': null,
    'Mapa do Campus': 'mapa@exemplo.com',
    'Restaurante Universitário': 'ru@exemplo.com',
  };

  // QUESTÃO 1 — PREPARAÇÃO DOS DADOS

  final notasValidasPorApp = <String, List<int>>{};
  final descartadasPorApp = <String, int>{};
  final categoriasUnicas = <String>{};

  notasRecebidas.forEach((app, notas) {
    final notasValidas = <int>[];
    int descartadas = 0;

    notas.forEach((nota) {
      final valor = int.parse(nota);

      if (valor >= notaMinima && valor <= notaMaxima) {
        notasValidas.add(valor);
      } else {
        descartadas++;
      }
    });

    notasValidasPorApp[app] = notasValidas;
    descartadasPorApp[app] = descartadas;
    categoriasUnicas.add(categoriasPorApp[app]!);
  });

  // QUESTÃO 2 — RELATÓRIO

  print('RELATÓRIO DE AVALIAÇÕES');
  print('======================');

  notasRecebidas.forEach((app, _) {
    final notas = notasValidasPorApp[app]!;
    final descartadas = descartadasPorApp[app]!;

    final media = calcularMedia(notas);
    final porcentagemPositiva =
        calcularPorcentagemPositiva(notas, notaPositiva);

    final classificacao = classificar(media, notas.isEmpty);

    print('\nApp: $app');
    print('Categoria: ${categoriasPorApp[app]}');
    print('Contato: ${contatosPorApp[app] ?? 'Não informado'}');
    print('Quantidade de notas válidas: ${notas.length}');
    print('Quantidade de notas descartadas: $descartadas');
    print('Média: ${media.toStringAsFixed(2)}');
    print('Porcentagem positiva: ${porcentagemPositiva.toStringAsFixed(2)}%');
    print('Classificação: ${textoClassificacao(classificacao)}');
    print('---------------------------------------');
  });

  print('\nCATEGORIAS ENCONTRADAS');

  categoriasUnicas.forEach((categoria) {
    print(categoria);
  });
}

// CÁLCULO DA MÉDIA

double calcularMedia(List<int> notas) {
  if (notas.isEmpty) return 0;

  return notas.reduce((a, b) => a + b) / notas.length;
}

// CÁLCULO DA PORCENTAGEM POSITIVA

double calcularPorcentagemPositiva(
    List<int> notas, int notaPositiva) {
  if (notas.isEmpty) return 0;

  final positivas =
      notas.where((nota) => nota >= notaPositiva).length;

  return (positivas / notas.length) * 100;
}

// CLASSIFICAÇÃO BASEADA NA MÉDIA

Classificacao classificar(double media, bool semAvaliacoes) {
  if (semAvaliacoes) return Classificacao.semAvaliacoes;
  if (media < 3) return Classificacao.baixa;
  if (media < 4) return Classificacao.regular;

  return Classificacao.alta;
}

// CONVERSÃO DO ENUM PARA TEXTO

String textoClassificacao(Classificacao classificacao) {
  switch (classificacao) {
    case Classificacao.semAvaliacoes:
      return 'Sem avaliações';
    case Classificacao.baixa:
      return 'Baixa';
    case Classificacao.regular:
      return 'Regular';
    case Classificacao.alta:
      return 'Alta';
  }
}
