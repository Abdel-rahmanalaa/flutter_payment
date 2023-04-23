import 'package:flutter/material.dart';
import 'package:payment_app/ui/screens/register/register_screen.dart';
import 'core/network/dio_helper.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelperPayment.initDio();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: RegisterScreen(),
    );
  }
}
