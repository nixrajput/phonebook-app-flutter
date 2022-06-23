import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phonebook_app/src/models/contact.dart';
import 'package:phonebook_app/src/providers/contact_provider.dart';
import 'package:phonebook_app/src/widgets/unfocus_widget.dart';

class AddContactView extends ConsumerWidget {
  const AddContactView({
    Key? key,
    this.contact,
  }) : super(key: key);

  final Contact? contact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController(text: contact?.name);
    final phoneController = TextEditingController(text: contact?.phoneNo);

    return UnFocusWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Contact"),
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        label: Text('Name'),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 32.0),
                    TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        label: Text('Phone Number'),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    onPressed: () {
                      if (nameController.text.isEmpty ||
                          phoneController.text.isEmpty) {
                        return;
                      }
                      if (contact != null) {
                        ref.read(contactProvider).updateContact(
                              Contact(
                                id: contact!.id,
                                name: nameController.text,
                                phoneNo: phoneController.text,
                              ),
                            );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Contact updated successfully.'),
                          ),
                        );
                      } else {
                        ref.read(contactProvider).addContact(
                              Contact(
                                name: nameController.text,
                                phoneNo: phoneController.text,
                              ),
                            );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Contact added successfully.'),
                          ),
                        );
                      }
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
