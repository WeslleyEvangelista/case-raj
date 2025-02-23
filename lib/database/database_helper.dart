// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import '../models/post.dart';

// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper._internal();
//   static Database? _database;

//   factory DatabaseHelper() {
//     return _instance;
//   }

//   DatabaseHelper._internal();

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     String path = join(await getDatabasesPath(), 'posts.db');
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) {
//         return db.execute(
//           "CREATE TABLE posts(id INTEGER PRIMARY KEY, title TEXT, body TEXT)",
//         );
//       },
//     );
//   }

//   Future<void> insertPost(Post post) async {
//     final db = await database;
//     await db.insert(
//       'posts',
//       post.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future<List<Post>> getPosts() async {
//     final db = await database;
//     List<Map<String, dynamic>> maps = await db.query('posts');
//     return List.generate(maps.length, (i) {
//       return Post(
//         id: maps[i]['id'],
//         title: maps[i]['title'],
//         body: maps[i]['body'],
//       );
//     });
//   }
// }

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/post.dart';

class DatabaseHelper {
  // Instância única do DatabaseHelper (padrão Singleton):
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database?
  _database; // Variável _database para armazenar a instância do banco de dados

  // Factory que retorna a instância única (Singleton):
  factory DatabaseHelper() {
    return _instance;
  }

  // Construtor privado para a classe DatabaseHelper (impede criação de outras instâncias fora do próprio arquivo)
  DatabaseHelper._internal();

  // Getter assíncrono para acessar a instância do banco de dados:
  Future<Database> get database async {
    // Se o banco de dados já foi instanciado, retorna a instância existente:
    if (_database != null) return _database!;
    // SE não, inicializa o banco de dados:
    _database = await _initDatabase();
    return _database!;
  }

  // Método privado para inicializar o banco de dados:
  Future<Database> _initDatabase() async {
    // Definir o caminho do banco de dados utilizando o caminho padrão dos bancos de dados do dispositivo:
    String path = join(await getDatabasesPath(), 'posts.db');

    // Abrir o banco de dados (caso não exista, será criado):
    return await openDatabase(
      path, // Caminho do banco de dados
      version: 1, // Versão do banco de dados
      onCreate: (db, version) {
        // Criar tabela 'posts' caso o banco de dados seja criado pela primeira vez:
        return db.execute(
          "CREATE TABLE posts(id INTEGER PRIMARY KEY, title TEXT, body TEXT)",
        );
      },
    );
  }

  // Método para inserir um post no banco de dados:
  Future<void> insertPost(Post post) async {
    final db = await database; // Obtém a instância do banco de dados
    await db.insert(
      'posts', // Nome da tabela
      post.toMap(), // Converte o objeto Post em um mapa (chave-valor)
      conflictAlgorithm:
          ConflictAlgorithm
              .replace, // Se houver conflito (post com o mesmo ID), ele será substituído
    );
  }

  // Método para obter todos os posts salvos no banco de dados:
  Future<List<Post>> getPosts() async {
    final db = await database; // Obtém a instância do banco de dados
    // Executar a consulta para obter todos os registros da tabela 'posts':
    List<Map<String, dynamic>> maps = await db.query('posts');

    // Converter a lista de mapas em uma lista de objetos Post:
    return List.generate(maps.length, (i) {
      return Post(
        id: maps[i]['id'], // Obtém o id do post
        title: maps[i]['title'], // Obtém o título do post
        body: maps[i]['body'], // Obtém o corpo do post
      );
    });
  }
}
