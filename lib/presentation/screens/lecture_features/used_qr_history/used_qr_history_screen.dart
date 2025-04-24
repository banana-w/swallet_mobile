import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:swallet_mobile/presentation/config/constants.dart';
import 'package:swallet_mobile/data/datasource/authen_local_datasource.dart';

class HistoryTabScreen extends StatefulWidget {
  static const String routeName = '/history-tab';

  const HistoryTabScreen({super.key});

  @override
  _HistoryTabScreenState createState() => _HistoryTabScreenState();
}

class _HistoryTabScreenState extends State<HistoryTabScreen> {
  List<QRCodeUsageHistory> _history = [];
  bool _isLoading = false;
  String? _errorMessage;
  int _page = 1;
  int _size = 10;
  bool _hasMore = true;
  String _searchName = '';
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchHistory();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isLoading &&
          _hasMore) {
        _page++;
        _fetchHistory();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchHistory({bool reset = false}) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      if (reset) {
        _history.clear();
        _page = 1;
        _hasMore = true;
        _errorMessage = null;
      }
    });

    try {
      final lecturer = await AuthenLocalDataSource.getLecture();
      final lecturerId = lecturer?.id;
      final token = await AuthenLocalDataSource.getToken(); // Lấy token nếu cần

      if (lecturerId == null) {
        throw Exception('Không tìm thấy ID giảng viên');
      }

      final response = await http.get(
        Uri.parse(
          'https://swallet-api-2025-capstoneproject.onrender.com/api/Lecturer/lecturer/$lecturerId/qr-code-usage-history?page=$_page&size=$_size&searchName=$_searchName',
        ),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> items = data['items'];
        setState(() {
          _history.addAll(
            items.map((item) => QRCodeUsageHistory.fromJson(item)).toList(),
          );
          _hasMore = data['page'] < data['totalPages'];
          _isLoading = false;
        });
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Lỗi khi lấy lịch sử');
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  void _onSearch() {
    setState(() {
      _searchName = _searchController.text.trim();
      _fetchHistory(reset: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double baseHeight = 812;
    double ffem = fem * 0.97;
    double hem = MediaQuery.of(context).size.height / baseHeight;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
            'Lịch sử nhận điểm',
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
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15 * fem),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm theo tên học sinh',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10 * fem),
                    borderSide: BorderSide(color: kPrimaryColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10 * fem),
                    borderSide: BorderSide(color: kPrimaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10 * fem),
                    borderSide: BorderSide(color: kPrimaryColor, width: 2),
                  ),
                ),
                onSubmitted: (_) => _onSearch(),
              ),
            ),
            Expanded(
              child:
                  _errorMessage != null
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Lỗi: $_errorMessage',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  fontSize: 16 * ffem,
                                  fontWeight: FontWeight.w600,
                                  color: kErrorTextColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 20 * hem),
                            ElevatedButton(
                              onPressed: () => _fetchHistory(reset: true),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryColor,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20 * fem,
                                  vertical: 10 * hem,
                                ),
                              ),
                              child: Text(
                                'Thử lại',
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                    fontSize: 16 * ffem,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      : _history.isEmpty && !_isLoading
                      ? Center(
                        child: Text(
                          'Chưa có giao dịch nào',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                      : ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.all(15 * fem),
                        itemCount: _history.length + (_isLoading ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == _history.length && _isLoading) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 20 * hem,
                                ),
                                child: CircularProgressIndicator(
                                  color: kPrimaryColor,
                                ),
                              ),
                            );
                          }
                          final item = _history[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 15 * hem),
                            padding: EdgeInsets.all(15 * fem),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10 * fem),
                              border: Border.all(color: kPrimaryColor),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Học sinh',
                                      style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      item.studentName,
                                      style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                          fontSize: 15 * ffem,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10 * hem),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Số điểm',
                                      style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '+${item.pointsTransferred} điểm',
                                      style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                          fontSize: 15 * ffem,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10 * hem),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Thời gian',
                                      style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      _formatDateTime(item.usedAt),
                                      style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                          fontSize: 15 * ffem,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime datetime) {
    return DateFormat("HH:mm - dd/MM/yyyy").format(datetime.toLocal());
  }
}

class QRCodeUsageHistory {
  final String studentId;
  final String studentName;
  final int pointsTransferred;
  final DateTime usedAt;

  QRCodeUsageHistory({
    required this.studentId,
    required this.studentName,
    required this.pointsTransferred,
    required this.usedAt,
  });

  factory QRCodeUsageHistory.fromJson(Map<String, dynamic> json) {
    return QRCodeUsageHistory(
      studentId: json['studentId'],
      studentName: json['studentName'],
      pointsTransferred: json['pointsTransferred'],
      usedAt: DateTime.parse(json['usedAt']),
    );
  }
}
