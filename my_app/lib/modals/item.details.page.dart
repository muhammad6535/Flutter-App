import 'package:flutter/material.dart';
import 'package:counter/counter.dart';
import 'package:my_app/widgets/break.line.widget.dart';

class ItemDetailsPage extends StatefulWidget {
  const ItemDetailsPage({super.key});

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

enum CockingType { salat, cocking }

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  CockingType _cockingTpye = CockingType.salat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21),
                      border: Border.all(
                        color: Colors.yellow,
                        width: 1.5,
                      )),
                  height: 270,
                  width: 350,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: const Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://img.etimg.com/thumb/msid-95423731,width-650,imgsize-56196,,resizemode-4,quality-100/tomatoes-canva.jpg'),
                    ),
                  ))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 200,
                  width: 350,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(21),
                      border: Border.all(
                        color: Colors.yellow,
                        width: 1.5,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Counter(
                                    min: 1,
                                    max: 20,
                                    bound: 1,
                                    step: 1,
                                  ),
                                ),
                                const Text(
                                  "كيلو غرام",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black54),
                                )
                              ],
                            ),
                            const Text(
                              "بندورة",
                              style: TextStyle(
                                  fontSize: 23, color: Colors.black54),
                            )
                          ],
                        ),
                        const BreakLine(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 30,
                              height: 50,
                              child: RadioListTile<CockingType>(
                                value: CockingType.salat,
                                groupValue: _cockingTpye,
                                onChanged: (CockingType? value) {
                                  setState(() {
                                    _cockingTpye = value!;
                                  });
                                },
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 1),
                              child: Text(
                                "للسلطة",
                                style: TextStyle(
                                    fontSize: 25, color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 30,
                              height: 50,
                              child: RadioListTile<CockingType>(
                                value: CockingType.cocking,
                                groupValue: _cockingTpye,
                                onChanged: (CockingType? value) {
                                  setState(() {
                                    _cockingTpye = value!;
                                  });
                                },
                              ),
                            ),
                            const Text(
                              "للطبيخ",
                              style: TextStyle(
                                  fontSize: 25, color: Colors.black54),
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
