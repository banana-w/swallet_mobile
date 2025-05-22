import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
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
  final TextEditingController _availableHoursController =
      TextEditingController();
  final TextEditingController _maxUsageCountController =
      TextEditingController();
  String? _lecturerId;
  int? _balance;
  Map<String, String>? _qrCodeData;
  int _totalCost = 0;

  @override
  void initState() {
    super.initState();
    _loadLecturerId();
    _pointsController.addListener(_updateTotalCost);
    _maxUsageCountController.addListener(_updateTotalCost);
  }

  Future<void> _loadLecturerId() async {
    final authenModel = await AuthenLocalDataSource.getLecture();
    final balance = await AuthenLocalDataSource.getBalance();
    setState(() {
      _lecturerId = authenModel?.id ?? widget.lectureId;
      final rawBalance = authenModel?.balance ?? balance;
      _balance =
          rawBalance != null
              ? (rawBalance is double ? rawBalance.toInt() : rawBalance as int)
              : null;
    });
  }

  void _updateTotalCost() {
    final points = int.tryParse(_pointsController.text) ?? 0;
    final maxUsageCount = int.tryParse(_maxUsageCountController.text) ?? 0;
    if (points > 0 && maxUsageCount > 0) {
      setState(() {
        _totalCost = points * maxUsageCount;
      });
    } else {
      setState(() {
        _totalCost = 0;
      });
    }
  }

  @override
  void dispose() {
    _pointsController.removeListener(_updateTotalCost);
    _maxUsageCountController.removeListener(_updateTotalCost);
    _pointsController.dispose();
    _availableHoursController.dispose();
    _maxUsageCountController.dispose();
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
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Padding(
                  padding: EdgeInsets.only(bottom: 120 * hem),
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
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 30 * hem),
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
                    SizedBox(height: 15 * hem),
                    Container(
                      width: 320 * fem,
                      height: 320 * fem,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 22, 52, 119),
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child:
                            _qrCodeData != null
                                ? Image.network(
                                  _qrCodeData!['qrCodeImageUrl']!,
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
                    SizedBox(height: 200 * hem),
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
    _pointsController.clear();
    _availableHoursController.clear();
    _maxUsageCountController.clear();
    _totalCost = 0;

    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15 * fem),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15 * fem),
              ),
              padding: EdgeInsets.all(20 * fem),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Nhập thông tin QR',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 18 * ffem,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    SizedBox(height: 20 * hem),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _pointsController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Số điểm',
                              labelStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10 * fem),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập số điểm';
                              }
                              if (int.tryParse(value) == null ||
                                  int.parse(value) <= 0) {
                                return 'Số điểm phải là số nguyên dương';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15 * hem),
                          TextFormField(
                            controller: _availableHoursController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Thời gian hiệu lực (giờ)',
                              labelStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10 * fem),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập thời gian hiệu lực';
                              }
                              if (int.tryParse(value) == null ||
                                  int.parse(value) <= 0) {
                                return 'Thời gian hiệu lực phải là số nguyên dương';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15 * hem),
                          TextFormField(
                            controller: _maxUsageCountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Số lần sử dụng tối đa',
                              labelStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10 * fem),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập số lần sử dụng tối đa';
                              }
                              if (int.tryParse(value) == null ||
                                  int.parse(value) <= 0) {
                                return 'Số lần sử dụng tối đa phải là số nguyên dương';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10 * hem),
                    Text(
                      'Số dư ví: ${_balance ?? 'Đang tải...'} xu',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 8, 88, 153),
                        ),
                      ),
                    ),
                    SizedBox(height: 20 * hem),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Hủy',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                _lecturerId != null) {
                              final points = int.parse(_pointsController.text);
                              final maxUsageCount = int.parse(
                                _maxUsageCountController.text,
                              );
                              if (_balance != null && _totalCost > _balance!) {
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(
                                    SnackBar(
                                      elevation: 0,
                                      duration: const Duration(
                                        milliseconds: 2000,
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      content: AwesomeSnackbarContent(
                                        title: 'Thất bại',
                                        message:
                                            'Tạo mã QR thất bại: Số dư không đủ',
                                        contentType: ContentType.failure,
                                      ),
                                    ),
                                  );
                                return;
                              }
                              // Hiển thị dialog xác nhận
                              _showConfirmationDialog(
                                context,
                                points,
                                maxUsageCount,
                              );
                            } else if (_lecturerId == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Không thể lấy Lecturer ID'),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 28, 160, 78),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10 * fem),
                            ),
                          ),
                          child: Text(
                            'Tạo',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }

  void _showConfirmationDialog(
    BuildContext context,
    int points,
    int maxUsageCount,
  ) {
    final fem = MediaQuery.of(context).size.width / 375;
    final ffem = fem * 0.97;
    final hem = MediaQuery.of(context).size.height / 812;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15 * fem),
            ),
            title: Text(
              'Xác nhận tạo mã QR',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 18 * ffem,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            content: Text(
              'Tổng cộng sẽ cần $_totalCost Xu để tạo QR, bạn có chắc muốn tạo không?',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(fontSize: 16 * ffem, color: Colors.black),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Hủy', style: TextStyle(color: Colors.black)),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<LectureBloc>().add(
                    GenerateQRCodeEvent(
                      points: points,
                      availableHours: int.parse(_availableHoursController.text),
                      lecturerId: _lecturerId!,
                      maxUsageCount: maxUsageCount,
                      expirationTime: '',
                      startOnTime: '',
                      context: context,
                    ),
                  );
                  Navigator.pop(context); // Đóng dialog xác nhận
                  Navigator.pop(context); // Đóng dialog nhập thông tin
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 28, 160, 78),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10 * fem),
                  ),
                ),
                child: Text('Có', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
    );
  }
}
