class LuckyPrize {
  final String id;
  final String prizeName;
  final double probability;
  final int quantity;
  final bool status;
  final int value;

  LuckyPrize({
    required this.id,
    required this.prizeName,
    required this.probability,
    required this.quantity,
    required this.status,
    required this.value,
  });

  factory LuckyPrize.fromJson(Map<String, dynamic> json) {
    // Kiểm tra null và cung cấp giá trị mặc định
    final prizeName = json['prizeName'] as String? ?? 'Unknown Prize';
    final id = json['Id'] as String? ?? '';
    final probability = (json['probability'] as num?)?.toDouble() ?? 0.0;
    final quantity = json['quantity'] as int? ?? 0;
    final status = json['status'] == 1;

    // Tính toán value từ prizeName
    int value = 0;
    if (prizeName.contains('Xu')) {
      final numberPart = prizeName.replaceAll(' Xu', '');
      value = int.tryParse(numberPart) ?? 0;
    }

    return LuckyPrize(
      id: id,
      prizeName: prizeName,
      probability: probability,
      quantity: quantity,
      status: status,
      value: value,
    );
  }
}
