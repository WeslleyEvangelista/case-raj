class Post {
  // Atributos da classe Post:
  final int id; // ID do post, identificador único
  final String title; // Título do post
  final String body; // Conteúdo do post

  // Construtor da classe Post
  Post({required this.id, required this.title, required this.body});

  // Método factory que cria um objeto Post a partir de um mapa (json):
  factory Post.fromJson(Map<String, dynamic> json) {
    // Retorna um objeto Post com base nos dados do mapa (json):
    // O método 'fromJson' é utilizado para converter os dados recebidos de uma API (JSON) em um objeto Dart:
    return Post(id: json['id'], title: json['title'], body: json['body']);
  }

  // Método que converte um objeto Post em um mapa (para inserir no banco de dados):
  Map<String, dynamic> toMap() {
    // Retorna um mapa (chave: valor) representando o objeto Post:
    // Esse método é usado para salvar o objeto em um banco de dados SQLite ou enviar para uma API:
    return {'id': id, 'title': title, 'body': body};
  }
}
