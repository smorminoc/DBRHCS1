import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

import '../auth/auh_service.dart';

class StorageMethods {
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  final _currentUser = AuthService.firebase().currentUser!;

  //adding image to firebase storage
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    Reference ref = _storage.ref().child(childName).child(_currentUser.id);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;

    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
