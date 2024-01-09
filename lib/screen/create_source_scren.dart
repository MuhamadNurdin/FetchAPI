import 'package:flutter/material.dart';

class CreateSourceScreen extends StatefulWidget {
  @override
  State<CreateSourceScreen> createState() => _CreateSourceScreenState();
}

class _CreateSourceScreenState extends State<CreateSourceScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Source'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              maxLines: null, // Allow unlimited lines for description
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _showSubmittedData();
              },
              child: Text('Submit'),
            ),
            SizedBox(height: 16.0),
            _buildSubmittedDataCard(),
          ],
        ),
      ),
    );
  }

  // Method to show the submitted data in a card-like structure
  Widget _buildSubmittedDataCard() {
    return _nameController.text.isNotEmpty || _descriptionController.text.isNotEmpty
        ? Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Submitted Data',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Name: ${_nameController.text}'),
            SizedBox(height: 8.0),
            Text('Description: ${_descriptionController.text}'),
          ],
        ),
      ),
    )
        : SizedBox.shrink();
  }

  // Method to show the submitted data in a dialog
  void _showSubmittedData() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Submitted Data'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Name: ${_nameController.text}'),
              SizedBox(height: 8.0),
              Text('Description: ${_descriptionController.text}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
