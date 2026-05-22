# Calculadora de IMC em Dart

Este é um projeto de console desenvolvido em Dart como parte de um desafio de lógica e testes unitários. O objetivo é calcular o Índice de Massa Corporal (IMC) de uma pessoa com base no nome, peso e altura inseridos via terminal.

## 🚀 Funcionalidades

- Criação da classe `Pessoa` encapsulando os dados do usuário.
- Leitura dinâmica de dados através do terminal.
- Tratamento robusto de exceções (`FormatException` e `ArgumentError`).
- Cálculo e classificação automática do IMC.
- Cobertura de testes unitários para a lógica de negócio e validações.

## 🛠️ Tecnologias Utilizadas

- **Linguagem:** Dart
- **Framework de Testes:** `flutter_test` (ou `test`)

## 📋 Pré-requisitos

Antes de começar, você vai precisar ter instalado em sua máquina o **Flutter SDK** ou o **Dart SDK**.

## 🔧 Como Executar o Projeto

1. Abra o terminal na pasta do projeto.
2. Certifique-se de baixar as dependências:
   ```bash
   flutter pub get
   ```

### Execute a aplicação com o comando:

```bash
dart run lib/main.dart   
```

## 🧪 Como Executar os Testes
Para validar se as regras de negócio e o tratamento de erros estão funcionando corretamente, execute:

```bash
flutter test
```