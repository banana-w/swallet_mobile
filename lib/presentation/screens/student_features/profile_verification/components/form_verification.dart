import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/student_features/student_model.dart';
import 'package:swallet_mobile/presentation/blocs/student/student_bloc.dart';
import 'package:swallet_mobile/presentation/cubits/validation/validation_cubit.dart';
import 'package:swallet_mobile/presentation/cubits/verification/verification_cubit.dart';
import 'package:swallet_mobile/presentation/screens/student_features/verify_studentMail/screens/verifycode_student_screen.dart';

import '../../../../config/constants.dart';
import '../../signup/components/step_5/upload_front_card.dart';
import 'text_form_field_default.dart';

class FormVerification extends StatefulWidget {
  const FormVerification({
    super.key,
    required this.hem,
    required this.fem,
    required this.ffem,
    required this.studentModel,
  });

  final double hem;
  final double fem;
  final double ffem;
  final StudentModel studentModel;

  @override
  State<FormVerification> createState() => _FormVerificationState();
}

class _FormVerificationState extends State<FormVerification> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  File? _selectedFrontCard;
  String? errorCard;

  @override
  void dispose() {
    // Controller này trước đây không được huỷ.
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StudentBloc, StudentState>(
      listenWhen:
          (previous, current) =>
              current is StudentUpdateVerificationSuccess ||
              current is StudentFaled,
      listener: _handleStudentState,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            BlocBuilder<ValidationCubit, ValidationState>(
              builder: (context, state) {
                return _EmailCard(
                  fem: widget.fem,
                  hem: widget.hem,
                  ffem: widget.ffem,
                  controller: emailController,
                  error:
                      state is CheckEmailFailed ? state.error.toString() : null,
                );
              },
            ),
            SizedBox(height: 15 * widget.hem),
            Container(
              width: 318 * widget.fem,
              height: 200 * widget.hem,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15 * widget.fem),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x0c000000),
                    offset: Offset(0 * widget.fem, 4 * widget.fem),
                    blurRadius: 2.5 * widget.fem,
                  ),
                ],
              ),
              child: Center(child: _buildCardSlot()),
            ),
            SizedBox(height: 5 * widget.hem),
            if (errorCard != null)
              Padding(
                padding: EdgeInsets.only(top: 5 * widget.hem),
                child: SizedBox(
                  width: 270 * widget.fem,
                  child: Text(
                    errorCard!,
                    style: GoogleFonts.openSans(
                      fontSize: 13 * widget.ffem,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xffba1c1c),
                    ),
                  ),
                ),
              )
            else
              SizedBox(height: 5 * widget.hem),
            SizedBox(height: 15 * widget.hem),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20 * widget.fem),
              child: Text(
                'Thông tin xác nhận chỉ được gửi một lần, sau khi xác thực thành công sẽ không được sửa.\n\nVui lòng kiểm tra kỹ thông tin',
                textAlign: TextAlign.center,
                maxLines: 4,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 13 * widget.ffem,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10 * widget.hem),
            BlocBuilder<ValidationCubit, ValidationState>(
              builder: (context, validationState) {
                return BlocBuilder<StudentBloc, StudentState>(
                  builder: (context, studentState) {
                    final isLoading =
                        studentState is StudentUpdatingVerification ||
                        validationState is ValidationInProcess;

                    return TextButton(
                      onPressed: isLoading ? null : _onSubmitPressed,
                      child: Container(
                        width: 220 * widget.fem,
                        height: 45 * widget.hem,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(23 * widget.fem),
                        ),
                        child: Center(
                          child:
                              isLoading
                                  ? const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  )
                                  : Text(
                                    'Xác minh',
                                    style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                        fontSize: 17 * widget.ffem,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Khung ảnh thẻ: ảnh vừa chọn, ảnh đã lưu trên server, hoặc nút tải lên.
  ///
  /// Ba nhánh này trước đây là ba khối `Column` chép lại của nhau, chỉ khác
  /// dòng tiêu đề và widget hiển thị ảnh.
  Widget _buildCardSlot() {
    final String title;
    final Widget preview;

    if (_selectedFrontCard != null) {
      title = 'Hình mặt trước của thẻ';
      preview = Container(
        width: 150 * widget.fem,
        height: 150 * widget.hem,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: FileImage(_selectedFrontCard!),
          ),
        ),
      );
    } else if (widget.studentModel.studentCardFront.isNotEmpty) {
      title = 'Hình mặt trước của thẻ';
      preview = SizedBox(
        width: 150 * widget.fem,
        height: 150 * widget.hem,
        child: Image.network(
          widget.studentModel.studentCardFront,
          fit: BoxFit.cover,
          // Ảnh chụp thẻ từ máy rất lớn so với khung 150*fem.
          cacheWidth:
              (150 * widget.fem * MediaQuery.devicePixelRatioOf(context))
                  .round(),
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Text(
                'Lỗi tải ảnh',
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 12 * widget.ffem,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            final total = loadingProgress.expectedTotalBytes;
            return Center(
              child: CircularProgressIndicator(
                value:
                    total != null
                        ? loadingProgress.cumulativeBytesLoaded / total
                        : null,
              ),
            );
          },
        ),
      );
    } else {
      title = 'Tải hình mặt trước của thẻ';
      preview = UpLoadFrontCard(
        fem: widget.fem,
        hem: widget.hem,
        ffem: widget.ffem,
        onPressed: _showImageSourceSheet,
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 14 * widget.ffem,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 10 * widget.hem),
        if (_selectedFrontCard != null ||
            widget.studentModel.studentCardFront.isNotEmpty)
          InkWell(onTap: _showImageSourceSheet, child: preview)
        else
          preview,
      ],
    );
  }

  void _handleStudentState(BuildContext context, StudentState state) {
    if (state is StudentUpdateVerificationSuccess) {
      context.read<VerificationCubit>().resendVerificationEmail(
        emailController.text,
      );
      Navigator.pushNamed(
        context,
        VerifyCodeStudentScreen.routeName,
        arguments: emailController.text,
      );
    } else if (state is StudentFaled) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            elevation: 0,
            duration: const Duration(milliseconds: 2000),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Cập nhật ảnh thất bại',
              message: 'Vui lòng xác minh lại!',
              contentType: ContentType.failure,
            ),
          ),
        );
      Navigator.pop(context);
    }
  }

  void _onSubmitPressed() {
    if (_selectedFrontCard == null &&
        widget.studentModel.studentCardFront.isEmpty) {
      setState(() => errorCard = 'Thẻ sinh viên không được bỏ trống');
      return;
    }
    if (_formKey.currentState!.validate()) {
      _submitForm();
    }
  }

  Future<void> _submitForm() async {
    final validationError = await context
        .read<ValidationCubit>()
        .validateStudentEmail(emailController.text);
    // Email sai thì ValidationCubit đã phát CheckEmailFailed, phần lỗi hiện
    // ngay dưới ô nhập.
    if (!mounted || validationError != '') return;

    final student = await AuthenLocalDataSource.getStudent();
    if (!mounted) return;
    if (student == null) {
      // Trước đây nhánh này lặng lẽ không làm gì, nút bấm trông như hỏng.
      setState(() {
        errorCard = 'Không tìm thấy dữ liệu sinh viên, vui lòng đăng nhập lại';
      });
      return;
    }

    final card = _selectedFrontCard;
    if (card != null) {
      context.read<StudentBloc>().add(
        UpdateVerification(studentId: student.id, studentCardFront: card.path),
      );
    } else {
      context.read<StudentBloc>().add(const SkipUpdateVerification());
    }
  }

  /// Chọn ảnh từ camera hoặc thư viện.
  ///
  /// Trước đây là hai hàm giống hệt nhau, phân biệt ô ảnh bằng cách so
  /// `hashCode` của hai `File?` — mà nhánh "mặt sau" thì `setState` rỗng vì
  /// phần đó đã bị comment từ lâu, nghĩa là ảnh chọn xong bị vứt đi.
  Future<void> _pickImage(ImageSource source) async {
    final picked = await ImagePicker().pickImage(source: source);
    if (picked == null || !mounted) return;
    setState(() {
      _selectedFrontCard = File(picked.path);
      errorCard = null;
    });
    Navigator.pop(context);
  }

  void _showImageSourceSheet() {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final hem = size.height / 812;
    final ffem = fem * 0.97;

    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return SizedBox(
          height: size.height * 0.2,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SourceOption(
                icon: Icons.camera_alt,
                label: 'Chụp ảnh',
                fem: fem,
                ffem: ffem,
                onTap: () => _pickImage(ImageSource.camera),
              ),
              SizedBox(height: 18 * hem),
              SizedBox(
                width: size.width * 0.7,
                child: Divider(color: kLowTextColor, thickness: 2 * fem),
              ),
              SizedBox(height: 18 * hem),
              _SourceOption(
                icon: Icons.photo_size_select_actual_rounded,
                label: 'Chọn sẵn có',
                fem: fem,
                ffem: ffem,
                onTap: () => _pickImage(ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Khung trắng chứa ô email sinh viên và dòng lỗi (nếu có).
class _EmailCard extends StatelessWidget {
  const _EmailCard({
    required this.fem,
    required this.hem,
    required this.ffem,
    required this.controller,
    required this.error,
  });

  final double fem;
  final double hem;
  final double ffem;
  final TextEditingController controller;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 318 * fem,
          height: 100 * hem,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15 * fem),
            boxShadow: [
              BoxShadow(
                color: const Color(0x0c000000),
                offset: Offset(0 * fem, 4 * fem),
                blurRadius: 2.5 * fem,
              ),
            ],
          ),
          child: Center(
            child: TextFormFieldDefault(
              hem: hem,
              fem: fem,
              ffem: ffem,
              labelText: 'EMAIL SINH VIÊN *',
              hintText: 'Nhập email sinh viên',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email sinh viên không được bỏ trống';
                }
                return null;
              },
              textController: controller,
            ),
          ),
        ),
        if (error != null) ...[
          SizedBox(height: 3 * hem),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 48 * fem),
              child: Text(
                error!,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    color: kErrorTextColor,
                    fontSize: 12 * ffem,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// Một dòng lựa chọn nguồn ảnh trong bottom sheet.
class _SourceOption extends StatelessWidget {
  const _SourceOption({
    required this.icon,
    required this.label,
    required this.fem,
    required this.ffem,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final double fem;
  final double ffem;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: kPrimaryColor, size: 30 * fem),
          SizedBox(width: 5 * fem),
          Text(
            label,
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 20 * ffem,
                fontWeight: FontWeight.bold,
                height: 1.3625 * ffem / fem,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
