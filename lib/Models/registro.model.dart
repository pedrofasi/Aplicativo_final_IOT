class Registro {
  int id;
  String usuario;
  String senha;
  String nome;
  String cpf;
  String cep;
  int qntdcarros;

  Registro(
      {this.id,
        this.usuario,
        this.senha,
        this.nome,
        this.cpf,
        this.cep,
        this.qntdcarros});

  Registro.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usuario = json['usuario'];
    senha = json['senha'];
    nome = json['nome'];
    cpf = json['cpf'];
    cep = json['cep'];
    qntdcarros = json['qntdcarros'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['usuario'] = this.usuario;
    data['senha'] = this.senha;
    data['nome'] = this.nome;
    data['cpf'] = this.cpf;
    data['cep'] = this.cep;
    data['qntdcarros'] = this.qntdcarros;
    return data;
  }
}
