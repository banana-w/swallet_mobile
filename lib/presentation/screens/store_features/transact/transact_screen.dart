import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/interface_repositories/store_features/store_repository.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/brand_repository.dart';
import 'package:swallet_mobile/data/models/student_features/student_model.dart';
import 'package:swallet_mobile/presentation/blocs/brand/brand_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/store/store_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/store_features/transact/success_transact_screen.dart';
import 'package:swallet_mobile/presentation/widgets/internet_listener.dart';

import '../widgets/store_app_bar.dart';
import 'components/form_transact.dart';
import 'components/information_card_profile.dart';

/// Số đậu tặng mỗi lần không được vượt quá tỉ lệ này so với ví dư.
const double _maxBonusRatio = 0.1;

class TransactScreen extends StatefulWidget {
  static const String routeName = '/transact-screen';

  static Route route({
    required StudentModel studentModel,
    required String brandId,
  }) {
    return MaterialPageRoute(
      builder:
          (_) => BlocProvider(
            create:
                (context) =>
                    StoreBloc(storeRepository: context.read<StoreRepository>()),
            child: TransactScreen(studentModel: studentModel, brandId: brandId),
          ),
      settings: const RouteSettings(name: routeName),
    );
  }

  const TransactScreen({
    super.key,
    required this.studentModel,
    required this.brandId,
  });

  final StudentModel studentModel;
  final String brandId;

  @override
  State<TransactScreen> createState() => _TransactScreenState();
}

class _TransactScreenState extends State<TransactScreen> {
  final _beanController = TextEditingController();
  final _desController = TextEditingController();

  bool _hasAmount = false;

  @override
  void initState() {
    super.initState();
    _beanController.addListener(() {
      final hasAmount = _beanController.text.isNotEmpty;
      if (hasAmount != _hasAmount) setState(() => _hasAmount = hasAmount);
    });
  }

  @override
  void dispose() {
    // Bản cũ bỏ quên dispose nên hai controller sống lâu hơn màn hình.
    _beanController.dispose();
    _desController.dispose();
    super.dispose();
  }

  void _goHome() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/landing-screen-store',
      (route) => false,
    );
  }

  void _onStoreState(BuildContext context, StoreState state) {
    if (state is CreateBonusFailed) {
      // Trước đây lỗi chỉ được `print`, người dùng không thấy gì cả.
      _showSnackBar(
        title: 'Chuyển thất bại!',
        message: state.error,
        type: ContentType.failure,
      );
    } else if (state is CreateBonusLoading) {
      showDialog<void>(
        context: context,
        builder:
            (_) => const AlertDialog(
              content: SizedBox(
                width: 250,
                height: 250,
                child: Center(
                  child: CircularProgressIndicator(color: kPrimaryColor),
                ),
              ),
            ),
      );
    } else if (state is CreateBonusSucess) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        SuccessTransactScreen.routeName,
        (route) => false,
        arguments: state.transactModel,
      );
    }
  }

  void _showSnackBar({
    required String title,
    required String message,
    required ContentType type,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          elevation: 0,
          duration: const Duration(milliseconds: 2000),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: title,
            message: message,
            contentType: type,
          ),
        ),
      );
  }

  Future<void> _transfer(double greenBalance) async {
    final amount = double.tryParse(_beanController.text);
    if (amount == null) {
      _showSnackBar(
        title: 'Chuyển thất bại!',
        message: 'Số đậu xanh không hợp lệ',
        type: ContentType.failure,
      );
      return;
    }

    if (amount > greenBalance * _maxBonusRatio) {
      _showSnackBar(
        title: 'Chuyển thất bại!',
        message: 'Số đậu tặng không quá 10% so với ví dư',
        type: ContentType.failure,
      );
      return;
    }

    final storeId = await AuthenLocalDataSource.getStoreId();
    if (!mounted || storeId == null) return;

    final description =
        _desController.text.isEmpty
            ? 'Chúc bạn một ngày vui vẻ'
            : _desController.text;

    context.read<StoreBloc>().add(
      CreateBonus(
        storeId: storeId,
        studentId: widget.studentModel.id,
        amount: amount,
        description: description,
        state: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final ffem = fem * 0.97;
    final hem = size.height / 812;

    return BlocListener<StoreBloc, StoreState>(
      listener: _onStoreState,
      child: BlocProvider(
        create:
            (context) =>
                BrandBloc(brandRepository: context.read<BrandRepository>())
                  ..add(LoadBrandById(id: widget.brandId)),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: klighGreyColor,
            appBar: StoreAppBar(
              title: 'Tặng đậu xanh',
              fem: fem,
              ffem: ffem,
              hem: hem,
              titleSize: 18,
              iconSize: 25,
              onBack: _goHome,
              onHome: _goHome,
            ),
            body: InternetListener(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    BlocBuilder<BrandBloc, BrandState>(
                      builder: (context, state) {
                        if (state is BrandLoading) {
                          return Center(
                            child: Lottie.asset(
                              'assets/animations/loading-screen.json',
                              width: 50,
                              height: 50,
                            ),
                          );
                        }
                        if (state is! BrandByIdLoaded) {
                          return const SizedBox.shrink();
                        }
                        return _BalanceCard(
                          balance: state.brand.totalIncome,
                          fem: fem,
                          ffem: ffem,
                          hem: hem,
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    InformationCardProfile(
                      hem: hem,
                      fem: fem,
                      ffem: ffem,
                      studentModel: widget.studentModel,
                    ),
                    const SizedBox(height: 20),
                    FormTransact(
                      fem: fem,
                      hem: hem,
                      ffem: ffem,
                      beanController: _beanController,
                      desController: _desController,
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            // Ví dư đọc từ state ngay tại đây; bản cũ gán vào biến của State
            // trong lúc `build` chạy, nên có thể còn là 0 khi bấm nút.
            floatingActionButton: BlocBuilder<BrandBloc, BrandState>(
              builder: (context, state) {
                final balance =
                    state is BrandByIdLoaded ? state.brand.totalIncome : 0.0;
                return _TransferButton(
                  enabled: _hasAmount,
                  fem: fem,
                  ffem: ffem,
                  hem: hem,
                  onTap: () => _transfer(balance),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

/// Thẻ "Ví dư" hiển thị số đậu xanh còn lại của thương hiệu.
class _BalanceCard extends StatelessWidget {
  const _BalanceCard({
    required this.balance,
    required this.fem,
    required this.ffem,
    required this.hem,
  });

  final double balance;
  final double fem;
  final double ffem;
  final double hem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 324 * fem,
      padding: EdgeInsets.symmetric(vertical: 15 * hem),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15 * fem),
        color: Colors.white,
      ),
      child: Row(
        children: [
          SizedBox(width: 20 * fem),
          Text(
            'Ví dư:',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 17 * ffem,
                fontWeight: FontWeight.bold,
                height: 1.3625 * ffem / fem,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            formatter.format(balance),
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 20 * ffem,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 2 * fem, top: 4 * hem),
            child: SvgPicture.asset(
              'assets/icons/green-bean-icon.svg',
              width: 28 * fem,
              height: 26 * fem,
            ),
          ),
        ],
      ),
    );
  }
}

class _TransferButton extends StatelessWidget {
  const _TransferButton({
    required this.enabled,
    required this.fem,
    required this.ffem,
    required this.hem,
    required this.onTap,
  });

  final bool enabled;
  final double fem;
  final double ffem;
  final double hem;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 220 * fem,
        height: 40 * hem,
        decoration: BoxDecoration(
          color: enabled ? kPrimaryColor : kLowTextColor,
          borderRadius: BorderRadius.circular(10 * fem),
        ),
        child: Center(
          child: Text(
            'Chuyển ngay',
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 15 * ffem,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
