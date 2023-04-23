import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/core/components/shared_components.dart';
import 'package:payment_app/core/network/api_constant.dart';
import 'package:payment_app/ui/screens/payment/controller/cubit/payment_cubit.dart';
import 'package:payment_app/ui/screens/payment/ref_code_screen.dart';
import 'package:payment_app/ui/screens/payment/visa_screen.dart';
import 'package:payment_app/ui/widgets/snak_bar.dart';

class ToggleScreen extends StatelessWidget {
  const ToggleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('toggle Screen'),
            centerTitle: true,
          ),
          body: BlocConsumer<PaymentCubit, PaymentState>(
            listener: (context, state) {
              if (state is PaymentRefCodeSuccessState) {
                showSnackBar(
                  context: context,
                  text: "Success get ref code ",
                  color: Colors.amber.shade400,
                );
                navigateTo(context, const ReferenceScreen());
              }
              if (state is PaymentRefCodeErrorState) {
                showSnackBar(
                  context: context,
                  text: "Error get ref code ",
                  color: Colors.red,
                );
              }
            },
            builder: (context, state) {
              var cubit = PaymentCubit.get(context);
              return Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          cubit.getRefCode();
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(15.0),
                            border:
                                Border.all(color: Colors.black87, width: 2.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Image(
                                image: NetworkImage(AppImages.refCodeImage),
                              ),
                              SizedBox(height: 15.0),
                              Text(
                                'Payment with Ref code',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          navigateTo(context, const VisaScreen());
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(color: Colors.black, width: 2.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Image(
                                image: NetworkImage(AppImages.visaImage),
                              ),
                              Text(
                                'Payment with visa',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              );
            },
          )),
    );
  }
}
