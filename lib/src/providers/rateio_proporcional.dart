import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

class RateioProporcional with ChangeNotifier {
  double _total;
  List<TextEditingController> pesoControllers = [];
  RateioProporcional(this._total);

  bool _chartVisible = false;
  List<Peso> pesos = [];
  List<double> resultados = [];

  void updateTotal(double valor) {
    _total = valor;
    notifyListeners();
  }

  void addPeso() {
    pesos.add(Peso(0.0, TextEditingController()));
    notifyListeners();
  }

  void updatePeso(int index, String value) {
    double peso = double.tryParse(value.replaceAll(',', '.')) ?? 0.0;
    pesos[index].value = peso;
    notifyListeners();
  }

  void removePeso(int index) {
    pesos[index].controller.dispose();
    pesos.removeAt(index);
    notifyListeners();
  }

  void rateioProporcional(BuildContext context) {
    if (_total == 0) {
      AnimatedSnackBar.material(
        'Preencha um valor!',
        type: AnimatedSnackBarType.warning,
        snackBarStrategy: RemoveSnackBarStrategy(),
      ).show(context);
      _chartVisible = false;
      return;
    }

    if (pesos.isEmpty) {
      AnimatedSnackBar.material(
        'Adicione os pesos necessários!',
        type: AnimatedSnackBarType.warning,
        snackBarStrategy: RemoveSnackBarStrategy(),
      ).show(context);
      _chartVisible = false;
      return;
    }

    for (var pe in pesos) {
      if (pe.value == 0) {
        AnimatedSnackBar.material(
          'Verifique o valor dos pesos!',
          type: AnimatedSnackBarType.warning,
          snackBarStrategy: RemoveSnackBarStrategy(),
        ).show(context);
        _chartVisible = false;
        return;
      }
    }
    double somaPesos =
        pesos.fold(0.0, (previousValue, peso) => previousValue + peso.value);
    resultados =
        pesos.map((peso) => (_total * peso.value) / somaPesos).toList();
    notifyListeners();
    _chartVisible = true;
  }

  bool chartVisibility() {
    return _chartVisible;
  }
}

class Peso {
  double value;
  TextEditingController controller;

  Peso(this.value, this.controller);
}
