import 'dart:io';
import 'package:submission/models/detail_transaction.dart';
import 'package:supercharged_dart/supercharged_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:submission/models/product.dart';
import 'package:submission/models/transaction.dart' as trans_model;
import 'package:submission/providers/providers.dart';
import 'package:submission/services/services.dart';
import 'package:submission/shared/shared.dart';
import 'package:submission/ui/layouts/layouts.dart';
import 'package:submission/ui/widgets/widgets.dart';

part 'auth/login_page.dart';
part 'auth/register_page.dart';
part 'auth/reset_password_page.dart';
part 'auth/register_success_page.dart';

part 'main_route/main_route.dart';

part 'main_menu/cashier_page.dart';
part 'main_menu/category_page.dart';
part 'main_menu/product_page.dart';
part 'main_menu/history_page.dart';

part 'category_page/category_form_page.dart';

part 'product_page/product_form_page.dart';
part 'product_page/product_form_edit_page.dart';

part 'history_page/detail_history_page.dart';