import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:google_fonts/google_fonts.dart';

class LuckyWheelScreen extends StatefulWidget {
  const LuckyWheelScreen({super.key});
  static const String routeName = '/lucky-wheel';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const LuckyWheelScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<LuckyWheelScreen> createState() => _LuckyWheelScreenState();
}

class _LuckyWheelScreenState extends State<LuckyWheelScreen> {
  // StreamController để điều khiển vòng quay
  final StreamController<int> _controller = StreamController<int>();
  String _selectedPrize = ''; // Biến lưu kết quả giải thưởng
  bool _isSpinning = false; // Trạng thái vòng quay

  // Danh sách các giải thưởng
  final List<String> prizes = [
    '1000 Xu',
    '5000 Xu',
    '3000 Xu',
    '900 Xu',
    '700 Xu',
    'May mắn lần sau',
    '100 Xu',
    '800 Xu',
  ];

  // Hàm xử lý khi nhấn nút quay
  void _spinWheel() {
    if (!_isSpinning) {
      setState(() {
        _isSpinning = true;
        _selectedPrize = ''; // Reset kết quả trước khi quay
      });

      // Tạo một giá trị ngẫu nhiên để chọn giải thưởng
      final randomIndex = Fortune.randomInt(0, prizes.length);
      _controller.add(randomIndex);

      // Giả lập thời gian quay (4 giây) trước khi hiển thị kết quả
      Future.delayed(const Duration(seconds: 4), () {
        setState(() {
          _selectedPrize = prizes[randomIndex];
          _isSpinning = false;
        });

        // Hiển thị thông báo kết quả
        _showResultDialog();
      });
    }
  }

  // Hiển thị dialog kết quả
  void _showResultDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'Kết quả',
              style: GoogleFonts.openSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            content: Text(
              _selectedPrize.isNotEmpty
                  ? 'Chúc mừng! Bạn đã nhận được: $_selectedPrize'
                  : 'Đang quay...',
              style: GoogleFonts.openSans(fontSize: 16),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'OK',
                  style: GoogleFonts.openSans(fontSize: 16, color: Colors.blue),
                ),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    _controller.close(); // Đóng StreamController khi widget bị hủy
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    double baseHeight = 812;
    double hem = MediaQuery.of(context).size.height / baseHeight;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Vòng Quay May Mắn',
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontSize: 22 * ffem,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Vòng quay may mắn
              Container(
                width: 300 * fem,
                height: 300 * fem,
                child: FortuneWheel(
                  selected: _controller.stream,
                  items:
                      prizes
                          .asMap()
                          .entries
                          .map(
                            (entry) => FortuneItem(
                              child: Text(
                                entry.value,
                                style: GoogleFonts.openSans(
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              style: FortuneItemStyle(
                                color:
                                    entry.key % 2 == 0
                                        ? Colors.yellow
                                        : Colors.redAccent,
                                borderColor: Colors.black,
                                borderWidth: 2,
                              ),
                            ),
                          )
                          .toList(),
                  onAnimationEnd: () {
                    // Được gọi khi vòng quay dừng lại
                    setState(() {
                      _isSpinning = false;
                    });
                  },
                ),
              ),
              SizedBox(height: 30 * hem),
              // Nút quay
              ElevatedButton(
                onPressed: _isSpinning ? null : _spinWheel,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(
                    horizontal: 40 * fem,
                    vertical: 15 * hem,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30 * fem),
                  ),
                ),
                child: Text(
                  _isSpinning ? 'Đang quay...' : 'QUAY',
                  style: GoogleFonts.openSans(
                    fontSize: 18 * ffem,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20 * hem),
              // Hiển thị kết quả (nếu có)
              if (_selectedPrize.isNotEmpty)
                Text(
                  'Kết quả: $_selectedPrize',
                  style: GoogleFonts.openSans(
                    fontSize: 16 * ffem,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
