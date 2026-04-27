import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Leading University",
          style: GoogleFonts.lobster(color: Colors.black),
        ), //Text
        backgroundColor: const Color.fromARGB(255, 163, 207, 32),
        foregroundColor: const Color.fromARGB(255, 8, 8, 8),
        // leading: Icon(Icons.home, color: Colors.amber),
        // actions: [
        //   IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
        //   IconButton(onPressed: () {}, icon: Icon(Icons.person)),
        // ],
      ), //AppBar
      body: SingleChildScrollView(
  child: Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          "Good morning!!!",
          style: GoogleFonts.lobster(
            color: const Color.fromARGB(255, 207, 104, 212),
            fontSize: 30,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          "Welcome to our class!!",
          style: GoogleFonts.lobster(
            color: const Color.fromARGB(255, 207, 104, 212),
            fontSize: 20,
          ),
        ),
      ),

      
      SizedBox(
        height: 200,
        width: 200,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.red,
          child: Center(
            child: Image.asset(
              "assets/images/icons8-flutter-48.png", 
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),

      Container(
        width: 300,
        height: 400,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 33, 164, 49),
          border: Border.all(color: Colors.white, width: 3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "I'm SADHONA!!",
              style: GoogleFonts.lobster(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            Text(
              "I am a student!!",
              style: GoogleFonts.lobster(
                color: const Color.fromARGB(255, 188, 12, 12),
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    ],
  ),
),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        onPressed: () {},
        child: Icon(Icons.add),
      ), //FloatingActionButton
      endDrawer: NavigationDrawer(
        //NavigationDrawer
        children: [
          ListTile(
            //ListTile
            leading: Icon(Icons.home),
            title: Text("HomePage"),
            onTap: () {},
          ), //ListTile
          ListTile(
            //ListTile
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {},
          ), //ListTile
          ListTile(
            //ListTile
            leading: Icon(Icons.person),
            title: Text("ProfilePage"),
            onTap: () {},
          ), //ListTile
        ],
      ), //NavigationDrawer
    ); //Scaffold
  }
}