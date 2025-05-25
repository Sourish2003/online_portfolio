import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/sections/contact_section/model/contact_submission_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'contact_submissions';

  Future<bool> submitContactForm(ContactSubmission submission) async {
    try {
      await _firestore.collection(_collection).add(submission.toMap());
      return true;
    } catch (e) {
      log('Error submitting form: $e');
      return false;
    }
  }

  // Get all submissions (for future admin use)
  Stream<List<ContactSubmission>> getContactSubmissions() {
    return _firestore
        .collection(_collection)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => ContactSubmission.fromFirestore(doc))
        .toList());
  }
}