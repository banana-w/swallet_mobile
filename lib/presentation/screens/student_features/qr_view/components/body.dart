import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/student_repository.dart';
import 'package:swallet_mobile/presentation/blocs/internet/internet_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/student/student_bloc.dart';
import 'package:swallet_mobile/presentation/screens/student_features/check_in/check_in_screen.dart';
import 'tab_scan_voucher.dart';

class Body extends StatefulWidget {
  const Body({
    super.key,
    required this.studentId,
    required this.cameraController,
  });

  final String studentId;
  final MobileScannerController cameraController;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;

    MobileScannerController cameraController2 = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      facing: CameraFacing.back,
      torchEnabled: false,
    );

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
            return DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  // App Bar
                  Container(
                    height: 80 * hem,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/background_splash.png',
                        ),
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
                              'Quét mã QR',
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
                  // TabBar
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/background_splash.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: TabBar(
                      indicatorColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorWeight: 2,
                      labelColor: Colors.white,
                      labelStyle: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 12 * ffem,
                          height: 1.3625 * ffem / fem,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      unselectedLabelColor: Colors.white60,
                      unselectedLabelStyle: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 12 * ffem,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      tabs: [Tab(text: 'Lecture QR'), Tab(text: 'Check-in QR')],
                    ),
                  ),
                  // Scanner Area
                  Expanded(
                    child: TabBarView(
                      children: [
                        BlocProvider(
                          create:
                              (context) => StudentBloc(
                                studentRepository:
                                    context.read<StudentRepository>(),
                              ),
                          child: TabScanLectureQR(
                            cameraController: widget.cameraController,
                            studentId: widget.studentId,
                          ),
                        ),
                        BlocProvider(
                          create:
                              (context) => StudentBloc(
                                studentRepository:
                                    context.read<StudentRepository>(),
                              ),
                          child: CheckInQRScanner(
                            cameraController: cameraController2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
