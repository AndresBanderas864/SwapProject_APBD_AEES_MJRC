import 'package:flutter/material.dart';

class ContactBottomSheet extends StatelessWidget {
  final String sellerEmail;
  final String? sellerPhone;
  const ContactBottomSheet({
    super.key,
    required this.sellerEmail,
    this.sellerPhone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contacto del vendedor',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.email, color: Colors.blue),
              const SizedBox(width: 12),
              Text(sellerEmail, style: const TextStyle(color: Colors.blue)),
            ],
          ),
          if (sellerPhone != null) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.phone, color: Colors.green),
                const SizedBox(width: 12),
                Text(sellerPhone!),
              ],
            ),
          ],
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
