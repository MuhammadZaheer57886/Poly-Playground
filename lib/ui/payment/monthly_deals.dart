import 'package:flutter/material.dart';
import '../../model/user_model.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_strings.dart';
import 'continue_button.dart';

class MonthlyDeals extends StatefulWidget {
  const MonthlyDeals({Key? key}) : super(key: key);

  @override
  MonthlyDealsState createState() => MonthlyDealsState();
}

class MonthlyDealsState extends State<MonthlyDeals> {
  late List<DealModel> _offers;
  late String _selectedAmount;

@override
  void initState() {
    _offers = [
      DealModel(
        duration: '3 Month',
        discount: '',
        price: '\$ 9.99/mo',
        selected: false,
      ),
      DealModel(
        duration: '6 Months',
        price: '\$ 5.99/mo',
        discount: 'Save 36%',
        selected: false,
      ),
      DealModel(
        duration: '1 Month',
        price: '\$ 14.99/mo',
        discount: '',
        selected: false,
      ),
    ];

    _selectedAmount = _offers[0].price;
    print(_selectedAmount);

    super.initState();
  }

  void _onDealSelected(int index) {
    setState(() {
    _selectedAmount = _offers[index].price;
      for (int i = 0; i < _offers.length; i++) {
        _offers[i].selected = i == index;
            } 
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 0; i<_offers.length; i++)
              GestureDetector(
                onTap: () => _onDealSelected(i),
                child: Container(
                  width: 100,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: _offers[i].selected
                        ? AppColors.i.brownColor
                        : Colors.white,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const WidgetSpan(
                            child: SizedBox(height: 50, width: 40)),
                        TextSpan(
                          text: '${_offers[i].duration.split(" ")[0]}\n',
                          style: TextStyle(
                            color: _offers[i].selected
                                ? Colors.white
                                : AppColors.i.brownColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 30,
                          ),
                        ),
                        const WidgetSpan(
                            child: SizedBox(height: 20, width: 20)),
                        TextSpan(
                          text: '${_offers[i].duration.split(" ")[1]}\n',
                          style: TextStyle(
                            color: _offers[i].selected
                                ? Colors.white
                                : AppColors.i.blackColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        const WidgetSpan(
                            child: SizedBox(height: 30, width: 15)),
                        TextSpan(
                          text: _offers[i].price,
                          style: TextStyle(
                            color: _offers[i].selected
                                ? Colors.white
                                : AppColors.i.blackColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        if (_offers[i].discount != null)
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Text(
                                _offers[i].discount,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 238, 194, 20),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: size.width * 0.8,
          child: Text(
            AppStrings.i.paymentComment,
            style: TextStyle(
              color: AppColors.i.whiteColor,
              fontWeight: FontWeight.w700,
              fontSize: size.width * 0.03,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: size.height * 0.03),
        ContinueButton( selectedAmount: _selectedAmount),
        
      ],
    );
  }
}
