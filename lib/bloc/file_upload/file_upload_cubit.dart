import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FileUploadCubit extends Cubit<TaskState> {
  FileUploadCubit() : super(TaskState.running);

  void setState(TaskState state) => emit(state);
}
