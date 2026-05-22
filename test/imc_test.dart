//import 'package:test/imc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calculadoraimc/pessoa.dart';
import 'package:calculadoraimc/calculadora_imc.dart';

void main() {
  group('Testes do IMC', () {
    test('Deve calcular o IMC corretamente', () {
      // Peso: 80, Altura: 2.0 -> IMC deve ser 80 / 4 = 20.0
      final pessoa = Pessoa(nome: "Carlos", peso: 80.0, altura: 2.0);
      expect(CalculadoraIMC.calcular(pessoa), equals(20.0));
    });

    test('Deve classificar o IMC corretamente como Saudável', () {
      expect(CalculadoraIMC.classificar(22.0), equals("Saudável"));
    });

    test('Deve classificar o IMC corretamente como Obesidade Grau III', () {
      expect(CalculadoraIMC.classificar(45.0), equals("Obesidade Grau III (mórbida)"));
    });

    test('Deve lançar exceção se peso for menor ou igual a zero', () {
      expect(
        () => Pessoa(nome: "Ana", peso: 0, altura: 1.65),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('Deve lançar exceção se nome for vazio', () {
      expect(
        () => Pessoa(nome: "   ", peso: 70, altura: 1.70),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}