import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/interface_repositories/store_features/store_repository.dart';
import 'package:swallet_mobile/presentation/blocs/landing_screen/landing_screen_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/role/role_app_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/store/store_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/login/login_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/brand/brand_detail_store_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/profile_update_detail/profile_update_detail_screen.dart';
import 'package:swallet_mobile/presentation/widgets/internet_listener.dart';

import 'button_profile.dart';
import 'information_card_profile.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  Future<void> _openUpdateProfile(BuildContext context) async {
    final storeModel = await AuthenLocalDataSource.getStore();
    if (!context.mounted || storeModel == null) return;
    Navigator.pushNamed(
      context,
      ProfileUpdateDetailStoreScreen.routeName,
      arguments: storeModel,
    );
  }

  Future<void> _openBrandDetail(BuildContext context) async {
    final storeModel = await AuthenLocalDataSource.getStore();
    if (!context.mounted || storeModel == null) return;
    Navigator.pushNamed(
      context,
      BrandDetailStoreScreen.routeName,
      arguments: storeModel.brandId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    return InternetListener(
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<RoleAppBloc>().add(RoleAppStart());
        },
        child: SingleChildScrollView(
          child: BlocBuilder<RoleAppBloc, RoleAppState>(
            builder: (context, state) {
              if (state is! StoreRole) {
                return const Center(child: Text('Error'));
              }

              final storeModel = state.storeModel;

              return Container(
                width: double.infinity,
                height: size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background_splash.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    // Nền xám phủ phần dưới ảnh bìa.
                    Positioned(
                      left: 0,
                      top: 120 * hem,
                      child: Container(
                        width: size.width,
                        height: size.height,
                        color: klighGreyColor,
                      ),
                    ),
                    Positioned(
                      top: 80 * hem,
                      left: 25 * fem,
                      child: BlocProvider(
                        create:
                            (context) => StoreBloc(
                              storeRepository: context.read<StoreRepository>(),
                            )..add(
                              LoadStoreById(accountId: storeModel.accountId),
                            ),
                        child: InformationCardProfile(
                          fem: fem,
                          hem: hem,
                          ffem: ffem,
                          storeModel: storeModel,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 300 * hem,
                      child: SizedBox(
                        width: size.width,
                        height: size.height,
                        child: Column(
                          children: [
                            ButtonProfile(
                              fem: fem,
                              hem: hem,
                              ffem: ffem,
                              widthIcon: 16,
                              heightIcon: 16,
                              onPressed: () => _openUpdateProfile(context),
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
                              onPressed: () => _openBrandDetail(context),
                              svgIcon: 'assets/icons/following-icon.svg',
                              title: 'Thông tin thương hiệu',
                            ),
                            SizedBox(height: 10 * hem),
                            ButtonProfile(
                              fem: fem,
                              hem: hem,
                              ffem: ffem,
                              svgIcon: 'assets/icons/logout-icon.svg',
                              title: 'Đăng xuất',
                              onPressed: () => _confirmLogout(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            'Bạn có muốn đăng xuất không?',
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
              textStyle: const TextStyle(
                fontSize: 16,
                color: kPrimaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'Không',
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.read<RoleAppBloc>().add(RoleAppEnd());
                context.read<LandingScreenBloc>().add(TabChange(tabIndex: 0));
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  LoginScreen.routeName,
                  (route) => false,
                );
              },
              child: Text(
                'Có',
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
