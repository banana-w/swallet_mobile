import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:swallet_mobile/domain/interface_repositories/store_features/store_repository.dart';
import 'package:swallet_mobile/presentation/blocs/internet/internet_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/store/store_bloc.dart';
import 'tab_scan_voucher.dart';

class Body extends StatefulWidget {
  const Body({super.key, required this.id});
  final String id;
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
    MobileScannerController cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      facing: CameraFacing.back,
      torchEnabled: false,
    );
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
                  title: 'Đã kết nối internet',
                  message: 'Đã kết nối internet!',
                  contentType: ContentType.success,
                ),
              ),
            );
        } else if (state is NotConnected) {
          showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: const Text('Không kết nối Internet'),
                content: Text('Vui lòng kết nối Internet'),
                actions: [
                  TextButton(
                    onPressed: () {
                      final stateInternet = context.read<InternetBloc>().state;
                      if (stateInternet is Connected) {
                        Navigator.pop(context);
                      } else {}
                    },
                    child: const Text('Đồng ý'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: BlocBuilder<InternetBloc, InternetState>(
        builder: (context, state) {
          if (state is Connected) {
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    elevation: 0,
                    flexibleSpace: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/background_splash.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    toolbarHeight: 40 * hem,
                    centerTitle: true,
                    title: Padding(
                      padding: EdgeInsets.only(top: 10 * hem),
                      child: Text(
                        'Swallet',
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 22 * ffem,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    leading: Padding(
                      padding: EdgeInsets.only(top: 10 * hem),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                          size: 30 * fem,
                        ),
                      ),
                    ),
                    bottom: TabBar(
                      automaticIndicatorColorAdjustment: false,
                      indicatorColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorWeight: 3,
                      indicatorPadding: EdgeInsets.only(bottom: 1 * fem),
                      labelColor: Colors.white,
                      labelStyle: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 13 * ffem,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      unselectedLabelColor: Colors.white60,
                      unselectedLabelStyle: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 13 * ffem,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      tabs: [
                        Tab(text: 'Quét ưu đãi'),
                      ],
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  BlocProvider(
                    create:
                        (context) => StoreBloc(
                          storeRepository: context.read<StoreRepository>(),
                        ),
                    child: TabScanVoucher(
                      cameraController: cameraController,
                      widget: widget,
                    ),
                  ),

                  //
                  // MultiBlocProvider(
                  //   providers: [
                  //     BlocProvider(
                  //       create:
                  //           (context) => StudentBloc(
                  //             studentRepository:
                  //                 context.read<StudentRepository>(),
                  //           ),
                  //     ),
                  //     BlocProvider(
                  //       create:
                  //           (context) => BrandBloc(
                  //             brandRepository: context.read<BrandRepository>(),
                  //           ),
                  //     ),
                  //   ],
                  //   child: TabScanStudent(
                  //     cameraController2: cameraController2,
                  //     widget: widget,
                  //   ),
                  // ),
                ],
              ),
            );
          } else {
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    elevation: 0,
                    flexibleSpace: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/background_splash.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    toolbarHeight: 40 * hem,
                    centerTitle: true,
                    title: Padding(
                      padding: EdgeInsets.only(top: 10 * hem),
                      child: Text(
                        'Swallet',
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 22 * ffem,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    leading: Padding(
                      padding: EdgeInsets.only(top: 10 * hem),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                          size: 30 * fem,
                        ),
                      ),
                    ),
                    bottom: TabBar(
                      automaticIndicatorColorAdjustment: false,
                      indicatorColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorWeight: 3,
                      indicatorPadding: EdgeInsets.only(bottom: 1 * fem),
                      labelColor: Colors.white,
                      labelStyle: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 13 * ffem,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      unselectedLabelColor: Colors.white60,
                      unselectedLabelStyle: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 13 * ffem,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      tabs: [
                        Tab(text: 'Quét ưu đãi'),
                      ],
                    ),
                  ),
                ];
              },
              body: Container(),
            );
          }
        },
      ),
    );
  }
}
