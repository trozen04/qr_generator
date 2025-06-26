import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:qr_code_generator/ApiServices/zen_qr_bloc.dart';
import 'Screens/Splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<QRevixBloc>(create: (context) => QRevixBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QRCodeGenerator',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}