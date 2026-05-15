import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/article_provider.dart';
import '../services/cloudinary_service.dart';

class AddArticleScreen extends StatefulWidget {
  const AddArticleScreen({super.key});
  @override
  State<AddArticleScreen> createState() => _AddArticleScreenState();
}

class _AddArticleScreenState extends State<AddArticleScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  String _category = 'Electrónica';
  String _type = 'venta';
  String _location = 'Bogotá - Sede Principal';
  File? _imageFile;
  bool _uploadingImage = false;

  final List<String> _categories = [
    'Electrónica', 'Libros', 'Ropa', 'Deportes', 'Hogar', 'Otro'
  ];
  final List<String> _types = ['venta', 'intercambio'];
  final List<String> _locations = [
    'Bogotá - Sede Principal',
    'Bogotá - Sede Administrativa',
    'Medellín',
    'Cali',
    'Bucaramanga',
    'Cúcuta',
    'Neiva',
    'Ibagué',
    'Villavicencio',
    'Otra sede',
  ];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 80,
    );
    if (picked != null) {
      setState(() => _imageFile = File(picked.path));
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ArticleProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Publicar artículo')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: _imageFile != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(_imageFile!, fit: BoxFit.cover),
                        )
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
                            SizedBox(height: 8),
                            Text('Agregar foto (opcional)',
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: const InputDecoration(labelText: 'Categoría'),
                items: _categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => _category = v!),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _type,
                decoration: const InputDecoration(labelText: 'Tipo'),
                items: _types
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (v) => setState(() => _type = v!),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _location,
                decoration: const InputDecoration(labelText: 'Ubicación'),
                items: _locations
                    .map((l) => DropdownMenuItem(value: l, child: Text(l)))
                    .toList(),
                onChanged: (v) => setState(() => _location = v!),
              ),
              const SizedBox(height: 24),
              if (provider.error != null)
                Text(provider.error!, style: const TextStyle(color: Colors.red)),
              (_uploadingImage || provider.loading)
                  ? const Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 8),
                        Text('Subiendo...'),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        final price = double.tryParse(_priceController.text) ?? 0;
                        if (_titleController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('El título es obligatorio')),
                          );
                          return;
                        }
                        if (price <= 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('El precio debe ser mayor a 0')),
                          );
                          return;
                        }
                        String? imageUrl;
                        if (_imageFile != null) {
                          setState(() => _uploadingImage = true);
                          imageUrl = await CloudinaryService().uploadImage(_imageFile!);
                          setState(() => _uploadingImage = false);
                        }
                        await provider.addArticle(
                          title: _titleController.text.trim(),
                          description: _descriptionController.text.trim(),
                          price: price,
                          category: _category,
                          type: _type,
                          location: _location,
                          imageUrl: imageUrl,
                        );
                        if (provider.error == null && context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Publicar'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
