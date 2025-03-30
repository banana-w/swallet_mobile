import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/authen_model.dart';
import 'package:swallet_mobile/domain/interface_repositories/lecture_features/lecture_repository.dart';
import 'package:swallet_mobile/presentation/blocs/lecture/lecture_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class QRGenerateScreen extends StatefulWidget {
  static const String routeName = '/qr-generate';

  const QRGenerateScreen({super.key, required this.lectureId});
  final String? lectureId;

  static Route route({required String lectureId}) {
    return MaterialPageRoute(
      builder: (_) => QRGenerateScreen(lectureId: lectureId),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<QRGenerateScreen> createState() => _QRGenerateScreenState();
}

class _QRGenerateScreenState extends State<QRGenerateScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pointsController = TextEditingController();
  final TextEditingController _expirationTimeController =
      TextEditingController();
  final TextEditingController _startOnTimeController = TextEditingController();
  final TextEditingController _availableHoursController =
      TextEditingController();
  String? _lecturerId;
  Map<String, String>? _qrCodeData;

  @override
  void initState() {
    super.initState();
    _loadLecturerId();
  }

  Future<void> _loadLecturerId() async {
    final authenModel = await AuthenLocalDataSource.getLecture();
    setState(() {
      _lecturerId = authenModel?.id ?? widget.lectureId;
    });
  }

  @override
  void dispose() {
    _pointsController.dispose();
    _expirationTimeController.dispose();
    _startOnTimeController.dispose();
    _availableHoursController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / 375;
    double ffem = fem * 0.97;
    double hem = MediaQuery.of(context).size.height / 812;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: Text(
          'Tạo mã QR',
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontSize: 20 * ffem,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<LectureBloc, LectureState>(
        listener: (context, state) {
          if (state is QRCodeGenerated) {
            setState(() {
              _qrCodeData = state.qrCodeData;
            });
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  elevation: 0,
                  duration: const Duration(milliseconds: 2000),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'Thành công',
                    message: 'Mã QR đã được tạo thành công!',
                    contentType: ContentType.success,
                  ),
                ),
              );
          } else if (state is QRCodeGenerationFailed) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  elevation: 0,
                  duration: const Duration(milliseconds: 2000),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'Thất bại',
                    message: 'Tạo mã QR thất bại: ${state.message}',
                    contentType: ContentType.failure,
                  ),
                ),
              );
          }
        },
        child: Stack(
          children: [
            // Nội dung chính
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(), // Spacer để đẩy nút xuống dưới
                Padding(
                  padding: EdgeInsets.only(
                    bottom:
                        120 *
                        hem, // Giảm khoảng cách từ dưới lên (trước đó là 40 * hem)
                  ),
                  child: Center(
                    child: ElevatedButton(
                      onPressed:
                          () => _showQRFormDialog(context, fem, ffem, hem),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10 * fem),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 40 * fem,
                          vertical: 15 * hem,
                        ),
                      ),
                      child: Text(
                        'Tạo mã QR',
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Overlay hiển thị mã QR
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 30 * hem,
                ), // Đẩy toàn bộ nội dung lên trên
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Mã QR của bạn:',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 18 * ffem,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15 * hem,
                    ), // Giảm khoảng cách giữa Text và QR Code
                    Container(
                      width: 320 * fem, // Rộng hơn QR Code một chút
                      height: 320 * fem, // Cao hơn QR Code một chút
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.green, // Màu viền xanh lá
                          width: 3, // Độ dày của viền
                        ),
                        borderRadius: BorderRadius.circular(10), // Bo góc viền
                      ),
                      child: Center(
                        child:
                            _qrCodeData != null
                                ? Image.network(
                                  _qrCodeData!['qrCodeImageUrl']!, // Hiển thị hình ảnh từ URL
                                  width: 300 * fem,
                                  height: 300 * fem,
                                  fit: BoxFit.contain,
                                  loadingBuilder: (
                                    context,
                                    child,
                                    loadingProgress,
                                  ) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value:
                                            loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    (loadingProgress
                                                            .expectedTotalBytes ??
                                                        1)
                                                : null,
                                      ),
                                    );
                                  },
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                          const Text('Lỗi tải hình ảnh'),
                                )
                                : Text(
                                  'Đang chờ mã QR...',
                                  style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                      fontSize: 16 * ffem,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                      ),
                    ),
                    SizedBox(
                      height: 200 * hem,
                    ), // Giảm khoảng cách dưới QR Code
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showQRFormDialog(
    BuildContext context,
    double fem,
    double ffem,
    double hem,
  ) {
    // Đặt lại giá trị của các TextEditingController
    _pointsController.clear();
    _startOnTimeController.text = DateFormat(
      'yyyy-MM-dd HH:mm',
    ).format(DateTime.now());
    _availableHoursController.clear();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'Nhập thông tin QR',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 18 * ffem,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            content: Container(
              width: 400 * fem, // Tăng chiều rộng của dialog
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _pointsController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Points',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10 * fem),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập points';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Points phải là số';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15 * hem),
                      TextFormField(
                        controller:
                            _startOnTimeController
                              ..text = DateFormat(
                                'yyyy-MM-dd HH:mm',
                              ).format(DateTime.now()),
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Start On Time (YYYY-MM-DD HH:MM)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10 * fem),
                          ),
                          suffixIcon: Icon(Icons.lock_clock, size: 20 * ffem),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập start on time';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15 * hem),
                      TextFormField(
                        controller: _availableHoursController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Available Hours',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10 * fem),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập available hours';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Available hours phải là số nguyên';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Hủy', style: TextStyle(color: Colors.grey)),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      _lecturerId != null) {
                    final startTime = DateTime.parse(
                      _startOnTimeController.text,
                    );
                    final availableHours = int.parse(
                      _availableHoursController.text,
                    );
                    final expirationTime = startTime.add(
                      Duration(hours: availableHours),
                    );
                    final formattedExpirationTime = DateFormat(
                      'yyyy-MM-dd HH:mm',
                    ).format(expirationTime);

                    context.read<LectureBloc>().add(
                      GenerateQRCodeEvent(
                        points: int.parse(_pointsController.text),
                        expirationTime: formattedExpirationTime,
                        startOnTime: _startOnTimeController.text,
                        availableHours: availableHours,
                        lecturerId: _lecturerId!,
                      ),
                    );
                    Navigator.pop(context);
                  } else if (_lecturerId == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Không thể lấy Lecturer ID')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                child: Text('Tạo', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
    );
  }
}
