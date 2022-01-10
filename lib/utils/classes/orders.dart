// Main Class
class Order {
  final int id;
  final Invoice invoice;
  final Family family;

  Order({
    required this.id,
    required this.invoice,
    required this.family,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      invoice: Invoice.fromJson(json['invoice']),
      family: Family.fromJson(json['family']),
    );
  }
}

class Invoice {
  final String invoiceNumber;

  Invoice({required this.invoiceNumber});

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      invoiceNumber: json['invoice_number'].toString(),
    );
  }
}

class Family {
  final String? lastName;

  Family({required this.lastName});

  factory Family.fromJson(Map<String, dynamic> json) {
    return Family(
      lastName: json['name_on_stone'],
    );
  }
}
