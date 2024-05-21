import 'dart:io';

import 'package:festo_app/bloc/file_upload/file_upload_cubit.dart';
import 'package:festo_app/services/storage.service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

class FileUploadView extends StatefulWidget {
  final String uploadPathPrefix;
  final File file;
  final void Function(String downloadURL) onUploadComplete;
  final void Function() onClose;
  const FileUploadView(
      {super.key,
      required this.uploadPathPrefix,
      required this.file,
      required this.onUploadComplete,
      required this.onClose});

  @override
  State<FileUploadView> createState() => _FileUploadViewState();
}

class _FileUploadViewState extends State<FileUploadView> {
  final storageService = StorageService();
  late Reference ref;
  late UploadTask task;
  final cubit = FileUploadCubit();

  @override
  void initState() {
    super.initState();
    ref = storageService.getFileStorageRefForUser(
        widget.uploadPathPrefix, basename(widget.file.path));
    task = storageService.uploadFile(ref, widget.file,
        snapshotEventListener: (taskSnapshot) {
      cubit.setState(taskSnapshot.state);
    });
  }

  @override
  void dispose() {
    storageService.disposeUploadTask(task);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: BlocBuilder<FileUploadCubit, TaskState>(
      bloc: cubit,
      builder: (context, state) {
        if (state == TaskState.error) {
          const snackBar =
              SnackBar(content: Text('Unknown error while uploading file'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.close_outlined,
                color: Colors.red,
              ),
              OutlinedButton(
                  onPressed: () {
                    widget.onClose();
                  },
                  child: const Text('Retry or Go back'))
            ],
          );
        } else if (state == TaskState.success) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            storageService
                .getDownloadURL(ref)
                .then((value) => widget.onUploadComplete(value));
          });
        }
        return const CircularProgressIndicator();
      },
    ));
  }
}
