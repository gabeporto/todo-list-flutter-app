import 'package:flutter/material.dart';
import 'package:todo_list_app/components/app_bar_component.dart';
import 'package:todo_list_app/components/detail_row_component.dart';
import 'package:todo_list_app/models/user.dart';

class ProfilePage extends StatelessWidget {
  final User? user;
  const ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        leading: false,
        title: 'ToDo App',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: 80,
              child: user != null ?
               Image.network(
                user!.image,
               )
              : const Icon(
                Icons.person, 
                color: Colors.grey
              )
            ),
            Text(
              '${user!.firstName} ${user!.lastName}',
              style: 
                const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
            ),
            Text(
              user!.email,
              style: 
                const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey
                ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detalhes do Perfil',
                    style: 
                      TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                  ),
                  detailRow(label: 'ID: ', value: user!.id.toString()),
                  detailRow(label: 'Nome: ', value: user!.firstName.toString() + " " + user!.lastName.toString() ),
                  detailRow(label: 'Email: ', value: user!.email.toString()),
              ],),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: (){},
                  child: const Text('Logout') ,
                ),
              ],
            ),  
          ],
        ),
      ),
    );
  }
}