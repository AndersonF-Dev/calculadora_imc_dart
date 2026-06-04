import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Importa o Hive para persistência local
import 'screens/home_screen.dart';

void main() async {
  // 1. Garante que os recursos nativos do Flutter estejam prontos antes do banco iniciar
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. Inicializa o armazenamento do Hive no dispositivo
  await Hive.initFlutter();
  
  // 3. Abre as "caixas" (bancos de dados) para histórico de IMC e configurações de altura
  await Hive.openBox('historico_imc');
  await Hive.openBox('configuracoes');

  // 4. Inicializa o aplicativo normalmente
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
      home: const HomeScreen(), // Chama a tela com a interface que vai ler do Hive
    );
  }
}