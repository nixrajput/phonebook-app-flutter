import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phonebook_app/src/providers/contact_provider.dart';
import 'package:phonebook_app/src/screens/add_view.dart';
import 'package:phonebook_app/src/widgets/contact_widget.dart';
import 'package:phonebook_app/src/widgets/unfocus_widget.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UnFocusWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Phonebook"),
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 4.0),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search with name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(80.0),
                    ),
                  ),
                  keyboardType: TextInputType.name,
                  maxLines: 1,
                  onChanged: (value) {
                    ref.read(contactProvider).filterContacts(value);
                  },
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: FutureBuilder(
                    future: ref.read(contactProvider).fetchContacts(),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (ref.watch(contactProvider).contactList.isEmpty) {
                        return const Center(
                          child: Text(
                            'No contacts yet.',
                            style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount:
                            ref.watch(contactProvider).contactList.length,
                        itemBuilder: (ctx, i) {
                          final contact =
                              ref.watch(contactProvider).contactList[i];
                          return ContactWidget(
                            contact: contact,
                            onDelete: () {
                              ref
                                  .read(contactProvider)
                                  .deleteContact(contact.id!);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddContactView(),
                ));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
