import 'package:blog_app_mobile/screens/login_screen.dart';
import 'package:blog_app_mobile/screens/post_form.dart';
import 'package:blog_app_mobile/screens/post_screen.dart';
import 'package:blog_app_mobile/screens/profile.dart';
import 'package:blog_app_mobile/services/user_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Olvera Blog'),
        leading: IconButton(
            onPressed: () {
              logout().then((value) => {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (route) => false)
                  });
            },
            icon: const Icon(Icons.logout_outlined)),
      ),
      body: currentIndex == 0 ? PostScreen() : const Profile(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PostForm(
                    title: 'Add new post',
                  )));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (val) {
          setState(() {
            currentIndex = val;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        type: BottomNavigationBarType.fixed, // Mantiene los elementos fijos
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey.shade600,
        iconSize: 30, // Tamaño del icono
      ),
    );
  }
}
