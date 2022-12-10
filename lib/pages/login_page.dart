import 'package:budget_app/main.dart';
import 'package:budget_app/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text('Manage your budget like a pro !',
                style: GoogleFonts.bebasNeue(fontSize: 50)),
          ),
          const SizedBox(
            height: 150,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 99, 96, 96),
                ),
                hintText: 'Enter your name',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade600),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade600),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          MaterialButton(
            onPressed: () async {
              if (_textController.text == '') {
                const snackBar = SnackBar(
                  backgroundColor: Colors.redAccent,
                  content: Text(
                    'Please enter your name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                await sharedPreferences.setString(
                    'nameKey', _textController.text);
                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const BottomNavbar();
                    },
                  ),
                );
              }

              setState(() {});
            },
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 55, 54, 54),
                  borderRadius: BorderRadius.circular(15)),
              height: 40,
              width: 110,
              child: const Center(
                child: Text(
                  'Countinue',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
