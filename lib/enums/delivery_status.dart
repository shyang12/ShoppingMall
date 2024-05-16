enum DeliveryStatus {
  // 상태 열거
  waiting('waiting', '배송대기'),
  delivering('delivering', '배송중'),
  delivered('delivered', '배송완료');

  // 생성자
  const DeliveryStatus(this.status, this.statusName);

  final String status;
  final String statusName;

  // 상태 이름 변환
  factory DeliveryStatus.getStatusName(String status) {
    return DeliveryStatus.values.firstWhere((value) => value.status == status,
      orElse: () => DeliveryStatus.waiting);
  }
}