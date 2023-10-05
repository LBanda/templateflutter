import 'package:flutter/material.dart';

import '../views/login_page.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
      child: Drawer(
        elevation: 0.5,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.symmetric(),
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('Nombre del usuario'),
              accountEmail: const Text('Correo del usuario'),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.network('assets/images/profile-icon.jpg',
                    fit: BoxFit.cover,
                    width: 500,
                    height: 500,
                    errorBuilder: (context, error, stackTrace) {
                      // Si ocurre un error al cargar la imagen remota, mostrar imagen local
                      return Image.asset(
                        'assets/images/profile-icon.jpg',
                        fit: BoxFit.cover,
                        width: 500,
                        height: 500,
                      );
                    },
                  ),
                ),
              ),
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () => onItemPressed(context, index: 0),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Acerca de'),
              onTap: () => onItemPressed(context, index: 1),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Cerrar sesion'),
              onTap: () => onItemPressed(context, index: 2),
            ),
          ],
        ),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);
    switch (index) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const loginPage()));
        break;
      default:
        Navigator.pop(context);
        break;
    }
  }

}