import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'dart:convert';
import '../database/database_helper.dart';
import '../models/post.dart';
import 'saved_screen.dart'; // Importa a tela que exibe os posts salvos

class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});

  @override
  ApiScreenState createState() => ApiScreenState();
}

class ApiScreenState extends State<ApiScreen> {
  List<Post> _posts = []; // Lista para armazenar os posts recebidos da API

  /// Método para buscar os posts da API:
  Future<void> fetchPosts() async {
    // Requisição HTTP para a API (obter os posts):
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    // Verificar se a requisição foi bem-sucedida (código 200):
    if (response.statusCode == 200) {
      // Decodificar o JSON retornado pela API:
      List<dynamic> data = json.decode(response.body);

      // Converter o JSON para uma lista de objetos Post e atualizar o estado:
      setState(() {
        _posts = data.map((item) => Post.fromJson(item)).toList();
      });
    } else {
      // Exibeir uma exceção em caso de erro:
      throw Exception('Falha ao carregar os posts');
    }
  }

  /// Exibir um alerta de confirmação antes de salvar um post:
  void showSaveConfirmationDialog(Post post) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Salvar Post"),
            content: Text("Tem certeza que deseja salvar este post?"),
            actions: [
              // Botão de cancelar:
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancelar"),
              ),
              // Botão para confirmar o salvamento:
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  savePost(post); // Chama a função para salvar o post
                },
                child: Text("Salvar", style: TextStyle(color: Colors.green)),
              ),
            ],
          ),
    );
  }

  /// Função para salvar o post no banco de dados:
  Future<void> savePost(Post post) async {
    // Obter a instância do banco de dados:
    final db = await DatabaseHelper().database;

    // Inserir o post na tabela 'posts' (caso já exista o post, ele será substituído ):
    await db.insert(
      'posts',
      post.toMap(),
      conflictAlgorithm:
          ConflictAlgorithm.replace, // Substitui se o post já existe
    );

    // Exibir um snackbar para o usuário confirmando que o post foi salvo:
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text("Post salvo!")),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Consulta API")),
      body: Column(
        children: [
          // Botão para carregar os posts da API:
          ElevatedButton(
            onPressed: fetchPosts,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF106B35),
              surfaceTintColor: Colors.transparent,
              elevation: 4,
              shadowColor: Colors.black26,
              splashFactory: InkRipple.splashFactory,
            ),
            // Quando pressionado, chama a função fetchPosts
            child: Text(
              "Carregar Posts da API",
              style: TextStyle(color: Colors.white),
            ),
          ),
          // Lista de posts, exibindo cada um com a aparência de um Card:
          Expanded(
            child: ListView.builder(
              itemCount: _posts.length, // Define a quantidade de itens na lista
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Exibe o título do post:
                        Text(
                          _posts[index].title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        // Exibe o corpo do post:
                        Text(_posts[index].body),
                        SizedBox(height: 10),
                        // Botão para salvar o post:
                        Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            icon: Icon(Icons.download, color: Colors.blue),
                            onPressed:
                                () => showSaveConfirmationDialog(
                                  _posts[index],
                                ), // Exibe o alerta de confirmação
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Botão para navegar até a tela de posts salvos:
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SavedScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF106B35),
              surfaceTintColor: Colors.transparent,
              elevation: 4,
              shadowColor: Colors.black26,
              splashFactory: InkRipple.splashFactory,
            ),
            child: Text(
              "Ver Posts Salvos",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
