class EstimateRequestDTO {
  final int id;
  final String userId;
  final int boxLength;
  final int boxWidth;
  final int boxHeight;
  final int quantity;
  final String status;
  final DateTime requestedDate;
  final int quoteReceived;
  final int year;
  final int month;
  final int day;

  EstimateRequestDTO({
    required this.id,
    required this.userId,
    required this.boxLength,
    required this.boxWidth,
    required this.boxHeight,
    required this.quantity,
    required this.status,
    required this.requestedDate,
    required this.quoteReceived,
    required this.year,
    required this.month,
    required this.day,
  });

  factory EstimateRequestDTO.fromJson(Map<String, dynamic> json) {
    return EstimateRequestDTO(
      id: json['id'] is int ? json['id'] : int.parse(json['id']),
      userId: json['userId'],
      boxLength: json['boxLength'] is int ? json['boxLength'] : int.parse(json['boxLength']),
      boxWidth: json['boxWidth'] is int ? json['boxWidth'] : int.parse(json['boxWidth']),
      boxHeight: json['boxHeight'] is int ? json['boxHeight'] : int.parse(json['boxHeight']),
      quantity: json['quantity'] is int ? json['quantity'] : int.parse(json['quantity']),
      status: json['status'],
      requestedDate: DateTime.parse(json['requestedDate']),
      quoteReceived: json['quoteReceived'] is int ? json['quoteReceived'] : int.parse(json['quoteReceived']),
      year: json['year'] is int ? json['year'] : int.parse(json['year']),
      month: json['month'] is int ? json['month'] : int.parse(json['month']),
      day: json['day'] is int ? json['day'] : int.parse(json['day']),
    );
  }
}
