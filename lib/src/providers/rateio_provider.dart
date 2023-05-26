import 'package:flutter/cupertino.dart';

class Rateio with ChangeNotifier {
  double _total;
  int _partes;

  double resultado = 0;

  Rateio(this._total, this._partes);

  void updateTotal(double newTotal, {bool runUpdate = true}) {
    _total = newTotal;
    if (runUpdate) {
      calculaResultado();
    }
    notifyListeners();
  }

  void updatePartes(int newPartes, {bool runUpdate = true}) {
    _partes = newPartes;
    if (runUpdate) {
      calculaResultado();
    }
    notifyListeners();
  }

  double getTotal() {
    return _total;
  }

  int getPartes() {
    return _partes;
  }

  double calculaResultado({bool runUpdate = false}) {
    resultado = _total / _partes;
    if (runUpdate) {
      notifyListeners();
    }

    return resultado;
  }
}
