import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// imports de telas
import 'form_screen.dart';
import 'description_screen.dart';
import 'home_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<dynamic> _users = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:5001/users'),
      );

      if (response.statusCode == 200) {
        setState(() {
          _users = json.decode(response.body)['users'];
          _isLoading = false;
        });
      } else {
        throw Exception('Falha ao carregar a agenda');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Erro ao carregar os agendamentos, verifique sua conexão: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _deleteUser(int userId) async {
    try {
      final response = await http.delete(
        Uri.parse('http://localhost:5001/users/$userId'),
      );

      if (response.statusCode == 200) {
        setState(() {
          _users.removeWhere((user) => user['id'] == userId);
        });
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Horário excluído com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        final error =
            json.decode(response.body)['error'] ?? 'Erro desconhecido';
        throw Exception('Falha ao excluir horário: $error');
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao excluir agendamento: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showDeleteConfirmation(int userId, String userName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text(
          'Tem certeza que deseja excluir o agendamento do cliente $userName?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteUser(userId);
            },
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  String _formatTimeDisplay(String time) {
    if (time.isEmpty) return 'Não disponível';
    final parts = time.split(':');
    if (parts.length < 2) return time;

    final hour = int.tryParse(parts[0]) ?? 0;
    final period = hour < 12 ? 'AM' : 'PM';
    final displayHour = hour <= 12 ? hour : hour - 12;
    return '$displayHour:00 $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Horários Marcados',
          style: TextStyle(
            fontFamily: 'Arial',
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 6, 1, 85),
      ),
      // barra inferior com atalhos
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 6, 1, 85),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Agendar Novo Horario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Sobre o Projeto',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),

              ///vai para paginainicial
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const FormScreen()), //vai para pagina de agendamento
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const DescriptionScreen()), //vai para pagina "sobre nós"
            );
          }
        },
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ExpansionTile(
                    title: Text(
                      user['name'] ?? 'Nome não disponível',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Telefone: ${user['phone'] ?? 'Não disponível'}'),
                            const SizedBox(height: 8),
                            Text('Data: ${user['date'] ?? 'Não disponível'}'),
                            const SizedBox(height: 8),
                            Text(
                                'Hora: ${_formatTimeDisplay(user['hour'] ?? '')}'),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FormScreen(userToEdit: user),
                                      ),
                                    ).then((_) => _fetchUsers());
                                  },
                                  icon: const Icon(Icons.edit),
                                  label: const Text('Editar'),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton.icon(
                                  onPressed: () => _showDeleteConfirmation(
                                    user['id'],
                                    user['name'],
                                  ),
                                  icon: const Icon(Icons.delete),
                                  label: const Text('Excluir'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
