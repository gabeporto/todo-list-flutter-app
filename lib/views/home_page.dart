import 'package:flutter/material.dart';
import 'package:todo_list_app/components/app_bar_component.dart';
import 'package:todo_list_app/controllers/access_controller.dart';
import 'package:todo_list_app/controllers/user_controller.dart';
import 'package:todo_list_app/models/user.dart';
import 'package:todo_list_app/views/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late User? _loggedUser;

  @override
  void initState() {
    super.initState();
    _loadLoggedUser();
  }

  Future<void> _loadLoggedUser() async {
    User user = await UserController.instance.getUserByIdFromJwtToken();
    setState(() {
      _loggedUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        leading: false, 
        title: 'ToDo App',
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => 
              <PopupMenuEntry<String>>[
                PopupMenuItem(
                  value: 'Perfil',
                  child: const Text('Perfil'),
                  onTap: (){},
                ),
                PopupMenuItem(
                  value: 'Logout',
                  child: const Text('Logout'),
                  onTap: () async {
                    final navigator = Navigator.of(context);
                    bool logout = await AccessController.instance.logout();

                    if(logout){
                      navigator.pushReplacement(
                        MaterialPageRoute(builder: (context) => const LoginPage())
                      );
                    }
                  },
                ),
              ],
              child: Image.network(_loggedUser!.image, width: 40, height: 40),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: const Color(0xFF27ae60),
        selectedIndex: _selectedIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.task_outlined), 
            selectedIcon: Icon(Icons.task),
            label: 'Tarefas'
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined), 
            selectedIcon: Icon(Icons.calendar_month),
            label: 'Calendário'
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings), 
            label: 'Tarefas'
          ),
        ],
      ),
      body: [
        const Text('Tarefas'),
        const Text('Calendário'),
        const Text('Configurações'),
      ][_selectedIndex],
    );
  }
}