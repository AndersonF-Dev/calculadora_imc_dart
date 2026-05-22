import 'pessoa.dart';

class CalculadoraIMC {
  static double calcular(Pessoa pessoa) {
    // Fórmula: Peso / (Altura * Altura)
    return pessoa.peso / (pessoa.altura * pessoa.altura);
  }

  static String classificar(double imc) {
    if (imc < 16) return "Magreza grave";
    if (imc < 17) return "Magreza moderada";
    if (imc < 18.5) return "Magreza leve";
    if (imc < 25) return "Saudável";
    if (imc < 30) return "Sobrepeso";
    if (imc < 35) return "Obesidade Grau I";
    if (imc < 40) return "Obesidade Grau II (severa)";
    return "Obesidade Grau III (mórbida)";
  }
}