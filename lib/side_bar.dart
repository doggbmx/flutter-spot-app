import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              'Pepe Pijudo',
              style: TextStyle(color: Colors.black, fontSize: 35),
            ),
            accountEmail: const Text(
              'Le encanta el crack y la paja',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            currentAccountPicture: CircleAvatar(
              child: Image.network(
                'https://imagenes.20minutos.es/files/image_990_v3/files/fp/uploads/imagenes/2020/11/05/luisito-time-el-humorista-que-hace-de-el-rata-en-el-video-viral-de-humor.r_d.540-294.jpeg',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://histecon.fas.harvard.edu/chlatin/graphics/favela-header.jpg'),
                  fit: BoxFit.cover,
                  opacity: 60),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.favorite),
            title: Text('chupapig'),
            onTap: null,
          ),
          const ListTile(
            leading: Icon(Icons.badge),
            title: Text('sisi'),
          ),
          const ListTile(
            leading: Icon(Icons.apps),
            title: Text('como no'),
          )
        ],
      ),
    );
  }
}
