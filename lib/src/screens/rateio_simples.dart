import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/rateio_provider.dart';

class RateioSimples extends StatelessWidget {
  const RateioSimples({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Rateio>(
      builder: (context, rateio, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+[,]{0,1}\d{0,2}'),
                  ),
                ],
                decoration: const InputDecoration(labelText: 'Total'),
                onChanged: (value) {
                  try {
                    rateio.updateTotal(double.parse(value.replaceAll(',', '.')),
                        runUpdate: false);
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
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+[,]{0,1}\d{0,2}'),
                  ),
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
