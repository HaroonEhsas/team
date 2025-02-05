import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FirebaseMessaging _firebaseMessaging;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging = FirebaseMessaging.instance;

    // Get the FCM token
    _firebaseMessaging.getToken().then((token) {
      print("FCM Token: $token");
    });

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print('Message contains notification: ${message.notification?.title}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TeamWork'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                // Simulate subscribing to a team updates notification
                await FirebaseMessaging.instance.subscribeToTopic('teamUpdates');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Subscribed to team updates')),
                );
              },
              child: Text('Subscribe to Team Updates'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/team_management');
              },
              child: Text('Manage Teams'),
            ),
          ],
        ),
      ),
    );
  }
}
