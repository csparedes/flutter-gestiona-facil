class ListaVenta {
  final List<int> listaId = new List<int>();

  ListaVenta();

  void agregarId(int id) {
    listaId.add(id);
    print(listaId);
  }
}
