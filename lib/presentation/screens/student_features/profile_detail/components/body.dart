import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:swallet_mobile/data/models/student_features/student_model.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/student_repository.dart';
import 'package:swallet_mobile/presentation/blocs/internet/internet_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/student/student_bloc.dart';

import 'information_card_profile.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.studentModel});

  final StudentModel studentModel;

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
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  BlocProvider(
                    create:
                        (context) => StudentBloc(
                          studentRepository: context.read<StudentRepository>(),
                        )..add(
                          LoadStudentById(accountId: studentModel.accountId),
                        ),
                    child: InformationCardProfile(
                      hem: hem,
                      fem: fem,
                      ffem: ffem,
                      studentModel: studentModel,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Mã QR của bạn',
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 13 * ffem,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_drop_down_sharp, size: 30),
                    ],
                  ),
                  SizedBox(height: 5 * hem),
                  Container(
                    // color: Colors.white,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/background_splash.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    padding: EdgeInsets.all(20 * fem),

                    width: 300 * fem,
                    height: 300 * hem,
                    child: QrImageView(
                      data: studentModel.id,
                      padding: EdgeInsets.all(20 * fem),
                      version: QrVersions.auto,
                      backgroundColor: Colors.white,
                      eyeStyle: QrEyeStyle(
                        color: Colors.black,
                        eyeShape: QrEyeShape.square,
                      ),
                      dataModuleStyle: QrDataModuleStyle(
                        color: Colors.black,
                        dataModuleShape: QrDataModuleShape.square,
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
