import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../ui/bottom_sheets/passport_upload_source_sheet.dart';

class PassportPickResult {
  const PassportPickResult({
    required this.fileName,
    this.path,
  });

  final String fileName;
  final String? path;
}

class PassportFilePicker {
  PassportFilePicker._();

  static const _allowedExtensions = ['jpg', 'jpeg', 'png', 'pdf'];

  static Future<PassportPickResult?> pick(BuildContext context) async {
    final source = await PassportUploadSourceSheet.show(context);
    if (source == null) return null;

    final result = source == PassportUploadSource.gallery
        ? await _pickFromGallery()
        : await _pickFromFiles();

    if (result == null) return null;

    final file = result.files.first;
    final fileName = file.name;
    if (!_isAllowedFile(fileName)) {
      throw PassportPickException(PassportPickError.invalidType);
    }

    return PassportPickResult(
      fileName: fileName,
      path: file.path,
    );
  }

  static Future<FilePickerResult?> _pickFromGallery() {
    return FilePicker.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      withData: false,
    );
  }

  static Future<FilePickerResult?> _pickFromFiles() {
    return FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: _allowedExtensions,
      allowMultiple: false,
      withData: false,
    );
  }

  static bool _isAllowedFile(String fileName) {
    final dotIndex = fileName.lastIndexOf('.');
    if (dotIndex == -1) return false;
    final ext = fileName.substring(dotIndex + 1).toLowerCase();
    return _allowedExtensions.contains(ext);
  }
}

enum PassportPickError { cancelled, invalidType, failed }

class PassportPickException implements Exception {
  PassportPickException(this.error, [this.message]);

  final PassportPickError error;
  final String? message;
}
