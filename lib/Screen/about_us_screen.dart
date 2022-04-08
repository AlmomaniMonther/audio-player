import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Me...'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.teal,
                        Colors.tealAccent,
                        Colors.white10,
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? -50
                        : -100,
                    right: 0,
                    left: 0,
                    child: CircleAvatar(
                      child: Image.asset(
                        'assets/developer.png',
                        fit: BoxFit.cover,
                      ),
                      radius: 100,
                    )),
              ],
            ),
            const SizedBox(
              height: 70,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'About me:',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(14),
              child: Text(
                'Hello everybody! \nMy name is Monther Almomani,'
                ' a communication engineer student in the last year.'
                ' \nI started to learn mobile app development about six months'
                ' ago, and this is my first application totally developed by me.'
                ' \nHope you enjoy your time using it and send me feedback about'
                ' your experience and what you hope to be better in the future.'
                '\nThank you for your support.',
                style: TextStyle(
                    fontSize: 17,
                    overflow: TextOverflow.visible,
                    fontStyle: FontStyle.italic),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Contact me:',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    primary: Colors.white70,
                  ),
                  onPressed: () {
                    _launchURL('https://facebook.com/monther.almomani/');
                  },
                  child: Image.asset(
                    'assets/logos/facebook_logo.png',
                    width: 75,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      primary: Colors.white70),
                  onPressed: () {
                    _launchURL('https://twitter.com/eng_abo_habib');
                  },
                  child: Image.asset(
                    'assets/logos/twitter_logo.png',
                    width: 75,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      primary: Colors.white70),
                  onPressed: () {
                    _launchURL('https://instagram.com/eng.abo.habib');
                  },
                  child: Image.asset(
                    'assets/logos/instagram_logo.png',
                    width: 75,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Support me on PayPal:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        primary: Colors.white70),
                    onPressed: () {
                      _launchURL('https://paypal.me/abohabib98');
                    },
                    child: Image.asset(
                      'assets/logos/paypal_logo.png',
                      width: 75,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
