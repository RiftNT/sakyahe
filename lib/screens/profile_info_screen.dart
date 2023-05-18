import 'package:flutter/material.dart';
import 'package:sakyahe/widgets/custom_button.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  @override
  Widget build(BuildContext context) {
    Widget ProfileInfo = Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 1),
      child: Column(
        children: [
          const SizedBox(height: 10),
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const ListTile(
              leading: Icon(
                Icons.keyboard_arrow_left,
                size: 50,
                color: Colors.black,
              ),
              title: Text(
                '   Profile',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
                textAlign: TextAlign.left,
              ),
              textColor: Colors.black54,
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Stack(
              alignment: Alignment.center,
              children: const [
                Icon(
                  Icons.circle,
                  size: 100,
                  color: Colors.grey,
                ),
                Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {},
            child: const ListTile(
              // tileColor: Colors.black12,
              contentPadding: EdgeInsets.symmetric(horizontal: 50),
              leading: Icon(
                Icons.call,
                size: 27,
                color: Colors.black54,
              ),
              title: Text(
                '+63 928 212 4127',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
                textAlign: TextAlign.left,
              ),
              textColor: Colors.black54,
            ),
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                  ),
                  builder: ((context) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 35),
                      // height: 500,
                      child: Column(
                        children: [
                          const Text(
                            "Edit your name",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            // controller: textController,
                            decoration: const InputDecoration(
                                hintText: "Enter your name"),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: CustomButton(
                              text: "Confirm",
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    );
                  }));
            },
            child: const ListTile(
              // tileColor: Colors.black12,
              contentPadding: EdgeInsets.symmetric(horizontal: 50),
              leading: Icon(
                Icons.person,
                size: 27,
                color: Colors.black54,
              ),
              title: Text(
                'Matthew Dave Q. Desabelle',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
                textAlign: TextAlign.left,
              ),
              textColor: Colors.black54,
            ),
          ),
          InkWell(
            onTap: () {},
            child: const ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 50),
              // tileColor: Colors.black12,
              leading: Icon(
                Icons.email,
                size: 27,
                color: Colors.black54,
              ),
              title: Text(
                '17100772@usc.edu.ph',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
                textAlign: TextAlign.left,
              ),
              textColor: Colors.black54,
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Info Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileInfo,
          ],
        ),
      ),
    );
  }
}
