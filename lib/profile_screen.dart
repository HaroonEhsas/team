import 'package:flutter/material.dart';
import 'location_service.dart';
import 'auth_service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();
  final LocationService _locationService = LocationService();
  String _location = "Unknown";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Welcome to Your Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                bool isAuthenticated = await _authService.authenticateWithFingerprint();
                if (isAuthenticated) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Authentication Successful")),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Authentication Failed")),
                  );
                }
              },
              child: Text('Authenticate with Fingerprint'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                Position position = await _locationService.getCurrentLocation();
                setState(() {
                  _location = 'Lat: ${position.latitude}, Long: ${position.longitude}';
                });
              },
              child: Text('Get Current Location'),
            ),
            SizedBox(height: 20),
            Text(
              'Current Location: $_location',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
