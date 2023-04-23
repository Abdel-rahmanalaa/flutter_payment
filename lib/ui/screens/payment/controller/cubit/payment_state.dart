part of 'payment_cubit.dart';

@immutable
abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentAuthLoadingState extends PaymentState {}

class PaymentAuthSuccessState extends PaymentState {}

class PaymentAuthErrorState extends PaymentState {
  final String error;
  PaymentAuthErrorState(this.error);
}

class PaymentOrderIdLoadingState extends PaymentState {}

class PaymentOrderIdSuccessState extends PaymentState {}

class PaymentOrderIdErrorState extends PaymentState {
  final String error;
  PaymentOrderIdErrorState(this.error);
}

class PaymentRequestTokenLoadingState extends PaymentState {}

class PaymentRequestTokenSuccessState extends PaymentState {}

class PaymentRequestTokenErrorState extends PaymentState {
  final String error;
  PaymentRequestTokenErrorState(this.error);
}

class PaymentRefCodeLoadingState extends PaymentState {}

class PaymentRefCodeSuccessState extends PaymentState {}

class PaymentRefCodeErrorState extends PaymentState {
  final String error;
  PaymentRefCodeErrorState(this.error);
}
