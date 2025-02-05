import 'package:flutter/material.dart';
import 'auth_service.dart';

class LeaveManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        Card(
          elevation: 5,
          child: ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Leave Requests'),
            subtitle: Text('Submit new leave requests'),
            onTap: () {
              // Navigate to Submit Leave screen
            },
          ),
        ),
        Card(
          elevation: 5,
          child: ListTile(
            leading: Icon(Icons.list),
            title: Text('Leave History'),
            subtitle: Text('View your leave history'),
            onTap: () {
              // Navigate to Leave History screen
            },
          ),
        ),
      ],
    );
  }
}
