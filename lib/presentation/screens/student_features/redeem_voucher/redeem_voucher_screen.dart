import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/interface_repositories/student_features/campaign_repository.dart';
import 'package:swallet_mobile/presentation/blocs/internet/internet_bloc.dart';
import 'package:swallet_mobile/presentation/blocs/redeem_voucher/redeem_voucher_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/student_features/buy_failed/buy_failed_screen.dart';
import 'package:swallet_mobile/presentation/screens/student_features/success_redeem_voucher/success_redeem_voucher_screen.dart';

import 'components/body.dart';

class RedeemVoucherScreen extends StatefulWidget {
  static const String routeName = '/redeem-voucher-student';

  static Route route({
    required String campignId,
    required String campaignDetailId,
    required String studentId,
    required int quantity,
    required double total,
    required String voucherName,
    required String campaignName,
    required double priceVoucher,
  }) {
    return MaterialPageRoute(
      builder:
          (_) => RedeemVoucherScreen(
            campignId: campignId,
            campaignDetailId: campaignDetailId,
            studentId: studentId,
            quantity: quantity,
            campaignName: campaignName,
            total: total,
            voucherName: voucherName,
            priceVoucher: priceVoucher,
          ),
      settings: const RouteSettings(name: routeName),
    );
  }

  const RedeemVoucherScreen({
    super.key,
    required this.campignId,
    required this.campaignDetailId,
    required this.studentId,
    required this.quantity,
    required this.total,
    required this.campaignName,
    required this.voucherName,
    required this.priceVoucher,
  });

  final String campignId;
  final String campaignDetailId;
  final String studentId;
  final int quantity;
  final double total;
  final String voucherName;
  final String campaignName;
  final double priceVoucher;

  @override
  State<RedeemVoucherScreen> createState() => _RedeemVoucherScreenState();
}

class _RedeemVoucherScreenState extends State<RedeemVoucherScreen> {
  bool _isNoInternetDialogOpen = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final fem = size.width / 375;
    final hem = size.height / 812;
    final ffem = fem * 0.97;

    // Hoá đơn không đổi trong suốt màn hình: dựng một lần rồi dùng lại đúng
    // instance đó, để lúc bật/tắt trạng thái loading Flutter bỏ qua nhánh này.
    final body = Body(
      quantity: widget.quantity,
      voucherName: widget.voucherName,
      total: widget.total,
      campaignName: widget.campaignName,
      priceVoucher: widget.priceVoucher,
    );

    return BlocProvider(
      // Bloc riêng cho một lần thanh toán, tạo và huỷ theo màn hình này.
      create:
          (context) => RedeemVoucherBloc(
            campaignRepository: context.read<CampaignRepository>(),
          ),
      child: BlocListener<InternetBloc, InternetState>(
        listener: _handleInternetState,
        child: BlocConsumer<RedeemVoucherBloc, RedeemVoucherState>(
          listenWhen:
              (previous, current) =>
                  current is RedeemVoucherSuccess ||
                  current is RedeemVoucherFailed,
          listener: _handleRedeemState,
          builder: (context, state) {
            final isProcessing = state is RedeemVoucherLoading;
            return PopScope(
              // Đang trừ điểm mà thoát màn thì bloc bị huỷ giữa chừng: request
              // vẫn chạy tiếp ở server nhưng app không còn chỗ nhận kết quả.
              canPop: !isProcessing,
              child: SafeArea(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Scaffold(
                      backgroundColor: klighGreyColor,
                      appBar: AppBar(
                        elevation: 0,
                        flexibleSpace: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/background_splash.png',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        leading: InkWell(
                          onTap:
                              isProcessing
                                  ? null
                                  : () => Navigator.pop(context),
                          child: Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                            size: 30 * fem,
                          ),
                        ),
                        toolbarHeight: 50 * hem,
                        centerTitle: true,
                        title: Text(
                          'Thanh toán an toàn',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 20 * ffem,
                              fontWeight: FontWeight.w900,
                              height: 1.3625 * ffem / fem,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      body: body,
                      bottomNavigationBar: _PayButton(
                        fem: fem,
                        hem: hem,
                        ffem: ffem,
                        isProcessing: isProcessing,
                        onPay: () => _pay(context),
                      ),
                    ),
                    // Lớp phủ nằm trong cây widget thay vì là một route dialog:
                    // không thể sót lại khi state đổi, và che luôn cả app bar.
                    if (isProcessing) _ProcessingOverlay(ffem: ffem),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _pay(BuildContext context) {
    // Mất mạng thì đừng bắn giao dịch: nó chỉ dẫn thẳng tới màn thất bại và
    // xoá sạch stack điều hướng.
    if (context.read<InternetBloc>().state is NotConnected) {
      _showAppSnackBar(
        context,
        title: 'Không có kết nối',
        message: 'Vui lòng kết nối internet rồi thử lại!',
        contentType: ContentType.warning,
      );
      return;
    }
    context.read<RedeemVoucherBloc>().add(
      RedeemCampaignVoucher(
        campaignId: widget.campignId,
        voucherId: widget.campaignDetailId,
        studentId: widget.studentId,
        quantity: widget.quantity,
        cost: widget.total,
      ),
    );
  }

  void _handleRedeemState(BuildContext context, RedeemVoucherState state) {
    if (state is RedeemVoucherSuccess) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        SuccessRedeemVoucherScreen.routeName,
        (route) => false,
        arguments: <dynamic>[widget.voucherName, widget.total],
      );
    } else if (state is RedeemVoucherFailed) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        FailedBuyScreen.routeName,
        (route) => false,
        arguments: state.error,
      );
    }
  }

  void _handleInternetState(BuildContext context, InternetState state) {
    if (state is Connected) {
      _showAppSnackBar(
        context,
        title: 'Đã kết nối internet',
        message: 'Đã kết nối internet!',
        contentType: ContentType.success,
      );
      // Có mạng lại thì tự đóng hộp thoại, không bắt người dùng bấm.
      if (_isNoInternetDialogOpen) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    } else if (state is NotConnected && !_isNoInternetDialogOpen) {
      _showNoInternetDialog(context);
    }
  }

  Future<void> _showNoInternetDialog(BuildContext context) async {
    _isNoInternetDialogOpen = true;
    await showCupertinoDialog<void>(
      context: context,
      builder:
          (dialogContext) => CupertinoAlertDialog(
            title: const Text('Không kết nối Internet'),
            content: const Text('Vui lòng kết nối Internet'),
            actions: [
              TextButton(
                // Luôn cho đóng: giữ người dùng trong hộp thoại không làm mạng
                // trở lại, mà nút thanh toán đã tự chặn khi mất kết nối.
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Đồng ý'),
              ),
            ],
          ),
    );
    _isNoInternetDialogOpen = false;
  }

  void _showAppSnackBar(
    BuildContext context, {
    required String title,
    required String message,
    required ContentType contentType,
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
            contentType: contentType,
          ),
        ),
      );
  }
}

class _PayButton extends StatelessWidget {
  const _PayButton({
    required this.fem,
    required this.hem,
    required this.ffem,
    required this.isProcessing,
    required this.onPay,
  });

  final double fem;
  final double hem;
  final double ffem;
  final bool isProcessing;
  final VoidCallback onPay;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: kPrimaryColor,
      height: 80 * hem,
      elevation: 5,
      child: Center(
        child: GestureDetector(
          // Đang xử lý thì khoá nút, tránh trừ điểm hai lần.
          onTap: isProcessing ? null : onPay,
          child: Container(
            width: 320 * fem,
            height: 45 * hem,
            decoration: BoxDecoration(
              color: isProcessing ? null : klightPrimaryColor,
              borderRadius: BorderRadius.circular(10 * fem),
            ),
            child: Center(
              child:
                  isProcessing
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                        'Thanh toán',
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            fontSize: 17 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.3625 * ffem / fem,
                            color: Colors.white,
                          ),
                        ),
                      ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProcessingOverlay extends StatelessWidget {
  const _ProcessingOverlay({required this.ffem});

  final double ffem;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ModalBarrier(dismissible: false, color: Colors.black54),
        Center(
          child: Material(
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(color: kPrimaryColor),
                  const SizedBox(height: 16),
                  Text(
                    'Đang thực hiện...',
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontSize: 15 * ffem,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
