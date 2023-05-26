import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/rateio_proporcional.dart';

class PesoTextField extends StatelessWidget {
  final int index;

  const PesoTextField(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    var rateioNotifier =
        Provider.of<RateioProporcional>(context, listen: false);
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
                FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+[,]{0,1}\d{0,2}')),
              ],
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
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
