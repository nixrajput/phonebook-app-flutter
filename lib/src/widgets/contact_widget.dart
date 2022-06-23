import 'package:flutter/material.dart';
import 'package:phonebook_app/src/models/contact.dart';
import 'package:phonebook_app/src/screens/add_view.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({Key? key, required this.contact, required this.onDelete})
      : super(key: key);

  final Contact contact;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddContactView(
                contact: contact,
              ),
            ),
          );
        },
        title: Text(
          contact.name!,
          style: const TextStyle(
            fontSize: 20.0,
          ),
        ),
        subtitle: Text(
          contact.phoneNo!,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
        trailing: GestureDetector(
          onTap: onDelete,
          child: const Icon(
            Icons.delete_forever,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
