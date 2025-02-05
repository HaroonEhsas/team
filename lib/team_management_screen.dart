import 'package:flutter/material.dart';

class TeamManagementScreen extends StatefulWidget {
  @override
  _TeamManagementScreenState createState() => _TeamManagementScreenState();
}

class _TeamManagementScreenState extends State<TeamManagementScreen> {
  final List<String> _teams = [];
  final TextEditingController _teamController = TextEditingController();

  void _addTeam() {
    setState(() {
      _teams.add(_teamController.text);
    });
    _teamController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Teams'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _teamController,
              decoration: InputDecoration(
                labelText: 'Team Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addTeam,
              child: Text('Add Team'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _teams.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_teams[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _teams.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
