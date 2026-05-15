import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../repositories/user_repository.dart';
import '../services/cloudinary_service.dart';
import '../theme/app_theme.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _phoneController = TextEditingController();
  final _repo = UserRepository();
  File? _imageFile;
  String? _currentPhotoUrl;
  bool _loading = true;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadCurrentData();
  }

  Future<void> _loadCurrentData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final user = await _repo.getUserByUid(uid);
    if (mounted) {
      setState(() {
        _phoneController.text = user?.phone ?? '';
        _currentPhotoUrl = user?.photoUrl;
        _loading = false;
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 85,
    );
    if (picked != null) {
      setState(() => _imageFile = File(picked.path));
    }
  }

  bool _validatePhone(String phone) {
    return phone.length == 10 && phone.startsWith('3');
  }

  Future<void> _save() async {
    setState(() {
      _error = null;
      _saving = true;
    });

    final phone = _phoneController.text.trim();
    if (phone.isNotEmpty && !_validatePhone(phone)) {
      setState(() {
        _error = 'El teléfono debe tener 10 dígitos y comenzar con 3';
        _saving = false;
      });
      return;
    }

    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final Map<String, dynamic> updates = {};
    if (phone.isNotEmpty) updates['phone'] = phone;

    if (_imageFile != null) {
      final url = await CloudinaryService().uploadImage(_imageFile!);
      if (url != null) updates['photoUrl'] = url;
    }

    if (updates.isNotEmpty) {
      await _repo.updateUser(uid, updates);
    }

    if (mounted) {
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil actualizado correctamente')),
      );
      Navigator.pop(context);
    }
  }

  Widget _avatar() {
    final hasNewImage = _imageFile != null;
    final hasCurrentPhoto = _currentPhotoUrl != null;

    ImageProvider? imageProvider;
    if (hasNewImage) {
      imageProvider = FileImage(_imageFile!);
    } else if (hasCurrentPhoto) {
      imageProvider = NetworkImage(_currentPhotoUrl!);
    }

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 56,
          backgroundColor: AppColors.coralSuave,
          backgroundImage: imageProvider,
          child: imageProvider == null
              ? const Icon(Icons.person, size: 56, color: Colors.white)
              : null,
        ),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.verdeTeal,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Icon(Icons.camera_alt,
                size: 18, color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mentaClaro,
      appBar: AppBar(
        backgroundColor: AppColors.verdeTeal,
        elevation: 0,
        title: Text('Editar perfil',
            style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.verdeTeal))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  _avatar(),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _pickImage,
                    child: Text('Cambiar foto',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            color: AppColors.verdeTeal,
                            fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Número de teléfono',
                      prefixIcon: Icon(Icons.phone_outlined,
                          color: AppColors.verdeTeal),
                    ),
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 8),
                    Text(_error!,
                        style: GoogleFonts.inter(
                            fontSize: 13, color: Colors.red)),
                  ],
                  const SizedBox(height: 32),
                  _saving
                      ? const CircularProgressIndicator(
                          color: AppColors.verdeTeal)
                      : SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _save,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.verdeTeal,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                            ),
                            child: Text('Guardar cambios',
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                          ),
                        ),
                ],
              ),
            ),
    );
  }
}
