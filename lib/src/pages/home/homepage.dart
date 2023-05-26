import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../providers/rateio_provider.dart';
import '../../widgets/chat_double.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

double fontSizeTitle = 20;
double fontSizeSubTitle = 18;
double fontSizeBody = 16;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Calculo de Rateio'),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext ctx) {
                      return AlertDialog(
                        title: Text('Como usar o cálculo de rateio', style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSizeTitle)),
                        content: SingleChildScrollView(
                          child: SelectableText.rich(
                            TextSpan(
                              style: Theme.of(context).textTheme.bodyMedium,
                              children: <TextSpan>[
                                TextSpan(text: 'O cálculo de rateio é usado para dividir uma quantidade total em partes iguais ou proporcionais. Aqui estão os passos para usar este aplicativo para fazer o cálculo:\n\n', style: TextStyle(fontSize: fontSizeBody)),
                                TextSpan(text: 'Rateio Simples\n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSizeSubTitle)),
                                TextSpan(text: '1. Digite o valor total que deseja dividir.\n2. Digite o número de partes iguais.\n3. Clique em calcular.\n4. O resultado será o valor para cada parte.\n\n', style: TextStyle(fontSize: fontSizeBody)),
                                TextSpan(text: 'Exemplo: Se você tem R\$100 para dividir entre 5 pessoas igualmente, você deve digitar "100" no Total e "5" nas Partes. O resultado será R\$20 para cada pessoa.\n\n', style: TextStyle(fontSize: fontSizeBody)),
                                TextSpan(text: 'Rateio Proporcional\n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSizeSubTitle)),
                                TextSpan(text: '1. Digite o valor total que deseja dividir.\n2. Para cada parte, digite o peso da parte.\n3. Clique em calcular.\n4. O resultado será o valor para cada parte de acordo com o peso da parte.\n\n', style: TextStyle(fontSize: fontSizeBody)),
                                TextSpan(text: 'Exemplo: Se você tem R\$100 para dividir entre 3 pessoas, onde a primeira pessoa recebe 50% do total e as outras duas recebem 25% cada, você deve digitar "100" no Total, e "50", "25", "25" nas Partes. O resultado será R\$50 para a primeira pessoa e R\$25 para as outras duas.\n\n', style: TextStyle(fontSize: fontSizeBody)),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                            child: const Text('Fechar'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.help,
                  color: Colors.white,
                ))
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.account_balance_wallet),
                text: "Rateio Simples",
              ),
              Tab(
                icon: Icon(Icons.account_balance),
                text: "Rateio Proporcional",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            rateioSimples(context),
            rateioProporcional(context),
          ],
        ),
      ),
    );
  }

  final totalController = TextEditingController();
  Widget rateioProporcional(BuildContext ctxBuild) {
    return Consumer<RateioProporcional>(
      builder: (ctx, rateioProporcional, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: totalController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+[,]{0,1}\d{0,2}')),
                ],
                decoration: InputDecoration(
                  labelText: 'Total',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calculate),
                    onPressed: () {
                      double total = double.tryParse(totalController.text.replaceAll(',', '.')) ?? 0;
                      rateioProporcional.updateTotal(total);
                      rateioProporcional.rateioProporcional(context);
                    },
                  ),
                ),
                onChanged: (value) {
                  try {
                    rateioProporcional.updateTotal(
                      double.parse(value.replaceAll(',', '.')),
                    );
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                },
                onFieldSubmitted: (value) {
                  double total = double.tryParse(totalController.text.replaceAll(',', '.')) ?? 0;
                  rateioProporcional.updateTotal(total);
                  rateioProporcional.rateioProporcional(context);
                },
                validator: (value) {
                  if (double.tryParse(value!.replaceAll(',', '.')) != null) {
                    return null;
                  } else {
                    return 'Por favor, insira um número válido.';
                  }
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: [
                  ElevatedButton(
                    child: const Text('Adicionar Peso'),
                    onPressed: () {
                      rateioProporcional.addPeso();
                    },
                  ),
                  ElevatedButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text('Calcular'),
                        SizedBox(width: 5, height: 5),
                        Icon(Icons.calculate),
                      ],
                    ),
                    onPressed: () {
                      rateioProporcional.rateioProporcional(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    runAlignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.start,
                    children: List.generate(
                      rateioProporcional.pesos.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(6),
                        child: SizedBox(
                          width: 220,
                          child: PesoTextField(index),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: rateioProporcional.chartVisibility(),
                child: SizedBox(
                  height: 180,
                  child: ResultadoGrafico(resultados: rateioProporcional.resultados),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget rateioSimples(BuildContext context) {
    return Consumer<Rateio>(
      builder: (context, rateio, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+[,]{0,1}\d{0,2}')),
                ],
                decoration: const InputDecoration(labelText: 'Total'),
                onChanged: (value) {
                  try {
                    rateio.updateTotal(double.parse(value.replaceAll(',', '.')), runUpdate: false);
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                },
                onEditingComplete: () {
                  rateio.calculaResultado();
                },
                validator: (value) {
                  if (double.tryParse(value!.replaceAll(',', '.')) != null) {
                    return null;
                  } else {
                    return 'Por favor, insira um número válido.';
                  }
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 10),
              TextFormField(
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+[,]{0,1}\d{0,2}')),
                ],
                onChanged: (value) {
                  try {
                    rateio.updatePartes(int.parse(value), runUpdate: false);
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                },
                onEditingComplete: () {
                  rateio.calculaResultado();
                },
                validator: (value) {
                  if (int.tryParse(value!) != null) {
                    return null;
                  } else {
                    return 'Por favor, insira um número INTEIRO válido.';
                  }
                },
                decoration: const InputDecoration(labelText: 'Partes'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SelectableText(
                  'O valor por parte é: ${rateio.calculaResultado().toStringAsFixed(2).replaceAll('.', ',')}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class PesoTextField extends StatelessWidget {
  final int index;

  const PesoTextField(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    var rateioNotifier = Provider.of<RateioProporcional>(context, listen: false);
    var peso = rateioNotifier.pesos[index];

    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: peso.controller,
              decoration: InputDecoration(
                labelText: 'Peso ${index + 1}',
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    rateioNotifier.removePeso(index);
                  },
                ),
              ),
              onChanged: (value) {
                rateioNotifier.updatePeso(index, value);
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+[,]{0,1}\d{0,2}')),
              ],
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (double.tryParse(value!.replaceAll(',', '.')) != null) {
                  return null;
                } else {
                  return 'Por favor, insira um número válido.';
                }
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
          if (rateioNotifier.resultados.length > index)
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: SelectableText(
                'Resultado: ${rateioNotifier.resultados[index].toStringAsFixed(2).replaceAll('.', ',')}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
