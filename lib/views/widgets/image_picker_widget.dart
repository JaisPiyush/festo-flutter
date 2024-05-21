import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final void Function(XFile? image) onImagePick;
  const ImagePickerWidget(
      {super.key,
      required this.title,
      required this.onImagePick,
      this.subtitle});

  Future<XFile?> _pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    return await imagePicker.pickImage(source: source);
  }

  Future<void> _pickImageAndCallOnImagePick(ImageSource source) async {
    final image = await _pickImage(source);
    onImagePick(image);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Center(
                child: Text(
              title,
              style: theme.textTheme.displayMedium!
                  .copyWith(fontWeight: FontWeight.normal),
            )),
            subtitle: subtitle != null
                ? Center(
                    child: Text(
                    subtitle!,
                  ))
                : null,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton.icon(
                  onPressed: () {
                    _pickImageAndCallOnImagePick(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera),
                  label: const Text(
                    'Camera',
                  )),
              const SizedBox(
                width: 20,
              ),
              OutlinedButton.icon(
                  onPressed: () {
                    _pickImageAndCallOnImagePick(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('Gallery')),
            ],
          )
        ],
      );
    });
  }
}
