import 'dart:convert';
import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/student_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/wheel_repository.dart';
import 'package:swallet_mobile/presentation/blocs/internet/internet_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/student/student_bloc.dart';
import 'package:swallet_mobile/presentation/screens/store_features/qr_view/components/qr_scanner_overlay.dart';

const String baseUrl =
    "https://swallet-api-2025-capstoneproject.onrender.com/api/";

class CheckInScreen extends StatefulWidget {
  static const String routeName = '/check-in';

  static Route route() {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => CheckInScreen(),
      transitionDuration: Duration(milliseconds: 400),
      transitionsBuilder: (_, animation, __, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  _CheckInScreenState createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: CheckInBody(cameraController: cameraController)),
    );
  }
}

class CheckInBody extends StatefulWidget {
  const CheckInBody({required this.cameraController});

  final MobileScannerController cameraController;

  @override
  _CheckInBodyState createState() => _CheckInBodyState();
}

class _CheckInBodyState extends State<CheckInBody> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;

    return BlocListener<InternetBloc, InternetState>(
      listener: (context, state) {
        if (state is Connected) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                elevation: 0,
                duration: const Duration(milliseconds: 2000),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Internet connected',
                  message: 'You\'re back online!',
                  contentType: ContentType.success,
                ),
              ),
            );
        } else if (state is NotConnected) {
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: Text('No Internet Connection'),
                  content: Text(
                    'Please connect to the internet to scan QR codes',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
          );
        }
      },
      child: BlocBuilder<InternetBloc, InternetState>(
        builder: (context, state) {
          if (state is Connected) {
            return Column(
              children: [
                Container(
                  height: 80 * hem,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background_splash.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 10 * hem),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Check-in bằng QR',
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                fontSize: 22 * ffem,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: BlocProvider(
                    create:
                        (context) => StudentBloc(
                          studentRepository: context.read<StudentRepository>(),
                        ),
                    child: CheckInQRScanner(
                      cameraController: widget.cameraController,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text(
                'No Internet Connection',
                style: TextStyle(fontSize: 18),
              ),
            );
          }
        },
      ),
    );
  }
}

class CheckInQRScanner extends StatefulWidget {
  const CheckInQRScanner({required this.cameraController});

  final MobileScannerController cameraController;

  @override
  _CheckInQRScannerState createState() => _CheckInQRScannerState();
}

class _CheckInQRScannerState extends State<CheckInQRScanner> {
  bool _hasScanned = false;

  @override
  void initState() {
    super.initState();
    _hasScanned = false;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Dịch vụ định vị bị tắt.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Quyền định vị bị từ chối.';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Quyền định vị bị từ chối vĩnh viễn. Vui lòng cấp quyền trong cài đặt.',
          ),
          action: SnackBarAction(
            label: 'Mở cài đặt',
            onPressed: () => Geolocator.openAppSettings(),
          ),
        ),
      );
      throw 'Quyền định vị bị từ chối vĩnh viễn.';
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> _checkInWithQR(String qrCode) async {
    final student = await AuthenLocalDataSource.getStudent();
    final studentId = student?.id;

    try {
      // Lấy vị trí GPS hiện tại
      Position position = await _determinePosition();

            final baseURL = 'https://10.0.2.2:7137/api/';
            final client = http.Client();
      final ioClient =
          HttpClient()
            ..badCertificateCallback =
                (X509Certificate cert, String host, int port) =>
                    true; // Bỏ qua kiểm tra chứng chỉ
      final httpClient = IOClient(ioClient);


      // Gửi yêu cầu check-in với GPS
      final response = await httpClient.post(
        Uri.parse('${baseURL}CheckIn/qr'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'studentId': studentId,
          'qrCode': qrCode,
          'latitude': position.latitude,
          'longitude': position.longitude,
        }),
      );

      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await context.read<SpinHistoryRepository>().incrementBonusSpins(
          studentId!,
          DateTime.now(),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              elevation: 0,
              duration: const Duration(milliseconds: 2000),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'Thành công!',
                message:
                    'Check-in thành công, bạn nhận được ${data['pointsAwarded'] ?? 10} xu và 1 lượt quay Lucky Wheel!',
                contentType: ContentType.success,
              ),
            ),
          );
      } else {
        throw Exception(data['message'] ?? 'Check-in thất bại');
      }
    } catch (e) {
      String errorMessage;
      if (e.toString().contains("Bạn không ở gần địa điểm này để check-in")) {
        errorMessage = 'Bạn không ở gần địa điểm này để check-in';
      } else if (e.toString().contains(
        "Bạn đã check-in tại địa điểm này hôm nay",
      )) {
        errorMessage = 'Bạn đã check-in tại địa điểm này hôm nay';
      } else {
        errorMessage = e.toString().replaceFirst(
          'Exception: ',
          '',
        ); // Hiển thị lỗi khác nếu có
      }

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            elevation: 0,
            duration: const Duration(milliseconds: 2000),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Lỗi!',
              message: errorMessage,
              contentType: ContentType.failure,
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MobileScanner(
          startDelay: true,
          overlay: Lottie.asset('assets/animations/scanning.json'),
          controller: widget.cameraController,
          onDetect: (capture) {
            if (_hasScanned) return;
            final barcodes = capture.barcodes;
            for (final barcode in barcodes) {
              if (barcode.rawValue != null) {
                setState(() {
                  _hasScanned = true;
                });
                _checkInWithQR(barcode.rawValue!);
                break;
              }
            }
          },
        ),
        Positioned.fill(
          child: Container(
            decoration: ShapeDecoration(
              shape: QrScannerOverlayShape(
                borderColor: Colors.blue,
                borderRadius: 10,
                borderLength: 20,
                borderWidth: 5,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 50,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              'Quét mã QR tại địa điểm để check-in!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
