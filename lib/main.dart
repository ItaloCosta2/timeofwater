import 'package:flutter/material.dart'; // importa o pacote base do Flutter

// função principal que inicia o app
void main() => runApp(const AguaApp());

// Widget principal do app
class AguaApp extends StatelessWidget {
  const AguaApp({super.key}); // construtor

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false, // tira a faixa "debug" no canto
        title: 'Agua', // nome interno do app
        theme: ThemeData(
          useMaterial3: true, // ativa Material Design 3
          colorSchemeSeed: Colors.blue, // cor principal do tema
        ),
        home: const HomePage(), // define a primeira tela do app
      );
}

// Tela inicial do app (Stateful porque vai mudar valores conforme o usuário interage)
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// Estado da HomePage
class _HomePageState extends State<HomePage> {
  int goal = 2000; // meta diária de água em ml (2000 ml = 2L)
  int intake = 0;  // quantidade de água ingerida até agora

  // Função para adicionar quantidade ao intake
  void add(int ml) => setState(() => intake += ml);

  @override
  Widget build(BuildContext context) {
    // calcula progresso (entre 0.0 e 1.0)
    final double progress = (intake / goal).clamp(0.0, 1.0);

    // calcula quanto falta (não deixa negativo)
    final int remaining = (goal - intake).clamp(0, goal).toInt();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Beber água'), // título da barra superior
        centerTitle: true, // centraliza o título
      ),
      body: Padding(
        padding: const EdgeInsets.all(16), // espaçamento em toda a tela
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // expande os widgets na horizontal
          children: [
            Text('Meta: $goal ml', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8), // espaço vertical
            LinearProgressIndicator(value: progress), // barra de progresso
            const SizedBox(height: 8),
            Text('Ingerido: $intake ml  •  Falta: $remaining ml'),
            const SizedBox(height: 16),

            // Wrap coloca botões lado a lado e quebra a linha se não couber
            Wrap(
              spacing: 12, // espaço entre botões na horizontal
              runSpacing: 12, // espaço entre linhas de botões
              children: [
                FilledButton.tonal(
                  onPressed: () => add(200), // ao clicar soma 200 ml
                  child: const Text('+200ml'),
                ),
                FilledButton.tonal(
                  onPressed: () => add(300), // soma 300 ml
                  child: const Text('+300ml'),
                ),
                FilledButton.tonal(
                  onPressed: () => add(500), // soma 500 ml
                  child: const Text('+500ml'),
                ),
                FilledButton.tonal(
                  onPressed: () => add(750), // soma 750 ml
                  child: const Text('+750ml'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
