import 'package:currency_converter/shared/components/constants.dart';
import 'package:currency_converter/shared/main_cubit/main_cubit.dart';
import 'package:currency_converter/shared/main_cubit/main_states.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final TextEditingController amountCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    internetConection(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BlocConsumer<MainCubit, MainState>(
        bloc: MainCubit.get(context)..currencyConverter(),
        listener: (context, state) {},
        builder: (context, state) {
          MainCubit ref = MainCubit.get(context);
          return Stack(
            children: [
              // Container(
              //   color: Colors.blue,
              // ),
              Image.asset(
                'lib/assets/background.jpg',
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * .4,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // gradient: LinearGradient(
                            //   begin: Alignment.topCenter,
                            //   end: Alignment.bottomCenter,
                            //   colors: [
                            //     Colors.blue.shade700,
                            //     Colors.blue.shade500,
                            //     Colors.blue.shade300,
                            //   ],
                            // ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownSearch<String>(
                            onChanged: (newValue) async {
                              internetConection(context);
                              await ref.changeFirstSelectedItem(newValue);
                              if (isNetworkConnection) {
                                await ref.currencyConverter(
                                  have: ref.firstSelectedItem,
                                  want: ref.secondSelectedItem,
                                  amount: double.parse(amountCont.text),
                                );
                              }
                            },
                            popupProps: PopupProps.menu(
                              showSelectedItems: true,
                              disabledItemFn: (String s) => s.startsWith('I'),
                            ),
                            items: ref.currencies,
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "From",
                                hintText: "First country",
                              ),
                            ),
                            selectedItem: ref.firstSelectedItem,
                          )),
                      Container(
                          width: MediaQuery.of(context).size.width * .4,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // gradient: LinearGradient(
                            //   begin: Alignment.topCenter,
                            //   end: Alignment.bottomCenter,
                            //   colors: [
                            //     Colors.blue.shade700,
                            //     Colors.blue.shade500,
                            //     Colors.blue.shade300,
                            //   ],
                            // ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownSearch<String>(
                            onChanged: (newValue) async {
                              internetConection(context);
                              await ref.changeSecondSelectedItem(newValue);
                              if (isNetworkConnection) {
                                await ref.currencyConverter(
                                  have: ref.firstSelectedItem,
                                  want: ref.secondSelectedItem,
                                  amount: double.parse(amountCont.text),
                                );
                              }
                            },
                            popupProps: PopupProps.menu(
                              showSelectedItems: true,
                              disabledItemFn: (String s) => s.startsWith('I'),
                            ),
                            items: ref.currencies,
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "To",
                                hintText: "First country",
                              ),
                            ),
                            selectedItem: ref.secondSelectedItem,
                          )),
                    ],
                  ),
                  const SizedBox(height: 40),
                  // ref.time == null || state is LoadingTimeState
                  //     ? const SpinKitHourGlass(
                  //         color: Colors.blue,
                  //         size: 50.0,
                  //       )
                  //     :
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .2),
                    child: TextField(
                      onChanged: (value) async {
                        internetConection(context);
                        if (isNetworkConnection) {
                          await ref.currencyConverter(
                            have: ref.firstSelectedItem,
                            want: ref.secondSelectedItem,
                            amount: double.parse(amountCont.text),
                          );
                        }
                      },
                      // cursorColor: Colors.deepPurple,
                      keyboardType: TextInputType.number,
                      controller: amountCont,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        // border: InputBorder.none,
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Amount',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ref.result['new_amount'] == null
                      ? const SpinKitPulse(
                          color: Colors.white,
                          size: 40,
                        )
                      : Text(
                          ref.result['new_amount'].toString(),
                          style: const TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.w900),
                        ),
                  SizedBox(height: MediaQuery.of(context).size.height * .3),
                ],
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AppBar(
                  title: const Text(
                    'Currency Converter',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.green.shade700,
                        Colors.green.shade500,
                        Colors.green.shade300,
                      ],
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      'Made By Mohamed Sameh',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
