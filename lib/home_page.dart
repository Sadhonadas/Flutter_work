import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to my app"),
        backgroundColor: const Color.fromARGB(255, 96, 102, 139),
        foregroundColor: Colors.white,
        // leading: Icon(Icons.home, color: Colors.amber),
        // actions: [
        //   IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
        //   IconButton(onPressed: () {}, icon: Icon(Icons.person)),
        // ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              "Description",
              style: TextStyle(color: Colors.cyan, fontSize: 30),
            ),
          ),

          Container(
            width: 200,
            height: 300,
            padding: EdgeInsets.all(40),
            margin: EdgeInsets.all(20),
            color: Colors.blueGrey,
            child: Text("Tap here"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 139, 108, 96),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      endDrawer: NavigationDrawer(
        children: [
          ListTile(
            leading: Icon(Icons.home),
            title: Text("HomePage"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("ProfilePage"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}