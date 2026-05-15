import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/article_model.dart';
import '../providers/article_provider.dart';

class EditArticleScreen extends StatefulWidget {
  final Article article;
  const EditArticleScreen({super.key, required this.article});
  @override
  State<EditArticleScreen> createState() => _EditArticleScreenState();
}

class _EditArticleScreenState extends State<EditArticleScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late String _type;

  final List<String> _types = ['venta', 'intercambio'];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.article.title);
    _descriptionController = TextEditingController(text: widget.article.description);
    _priceController = TextEditingController(text: widget.article.price.toStringAsFixed(0));
    _type = widget.article.type;
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
      appBar: AppBar(title: const Text('Editar artículo')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                value: _type,
                decoration: const InputDecoration(labelText: 'Tipo'),
                items: _types
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (v) => setState(() => _type = v!),
              ),
              const SizedBox(height: 24),
              if (provider.error != null)
                Text(provider.error!, style: const TextStyle(color: Colors.red)),
              provider.loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        final price = double.tryParse(_priceController.text) ?? 0;
                        if (price <= 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('El precio debe ser mayor a 0')),
                          );
                          return;
                        }
                        await provider.updateArticle(
                          widget.article.id,
                          title: _titleController.text.trim(),
                          description: _descriptionController.text.trim(),
                          price: price,
                          type: _type,
                        );
                        if (provider.error == null && context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Guardar cambios'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
