import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/rateio_proporcional.dart';
import '../widgets/chart.dart';
import '../widgets/field_peso.dart';

class RateioProporcionalScreen extends StatefulWidget {
  const RateioProporcionalScreen({super.key});

  @override
  State<RateioProporcionalScreen> createState() =>
      _RateioProporcionalScreenState();
}

class _RateioProporcionalScreenState extends State<RateioProporcionalScreen> {
  final totalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<RateioProporcional>(
      builder: (ctx, rateioProporcional, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: totalController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+[,]{0,1}\d{0,2}'),
                  ),
                ],
                decoration: InputDecoration(
                  labelText: 'Total',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calculate),
                    onPressed: () {
                      double total = double.tryParse(
                              totalController.text.replaceAll(',', '.')) ??
                          0;
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
                  double total = double.tryParse(
                        totalController.text.replaceAll(',', '.'),
                      ) ??
                      0;
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
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                    spacing: 4,
                    runSpacing: 4,
                    runAlignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.start,
                    children: List.generate(
                      rateioProporcional.pesos.length,
                      (index) => SizedBox(
                        width: 150,
                        child: PesoTextField(index),
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
                  child: ResultadoGrafico(
                    resultados: rateioProporcional.resultados,
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
