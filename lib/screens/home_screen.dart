import 'package:flutter/material.dart';
import 'package:calculadoraimc/pessoa.dart';
import 'package:calculadoraimc/calculadora_imc.dart';

// Criamos uma classe simples para estruturar o que vai aparecer na lista
class ItemHistorico {
  final String nome;
  final double imc;
  final String classificacao;

  ItemHistorico({required this.nome, required this.imc, required this.classificacao});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controladores para capturar o texto dos inputs na tela
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();

  // Lista na memória para guardar o histórico de resultados
  final List<ItemHistorico> _historico = [];

  void _processarCalculo() {
    try {
      String nomeInput = _nomeController.text;
      if (nomeInput.trim().isEmpty) {
        throw FormatException("Nome inválido.");
      }

      double? peso = double.tryParse(_pesoController.text.replaceAll(',', '.'));
      if (peso == null) {
        throw FormatException("O peso digitado não é um número válido.");
      }

      double? altura = double.tryParse(_alturaController.text.replaceAll(',', '.'));
      if (altura == null) {
        throw FormatException("A altura digitada não é um número válido.");
      }

      // Reaproveitando suas classes originais do CLI!
      Pessoa pessoa = Pessoa(nome: nomeInput, peso: peso, altura: altura);
      double imc = CalculadoraIMC.calcular(pessoa);
      String classificacao = CalculadoraIMC.classificar(imc);

      // Se tudo deu certo, adiciona no topo da lista (index 0)
      setState(() {
        _historico.insert(0, ItemHistorico(
          nome: pessoa.nome,
          imc: imc,
          classificacao: classificacao,
        ));
      });

      // Limpa os campos de texto
      _nomeController.clear();
      _pesoController.clear();
      _alturaController.clear();
      FocusScope.of(context).unfocus(); // Fecha o teclado

    } on FormatException catch (e) {
      _mostrarErro("[ERRO DE FORMATO]: ${e.message}");
    } on ArgumentError catch (e) {
      _mostrarErro("[ERRO DE VALIDAÇÃO]: ${e.message}");
    } catch (e) {
      _mostrarErro("[ERRO INESPERADO]: $e");
    }
  }

  // Substitui os prints de erro por um SnackBar elegante na tela
  void _mostrarErro(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Inputs de texto substituindo o stdin.readLineSync()
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome da pessoa', prefixIcon: Icon(Icons.person)),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _pesoController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Peso (ex: 70.5)', prefixIcon: Icon(Icons.fitness_center)),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _alturaController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Altura em metros (ex: 1.75)', prefixIcon: Icon(Icons.straighten)),
            ),
            const SizedBox(height: 16),
            
            // Botão que dispara o cálculo
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: _processarCalculo,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
                child: const Text('Calcular e Adicionar à Lista'),
              ),
            ),
            const SizedBox(height: 20),
            
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Resultados:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            
            // Lista substituindo os prints finais de resultado
            Expanded(
              child: _historico.isEmpty
                  ? const Center(child: Text('Nenhum IMC calculado ainda.'))
                  : ListView.builder(
                      itemCount: _historico.length,
                      itemBuilder: (context, index) {
                        final item = _historico[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.teal.shade100,
                              child: Text(item.imc.toStringAsFixed(1), style: const TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            title: Text('${item.nome} - ${item.classificacao}'),
                            subtitle: Text('IMC completo: ${item.imc.toStringAsFixed(2)}'),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}