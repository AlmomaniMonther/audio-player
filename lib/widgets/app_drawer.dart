import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.asset('assets/drawer.png'),
            ),
            ListTile(
              leading: const Icon(Icons.info, size: 30, color: Colors.black87),
              title: const Text(
                'About us...',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/aboutUsScreen');
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.feedback, size: 30, color: Colors.black87),
              title: const Text(
                'Feedback...',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/feedbackScreen');
              },
            ),
          ],
        ),
      ),
    );
  }
}
