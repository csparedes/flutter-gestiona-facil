class Resultado {
  double confidence;
  int id;
  String label;

  Resultado(this.confidence, this.id, this.label);

  mostrarResultado() =>
      'Confianza: $confidence \nIdentificador: $id \nEtiqueta: $label';
}
