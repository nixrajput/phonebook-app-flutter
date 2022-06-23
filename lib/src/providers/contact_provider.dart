import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phonebook_app/src/models/contact.dart';
import 'package:phonebook_app/src/providers/db_provider.dart';

final contactProvider =
    ChangeNotifierProvider<ContactProvider>((ref) => ContactProvider());

class ContactProvider with ChangeNotifier {
  List<Contact> _contactList = [];
  final dbServices = DatabaseProvider();
  String? search = '';

  List<Contact> get contactList => [..._contactList];

  Future<void> filterContacts(String name) async {
    search = name;
    notifyListeners();
  }

  Future<void> fetchContacts() async {
    _contactList = await dbServices.fetch();
    if (search != null) {
      _contactList.retainWhere((element) =>
          element.name!.toLowerCase().contains(search!.toLowerCase()));
    }
    notifyListeners();
  }

  Future<void> addContact(Contact contact) async {
    await dbServices.insert(contact);
    notifyListeners();
  }

  Future<void> updateContact(Contact contact) async {
    dbServices.update(contact);
    notifyListeners();
  }

  Future<void> deleteContact(int id) async {
    dbServices.delete(id);
    notifyListeners();
  }
}
