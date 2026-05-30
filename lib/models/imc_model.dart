
class ImcModel {
  final String nome;
  final double peso;
  final double altura;
  final double resultado;
  final String classificacao;

  ImcModel({
    required this.nome,
    required this.peso,
    required this.altura,
    required this.resultado,
    required this.classificacao,
  });

  // Converte o objeto para salvar no Hive
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'peso': peso,
      'altura': altura,
      'resultado': resultado,
      'classificacao': classificacao,
    };
  }

  // Cria o objeto de volta ao ler do Hive
  factory ImcModel.fromMap(Map<dynamic, dynamic> map) {
    return ImcModel(
      nome: map['nome'] ?? '',
      peso: (map['peso'] as num).toDouble(),
      altura: (map['altura'] as num).toDouble(),
      resultado: (map['resultado'] as num).toDouble(),
      classificacao: map['classificacao'] ?? '',
    );
  }
}