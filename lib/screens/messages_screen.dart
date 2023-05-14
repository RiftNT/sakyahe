import 'package:flutter/material.dart';
import 'package:sakyahe/screens/chat_screen.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget Messages = Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Column(
        children: [
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Text(
                  'Messages',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChatScreen(),
                    ),
                  );
                },
                child: const ListTile(
                  leading: Icon(
                    Icons.circle,
                    size: 60,
                    color: Colors.black12,
                  ),
                  title: Text('Carpool Group 1'),
                  subtitle: Text('Joaan: See you guys tommorow. :)'),
                  textColor: Colors.black87,
                ),
              ),
              const SizedBox(height: 5),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChatScreen(),
                    ),
                  );
                },
                child: const ListTile(
                  leading: Icon(
                    Icons.circle,
                    size: 60,
                    color: Colors.black12,
                  ),
                  title: Text('Carpool Group 2'),
                  subtitle: Text('Fushi: Hello, Good morning.'),
                  textColor: Colors.black87,
                ),
              ),
              const SizedBox(height: 5),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChatScreen(),
                    ),
                  );
                },
                child: const ListTile(
                  leading: Icon(
                    Icons.circle,
                    size: 60,
                    color: Colors.black12,
                  ),
                  title: Text('Carpool Group 3'),
                  subtitle: Text('March: Andam namo guys :D'),
                  textColor: Colors.black87,
                ),
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Text(
                  'Archived',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const ChatScreen(),
                  //   ),
                  // );
                },
                child: const ListTile(
                  leading: Icon(
                    Icons.circle,
                    size: 60,
                    color: Colors.black12,
                  ),
                  title: Text('Carpool Group 12'),
                  subtitle: Text('Parona: Thank you guys, amping mo.'),
                  textColor: Colors.black38,
                ),
              ),
              const SizedBox(height: 5),
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const ChatScreen(),
                  //   ),
                  // );
                },
                child: const ListTile(
                  leading: Icon(
                    Icons.circle,
                    size: 60,
                    color: Colors.black12,
                  ),
                  title: Text('Carpool Group 21'),
                  subtitle: Text('Gugu: Take care always guys.'),
                  textColor: Colors.black38,
                ),
              ),
              const SizedBox(height: 5),
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const ChatScreen(),
                  //   ),
                  // );
                },
                child: const ListTile(
                  leading: Icon(
                    Icons.circle,
                    size: 60,
                    color: Colors.black12,
                  ),
                  title: Text('Carpool Group 11'),
                  subtitle: Text('Tonari: Salamat boss'),
                  textColor: Colors.black38,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Messages,
          ],
        ),
      ),
    );
  }
}
