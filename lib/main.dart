// import 'dart:io';
// import 'package:calculadoraimc/pessoa.dart';
// import 'package:calculadoraimc/calculadora_imc.dart';

// void main() {
//   print("--- CALCULADORA DE IMC ---");

//   try {
//     stdout.write("Digite o nome da pessoa: ");
//     String? nomeInput = stdin.readLineSync();
//     if (nomeInput == null || nomeInput.trim().isEmpty) {
//       throw FormatException("Nome inválido.");
//     }

//     stdout.write("Digite o peso (ex: 70.5): ");
//     String? pesoInput = stdin.readLineSync();
//     double? peso = double.tryParse(pesoInput ?? '');
//     if (peso == null) {
//       throw FormatException("O peso digitado não é um número válido.");
//     }

//     stdout.write("Digite a altura em metros (ex: 1.75): ");
//     String? alturaInput = stdin.readLineSync();
//     // Substitui vírgula por ponto para evitar erros de digitação do usuário
//     double? altura = double.tryParse(alturaInput?.replaceAll(',', '.') ?? '');
//     if (altura == null) {
//       throw FormatException("A altura digitada não é um número válido.");
//     }

//     // Criando a pessoa (pode disparar ArgumentError se os valores forem <= 0)
//     Pessoa pessoa = Pessoa(nome: nomeInput, peso: peso, altura: altura);

//     // Calculando e classificando
//     double imc = CalculadoraIMC.calcular(pessoa);
//     String classificacao = CalculadoraIMC.classificar(imc);

//     // Printando o resultado
//     print("\n--- RESULTADO ---");
//     print("Nome: ${pessoa.nome}");
//     print("IMC: ${imc.toStringAsFixed(2)}");
//     print("Classificação: $classificacao");

//   } on FormatException catch (e) {
//     print("\n[ERRO DE FORMATO]: ${e.message}");
//   } on ArgumentError catch (e) {
//     print("\n[ERRO DE VALIDAÇÃO]: ${e.message}");
//   } catch (e) {
//     print("\n[ERRO INESPERADO]: $e");
//   }
// }

import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Vamos criar este arquivo em seguida

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora IMC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomeScreen(), // Chama a tela com a interface
    );
  }
}