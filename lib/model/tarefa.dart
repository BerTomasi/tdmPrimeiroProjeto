class Tarefa{
  final String descricao;
  final String obs;
  //construtor
  Tarefa(this.descricao, this.obs);

  @override
  String toString() {
    return 'Tarefa{descricao: $descricao, obs: $obs}';
  }

}