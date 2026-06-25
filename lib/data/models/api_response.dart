import 'package:equatable/equatable.dart';

class ApiResponse<T> extends Equatable {
  final T result; // sẽ tương ứng với "items"
  final int page; // thay vì currentPage
  final int totalPages; // thay vì pageCount
  final int size; // thay vì pageSize
  final int total; // thay vì totalCount
  // bỏ rowCount vì API không trả về field này

  const ApiResponse({
    required this.result,
    required this.page,
    required this.totalPages,
    required this.size,
    required this.total,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    Function(List<dynamic>) create,
  ) {
    return ApiResponse<T>(
      result: create(json['items']), // đổi từ 'result' thành 'items'
      page: json['page'], // đổi từ 'currentPage' thành 'page'
      totalPages: json['totalPages'], // đổi từ 'pageCount' thành 'totalPages'
      size: json['size'], // đổi từ 'pageSize' thành 'size'
      total: json['total'], // đổi từ 'totalCount' thành 'total'
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['items'] = result; // đổi từ 'result' thành 'items'
    data['page'] = page; // đổi từ 'currentPage' thành 'page'
    data['totalPages'] =
        totalPages; // đổi từ 'pageCount' thành 'totalPages'
    data['size'] = size; // đổi từ 'pageSize' thành 'size'
    data['total'] = total; // đổi từ 'totalCount' thành 'total'
    return data;
  }

  @override
  List<Object?> get props => [
    result,
    page,
    totalPages,
    size,
    total,
  ];
}
