import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import '../../domain/entities/resume.dart';
import '../../domain/usecases/get_resumes_usecase.dart';
import '../../domain/usecases/upload_resume_usecase.dart';
import '../../domain/usecases/delete_resume_usecase.dart';
import '../../../../core/services/snackbar_service.dart';

class ResumeController extends GetxController {
  final GetResumesUseCase _getResumesUseCase;
  final UploadResumeUseCase _uploadResumeUseCase;
  final DeleteResumeUseCase _deleteResumeUseCase;

  ResumeController({
    required GetResumesUseCase getResumesUseCase,
    required UploadResumeUseCase uploadResumeUseCase,
    required DeleteResumeUseCase deleteResumeUseCase,
  }) : _getResumesUseCase = getResumesUseCase,
       _uploadResumeUseCase = uploadResumeUseCase,
       _deleteResumeUseCase = deleteResumeUseCase;

  // Observable variables
  final RxBool _isLoading = false.obs;
  final RxList<Resume> _resumes = <Resume>[].obs;
  final RxString _errorMessage = ''.obs;

  // Getters
  bool get isLoading => _isLoading.value;
  List<Resume> get resumes => _resumes;
  String get errorMessage => _errorMessage.value;

  @override
  void onInit() {
    super.onInit();
    loadResumes();
  }

  Future<void> loadResumes({bool refresh = false}) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final resumes = await _getResumesUseCase(refresh: refresh);
      _resumes.value = resumes;
      
      if (refresh) {
        SnackbarService.showSuccess(
          title: 'Success',
          message: 'Resumes refreshed successfully',
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      _errorMessage.value = e.toString().replaceAll('Exception: ', '');
      SnackbarService.showError(title: 'Error', message: _errorMessage.value);
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> pickAndUploadResume() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = File(result.files.first.path!);
        final resume = await _uploadResumeUseCase(file);
        
        _resumes.insert(0, resume);
        
        SnackbarService.showSuccess(
          title: 'Success',
          message: 'Resume uploaded successfully',
        );
      }
    } catch (e) {
      _errorMessage.value = e.toString().replaceAll('Exception: ', '');
      SnackbarService.showError(title: 'Error', message: _errorMessage.value);
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> deleteResume(String resumeId) async {
    // Show confirmation dialog
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Delete Resume'),
        content: const Text('Are you sure you want to delete this resume? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      // Call the delete use case
      await _deleteResumeUseCase(resumeId);
      
      // Remove from local list
      _resumes.removeWhere((resume) => resume.id == resumeId);
      
      SnackbarService.showSuccess(
        title: 'Success',
        message: 'Resume deleted successfully',
      );
    } catch (e) {
      _errorMessage.value = e.toString().replaceAll('Exception: ', '');
      SnackbarService.showError(
        title: 'Error',
        message: _errorMessage.value,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  /// Force refresh resumes (bypass cache)
  Future<void> forceRefreshResumes() async {
    await loadResumes(refresh: true);
  }

  void clearError() {
    _errorMessage.value = '';
  }
}
