import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:swallet_mobile/presentation/blocs/store/store_bloc.dart';
import 'package:swallet_mobile/presentation/screens/store_features/campaign_voucher_information/campaign_vouher_information_screen.dart';
import 'package:swallet_mobile/presentation/screens/store_features/failed_scan_voucher/failed_scan_voucher_screen.dart';

import '../../../../config/constants.dart';
import 'body.dart';
import 'qr_scanner_overlay.dart';

class TabScanVoucher extends StatelessWidget {
  const TabScanVoucher({
    super.key,
    required this.cameraController,
    required this.widget,
  });

  final MobileScannerController cameraController;
  final Body widget;

  @override
  Widget build(BuildContext context) {
    return BlocListener<StoreBloc, StoreState>(
      listener: (context, state) {
        if (state is StoreCampaignVoucherInforFailed) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            FailedScanVoucherScreen.routeName,
            (Route<dynamic> route) => false,
            arguments: state.error,
          );
        } else if (state is StoreCampaignVoucherInforLoading) {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(Duration(seconds: 5));
              return AlertDialog(
                content: SizedBox(
                  width: 250,
                  height: 250,
                  child: Center(
                    child: CircularProgressIndicator(color: kPrimaryColor),
                  ),
                ),
              );
            },
          );
        } else if (state is StoreCampaigVoucherInforSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            CampaignVoucherInformationScreen.route(
              campaignModel: state.campaignDetailModel,
              voucherModel: state.campaignVoucherDetailModel,
              studentId: state.studentId,
              storeId: widget.id,
              voucherItemId: state.voucherItemId,
            ),
            (Route<dynamic> route) => false,
          );
        }
      },
      child: Stack(
        children: [
          MobileScanner(
            startDelay: true,
            overlay: Lottie.asset('assets/animations/scanning.json'),
            controller: cameraController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              String? value;
              for (final barcode in barcodes) {
                print('Barcode found! ${barcode.rawValue}');
                value = barcode.rawValue;
                if (value != null) {
                  break;
                }
              }
              if (value != null) {
                context.read<StoreBloc>().add(
                  LoadCampaignVoucherInformation(voucherCode: value),
                );
              }
            },
          ),
          Positioned.fill(
            child: Container(
              decoration: ShapeDecoration(
                shape: QrScannerOverlayShape(
                  borderColor: kPrimaryColor,
                  borderRadius: 10,
                  borderLength: 20,
                  borderWidth: 5,
                  // cutOutSize: scanArea,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
