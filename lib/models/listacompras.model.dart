class ListaCompras {
  bool emfalta;
  String descricao;
  String quantidade;
  bool comprado;

  ListaCompras(
      {this.descricao,
      this.quantidade,
      this.comprado = false,
      this.emfalta = false});
}
