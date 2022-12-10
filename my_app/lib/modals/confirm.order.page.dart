// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_app/widgets/break.line.widget.dart';
import 'package:my_app/widgets/radio.btn.widget.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:http/http.dart' as http;
import '../widgets/delivery.type.btn.widget.dart';

class ConfirmOrderPage extends StatefulWidget {
  const ConfirmOrderPage({super.key});

  @override
  State<ConfirmOrderPage> createState() => _ConfirmOrderPageState();
}

enum PayMethod { creditCard, cash }

enum DeliveryService { inPerson, delivery }

// ignore: non_constant_identifier_names
Future<double?> GetShekelRate() async {
  var url = 'https://www.floatrates.com/daily/usd.json';

  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    var shekelRate = double.tryParse(jsonResponse['ils']['rate'].toString());
    return shekelRate!;
  } else {
    return null;
  }
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  var sign = '₪';
  int isShekel = 0;
  double foodPrice = 175;
  double deliveryPrice = 20;
  double totalPrice = 195;
  PayMethod _payMethodType = PayMethod.cash;
  DeliveryService _deliveryService = DeliveryService.delivery;
  void updateVariablesStates(index) async {
    double? shekelRate = await GetShekelRate();
    setState(() {
      isShekel = index!;
      sign = isShekel == 0 ? '₪' : "\$";
      if (index == 0) {
        deliveryPrice = deliveryPrice * shekelRate!;
        foodPrice = foodPrice * shekelRate;
        totalPrice = totalPrice * shekelRate;
      } else {
        deliveryPrice = deliveryPrice / shekelRate!;
        foodPrice = foodPrice / shekelRate;
        totalPrice = totalPrice / shekelRate;
      }
    });
  }

  void updatePayMethod(value) {
    setState(() {
      _payMethodType = value!;
    });
  }

  void updateDeliveryType(DeliveryService deliveryService) {
    setState(() {
      _deliveryService = deliveryService;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
            child: Column(
              children: [
                const Text("تاكيد الطلبيه",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                BreakLine(),
                Column(
                  children: [
                    Text(
                      "طريقه الدفع",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: RadioListTile<PayMethod>(
                                value: PayMethod.cash,
                                groupValue: _payMethodType,
                                onChanged: (PayMethod? value) {
                                  updatePayMethod(value!);
                                },
                              ),
                            ),
                            RadioBtnWidget(
                                icon:
                                    "https://cdn2.iconfinder.com/data/icons/credit-cards-6/156/visa-512.png",
                                text: "بطاقة إئتمان")
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: RadioListTile<PayMethod>(
                                value: PayMethod.creditCard,
                                groupValue: _payMethodType,
                                onChanged: (PayMethod? value) {
                                  updatePayMethod(value!);
                                },
                              ),
                            ),
                            RadioBtnWidget(
                              icon:
                                  "https://cdn4.iconfinder.com/data/icons/stack-of-coins/100/coin-01-512.png",
                              text: "نقدي",
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                BreakLine(),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            updateDeliveryType(DeliveryService.delivery);
                          },
                          child: DeliveryTypeBtnWidget(
                            bgColor:
                                _deliveryService == DeliveryService.delivery
                                    ? Colors.orange
                                    : Colors.indigo,
                            icon:
                                "https://cdn4.iconfinder.com/data/icons/logistics-and-shipping-5/85/scooter_delivery_box_package-512.png",
                            text: "خدمة التوصيل",
                            isSelected:
                                _deliveryService == DeliveryService.delivery,
                          ),
                        )),
                    const SizedBox(width: 10),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            updateDeliveryType(DeliveryService.inPerson);
                          },
                          child: DeliveryTypeBtnWidget(
                            bgColor:
                                _deliveryService == DeliveryService.inPerson
                                    ? Colors.orange
                                    : Colors.indigo,
                            icon:
                                "https://cdn4.iconfinder.com/data/icons/shopping-350/512/hand-shopping-bag-sale-buy-512.png",
                            text: "إستلام بشكل شخصي",
                            isSelected:
                                _deliveryService == DeliveryService.inPerson,
                          ),
                        ))
                  ],
                ),
                BreakLine(),
                Container(
                  padding: EdgeInsets.only(right: 15, left: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ToggleSwitch(
                              minWidth: 90.0,
                              cornerRadius: 20.0,
                              fontSize: 15.0,
                              activeBgColors: [
                                [Colors.indigo[800]!],
                                [Colors.indigo[800]!]
                              ],
                              activeFgColor: Colors.white,
                              inactiveBgColor: Colors.grey,
                              inactiveFgColor: Colors.white,
                              initialLabelIndex:
                                  int.tryParse(isShekel.toString()),
                              totalSwitches: 2,
                              labels: const ['₪', '\$'],
                              radiusStyle: true,
                              onToggle: (index) {
                                updateVariablesStates(index);
                              }),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(foodPrice.toStringAsFixed(2) + sign,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text('تكلفة الطلبية',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black54)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(deliveryPrice.toStringAsFixed(2) + sign,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text('تكلفة التوصيل',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black54)),
                        ],
                      ),
                      BreakLine(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(totalPrice.toStringAsFixed(2) + sign,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text('مبلغ الدفع النهائي',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
                BreakLine(),
                Container(
                  padding: EdgeInsets.only(right: 15, left: 15),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          'موقع إرسال الطلبية',
                          style: TextStyle(fontSize: 18, color: Colors.black87),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(Icons.edit),
                        Text(
                          'المكتب',
                          style: TextStyle(fontSize: 18, color: Colors.black87),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.8),
                          borderRadius: BorderRadius.circular(10)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://developers.google.com/static/maps/images/landing/hero_geocoding_api_480.png'),
                        ),
                      ),
                    )
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        minimumSize: const Size(300, 40),
                        textStyle: const TextStyle(fontSize: 30)),
                    onPressed: () {},
                    child: const Text('اضغط هنا لإنهاء الطلبية'),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
