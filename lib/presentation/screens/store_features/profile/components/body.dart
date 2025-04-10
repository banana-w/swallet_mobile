import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/interface_repositories/store_features/store_repository.dart';
import 'package:swallet_mobile/presentation/blocs/internet/internet_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/landing_screen/landing_screen_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/store/store_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/login/login_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/brand/brand_detail_store_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/profile_update_detail/profile_update_detail_screen.dart';
import 'button_profile.dart';
import 'information_card_profile.dart';

class Body extends StatelessWidget {
  const Body({super.key});

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
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<RoleAppBloc>().add(RoleAppStart());
        },
        child: SingleChildScrollView(
          child: BlocBuilder<RoleAppBloc, RoleAppState>(
            builder: (context, state) {
              if (state is StoreRole) {
                final storeModel = state.storeModel;
                return Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background_splash.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        child: Stack(
                          children: [
                            //background body
                            Positioned(
                              left: 0 * fem,
                              top: 120 * hem,
                              child: Align(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  color: klighGreyColor,
                                ),
                              ),
                            ),

                            //widget information of profile
                            Positioned(
                              top: 80 * hem,
                              left: 25 * fem,
                              child: BlocProvider(
                                create:
                                    (context) => StoreBloc(
                                      storeRepository:
                                          context.read<StoreRepository>(),
                                    )..add(
                                      LoadStoreById(
                                        accountId: storeModel.accountId,
                                      ),
                                    ),
                                child: InformationCardProfile(
                                  fem: fem,
                                  hem: hem,
                                  storeModel: storeModel,
                                  ffem: ffem,
                                ),
                              ),
                            ),

                            Positioned(
                              left: 0 * fem,
                              top: 300 * hem,
                              child: Container(
                                // color: Colors.red,
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,

                                child: Column(
                                  children: [
                                    ButtonProfile(
                                      fem: fem,
                                      hem: hem,
                                      ffem: ffem,
                                      widthIcon: 16,
                                      heightIcon: 16,
                                      onPressed: () async {
                                        final storeModel =
                                            await AuthenLocalDataSource.getStore();
                                        Navigator.pushNamed(
                                          context,
                                          ProfileUpdateDetailStoreScreen
                                              .routeName,
                                          arguments: storeModel,
                                        );
                                      },
                                      svgIcon: 'assets/icons/pen-icon.svg',
                                      title: 'Cập nhật thông tin',
                                    ),
                                    SizedBox(height: 10 * hem),
                                    ButtonProfile(
                                      fem: fem,
                                      hem: hem,
                                      ffem: ffem,
                                      widthIcon: 17,
                                      heightIcon: 17,
                                      onPressed: () async {
                                        final storeModel =
                                            await AuthenLocalDataSource.getStore();
                                        Navigator.pushNamed(
                                          context,
                                          BrandDetailStoreScreen.routeName,
                                          arguments: storeModel!.brandId,
                                        );
                                      },
                                      svgIcon:
                                          'assets/icons/following-icon.svg',
                                      title: 'Thông tin thương hiệu',
                                    ),
                                    // SizedBox(height: 10 * hem),
                                    // ButtonProfile(
                                    //   fem: fem,
                                    //   hem: hem,
                                    //   ffem: ffem,
                                    //   widthIcon: 14,
                                    //   heightIcon: 14,
                                    //   onPressed: () async {
                                    //     // final storeModel =
                                    //     //     await AuthenLocalDataSource
                                    //     //         .getStore();
                                    //     // Navigator.pushNamed(
                                    //     //     context, BonusScreen.routeName,
                                    //     //     arguments: storeModel);
                                    //   },
                                    //   svgIcon:
                                    //       'assets/icons/bonus-bean-icon.svg',
                                    //   title: 'Danh sách tặng đậu',
                                    // ),
                                    SizedBox(height: 10 * hem),
                                    //button logout
                                    ButtonProfile(
                                      fem: fem,
                                      hem: hem,
                                      ffem: ffem,
                                      svgIcon: 'assets/icons/logout-icon.svg',
                                      title: 'Đăng xuất',
                                      onPressed: () => _dialogLogout(context),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container(child: Text('Error'));
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> _dialogLogout(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Bạn có muốn đăng xuất không?',
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 16,
                color: kPrimaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Không',
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<RoleAppBloc>().add(RoleAppEnd());
                context.read<LandingScreenBloc>().add(TabChange(tabIndex: 0));

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  LoginScreen.routeName,
                  (Route<dynamic> route) => false,
                );
              },
              child: Text(
                'Có',
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
