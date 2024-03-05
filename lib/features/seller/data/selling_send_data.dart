import 'dart:convert';

String jsonData = '{"orders": [...], "formData": {...}, "payments": [...]}';
Map<String, dynamic> jsonMap = json.decode(jsonData);

List<dynamic> ordersJson = jsonMap['orders'];
Map<String, dynamic> formDataJson = jsonMap['formData'];
List<dynamic> paymentsJson = jsonMap['payments'];

List<SellingOrder> ordersWithoutId = ordersJson.map((orderJson) {
  return SellingOrder(
    model: orderJson['model'],
    tissue: orderJson['tissue'],
    title: orderJson['title'],
    price: orderJson['price'],
    sale: orderJson['sale'],
    qty: orderJson['qty'],
    sum: orderJson['sum'],
    cathegory: orderJson['cathegory'],
  );
}).toList();

List<SellingOrder> ordersWithId = ordersJson.map((orderJson) {
  return SellingOrder(
    id: orderJson['id'],
    orderId: orderJson['orderId'],
    model: orderJson['model'],
    tissue: orderJson['tissue'],
    title: orderJson['title'],
    price: orderJson['price'],
    sale: orderJson['sale'],
    qty: orderJson['qty'],
    sum: orderJson['sum'],
    cathegory: orderJson['cathegory'],
  );
}).toList();

SellingFormData formData = SellingFormData(
  id: formDataJson['id'],
  clientName: formDataJson['clientName'],
  phone: formDataJson['phone'],
  whereFrom: formDataJson['whereFrom'],
  status: formDataJson['status'],
  deliveryDate: formDataJson['deliveryDate'],
);

List<SellingPayment> payments = paymentsJson.map((paymentJson) {
  return SellingPayment(
    id: paymentJson['id'],
    paymentType: paymentJson['payment_type'],
    paymentSum: paymentJson['payment_sum'],
    payment$: paymentJson['payment_\$'],
    kurs: paymentJson['kurs'],
    amountByKurs: paymentJson['amount_by_kurs'],
    change: paymentJson['change'],
    totalSum: paymentJson['total_sum'],
    restMoney: paymentJson['rest_money'],
    walletId: paymentJson['wallet_id'],
  );
}).toList();

class SellingOrder {
  String model;
  String? id;
  String? orderId;
  String tissue;
  String title;
  int price;
  int sale;
  int qty;
  int sum;
  String cathegory;

  SellingOrder({
    this.id,
    this.orderId,
    required this.model,
    required this.tissue,
    required this.title,
    required this.price,
    required this.sale,
    required this.qty,
    required this.sum,
    required this.cathegory,
  });
}

class SellingFormData {
  String id;
  String clientName;
  String phone;
  String whereFrom;
  String status;
  String deliveryDate;

  SellingFormData({
    required this.id,
    required this.clientName,
    required this.phone,
    required this.whereFrom,
    required this.status,
    required this.deliveryDate,
  });
}

class SellingPayment {
  int id;
  String paymentType;
  int paymentSum;
  int payment$;
  int kurs;
  int amountByKurs;
  int change;
  int totalSum;
  int restMoney;
  String walletId;

  SellingPayment({
    required this.id,
    required this.paymentType,
    required this.paymentSum,
    required this.payment$,
    required this.kurs,
    required this.amountByKurs,
    required this.change,
    required this.totalSum,
    required this.restMoney,
    required this.walletId,
  });
}

class ApiData {
  List<SellingOrder> orders;
  SellingFormData formData;
  List<SellingPayment> payments;

  ApiData({
    required this.orders,
    required this.formData,
    required this.payments,
  });
}


