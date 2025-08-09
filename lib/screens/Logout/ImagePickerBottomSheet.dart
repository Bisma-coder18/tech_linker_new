import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  final VoidCallback onRemove;

  const ImagePickerBottomSheet({
    super.key,
    required this.onRemove,
  });

  Future<void> _pickGallery(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      debugPrint("Selected image from gallery: ${pickedFile.path}");
    }
    Navigator.pop(context);
  }

  Future<void> _pickCamera(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );
    if (pickedFile != null) {
      debugPrint("Captured image from camera: ${pickedFile.path}");
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 5,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildOption(
                icon: Icons.photo,
                label: "Gallery",
                onTap: () => _pickGallery(context),
              ),
              _buildOption(
                icon: Icons.camera_alt,
                label: "Camera",
                onTap: () => _pickCamera(context),
              ),
              _buildOption(
                icon: Icons.delete,
                label: "Remove",
                onTap: () {
                  onRemove();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xFF2563EB),
            child: Icon(icon, color: Colors.white, size: 26),
          ),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}
