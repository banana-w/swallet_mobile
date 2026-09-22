import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/models/student_features/location_model.dart';
import 'package:swallet_mobile/presentation/blocs/location/location_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

class LocationListScreen extends StatelessWidget {
  static const String routeName = '/location_screen';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const LocationListScreen(),
      // Trước đây truyền routeName vào `arguments` thay vì `name`.
      settings: const RouteSettings(name: routeName),
    );
  }

  const LocationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

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
            onTap: () => Navigator.pop(context),
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
            // Trước đây hàm này trả về ngay, nên vòng xoay tắt trước cả khi
            // danh sách kịp tải xong.
            // orElse cần thiết vì rời màn hình giữa chừng sẽ đóng bloc, và
            // firstWhere trên stream đã đóng mà không khớp sẽ ném StateError.
            await context.read<LocationBloc>().stream.firstWhere(
              (state) => state is! LocationLoading,
              orElse: () => LocationInitial(),
            );
          },
          child: BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  width: size.width,
                  child: _buildContent(state, fem, hem, ffem),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    LocationState state,
    double fem,
    double hem,
    double ffem,
  ) {
    // Trước đây cả nhánh đang tải lẫn nhánh mặc định đều gọi một hàm
    // "shimmer" dựng hai Container trắng không đặt chiều cao — tức là không
    // vẽ ra gì cả. Màn hình chỉ trắng trơn, kể cả khi tải hỏng.
    if (state is LocationLoading || state is LocationInitial) {
      return Padding(
        padding: EdgeInsets.only(top: 40 * hem),
        child: const Center(
          child: CircularProgressIndicator(color: kPrimaryColor),
        ),
      );
    }

    if (state is LocationFailed) {
      // `LocationFailed` trước đây không được xử lý ở đâu cả.
      return _messageCard(
        icon: Icons.error_outline,
        message: 'Không tải được danh sách địa điểm',
        fem: fem,
        hem: hem,
      );
    }

    if (state is LocationLoaded) {
      if (state.locations.isEmpty) {
        return _messageCard(
          icon: Icons.location_off,
          message: 'Không có địa điểm check-in nào',
          fem: fem,
          hem: hem,
        );
      }
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: state.locations.length,
        itemBuilder:
            (context, index) => _LocationCard(
              location: state.locations[index],
              fem: fem,
              hem: hem,
              ffem: ffem,
            ),
      );
    }

    return const SizedBox();
  }

  Widget _messageCard({
    required IconData icon,
    required String message,
    required double fem,
    required double hem,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 15 * fem, right: 15 * fem, top: 20),
      height: 220 * hem,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: kPrimaryColor, size: 50 * fem),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  const _LocationCard({
    required this.location,
    required this.fem,
    required this.hem,
    required this.ffem,
  });

  final LocationModel location;
  final double fem;
  final double hem;
  final double ffem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10 * hem, horizontal: 15 * fem),
      padding: EdgeInsets.all(15 * fem),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15 * fem),
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
  }
}
