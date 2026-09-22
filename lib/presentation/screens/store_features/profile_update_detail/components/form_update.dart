import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';
import 'package:swallet_mobile/data/models/store_features/store_model.dart';
import 'package:swallet_mobile/presentation/blocs/store/store_bloc.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/presentation/screens/store_features/profile_update_detail/components/text_form_field_address.dart';

import 'text_form_field_default.dart';

/// Mô tả cửa hàng tối đa bấy nhiêu ký tự.
const int _maxDescriptionLength = 500;

class FormUpdate extends StatefulWidget {
  const FormUpdate({
    super.key,
    required this.ffem,
    required this.fem,
    required this.hem,
    required this.storeModel,
  });

  final double ffem;
  final double fem;
  final double hem;
  final StoreModel storeModel;

  @override
  State<FormUpdate> createState() => _FormUpdateState();
}

class _FormUpdateState extends State<FormUpdate> {
  final _formKey = GlobalKey<FormState>();
  final _storeNameController = TextEditingController();
  final _areaController = TextEditingController();
  final _openHoursController = TextEditingController();
  final _closingHoursController = TextEditingController();
  final _addressController = TextEditingController();
  final _descripController = TextEditingController();

  late TimeOfDay _openingHours;
  late TimeOfDay _closingHours;

  bool _changed = false;

  double get fem => widget.fem;
  double get hem => widget.hem;
  double get ffem => widget.ffem;

  @override
  void initState() {
    super.initState();
    final store = widget.storeModel;

    _storeNameController.text = store.storeName;
    _areaController.text = store.areaId;
    _addressController.text = store.address;
    _descripController.text = store.description;

    _openingHours = parseTimeString(store.openingHours);
    _closingHours = parseTimeString(store.closingHours);
    _openHoursController.text = timeOfDayToString(_openingHours);
    _closingHoursController.text = timeOfDayToString(_closingHours);

    for (final controller in [
      _storeNameController,
      _areaController,
      _addressController,
      _descripController,
    ]) {
      controller.addListener(_markChanged);
    }
  }

  @override
  void dispose() {
    // Bản cũ không gọi dispose, nên mỗi lần mở màn sửa hồ sơ là rò thêm sáu
    // controller kèm listener của chúng.
    for (final controller in [
      _storeNameController,
      _areaController,
      _openHoursController,
      _closingHoursController,
      _addressController,
      _descripController,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  void _markChanged() {
    if (!_changed) setState(() => _changed = true);
  }

  Future<void> _pickTime({required bool isOpening}) async {
    final time = await showTimePicker(
      context: context,
      initialTime: isOpening ? _openingHours : _closingHours,
      builder:
          (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          ),
    );
    // Bấm huỷ trả về null; bản cũ gán thẳng vào biến rồi `!` nên văng lỗi.
    if (time == null || !mounted) return;

    setState(() {
      if (isOpening) {
        _openingHours = time;
        _openHoursController.text = timeOfDayToString(time);
      } else {
        _closingHours = time;
        _closingHoursController.text = timeOfDayToString(time);
      }
      _changed = true;
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          elevation: 0,
          duration: const Duration(milliseconds: 2000),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Sửa thất bại',
            message: message,
            contentType: ContentType.failure,
          ),
        ),
      );
  }

  Future<void> _save() async {
    if (_openingHours.hour > _closingHours.hour) {
      _showError('Giờ mở cửa không được sau giờ đóng cửa!');
      return;
    }
    if (_descripController.text.length > _maxDescriptionLength) {
      _showError('Mô tả không được quá $_maxDescriptionLength từ!');
      return;
    }

    final storeId = await AuthenLocalDataSource.getStoreId();
    if (!mounted || storeId == null) return;

    context.read<StoreBloc>().add(
      UpdateStore(
        storeId: storeId,
        areaId: _areaController.text,
        storeName: _storeNameController.text,
        address: _addressController.text,
        openHours: _openHoursController.text,
        closeHours: _closingHoursController.text,
        description: _descripController.text,
        state: true,
      ),
    );
  }

  void _onStoreState(BuildContext context, StoreState state) {
    if (state is StoreUpdateSuccess) {
      _showSnackBar(
        title: 'Cập nhật thành công',
        message: 'Cập nhật thông tin mới thành công!',
        type: ContentType.success,
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/landing-screen-store',
        (route) => false,
      );
    } else if (state is StoreUpdateFailed) {
      _showSnackBar(
        title: 'Sửa thất bại',
        message: 'Cập nhật thông tin thất bại!',
        type: ContentType.failure,
      );
      Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<StoreBloc, StoreState>(
      listener: _onStoreState,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              margin: EdgeInsets.symmetric(horizontal: 15 * fem),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15 * fem),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x0c000000),
                    offset: Offset(0 * fem, 4 * fem),
                    blurRadius: 2.5 * fem,
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 25 * hem),
                  TextFormFieldDefault(
                    hem: hem,
                    fem: fem,
                    ffem: ffem,
                    labelText: 'TÊN CỦA HÀNG',
                    hintText: 'Nhập tên cửa hàng...',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Tên cửa hàng không được bỏ trống';
                      }
                      if (!vietNameseTextOnlyPattern.hasMatch(value)) {
                        return 'Tên cửa hàng không hợp lệ';
                      }
                      return null;
                    },
                    textController: _storeNameController,
                  ),
                  SizedBox(height: 25 * hem),
                  SizedBox(
                    width: 272 * fem,
                    child: TextFormField(
                      readOnly: true,
                      initialValue: widget.storeModel.areaName,
                      style: _fieldTextStyle,
                      decoration: _inputDecoration(labelText: 'KHU VỰC'),
                    ),
                  ),
                  SizedBox(height: 20 * hem),
                  _TimeField(
                    label: 'GIỜ MỞ CỬA',
                    value: _openingHours.format(context),
                    fem: fem,
                    ffem: ffem,
                    hem: hem,
                    onTap: () => _pickTime(isOpening: true),
                  ),
                  SizedBox(height: 13 * hem),
                  _TimeField(
                    label: 'GIỜ ĐÓNG CỬA',
                    value: _closingHours.format(context),
                    fem: fem,
                    ffem: ffem,
                    hem: hem,
                    onTap: () => _pickTime(isOpening: false),
                  ),
                  SizedBox(height: 25 * hem),
                  TextFormFieldAddress(
                    hem: hem,
                    fem: fem,
                    ffem: ffem,
                    labelText: 'ĐỊA CHỈ',
                    hintText: 'Nhập địa chỉ...',
                    validator: (_) => null,
                    textController: _addressController,
                  ),
                  SizedBox(height: 25 * hem),
                  SizedBox(
                    width: 272 * fem,
                    height: 100 * fem,
                    child: TextFormField(
                      maxLines: null,
                      expands: true,
                      validator: (_) => null,
                      controller: _descripController,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15 * fem,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      decoration: _inputDecoration(
                        labelText: 'MÔ TẢ',
                        hintText: 'Nhập mô tả',
                      ),
                    ),
                  ),
                  SizedBox(height: 25 * hem),
                ],
              ),
            ),
            SizedBox(height: 25 * hem),
            _SaveButton(
              enabled: _changed,
              fem: fem,
              ffem: ffem,
              hem: hem,
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }

  TextStyle get _fieldTextStyle => GoogleFonts.openSans(
    textStyle: TextStyle(
      color: Colors.black,
      fontSize: 15 * ffem,
      fontWeight: FontWeight.bold,
    ),
  );

  InputDecoration _inputDecoration({
    required String labelText,
    String? hintText,
  }) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(28 * fem),
      borderSide: const BorderSide(
        width: 2,
        color: Color.fromARGB(255, 220, 220, 220),
      ),
      gapPadding: 10,
    );

    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: GoogleFonts.openSans(
        textStyle: TextStyle(
          color: kPrimaryColor,
          fontSize: 15 * ffem,
          fontWeight: FontWeight.w900,
        ),
      ),
      hintStyle: GoogleFonts.openSans(
        textStyle: TextStyle(
          color: kLowTextColor,
          fontSize: 15 * ffem,
          fontWeight: FontWeight.w700,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 26 * fem,
        vertical: 10 * hem,
      ),
      enabledBorder: border,
      focusedBorder: border,
      errorBorder: border,
    );
  }
}

/// Ô giờ mở/đóng cửa: viền bo tròn với nhãn nổi ở góc trên.
class _TimeField extends StatelessWidget {
  const _TimeField({
    required this.label,
    required this.value,
    required this.fem,
    required this.ffem,
    required this.hem,
    required this.onTap,
  });

  final String label;
  final String value;
  final double fem;
  final double ffem;
  final double hem;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          SizedBox(width: 272 * fem, height: 60 * hem),
          Positioned(
            top: 10,
            child: Container(
              width: 272 * fem,
              height: 45 * hem,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28 * fem),
                border: Border.all(
                  width: 2,
                  color: const Color.fromARGB(255, 220, 220, 220),
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(top: 10, left: 25 * fem),
                child: Text(
                  value,
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 15 * ffem,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 2,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 8, right: 13),
              child: Text(
                label,
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 12 * ffem,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({
    required this.enabled,
    required this.fem,
    required this.ffem,
    required this.hem,
    required this.onPressed,
  });

  final bool enabled;
  final double fem;
  final double ffem;
  final double hem;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final label = Text(
      'Lưu thông tin',
      style: GoogleFonts.openSans(
        textStyle: TextStyle(
          fontSize: 17 * ffem,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );

    return TextButton(
      onPressed: enabled ? onPressed : null,
      child: Container(
        width: 220 * fem,
        height: 45 * hem,
        decoration: BoxDecoration(
          color: enabled ? kPrimaryColor : kLowTextColor,
          borderRadius: BorderRadius.circular(23 * fem),
        ),
        child: Center(
          child:
              enabled
                  ? BlocBuilder<StoreBloc, StoreState>(
                    builder:
                        (context, state) =>
                            state is StoreUpding
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                : label,
                  )
                  : label,
        ),
      ),
    );
  }
}
