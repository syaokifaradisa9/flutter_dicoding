import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:submission/models/detail_transaction.dart';
import 'package:submission/models/product.dart';
import 'package:submission/models/transaction.dart' as trans_model;
import 'package:submission/models/user_model.dart';
import 'package:submission/shared/shared.dart';
import 'package:submission/ui/pages/pages.dart';
import 'package:path/path.dart' as path;

part 'auth_service.dart';
part 'user_service.dart';
part 'product_service.dart';
part 'category_service.dart';
part 'image_service.dart';
part 'transaction_service.dart';