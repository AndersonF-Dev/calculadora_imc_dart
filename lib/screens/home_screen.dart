import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/imc_model.dart';
import 'package:calculadoraimc/pessoa.dart';
import 'package:calculadoraimc/calculadora_imc.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  // 1. RECOLOQUEI O CONTROLADOR DA ALTURA AQUI:
  final TextEditingController _alturaController = TextEditingController();

  late Box _imcBox;
  late Box _configBox;
  List<ImcModel> _historico = [];

  @override
  void initState() {
    super.initState();
    _imcBox = Hive.box('historico_imc');
    _configBox = Hive.box('configuracoes');
    _carregarHistorico();
    _carregarAlturaPadrao();
  }

  // Se já houver uma altura salva nas configurações, ela preenche o campo automaticamente
  void _carregarAlturaPadrao() {
    double? alturaSalva = _configBox.get('altura');
    if (alturaSalva != null) {
      _alturaController.text = alturaSalva.toString();
    }
  }

  void _carregarHistorico() {
    final dadosRaw = _imcBox.values;
    setState(() {
      _historico = dadosRaw.map((item) => ImcModel.fromMap(item)).toList().reversed.toList();
    });
  }

  void _processarCalculo() {
    try {
      String nomeInput = _nomeController.text.trim(); // .trim() remove espaços em branco extras
      
      // 1. VALIDAÇÃO ANTECIPADA: Se o nome estiver vazio, para tudo ANTES de mexer no Hive
      if (nomeInput.isEmpty) {
        _mostrarErro("Nome inválido. O campo não pode ficar vazio.");
        return; // O return força a função a PARAR de rodar aqui
      }

      double? peso = double.tryParse(_pesoController.text.replaceAll(',', '.'));
      if (peso == null || peso <= 0) {
        _mostrarErro("O peso digitado não é um número válido.");
        return; // Para a execução se o peso for inválido
      }

      double? altura = double.tryParse(_alturaController.text.replaceAll(',', '.'));
      if (altura == null || altura <= 0) {
        _mostrarErro("A altura digitada não é um número válido.");
        return; // Para a execução se a altura for inválida
      }

      // Reaproveitando suas classes originais de negócio
      Pessoa pessoa = Pessoa(nome: nomeInput, peso: peso, altura: altura);
      double imc = CalculadoraIMC.calcular(pessoa);
      String classificacao = CalculadoraIMC.classificar(imc);

      ImcModel novoRegistro = ImcModel(
        nome: pessoa.nome, 
        peso: peso,
        altura: altura,
        resultado: imc,
        classificacao: classificacao,
      );

      String chaveUnica = pessoa.nome.toLowerCase();

      // ====== DESAFIO REVISADO: VERIFICA SE O NOME JÁ EXISTIA NO BANCO ======
      bool jaExiste = _imcBox.containsKey(chaveUnica);

      // SÓ SALVA NO HIVE SE PASSOU POR TODAS AS VALIDAÇÕES ACIMA
      _imcBox.put(chaveUnica, novoRegistro.toMap());

      // Recarrega a lista da tela com os dados atualizados do banco
      _carregarHistorico();

      // EXIBE O AVISO CORRETO DE ACORDO COM A AÇÃO
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            jaExiste 
                ? "Os dados de ${pessoa.nome} foram atualizados com sucesso!" 
                : "${pessoa.nome} foi salvo com sucesso!",
          ),
          backgroundColor: jaExiste ? Colors.blueAccent : Colors.teal,
          duration: const Duration(seconds: 2),
        ),
      );
      // ======================================================================

      // Limpa os campos após o sucesso
      _nomeController.clear();
      _pesoController.clear();
      FocusScope.of(context).unfocus();

    } on FormatException catch (e) {
      _mostrarErro(e.message);
    } on ArgumentError catch (e) {
      _mostrarErro("[ERRO DE VALIDAÇÃO]: ${e.message}");
    } catch (e) {
      _mostrarErro("[ERRO INESPERADO]: $e");
    }
  }

  void _mostrarErro(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem), backgroundColor: Colors.redAccent),
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
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              ).then((_) {
                _carregarHistorico();
                _carregarAlturaPadrao(); // Atualiza se mudar na outra tela
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
            
            // 3. RECOLOQUEI O WIDGET DO TEXTFIELD DE ALTURA DE VOLTA AQUI:
            TextField(
              controller: _alturaController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Altura em metros (ex: 1.75)', prefixIcon: Icon(Icons.straighten)),
            ),
            
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: _processarCalculo,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
                child: const Text('Calcular e Gravar'),
              ),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Histórico (Salvo Localmente):', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _historico.isEmpty
                  ? const Center(child: Text('Nenhum registro armazenado.'))
                  : ListView.builder(
                      itemCount: _historico.length,
                      itemBuilder: (context, index) {
                        final item = _historico[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.teal.shade100,
                              child: Text(item.resultado.toStringAsFixed(1), style: const TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            title: Text('${item.nome} - ${item.classificacao}'),
                            subtitle: Text('Peso: ${item.peso}kg | Altura: ${item.altura}m'),
                            
                            // ====== O BOTÃO DE REMOVER ENTRA AQUI ======
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () {
                                // Descobre a chave única usada para salvar (nome em minúsculas)
                                String chaveNoBanco = item.nome.trim().toLowerCase();
                                
                                // Remove direto do Hive
                                _imcBox.delete(chaveNoBanco);
                                
                                // Recarrega a lista para atualizar a tela instantaneamente
                                _carregarHistorico();

                                // Feedback visual de que deu certo
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${item.nome} removido com sucesso!'),
                                    backgroundColor: Colors.orange,
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                            // ==========================================
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