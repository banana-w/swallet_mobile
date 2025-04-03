import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

const kAnimationDuration = Duration(milliseconds: 200);

//colors
const kPrimaryColor = Color(0xff2ecc71);
const klightPrimaryColor = Color(0xff83f28f);
const kDarkPrimaryColor = Color(0xff1d4d4f);
const kLowTextColor = Color(0xff989da3);
const klowTextGrey = Color(0xfff4b5563);
const kbgWhiteColor = Color.fromARGB(255, 246, 242, 250);
const klighGreyColor = Color(0xffececf1);
const kErrorTextColor = Color(0xffba1c1c);
const kbgYellow = Color(0xfffffbe6);
const kYellow = Color(0xfffaad14);
//strings
const String baseURL = 'https://swallet-api-2025-capstoneproject.onrender.com/api/';

//RegExp
final RegExp emailValidationRegExp = RegExp(
  r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
);

final RegExp textOnlyPattern = RegExp(r'^[a-zA-Z ]+$');

final RegExp vietNameseTextOnlyPattern = RegExp(
  r'^[a-zA-ZÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễếệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ ]+$',
);

final RegExp passwordPattern = RegExp(
  r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
);

final RegExp userNamePattern = RegExp(r'^(?=.*[a-z0-9])[a-z0-9]{5,50}$');

final RegExp phoneNumberPattern = RegExp(r'^\d{9}$');

final RegExp numberRegExp = RegExp(r'^[0-9]+$');
//response failed from api
final String invalidStudentCode = '["Student code is already in use"]';

//function
String changeFormateDate(String dateTime) {
  DateTime formatDate = DateTime.parse(dateTime);
  String formattedDate = DateFormat('dd/MM/yyyy').format(formatDate);
  return formattedDate;
}

//format
var formatter = NumberFormat.decimalPattern();

TimeOfDay parseTimeString(String timeString) {
  // Splitting the time string by ":" and converting the parts to integers
  List<String> parts = timeString.split(":");
  int hour = int.parse(parts[0]);
  int minute = int.parse(parts[1]);

  // Creating a TimeOfDay instance
  return TimeOfDay(hour: hour, minute: minute);
}

String timeOfDayToString(TimeOfDay timeOfDay) {
  // Format the TimeOfDay object into a string
  return '${timeOfDay.hour}:${timeOfDay.minute}';
}

Color checkColorState(String stateName) {
  if (stateName == 'Đã hủy') {
    return Colors.red;
  } else {
    return kPrimaryColor;
  }
}

IndicatorStyle checkIndicatorStyle(String stateName) {
  if (stateName == 'Đã hủy') {
    return IndicatorStyle(
      width: 50,
      height: 50,
      indicator: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.red[200],
        ),
        child: Icon(Icons.cancel_outlined, color: Colors.red, size: 25),
      ),
    );
  } else {
    return IndicatorStyle(
      width: 50,
      height: 50,
      indicator: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromARGB(255, 178, 247, 180),
        ),
        child: Icon(Icons.check_rounded, color: kPrimaryColor, size: 25),
      ),
    );
  }
}
