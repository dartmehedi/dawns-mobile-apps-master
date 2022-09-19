import 'package:dawnsapp/Views/invoice/invoiceModel/customer.dart';
import 'package:dawnsapp/Views/invoice/invoiceModel/invoice.dart';
import 'package:dawnsapp/Views/invoice/invoiceModel/supplier.dart';

invoiceLayout(customerName, customerAddress, orderNumber, orderedProducts) {
  final date = DateTime.now();
  return Invoice(
    supplier: const Supplier(
      name: 'DAWN STATIONERY',
      address: '144,MITFORD ROAD, DHAKA',
      paymentInfo: '',
    ),
    customer: Customer(
      name: '$customerName',
      address: '$customerAddress',
    ),
    info: InvoiceInfo(
      date: date,
      // dueDate: '90',
      description: 'My description...',
      number: '$orderNumber',
    ),
    items: [
      for (int i = 0; i < orderedProducts.length; i++)
        InvoiceItem(
          description: '${orderedProducts[i]['productName']}',
          date: date,
          quantity: orderedProducts[i]['quantity'],
          vat: 0.00,
          unitPrice: orderedProducts[i]['singlePrice'].toDouble(),
        ),
      //delivery charge
    ],
  );
}
