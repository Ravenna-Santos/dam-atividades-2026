
abstract class Livro {
  final int codigo;
  String _titulo;
  final String? autor;

  Livro({
    required this.codigo,
    required String titulo,
    this.autor,
  }) : _titulo = titulo.trim();

  String get titulo => _titulo;

  // Encapsulamento: altera o título somente se não estiver vazio.
  set titulo(String novoTitulo) {
    final tituloTratado = novoTitulo.trim();

    if (tituloTratado.isNotEmpty) {
      _titulo = tituloTratado;
    }
  }

  String get nomeAutor {
    if (autor == null || autor!.trim().isEmpty) {
      return 'Autor desconhecido';
    }
    return autor!.trim();
  }

  String descricao();
}

// Extensão para gerar a referência do livro.
extension ReferenciaLivro on Livro {
  String get referencia => '$titulo - $nomeAutor';
}

// Interface para operações de empréstimo.
abstract interface class Emprestavel {
  bool consultarDisponibilidade();
  bool emprestar();
  void devolver();
}

// Classe LivroFisico.
class LivroFisico extends Livro implements Emprestavel {
  final int numeroPaginas;
  bool _disponivel = true;

  LivroFisico({
    required super.codigo,
    required super.titulo,
    super.autor,
    required this.numeroPaginas,
  });

  @override
  String descricao() {
    return 'Livro Físico\n'
        'Código: $codigo\n'
        'Título: $titulo\n'
        'Autor: $nomeAutor\n'
        'Número de páginas: $numeroPaginas\n'
        'Disponível: ${consultarDisponibilidade() ? "Sim" : "Não"}';
  }

  @override
  bool consultarDisponibilidade() => _disponivel;

  @override
  bool emprestar() {
    if (!_disponivel) {
      return false;
    }

    _disponivel = false;
    return true;
  }

  @override
  void devolver() {
    _disponivel = true;
  }
}

// Classe LivroDigital.
class LivroDigital extends Livro {
  final double tamanhoMB;

  LivroDigital({
    required super.codigo,
    required super.titulo,
    super.autor,
    required this.tamanhoMB,
  });

  @override
  String descricao() {
    return 'Livro Digital\n'
        'Código: $codigo\n'
        'Título: $titulo\n'
        'Autor: $nomeAutor\n'
        'Tamanho: $tamanhoMB MB';
  }
}

void main() {
  // Coleção única contendo livros físicos e digitais.
  List<Livro> biblioteca = [
    LivroFisico(
      codigo: 101,
      titulo: 'Dom Casmurro',
      autor: 'Machado de Assis',
      numeroPaginas: 256,
    ),
    LivroDigital(
      codigo: 102,
      titulo: 'Clean Code',
      autor: 'Robert C. Martin',
      tamanhoMB: 5.8,
    ),
    LivroFisico(
      codigo: 103,
      titulo: 'O Pequeno Príncipe',
      numeroPaginas: 96,
    ),
  ];

  // Exibição das descrições e referências.
  print('========== CATÁLOGO DA BIBLIOTECA ==========');

  for (Livro livro in biblioteca) {
    print('\n${livro.descricao()}');
    print('Referência: ${livro.referencia}');
    print('--------------------------------------------');
  }

  // Demonstração da alteração do título.
  Livro primeiroLivro = biblioteca[0];

  print('\n========== ALTERAÇÃO DO TÍTULO ==========');

  print('Título original: ${primeiroLivro.titulo}');

  primeiroLivro.titulo = '  Dom Casmurro - Edição Especial  ';
  print('Após entrada válida: ${primeiroLivro.titulo}');

  primeiroLivro.titulo = '   ';
  print('Após entrada em branco: ${primeiroLivro.titulo}');

  // Demonstração dos empréstimos.
  print('\n========== EMPRÉSTIMOS ==========');

  LivroFisico livroEmprestimo = biblioteca[0] as LivroFisico;

  print('Disponibilidade inicial: '
      '${livroEmprestimo.consultarDisponibilidade()}');

  // Primeiro empréstimo: aceito.
  if (livroEmprestimo.emprestar()) {
    print('Primeiro empréstimo: ACEITO.');
  } else {
    print('Primeiro empréstimo: RECUSADO.');
  }

  print('Disponibilidade após empréstimo: '
      '${livroEmprestimo.consultarDisponibilidade()}');

  // Segundo empréstimo: recusado.
  if (livroEmprestimo.emprestar()) {
    print('Segundo empréstimo: ACEITO.');
  } else {
    print('Segundo empréstimo: RECUSADO. '
        'O livro já está emprestado.');
  }

  // Devolução.
  livroEmprestimo.devolver();

  print('Disponibilidade após devolução: '
      '${livroEmprestimo.consultarDisponibilidade()}');

  // Devolver novamente não altera o estado.
  livroEmprestimo.devolver();

  print('Disponibilidade após nova devolução: '
      '${livroEmprestimo.consultarDisponibilidade()}');
}
