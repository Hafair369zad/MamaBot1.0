// firestore_service.dart

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Metode untuk mendapatkan stream dokumen pengguna
  Stream<DocumentSnapshot> getUserDocumentStream(String uid) {
    return _firestore.collection('Users').doc(uid).snapshots();
  }

  Future<void> createUserDocument(
      User user, String username, String profilePictureUrl) async {
    await _firestore.collection('Users').doc(user.uid).set({
      'uid': user.uid,
      'username': username,
      'email': user.email,
      'profilePictureUrl': profilePictureUrl,
      'createdAt': FieldValue.serverTimestamp(),
      'lastLogin': FieldValue.serverTimestamp(),
      'updateAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateUserProfile(User user, String username, String phoneNumber,
      String profilePictureUrl) async {
    await _firestore.collection('Users').doc(user.uid).update({
      'username': username,
      'profilePictureUrl': profilePictureUrl,
      'updateAt': FieldValue.serverTimestamp(),
    });
  }

  Future<String> uploadProfilePicture(File imageFile, String userId) async {
    try {
      final ref = _storage.ref().child('profile_pictures').child('$userId.jpg');
      await ref.putFile(imageFile);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print('Error uploading profile picture: $e');
      // return 'https://firebasestorage.googleapis.com/v0/b/mamabot-4eba5.appspot.com/o/profile_pictures%2FuserBlank.png?alt=media&token=a3f40d30-e3d6-4bc7-bc47-0ad7ed0a6ea0';
      return 'assets/default_profile.png';
    }
  }

  Future<DocumentSnapshot> getUserDocument(String uid) async {
    return await _firestore.collection('Users').doc(uid).get();
  }

  Future<void> addMessage(String chatId, String senderId, String receiverId,
      String message, String time, String isField) async {
    await _firestore
        .collection('Chats')
        .doc(chatId)
        .collection('messages')
        .add({
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
      'isField': isField,
    });
  }

  Future<List<String>> getPromptTemplates() async {
    final promptCollection = await _firestore
        .collection('Prompt')
        .orderBy('timestamp', descending: false)
        .get();
    return promptCollection.docs.map((doc) => doc['prompt'] as String).toList();
  }
}
