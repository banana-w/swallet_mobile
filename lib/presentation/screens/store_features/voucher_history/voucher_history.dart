import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/student_repository.dart';
import 'package:swallet_mobile/presentation/blocs/student/student_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

import '../widgets/store_app_bar.dart';
import 'components/body_voucher_history.dart';

class VoucherHistoryScreenStore extends StatefulWidget {
  static const String routeName = '/voucher-history-store';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const VoucherHistoryScreenStore(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const VoucherHistoryScreenStore({super.key});

  @override
  State<VoucherHistoryScreenStore> createState() =>
      _VoucherHistoryScreenStoreState();
}

class _VoucherHistoryScreenStoreState extends State<VoucherHistoryScreenStore> {
  String? _storeId;

  @override
  void initState() {
    super.initState();
    _fetchStoreId();
  }

  Future<void> _fetchStoreId() async {
    String? id;
    try {
      final store = await AuthenLocalDataSource.getStore();
      id = store?.id ?? '';
    } catch (_) {
      id = '';
    }
    if (!mounted) return;
    setState(() => _storeId = id);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    return BlocProvider(
      create:
          (context) =>
              StudentBloc(studentRepository: context.read<StudentRepository>()),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: klighGreyColor,
          appBar: StoreAppBar(
            title: 'Swallet',
            fem: fem,
            ffem: ffem,
            hem: hem,
            titleSize: 22,
          ),
          body:
              _storeId == null
                  ? const Center(child: CircularProgressIndicator())
                  : BodyVoucherHistoryStore(storeId: _storeId!),
        ),
      ),
    );
  }
}
