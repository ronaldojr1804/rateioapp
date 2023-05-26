import 'package:flutter/material.dart';

class DialogHelp extends StatelessWidget {
  const DialogHelp({super.key});
  final double fontSizeTitle = 20;
  final double fontSizeSubTitle = 18;
  final double fontSizeBody = 16;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Como usar o cálculo de rateio',
          style:
              TextStyle(fontWeight: FontWeight.bold, fontSize: fontSizeTitle)),
      content: SingleChildScrollView(
        child: SelectableText.rich(
          TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              TextSpan(
                  text:
                      'O cálculo de rateio é usado para dividir uma quantidade total em partes iguais ou proporcionais. Aqui estão os passos para usar este aplicativo para fazer o cálculo:\n\n',
                  style: TextStyle(fontSize: fontSizeBody)),
              TextSpan(
                  text: 'Rateio Simples\n',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: fontSizeSubTitle)),
              TextSpan(
                  text:
                      '1. Digite o valor total que deseja dividir.\n2. Digite o número de partes iguais.\n3. Clique em calcular.\n4. O resultado será o valor para cada parte.\n\n',
                  style: TextStyle(fontSize: fontSizeBody)),
              TextSpan(
                  text:
                      'Exemplo: Se você tem R\$100 para dividir entre 5 pessoas igualmente, você deve digitar "100" no Total e "5" nas Partes. O resultado será R\$20 para cada pessoa.\n\n',
                  style: TextStyle(fontSize: fontSizeBody)),
              TextSpan(
                  text: 'Rateio Proporcional\n',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: fontSizeSubTitle)),
              TextSpan(
                  text:
                      '1. Digite o valor total que deseja dividir.\n2. Para cada parte, digite o peso da parte.\n3. Clique em calcular.\n4. O resultado será o valor para cada parte de acordo com o peso da parte.\n\n',
                  style: TextStyle(fontSize: fontSizeBody)),
              TextSpan(
                  text:
                      'Exemplo: Se você tem R\$100 para dividir entre 3 pessoas, onde a primeira pessoa recebe 50% do total e as outras duas recebem 25% cada, você deve digitar "100" no Total, e "50", "25", "25" nas Partes. O resultado será R\$50 para a primeira pessoa e R\$25 para as outras duas.\n\n',
                  style: TextStyle(fontSize: fontSizeBody)),
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
  }
}
