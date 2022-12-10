import 'package:flutter/material.dart';
import 'package:my_app/modals/confirm.order.modal.dart';
import 'package:my_app/modals/item.details.modal.dart';

ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.indigo[700],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(13), // <-- Radius
    ),
    minimumSize: const Size(300, 40),
    textStyle: const TextStyle(fontSize: 30));

@override
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            style: buttonStyle,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) =>
                    //my modal
                    const ConfirmOrderPage(),
              );
            },
            child: const Text('Confirm Order'),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: buttonStyle,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) =>
                    //my modal
                    const ItemDetailsPage(),
              );
            },
            child: const Text('Order Details'),
          ),
        ],
      ),
    );
  }
}
