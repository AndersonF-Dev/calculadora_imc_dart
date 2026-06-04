# Calculadora de IMC em Dart

Este é um projeto de console desenvolvido em Dart como parte de um desafio de lógica e testes unitários. O objetivo é calcular o Índice de Massa Corporal (IMC) de uma pessoa com base no nome, peso e altura inseridos via terminal.

Este projeto começou como uma aplicação de console desenvolvida em Dart para fins de lógica e testes unitários. Agora, evoluiu para um aplicativo completo com interface gráfica (UI) utilizando **Flutter**, permitindo a leitura dinâmica de dados e exibição dos resultados em formato de lista (histórico).

> 📌 **Nota da Branch:** A versão com interface gráfica e histórico em lista está disponível na branch `feat/interface-app`. A versão original em formato CLI (Console) permanece intacta na branch `main`.

---

## 🚀 Funcionalidades da verção de original em formato CLI (Console)

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

## 🚀 Funcionalidades

### Nova Versão Mobile / UI (Branch `feat/interface-app`)
Nesta branch, o desafio foi totalmente concluído seguindo o checklist solicitado e aplicando melhorias de experiência do usuário:
- **Pasta Model criada:** Implementação da classe `ImcModel` para estruturar e mapear as informações de cada cálculo.
- **Leitura de Dados Dinâmica:** Interface gráfica amigável com campos de captura (`TextField`) com tratamento visual de erros via `SnackBar`.
- **Altura nas Configurações:** Tela dedicada de Configurações de Perfil (acessível pelo ícone ⚙️) para definir e salvar a altura padrão do usuário.
- **Gravação de Dados com Hive:** Persistência local robusta e ultra rápida utilizando o banco NoSQL **Hive**. Os dados não são perdidos ao fechar o app.
- **Proteção contra Duplicados:** O aplicativo valida de forma inteligente se o perfil já existe. Se existir, ele atualiza o peso e o IMC enviando uma notificação de sucesso na tela; se não existir, cria um novo perfil.
- **Exibição e Remoção em Lista:** Apresentação dinâmica do histórico utilizando `ListView.builder` com suporte a remoção individual de registros direto no banco através de um botão de lixeira.

---

## 🛠️ Tecnologias Utilizadas

- **Linguagem:** Dart
- **Framework UI:** Flutter
- **Framework de Testes:** `flutter_test`

---

## 📋 Pré-requisitos

Antes de começar, você vai precisar ter instalado em sua máquina o **Flutter SDK** e um emulador configurado (ou dispositivo físico conectado).

---

## 🔧 Como Executar o Projeto

Primeiro, abra o terminal na pasta do projeto e certifique-se de baixar as dependências atualizadas:
```bash
flutter pub get
```

Opção 1: Executar a Nova Versão com Interface (Flutter)
Para rodar a versão mobile com a interface gráfica e listagem:

```bash
flutter run
```
(Certifique-se de ter um emulador aberto ou celular conectado via USB)

## 🧪 Como Executar os Testes
Para validar se as regras de negócio, cálculos e o tratamento de erros originais continuam funcionando corretamente, execute:

```bash
flutter test
```