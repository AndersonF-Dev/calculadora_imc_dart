class Pessoa {
  final String nome;
  final double peso;
  final double altura;

  Pessoa({required this.nome, required this.peso, required this.altura}) {
    // Validações básicas no construtor
    if (nome.trim().isEmpty) {
      throw ArgumentError("O nome não pode ser vazio.");
    }
    if (peso <= 0) {
      throw ArgumentError("O peso deve ser maior que zero.");
    }
    if (altura <= 0) {
      throw ArgumentError("A altura deve ser maior que zero.");
    }
  }
}