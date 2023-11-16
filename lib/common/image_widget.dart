import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spims/common/app_responsive.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({super.key});

  @override
  _ImageWidgetState createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  String selectedImage = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectImage,
      child: Tooltip(
        message: 'Add Profile Image',
        child: ClipRRect(
          borderRadius: BorderRadius.circular(1000),
          child: Container(
            width: AppResponsive.isMobile(context) ? 80 : 120,
            height: AppResponsive.isMobile(context) ? 80 : 120,
            color: Colors.grey[300],
            child: selectedImage.isEmpty
                ? const Icon(
                    Icons.add_a_photo,
                    size: 60,
                    semanticLabel: 'Add Image',
                    textDirection: TextDirection.ltr,
                  )
                : Image.asset(
                    selectedImage,
                    width: AppResponsive.isMobile(context) ? 42 : 120,
                    height: AppResponsive.isMobile(context) ? 42 : 120,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage.path;
      });
    }
  }
}
