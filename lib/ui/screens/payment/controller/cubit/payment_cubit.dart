import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/core/network/api_constant.dart';
import 'package:payment_app/core/network/dio_helper.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  static PaymentCubit get(context) => BlocProvider.of(context);

  Future<void> getAuthToken() async {
    emit(PaymentAuthLoadingState());
    DioHelperPayment.postData(url: ApiConstant.getAuthToken, data: {
      "api_key": ApiConstant.paymentApiKey,
    }).then((value) {
      ApiConstant.paymentFirstToken = value.data["token"];
      print("Token: ${ApiConstant.paymentFirstToken}");
      emit(PaymentAuthSuccessState());
    }).catchError((error) {
      print('Erorr: $error');
      emit(
        PaymentAuthErrorState(error.toString()),
      );
    });
  }

  Future getOrderRegisterationId({
    required String priceOrder,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    emit(PaymentOrderIdLoadingState());
    DioHelperPayment.postData(url: ApiConstant.getOrderId, data: {
      'auth_token': ApiConstant.paymentFirstToken,
      "delivery_needed": "false",
      "amount_cents": priceOrder,
      "currency": "EGP",
      "items": [],
    }).then((value) {
      ApiConstant.paymentOrderId = value.data["id"].toString();
      getPaymentRequest(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        priceOrder: priceOrder,
      );
      emit(PaymentOrderIdSuccessState());
    }).catchError((error) {
      print('Erorr: $error');
      emit(PaymentOrderIdErrorState(error.toString()));
    });
  }

  Future<void> getPaymentRequest({
    required String priceOrder,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    emit(PaymentRequestTokenLoadingState());
    DioHelperPayment.postData(
      url: ApiConstant.getPaymentKeyRequest,
      data: {
        "auth_token": ApiConstant.paymentFirstToken,
        "amount_cents": priceOrder,
        "expiration": 3600,
        "order_id": ApiConstant.paymentOrderId,
        "billing_data": {
          "apartment": "NA",
          "email": email,
          "floor": "NA",
          "first_name": firstName,
          "street": "NA",
          "building": "NA",
          "phone_number": phone,
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": "NA",
          "country": "NA",
          "last_name": lastName,
          "state": "NA"
        },
        "currency": "EGP",
        "integration_id": ApiConstant.integrationIdCard,
        "lock_order_when_paid": "false"
      },
    ).then((value) {
      ApiConstant.paymentFinalToken = value.data['token'];
      emit(PaymentRequestTokenSuccessState());
    }).catchError((error) {
      print('Erorr: $error');
      emit(PaymentRequestTokenErrorState(error.toString()));
    });
  }

  Future getRefCode() async {
    DioHelperPayment.postData(
      url: ApiConstant.getRefCode,
      data: {
        "source": {
          "identifier": "AGGREGATOR",
          "subtype": "AGGREGATOR",
        },
        "payment_token": ApiConstant.paymentFinalToken,
      },
    ).then((value) {
      ApiConstant.refCode = value.data['id'].toString();
      emit(PaymentRefCodeSuccessState());
    }).catchError((error) {
      print('Erorr: $error');
      emit(PaymentRefCodeErrorState(error.toString()));
    });
  }
}
