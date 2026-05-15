import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CloudinaryService {
  static const String _cloudName = 'dbuivo1jf';
  static const String _uploadPreset = 'SWAPimgs';

  Future<String?> uploadImage(File imageFile) async {
    try {
      final uri = Uri.parse(
          'https://api.cloudinary.com/v1_1/$_cloudName/image/upload');
      final request = http.MultipartRequest('POST', uri);
      request.fields['upload_preset'] = _uploadPreset;
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        imageFile.path,
      ));
      final response = await request.send();
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);
      if (response.statusCode == 200) {
        return jsonMap['secure_url'] as String;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
