import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:submission/models/detail_transaction.dart';
import 'package:submission/models/product.dart';
import 'package:submission/models/transaction.dart';
import 'package:submission/models/user_model.dart';
import 'package:submission/providers/providers.dart';
import 'package:submission/ui/pages/pages.dart';
import 'firebase_options.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  // Register Adapter Hive
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(DetailTransactionAdapter());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(create: (context) => LoginProvider()),
        ChangeNotifierProvider<RegisterProvider>(create: (context) => RegisterProvider()),
        ChangeNotifierProvider<ResetPasswordProvider>(create: (context) => ResetPasswordProvider()),
        ChangeNotifierProvider<CashierProvider>(create: (context) => CashierProvider()),
        ChangeNotifierProvider<ProductProvider>(create: (context) => ProductProvider()),
        ChangeNotifierProvider<HistoryProvider>(create: (context) => HistoryProvider())
      ],
      child: GetMaterialApp(
        builder: EasyLoading.init(),
        title: 'Kasir UMKM',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FirebaseAuth.instance.currentUser != null ? MainRoute() : LoginPage()
      ),
    );
  }
}