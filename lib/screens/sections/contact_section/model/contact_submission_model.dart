import 'package:cloud_firestore/cloud_firestore.dart';

class ContactSubmission {
  final String? id;
  final String name;
  final String email;
  final String? phone;
  final String message;
  final DateTime timestamp;

  ContactSubmission({
    this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.message,
    required this.timestamp,
  });

// Convert to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'message': message,
      'timestamp': timestamp.millisecondsSinceEpoch, // Use milliseconds instead
    };
  }

// Update fromFirestore method too
  factory ContactSubmission.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ContactSubmission(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'],
      message: data['message'] ?? '',
      timestamp: DateTime.fromMillisecondsSinceEpoch(data['timestamp'] ?? 0),
    );
  }
}