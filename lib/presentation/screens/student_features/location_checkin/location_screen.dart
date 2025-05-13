import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/presentation/blocs/location/location_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/student_features/campaign_detail/campaign_detail_screen.dart';
import '../../../widgets/shimmer_widget.dart';

class LocationListScreen extends StatelessWidget {
  static const String routeName = '/location_screen';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => LocationListScreen(),
      settings: const RouteSettings(arguments: routeName),
    );
  }

  const LocationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double baseHeight = 812;
    double ffem = fem * 0.97;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    return SafeArea(
      child: Scaffold(
        backgroundColor: klighGreyColor,
        appBar: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_splash.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 25 * fem,
            ),
          ),
          toolbarHeight: 50 * hem,
          centerTitle: true,
          title: Text(
            'Địa điểm check-in',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 18 * ffem,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<LocationBloc>().add(LoadLocation());
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  BlocBuilder<LocationBloc, LocationState>(
                    builder: (context, state) {
                      if (state is LocationLoading) {
                        return buildNotificationShimmer(3, fem, hem);
                      } else if (state is LocationLoaded) {
                        if (state.locations.isEmpty) {
                          return Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(
                              left: 15 * fem,
                              right: 15 * fem,
                              top: 20,
                            ),
                            height: 220 * hem,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.notifications,
                                  color: kPrimaryColor,
                                  size: 50 * fem,
                                ),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text(
                                      'Không có địa điểm check-in nào',
                                      style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          final locations =
                              state
                                  .locations; // Assuming state.locations is List<LocationModel>
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: locations.length,
                                itemBuilder: (context, index) {
                                  final location =
                                      locations[index]; // LocationModel object
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                      vertical: 10 * hem,
                                      horizontal: 15 * fem,
                                    ),
                                    padding: EdgeInsets.all(15 * fem),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        15 * fem,
                                      ),
                                      color: Colors.white,
                                      border: Border.all(color: klighGreyColor),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0x0c000000),
                                          offset: Offset(0, 2 * fem),
                                          blurRadius: 5 * fem,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          location.name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.openSans(
                                            fontSize: 15 * ffem,
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 5 * hem),
                                        Text(
                                          location.address,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.openSans(
                                            fontSize: 12 * ffem,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        }
                      }
                      return buildNotificationShimmer(3, fem, hem);
                    },
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildNotificationShimmer(count, double fem, double hem) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
        width: 170 * fem,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15 * fem),
          color: Colors.white,
        ),
      ),
      Container(
        width: 170 * fem,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15 * fem),
          color: Colors.white,
        ),
      ),
    ],
  );
}
