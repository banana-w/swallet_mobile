import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/student_repository.dart';
import 'package:swallet_mobile/presentation/blocs/student/student_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

import 'components/body_voucher_history.dart';

class VoucherHistoryScreenStore extends StatefulWidget {
  static const String routeName = '/voucher-history-store';

  // Static method to create a route without storeId
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const VoucherHistoryScreenStore(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const VoucherHistoryScreenStore({super.key});

  @override
  _VoucherHistoryScreenStoreState createState() => _VoucherHistoryScreenStoreState();
}

class _VoucherHistoryScreenStoreState extends State<VoucherHistoryScreenStore> {
  String storeId = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchStoreId();
  }

  Future<void> _fetchStoreId() async {
    try {
      final store = await AuthenLocalDataSource.getStore();
      setState(() {
        storeId = store?.id ?? ''; // Fallback to empty string if store or id is null
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        storeId = '';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double baseHeight = 812;
    double ffem = fem * 0.97;
    double hem = MediaQuery.of(context).size.height / baseHeight;

    return BlocProvider(
      create: (context) => StudentBloc(studentRepository: context.read<StudentRepository>()),
      child: SafeArea(
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
            toolbarHeight: 50 * hem,
            centerTitle: true,
            title: Text(
              'Swallet',
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 22 * ffem,
                  fontWeight: FontWeight.w900,
                  height: 1.3625 * ffem / fem,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          body: isLoading
              ? const Center(child: CircularProgressIndicator())
              : BodyVoucherHistoryStore(storeId: storeId),
        ),
      ),
    );
  }
}
