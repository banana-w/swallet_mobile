import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swallet_mobile/data/models/student_features/campus_model.dart';
import 'package:swallet_mobile/presentation/blocs/internet/internet_bloc.dart';
import 'package:swallet_mobile/presentation/screens/lecture_features/campus/components/campus_list_card.dart';
import 'package:swallet_mobile/presentation/screens/lecture_features/campus/components/campus_api_client.dart';

import '../../../../config/constants.dart';

class CampusScreenBody extends StatefulWidget {
  final String lectureId;

  const CampusScreenBody({super.key, required this.lectureId});

  @override
  State<CampusScreenBody> createState() => _BodyState();
}

class _BodyState extends State<CampusScreenBody> {
  late Future<List<CampusModel>> _campusFuture;
  int _currentPage = 1;
  final int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    final apiClient = CampusAPIClient();
    _campusFuture = apiClient.getCampusesByLectureId(
      lectureId: widget.lectureId,
      page: _currentPage,
      size: _pageSize,
    );
  }

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
                content: const Text('Vui lòng kết nối Internet'),
                actions: [
                  TextButton(
                    onPressed: () {
                      final stateInternet = context.read<InternetBloc>().state;
                      if (stateInternet is Connected) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Đồng ý'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: RefreshIndicator(
        onRefresh: () async {
          final apiClient = CampusAPIClient();
          setState(() {
            _campusFuture = apiClient.getCampusesByLectureId(
              lectureId: widget.lectureId,
              page: _currentPage,
              size: _pageSize,
            );
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10 * hem),
            Expanded(
              child: FutureBuilder<List<CampusModel>>(
                future: _campusFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 15 * fem,
                              vertical: 5 * hem,
                            ),
                            height: 130 * hem,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Lỗi: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/campaign-navbar-icon.svg',
                            width: 60 * fem,
                            colorFilter: ColorFilter.mode(
                              kLowTextColor,
                              BlendMode.srcIn,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5 * hem),
                            child: Text(
                              'Không có campus nào!',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16 * ffem,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  final campuses = snapshot.data!;
                  return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: campuses.length,
                    itemBuilder: (context, index) {
                      final campus = campuses[index];
                      return CampusListCard(
                        fem: fem,
                        hem: hem,
                        ffem: ffem,
                        campusModel: campus,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
