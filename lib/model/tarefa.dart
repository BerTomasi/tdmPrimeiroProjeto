class Tarefa{
  final int id;
  final String descricao;
  final String obs;
  //construtor
  Tarefa(this.id, this.descricao, this.obs);

  @override
  String toString() {
    return 'Tarefa{descricao: $descricao, obs: $obs}';
  }

}