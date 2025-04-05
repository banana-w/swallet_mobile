import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/models/lecture_features/lecture_model.dart';
import 'package:swallet_mobile/data/models/store_features/store_model.dart';
import 'package:swallet_mobile/domain/interface_repositories/lecture_features/lecture_repository.dart';
import 'package:swallet_mobile/domain/interface_repositories/store_features/store_repository.dart';
import 'package:swallet_mobile/presentation/blocs/internet/internet_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/lecture/lecture_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/store/store_bloc.dart';

import '../../../../blocs/blocs.dart';
import 'form_update.dart';

class Body extends StatelessWidget {
  Body({super.key, required this.lectureModel});

  final LectureModel lectureModel;
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
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20 * hem),
                    // Text(
                    //   'Thông tin cá nhân',
                    //   style: GoogleFonts.openSans(
                    //     textStyle: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: 18 * ffem,
                    //       fontWeight: FontWeight.w700,
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 20 * hem),
                    BlocProvider(
                      create:
                          (context) => LectureBloc(
                            lectureRepository:
                                context.read<LectureRepository>(),
                          ),
                      child: FormUpdate(
                        ffem: ffem,
                        fem: fem,
                        hem: hem,
                        lectureModel: lectureModel,
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
