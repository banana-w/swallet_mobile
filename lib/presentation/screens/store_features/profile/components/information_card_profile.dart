import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/store_features/store_model.dart';
import 'package:swallet_mobile/presentation/blocs/store/store_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';

import 'name_profile.dart';

class InformationCardProfile extends StatefulWidget {
  const InformationCardProfile({
    super.key,
    required this.fem,
    required this.hem,
    required this.storeModel,
    required this.ffem,
  });

  final double fem;
  final double hem;
  final StoreModel storeModel;
  final double ffem;

  @override
  State<InformationCardProfile> createState() => _InformationCardProfileState();
}

class _InformationCardProfileState extends State<InformationCardProfile> {
  File? _selectedAvatar;

  double get fem => widget.fem;
  double get hem => widget.hem;
  double get ffem => widget.ffem;

  void _onStoreState(BuildContext context, StoreState state) {
    if (state is StoreUpding) {
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
      return;
    }

    final isSuccess = state is StoreUpdateSuccess;
    if (!isSuccess && state is! StoreUpdateFailed) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          elevation: 0,
          duration: const Duration(milliseconds: 2000),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: isSuccess ? 'Cập nhật thành công' : 'Cập nhật thất bại',
            message:
                isSuccess
                    ? 'Cập nhật ảnh đại diện thành công!'
                    : 'Cập nhật ảnh đại diện thất bại!',
            contentType: isSuccess ? ContentType.success : ContentType.failure,
          ),
        ),
      );
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/landing-screen-store',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StoreBloc, StoreState>(
      listener: _onStoreState,
      child: Container(
        width: 324 * fem,
        height: 200 * hem,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15 * fem),
          color: Colors.white,
        ),
        child: Column(
          children: [
            SizedBox(height: 10 * hem),
            Row(
              children: [
                SizedBox(width: 25 * fem),
                InkWell(
                  onTap: _showAvatarPicker,
                  child: BlocBuilder<StoreBloc, StoreState>(
                    builder: (context, state) {
                      // Chưa tải xong hồ sơ thì dùng tạm ảnh mặc định.
                      final avatarUrl =
                          state is StoreByIdLoaed
                              ? state.storeModel.avatar
                              : null;
                      return _Avatar(
                        avatarUrl: avatarUrl,
                        selectedAvatar: _selectedAvatar,
                        fem: fem,
                        hem: hem,
                      );
                    },
                  ),
                ),
                SizedBox(width: 20 * fem),
                BlocBuilder<StoreBloc, StoreState>(
                  builder: (context, state) {
                    final store =
                        state is StoreByIdLoaed
                            ? state.storeModel
                            : widget.storeModel;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NameProfile(
                          fem: fem,
                          ffem: ffem,
                          hem: hem,
                          name: store.storeName,
                        ),
                        SizedBox(
                          width: 150 * fem,
                          child: Text(
                            store.email,
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                fontSize: 13 * ffem,
                                fontWeight: FontWeight.normal,
                                color: klowTextGrey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 10 * fem),
            SizedBox(
              width: 280 * fem,
              child: Divider(
                thickness: 1 * fem,
                color: const Color.fromARGB(255, 225, 223, 223),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10 * hem),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _CountChip(
                    icon: 'assets/icons/campaign-navbar-icon.svg',
                    iconSize: 18,
                    label: '${widget.storeModel.numberOfCampaigns} chiến dịch',
                    fem: fem,
                    ffem: ffem,
                    hem: hem,
                  ),
                  _CountChip(
                    icon: 'assets/icons/voucher-navbar-icon.svg',
                    iconSize: 15,
                    label: '${widget.storeModel.numberOfVouchers} ưu đãi',
                    fem: fem,
                    ffem: ffem,
                    hem: hem,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Chọn ảnh rồi gửi ngay lên server. Trả về `false` nếu người dùng huỷ.
  Future<void> _pickAndUpload(ImageSource source) async {
    final returnedImage = await ImagePicker().pickImage(source: source);
    if (returnedImage == null) return;

    if (!mounted) return;
    setState(() => _selectedAvatar = File(returnedImage.path));
    Navigator.pop(context);

    final storeModel = await AuthenLocalDataSource.getStore();
    if (!mounted || storeModel == null) return;
    context.read<StoreBloc>().add(
      UpdateStore(
        storeId: storeModel.id,
        areaId: storeModel.areaId,
        storeName: storeModel.storeName,
        address: storeModel.address,
        openHours: storeModel.openingHours,
        closeHours: storeModel.closingHours,
        description: storeModel.description,
        avatar: returnedImage.path,
        state: true,
      ),
    );
  }

  void _showAvatarPicker() {
    final size = MediaQuery.sizeOf(context);

    showModalBottomSheet<void>(
      context: context,
      builder:
          (_) => SizedBox(
            height: size.height * 0.2,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _PickerOption(
                  icon: Icons.camera_alt,
                  label: 'Chụp ảnh',
                  fem: fem,
                  ffem: ffem,
                  onTap: () => _pickAndUpload(ImageSource.camera),
                ),
                SizedBox(height: 18 * hem),
                SizedBox(
                  width: size.width * 0.7,
                  child: Divider(color: kLowTextColor, thickness: 2 * fem),
                ),
                SizedBox(height: 18 * hem),
                _PickerOption(
                  icon: Icons.photo_size_select_actual_rounded,
                  label: 'Chọn sẵn có',
                  fem: fem,
                  ffem: ffem,
                  onTap: () => _pickAndUpload(ImageSource.gallery),
                ),
              ],
            ),
          ),
    );
  }
}

/// Ảnh đại diện kèm huy hiệu máy ảnh; ưu tiên ảnh vừa chọn trong máy.
class _Avatar extends StatelessWidget {
  const _Avatar({
    required this.avatarUrl,
    required this.selectedAvatar,
    required this.fem,
    required this.hem,
  });

  final String? avatarUrl;
  final File? selectedAvatar;
  final double fem;
  final double hem;

  @override
  Widget build(BuildContext context) {
    final width = 80 * fem;
    final height = 80 * hem;

    Widget image;
    if (selectedAvatar != null) {
      image = Image.file(
        selectedAvatar!,
        width: width,
        height: height,
        fit: BoxFit.cover,
      );
    } else if (avatarUrl != null) {
      image = Image.network(
        avatarUrl!,
        width: width,
        height: height,
        fit: BoxFit.fill,
        errorBuilder:
            (context, error, stackTrace) => Image.asset(
              'assets/images/ava_signup.png',
              width: width,
              height: height,
            ),
      );
    } else {
      image = Image.asset(
        'assets/images/ava_signup.png',
        width: width,
        height: height,
        fit: BoxFit.fill,
      );
    }

    return Stack(
      children: [
        ClipRRect(borderRadius: BorderRadius.circular(50), child: image),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: klighGreyColor,
            ),
            padding: const EdgeInsets.all(5),
            child: const Icon(Icons.camera_alt_outlined, size: 20),
          ),
        ),
      ],
    );
  }
}

/// Ô đếm "n chiến dịch" / "n ưu đãi".
class _CountChip extends StatelessWidget {
  const _CountChip({
    required this.icon,
    required this.iconSize,
    required this.label,
    required this.fem,
    required this.ffem,
    required this.hem,
  });

  final String icon;
  final double iconSize;
  final String label;
  final double fem;
  final double ffem;
  final double hem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5 * fem),
      width: 140 * fem,
      height: 40 * hem,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[100],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            colorFilter: const ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
            height: iconSize * fem,
            width: iconSize * fem,
          ),
          SizedBox(width: 5 * fem),
          Text(
            label,
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 12 * fem,
                fontWeight: FontWeight.bold,
                height: 1.3625 * ffem / fem,
                color: kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Một lựa chọn trong bảng chọn ảnh đại diện.
class _PickerOption extends StatelessWidget {
  const _PickerOption({
    required this.icon,
    required this.label,
    required this.fem,
    required this.ffem,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final double fem;
  final double ffem;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: kPrimaryColor, size: 30 * fem),
          SizedBox(width: 5 * fem),
          Text(
            label,
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 20 * ffem,
                fontWeight: FontWeight.bold,
                height: 1.3625 * ffem / fem,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
