import 'package:flutter/material.dart';

void main() {
  runApp(const PaymentGatewayApp());
}
class PaymentGatewayApp extends StatelessWidget {
  const PaymentGatewayApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Payment Gateway',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PaymentGatewayScreen(),
    );
  }
}

class PaymentGatewayScreen extends StatefulWidget {
  const PaymentGatewayScreen({Key? key}) : super(key: key);

  @override
  State<PaymentGatewayScreen> createState() => _PaymentGatewayScreenState();
}

class _PaymentGatewayScreenState extends State<PaymentGatewayScreen> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardHolderNameController = TextEditingController();
  final TextEditingController _upiController = TextEditingController();

  bool _isCardPayment = true;
  String? _selectedUpiApp;

  void _processPayment() {
    if (_isCardPayment) {
      // Validate card details
      if (_cardNumberController.text.isEmpty ||
          _expiryDateController.text.isEmpty ||
          _cvvController.text.isEmpty ||
          _cardHolderNameController.text.isEmpty) {
        _showErrorDialog('Please fill all card details.');
      } else {
        _showSuccessDialog('Your card payment has been processed successfully!');
      }
    } else {
      // Validate UPI details
      if (_selectedUpiApp == null || _upiController.text.isEmpty) {
        _showErrorDialog('Please select a UPI app and enter your UPI ID.');
      } else {
        _showSuccessDialog('Your UPI payment has been processed successfully!');
      }
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Payment Confirmation'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Gateway'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Payment Method',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text('Card Payment'),
                      leading: Radio<bool>(
                        value: true,
                        groupValue: _isCardPayment,
                        onChanged: (value) {
                          setState(() {
                            _isCardPayment = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('UPI Payment'),
                      leading: Radio<bool>(
                        value: false,
                        groupValue: _isCardPayment,
                        onChanged: (value) {
                          setState(() {
                            _isCardPayment = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (_isCardPayment) ...[
                TextField(
                  controller: _cardNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Card Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _expiryDateController,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          labelText: 'Expiry Date (MM/YY)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _cvvController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'CVV',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _cardHolderNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Card Holder Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ] else ...[
                DropdownButtonFormField<String>(
                  value: _selectedUpiApp,
                  items: [
                    'Google Pay',
                    'PhonePe',
                    'Paytm',
                    'Amazon Pay',
                    'BHIM UPI',
                  ].map((app) {
                    return DropdownMenuItem<String>(
                      value: app,
                      child: Text(app),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedUpiApp = value!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Select UPI App',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _upiController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'UPI ID',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _processPayment,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Pay Now',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}