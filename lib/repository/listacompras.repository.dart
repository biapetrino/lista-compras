import '../models/listacompras.model.dart';

class ListaComprasRepository {
  // ignore: deprecated_member_use
  static List<ListaCompras> listacompra = List<ListaCompras>();

  List<ListaCompras> read() {
    return listacompra;
  }

  ListaComprasRepository() {
    if (listacompra.isEmpty) {
      listacompra.add(
          ListaCompras(descricao: "Arroz", quantidade: "2", comprado: false));
      listacompra.add(
          ListaCompras(descricao: "Feijao", quantidade: "3", comprado: false));
      listacompra.add(
          ListaCompras(descricao: "Batata", quantidade: "10", comprado: false));
    }
  }

  void create(ListaCompras listaCompras) {
    return listacompra.add(listaCompras);
  }

  void update(ListaCompras novaCompra, ListaCompras velhaCompra) {
    final list =
        listacompra.singleWhere(((t) => t.descricao == velhaCompra.descricao));
    listacompra.singleWhere(((t) => t.quantidade == velhaCompra.quantidade));
    list.descricao = novaCompra.descricao;
    list.quantidade = novaCompra.quantidade;
  }

  void delete(String descricao) {
    final list = listacompra.singleWhere(((t) => t.descricao == descricao));
    listacompra.remove(list);
  }
}
