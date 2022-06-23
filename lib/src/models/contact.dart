class Contact {
  Contact({
    this.id,
    this.name,
    this.phoneNo,
  });

  final int? id;
  final String? name;
  final String? phoneNo;

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['_id'],
      name: map['name'],
      phoneNo: map['phoneNo'],
    );
  }

  Map<String, Object?> toMap() {
    return {
      '_id': id,
      'name': name,
      'phoneNo': phoneNo,
    };
  }
}
