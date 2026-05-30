import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Controlador para o usuário digitar a altura dele
  final TextEditingController _alturaController = TextEditingController();
  late Box _configBox;

  @override
  void initState() {
    super.initState();
    _configBox = Hive.box('configuracoes');
    
    // Se o usuário já tiver digitado e salvo uma altura antes, ela aparece no campo automaticamente
    double? alturaSalva = _configBox.get('altura');
    if (alturaSalva != null) {
      _alturaController.text = alturaSalva.toString();
    }
  }

  void _salvarConfiguracoes() {
    // Captura o que o usuário digitou e trata a vírgula por ponto
    double? altura = double.tryParse(_alturaController.text.replaceAll(',', '.'));
    
    if (altura != null && altura > 0) {
      // Grava permanentemente a altura digitada no Hive
      _configBox.put('altura', altura);
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Altura salva com sucesso!'), backgroundColor: Colors.teal),
      );
      
      Navigator.pop(context); // Volta para a tela principal
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, digite uma altura válida!'), backgroundColor: Colors.redAccent),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações do Perfil'), 
        backgroundColor: Colors.teal, 
        foregroundColor: Colors.white
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Configure os seus dados padrão:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Digite a sua altura abaixo. Ela ficará salva localmente e será usada de forma fixa para calcular todos os seus novos IMCs na tela inicial.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            
            // O CAMPO PARA DIGITAR A ALTURA:
            TextField(
              controller: _alturaController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Sua Altura (ex: 1.75)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.straighten),
              ),
            ),
            const SizedBox(height: 24),
            
            // Botão para gravar a digitação no banco
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: _salvarConfiguracoes,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
                child: const Text('Salvar e Atualizar Perfil'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}