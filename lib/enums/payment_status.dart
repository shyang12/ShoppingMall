enum PaymentStatus {
  // 상태 열거
  waiting('waiting', '입금대기'),
  completed('completed', '결제완료'),
  cancelled('cancelled', '주문취소');

  // 생성자
  const PaymentStatus(this.status, this.statusName);

  final String status;
  final String statusName;

  // 상태 이름 변환
  factory PaymentStatus.getStatusName(String status) {
    return PaymentStatus.values.firstWhere((value) => value.status == status,
      orElse: () => PaymentStatus.waiting);
  }
}