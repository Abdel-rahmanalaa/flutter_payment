import 'package:flutter/material.dart';

//import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/core/components/shared_components.dart';
import 'package:payment_app/core/utils/app_strings.dart';
import 'package:payment_app/ui/screens/payment/controller/cubit/payment_cubit.dart';
import 'package:payment_app/ui/screens/payment/toggle_screen.dart';
import 'package:payment_app/ui/widgets/custom_button.dart';
import 'package:payment_app/ui/widgets/custom_text_form_field.dart';
import 'package:payment_app/ui/widgets/snak_bar.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  TextEditingController firstNameEditingController = TextEditingController();
  TextEditingController lastNameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController priceEditingController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      PaymentCubit()
        ..getAuthToken(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Payment Integration'),
          backgroundColor: Colors.purple.shade400,
          centerTitle: true,
        ),
        body: BlocConsumer<PaymentCubit, PaymentState>(
          listener: (context, state) {
            if (state is PaymentRequestTokenSuccessState) {
              showSnackBar(
                context: context,
                text: 'Success get final token',
                color: Colors.green,
              );
              navigateTo(context, const ToggleScreen());
            }
          },
          builder: (context, state) {
            var cubit = PaymentCubit.get(context);
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/Delivery.png',
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.42,
                    ),
                    Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    controller: firstNameEditingController,
                                    keyboardType: TextInputType.name,
                                    prefix: Icons.person,
                                    hintText: AppStrings.firstName,
                                    validate: _isFirstNameEmptyMethod,
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width *.02,
                                ),
                                Expanded(
                                  child: CustomTextFormField(
                                    controller: lastNameEditingController,
                                    keyboardType: TextInputType.name,
                                    prefix: Icons.person,
                                    hintText: AppStrings.lastName,
                                    validate: _isLastNameEmptyMethod,),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.01,
                            ),
                            CustomTextFormField(
                                controller: emailEditingController,
                                keyboardType: TextInputType.emailAddress,
                                prefix: Icons.email,
                                hintText: AppStrings.email,
                                validate: _isEmailEmptyMethod,),
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.01,
                            ),
                            CustomTextFormField(
                              controller: phoneEditingController,
                              keyboardType: TextInputType.phone,
                              prefix: Icons.phone,
                              hintText: AppStrings.phone,
                              validate: _isPhoneEmptyMethod,),
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.01,
                            ),
                            CustomTextFormField(
                              controller: priceEditingController,
                              keyboardType: TextInputType.number,
                              prefix: Icons.monetization_on,
                              hintText: AppStrings.price,
                              validate: _isPriceEmptyMethod,),
                          ],
                        )),
                    SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.02,
                    ),
                    CustomButton(
                      buttonWidget: const Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          letterSpacing: 1.6,
                        ),
                      ),
                      function: () {
                        if (formKey.currentState!.validate()) {
                          cubit.getOrderRegisterationId(
                            firstName: firstNameEditingController.text,
                            lastName: lastNameEditingController.text,
                            email: emailEditingController.text,
                            phone: phoneEditingController.text,
                            priceOrder: priceEditingController.text,
                          );
                        }
                      },
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      radius: 10.0,
                      backgroundColor: Colors.purple.shade300,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String? _isFirstNameEmptyMethod(String? value) =>
      value!.isEmpty ? 'please enter first name' : null;

  String? _isLastNameEmptyMethod(String? value) =>
      value!.isEmpty ? 'please enter second name' : null;

  String? _isEmailEmptyMethod(String? value) =>
      value!.isEmpty ? 'please enter email' : null;

  String? _isPhoneEmptyMethod(String? value) =>
      value!.isEmpty ? 'please enter phone number' : null;

  String? _isPriceEmptyMethod(String? value) =>
      value!.isEmpty ? 'please enter price' : null;
}
