import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'api_screen.dart'; // Importa a tela para navegar de volta

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  SavedScreenState createState() => SavedScreenState();
}

class SavedScreenState extends State<SavedScreen> {
  List<Map<String, dynamic>> _savedPosts =
      []; // Lista para armazenar os posts salvos como Map

  /// Método para carregar os posts salvos do banco de dados:
  Future<void> loadSavedPosts() async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('posts');

    setState(() {
      _savedPosts = maps; // Atualiza a lista com os posts do banco de dados
    });
  }

  /// Método para excluir um post do banco de dados:
  Future<void> deletePost(int id) async {
    final db = await DatabaseHelper().database;

    // Confirmação antes de excluir
    final shouldDelete =
        await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirmar Exclusão'),
              content: Text('Você tem certeza que deseja excluir este post?'),
              actions: [
                TextButton(
                  child: Text('Cancelar'),
                  onPressed:
                      () => Navigator.of(
                        context,
                      ).pop(false), // Retorna false se o usuário cancelar
                ),
                TextButton(
                  child: Text('Excluir'),
                  onPressed:
                      () => Navigator.of(
                        context,
                      ).pop(true), // Retorna true se o usuário confirmar
                ),
              ],
            );
          },
        ) ??
        false;

    // Se o usuário confirmar a exclusão:
    if (shouldDelete) {
      await db.delete(
        'posts', // Nome da tabela
        where: 'id = ?', // Condição de exclusão
        whereArgs: [id], // Passa o id do post a ser excluído
      );

      // Recarrega a lista de posts após a exclusão:
      loadSavedPosts();

      // Exibir o Snackbar de confirmação da exclusão do post:
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Post excluído com sucesso!',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Posts Salvos")),
      body: Column(
        children: [
          // Botão para carregar os posts salvos:
          ElevatedButton(
            onPressed: loadSavedPosts,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF106B35),
              surfaceTintColor: Colors.transparent,
              elevation: 4,
              shadowColor: Colors.black26,
              splashFactory: InkRipple.splashFactory,
            ), // Chama a função para carregar os posts salvos
            child: Text(
              "Carregar Posts Salvos",
              style: TextStyle(color: Colors.white),
            ),
          ),
          // Lista de posts salvos, exibindo cada um com a aparência de um Card
          Expanded(
            child: ListView.builder(
              itemCount: _savedPosts.length, // Número de posts na lista
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ), // Margem do card
                  elevation: 3, // Sombras do card
                  child: Padding(
                    padding: const EdgeInsets.all(12.0), // Padding do conteúdo
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Alinhamento do conteúdo
                      children: [
                        // Exibe o título do post salvo
                        Text(
                          _savedPosts[index]['title'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5), // Espaço entre título e corpo
                        // Exibe o corpo do post salvo
                        Text(_savedPosts[index]['body']),
                        // Botão de exclusão
                        Align(
                          alignment:
                              Alignment.centerRight, // Alinha o botão à direita
                          child: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed:
                                () => deletePost(
                                  _savedPosts[index]['id'],
                                ), // Chama a função para excluir o post
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Botão para navegar de volta para a tela 1 (carregar posts da API)
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ApiScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF106B35),
              surfaceTintColor: Colors.transparent,
              elevation: 4,
              shadowColor: Colors.black26,
              splashFactory: InkRipple.splashFactory,
            ),
            child: Text("Voltar", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
