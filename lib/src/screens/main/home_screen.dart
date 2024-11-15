import 'package:chat_app_flutter/src/screens/main/chat_room_screen.dart';
import 'package:chat_app_flutter/src/services/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  String chatRoomId(String user1, String user2) {
    if (user1[0]
        .toLowerCase()
        .codeUnits[0] > user2[0]
        .toLowerCase()
        .codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('users')
        .where("email", isEqualTo: _search.text)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        setState(() {
          userMap = value.docs[0].data();
        });
      } else {
        setState(() {
          userMap = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User not found")),
        );
      }
      setState(() {
        isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
      print("Error occurred: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return isLoading
        ? const Center(
      child: CircularProgressIndicator(
        strokeWidth: 4.0,
      ),
    )
        : Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          IconButton(
              onPressed: () => logout(context),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: size.height / 20),
          Container(
            height: size.height / 14,
            width: size.width,
            alignment: Alignment.center,
            child: SizedBox(
              height: size.height / 14,
              width: size.width / 1.15,
              child: TextField(
                controller: _search,
                decoration: InputDecoration(
                  hintText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: size.height / 50),
          ElevatedButton(
            onPressed: onSearch,
            child: const Text("Search"),
          ),
          SizedBox(height: size.height / 30),
          userMap != null
              ? ListTile(
            onTap: () {
              if (_auth.currentUser?.displayName != null) {
                String roomId = chatRoomId(
                    _auth.currentUser!.displayName!,
                    userMap!['name']);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatRoomScreen(
                      charRoomId: roomId,
                      userMap: userMap!,
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Display name not found")),
                );
              }
            },
            leading: const Icon(
              Icons.account_box,
              color: Colors.black,
            ),
            title: Text(
              userMap?['name'] ?? "Unknown",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
            subtitle: Text(userMap?['email'] ?? "Unknown"),
            trailing: const Icon(
              Icons.chat,
              color: Colors.black,
            ),
          )
              : Container(),
        ],
      ),
    );
  }
}
