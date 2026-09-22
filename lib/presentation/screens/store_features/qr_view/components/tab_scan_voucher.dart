import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:swallet_mobile/presentation/blocs/store/store_bloc.dart';
import 'package:swallet_mobile/presentation/screens/store_features/campaign_voucher_information/campaign_vouher_information_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/failed_scan_voucher/failed_scan_voucher_screen.dart';

import '../../../../config/constants.dart';
import 'qr_scanner_overlay.dart';

class TabScanVoucher extends StatelessWidget {
  const TabScanVoucher({
    super.key,
    required this.cameraController,
    required this.storeId,
  });

  final MobileScannerController cameraController;
  final String storeId;

  void _onStoreState(BuildContext context, StoreState state) {
    if (state is StoreCampaignVoucherInforFailed) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        FailedScanVoucherScreen.routeName,
        (route) => false,
        arguments: state.error,
      );
    } else if (state is StoreCampaignVoucherInforLoading) {
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
    } else if (state is StoreCampaigVoucherInforSuccess) {
      Navigator.pushAndRemoveUntil(
        context,
        CampaignVoucherInformationScreen.route(
          campaignModel: state.campaignDetailModel,
          voucherModel: state.campaignVoucherDetailModel,
          studentId: state.studentId,
          storeId: storeId,
          voucherItemId: state.voucherItemId,
        ),
        (route) => false,
      );
    }
  }

  void _onDetect(BuildContext context, BarcodeCapture capture) {
    for (final barcode in capture.barcodes) {
      final value = barcode.rawValue;
      if (value != null) {
        if (kDebugMode) debugPrint('Barcode found! $value');
        context.read<StoreBloc>().add(
          LoadCampaignVoucherInformation(voucherCode: value),
        );
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StoreBloc, StoreState>(
      listener: _onStoreState,
      child: Stack(
        alignment: Alignment.center,
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) => _onDetect(context, capture),
          ),
          IgnorePointer(
            child: Lottie.asset(
              'assets/animations/scanning.json',
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: ShapeDecoration(
                shape: QrScannerOverlayShape(
                  borderColor: kPrimaryColor,
                  borderRadius: 10,
                  borderLength: 20,
                  borderWidth: 5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
