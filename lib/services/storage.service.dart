import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final storageRef = FirebaseStorage.instance.ref();

  Reference getFileStorageRefForUser(String uid, String filename) {
    return storageRef.child('$uid/$filename');
  }

  UploadTask uploadFile(Reference ref, File file,
      {void Function(TaskSnapshot event)? snapshotEventListener}) {
    final task = ref.putFile(file);
    if (snapshotEventListener != null) {
      task.snapshotEvents.listen((event) {
        snapshotEventListener(event);
      });
    }
    return task;
  }

  Future<bool> disposeUploadTask(UploadTask task) async {
    return await task.cancel();
  }

  Future<String> getDownloadURL(Reference ref) async {
    return await ref.getDownloadURL();
  }

  Future<void> deleteFile(Reference ref) async {
    await ref.delete();
  }
}
