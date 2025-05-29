import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// imports de telas
import 'form_screen.dart';
import 'user_list_screen.dart';
import 'home_screen.dart';

class DescriptionScreen extends StatefulWidget {
  const DescriptionScreen({super.key});

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quem Somos??',
          style: TextStyle(

              ///Estilos Do titulo (cor, fonte , etc)
              fontFamily: 'Arial',
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 6, 1, 85),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'No mundo tecnológico que vivemos hoje, a presença da internet é indispensável ! e por isso a Tech Barber procura trazer mais tecnologia a sua barbearia, utilizando um sistema 100% online onde você pode receber solicitações de agendamentos de horário diretamente na palma da sua mão , ou da mesa de seu computador! nosso sistema recebe as informações do cliente e disponibiliza os horários para própria escolha.Todos os cadastros são enviados para lista de clientes cadastrados. ',
              style: TextStyle(
                ///Estilos Do texto (cor, fonte , etc)
                fontFamily: 'Arial',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 6, 1, 85),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Nosso projeto busca trazer facilidade no agendamento de horários de barbearias,e para essa tarefa utilizamos uma API em Python (Flask API) que permite cadastrar, consultar, editar e excluir usuários de uma tabela em um banco de dados, e através de um frontend criado em Flutter implementamos essa aplicação em nosso sistema de cadastro de agendamentos.',
              style: TextStyle(
                ///Estilos Do texto (cor, fonte , etc)
                fontFamily: 'Arial',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 6, 1, 85),
              ),
            ),
          ],
        ),
      ),
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
            label: 'Agendar Novo Horário',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Agendamentos',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FormScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UserListScreen()),
            );
          }
        },
      ),
    );
  }
}
