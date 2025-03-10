import 'package:SnapBuy/Pages/Home.dart';
import 'package:SnapBuy/Saller/AllPages.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeepProvider with ChangeNotifier{
  Color first = Color(0xFFF67952);
  late Locale _appLocale = Locale('en', 'US');

  User user = User(21354,'Mouhamed', 'Bekkouch', DateTime(2003, 07, 31), 'ayoubboursas@gmail.com',0696135644,'Male','ayoubg4','media/portrait-homme-affaires-optimiste-tenue-formelle_1262-3600.jpg');

  Seller sllr = Seller(21231,'Ayoub', 'Boursas', DateTime(2003, 12, 25), 'ayoubboursas25@gmail.com','Male',0696135644,'ayoubg4','media/saller.jpg');

  List<Placemark> userAdress = [];

  List<Order> ords = [
  ];

  List<Order_item> ordr_itelms = [];

  List<Order_item> hist_item = [];


  List<Cart> cart_item = [];

  List<Review> ords_rvws = [];

  List<Promo> prmliste = [

    Promo(11534, 30, 'Get discount for every order, only valid for to day'),
    Promo(1635438, 55, 'Get discount for every order, only valid for to day'),
    Promo(13548, 30, 'Get discount for every order, only valid for to day'),
    Promo(13544, 45, 'Get discount for every order, only valid for to day'),
    Promo(54654, 60, 'jfbs,djbfshdbfsjdghfsjdhgfj')

  ];

  List<Product> prdliste = [
    Product(13548,87956, 'Stan Smith', 1500, ['media/FX7519_01_standard-removebg-preview.png',
    'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 4.9, 1658, 'shoes',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 1000),
    Product(54654,87956, 'Stan Smith', 2000, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 3.8, 1500, 'shoes',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 1000),
    Product(1635438,87956, 'Stan Smith', 2300, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 4.7, 1662, 'shoes',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 1000),
    Product(135438,87956, 'Stan Smith', 1800, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 3.7, 1223, 'shoes',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 1000),
    Product(15348,87956, 'Stan Smith', 1700, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 4.1, 1500, 'clothes',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 1000),
    Product(21354,87956, 'Stan Smith', 2400, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 4.5, 1888, 'clothes',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 1000),
    Product(13544,87956, 'Stan Smith', 2550, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 4.7, 1154, 'clothes',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 1000),
    Product(1534138,5332, 'Stan Smith', 3000, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 4.2, 1500, 'clothes',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 1000),
    Product(153154,5332, 'Stan Smith', 4000, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 4.3, 1995, 'bags',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 0),
    Product(151354,5332, 'Stan Smith', 6500, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 4.7, 1222, 'bags',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 1000),
    Product(13548,5332, 'Stan Smith', 3000, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 4.2, 2045, 'bags',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 0),
    Product(13548,5332, 'Stan Smith', 3500, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 3.6, 1600, 'bags',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 14886),
    Product(15348,5332, 'Stan Smith', 2550, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 3.8, 1546, 'electronics',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 0),
    Product(15486,5332, 'Stan Smith', 1555, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 4.2, 1500, 'electronics',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 0),
    Product(51684,5332, 'Stan Smith', 1220, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 2.9, 1125, 'electronics',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 14886),
    Product(135438,5332, 'Stan Smith', 1600, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 4.1, 1112, 'electronics',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 14886),
    Product(215344,5332, 'Stan Smith', 1450, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 3.8, 1548, 'watches',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 0),
    Product(15348,5332, 'Stan Smith', 1223, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 3.9, 900, 'watches',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 14886),
    Product(15468,5332, 'Stan Smith', 2444, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 4.0, 800, 'watches',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 14886),
    Product(124548,5332, 'Stan Smith', 2335, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 3.1, 300, 'watches',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 14886),
    Product(13544,5332, 'Stan Smith', 2154, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 3.4, 500, 'jewelry',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 14886),
    Product(11534,5332, 'Stan Smith', 1255, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 4.9, 5455, 'jewelry',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black, Colors.purple], ['40', '41', '42', '43', '44', '45'], 2000, 14886),
    Product(15438,5332, 'Stan Smith', 2356, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 4.2, 1500, 'jewelry',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 14886),
    Product(15435,5332, 'Stan Smith', 12235, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 4.2, 1531, 'jewelry',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 14886),
    Product(15648,5332, 'Stan Smith', 2154, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 4.2, 2153, 'kitchen',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 14886),
    Product(516546,5332, 'Stan Smith', 1888, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 4.9, 1111, 'kitchen',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 14886),
    Product(31355,5332, 'Stan Smith', 3265, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 4.2, 1251, 'kitchen',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 14886),
    Product(165468,5332, 'Stan Smith', 1548, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 4.9, 1315, 'kitchen',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 14886),
    Product(15468,5332, 'Stan Smith', 2127, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 4.7, 1200, 'toys',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 14886),
    Product(9965,5332, 'Stan Smith', 2222, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 4.4, 2154, 'toys',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 14886),
    Product(1111,5332, 'Stan Smith', 1255, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 2.5, 121, 'toys',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 14886),
    Product(789,5332, 'Stan Smith', 1544, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 4.2, 1534, 'toys',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 14886),
    Product(121,5332, 'Stan Smith', 2134, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 4.8, 1354, 'clothes',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 14886),
    Product(152,5332, 'Stan Smith', 2138, ['media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 4.6, 2003, 'shoes',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 0),
    Product(68468,5332, 'Stan Smith', 4789, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 3.6, 1513, 'bags',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 14886),
    Product(4846,5332, 'Stan Smith', 4554, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 4.5, 2315, 'electronics',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 14886),
    Product(121,5332, 'Stan Smith', 1484, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 3.8, 1545, 'watches',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 14886),
    Product(15648,5332, 'Stan Smith', 2154, ['media/FX7519_01_standard-removebg-preview.png',
      'media/FX7519_02_standard_hover-removebg-preview.png',
      'media/FX7519_03_standard-removebg-preview.png',
      'media/FX7519_04_standard-removebg-preview.png',
      'media/FX7519_05_standard-removebg-preview.png',
      'media/FX7519_06_standard-removebg-preview.png',
      'media/FX7519_09_standard-removebg-preview.png',
      'media/FX7519_41_detail-removebg-preview.png',
      'media/FX7519_42_detail-removebg-preview.png'], 3.2, 1000, 'jewelry',
        'jzehzkjefhzjehfkjzhefkzjhefkjzhekfjzhezkjeejfzhkjefxgdfgdgdrgd', false,
        [Colors.red,Colors.white, Colors.black], ['40', '41', '42', '43', '44', '45'], 2000, 0)
  ];

  List<Store> strliste = [
  Store(21231,87956, 'Louis Vuitton', 'media/Nike-Art-City-1024x717-1-q0sr379m5q1a26f05nltoe3sct9yfndmrltr412f1c.png', 'bags',39566),
    Store(2151,5332, 'Nike', 'media/Nike-Art-City-1024x717-1-q0sr379m5q1a26f05nltoe3sct9yfndmrltr412f1c.png', 'kitchen',87998),
    Store(513513,15313, 'Zara', 'media/Nike-Art-City-1024x717-1-q0sr379m5q1a26f05nltoe3sct9yfndmrltr412f1c.png', 'toys',48646),
  /*Store(2131, 'Top Man', 'media/Nike-Art-City-1024x717-1-q0sr379m5q1a26f05nltoe3sct9yfndmrltr412f1c.png', 'clothes', 15132),
    Store(22151, 'Fateh Shop', 'media/Nike-Art-City-1024x717-1-q0sr379m5q1a26f05nltoe3sct9yfndmrltr412f1c.png', 'electronics',89796),
    Store(15313, 'Zara', 'media/Nike-Art-City-1024x717-1-q0sr379m5q1a26f05nltoe3sct9yfndmrltr412f1c.png', 'toys',48646),
    Store(5332, 'Nike', 'media/Nike-Art-City-1024x717-1-q0sr379m5q1a26f05nltoe3sct9yfndmrltr412f1c.png', 'kitchen',87998),
    Store(351869, 'Puma', 'media/Nike-Art-City-1024x717-1-q0sr379m5q1a26f05nltoe3sct9yfndmrltr412f1c.png', 'watches',66584),
    Store(87956, 'Louis Vuitton', 'media/Nike-Art-City-1024x717-1-q0sr379m5q1a26f05nltoe3sct9yfndmrltr412f1c.png', 'bags',39566),*/
/*    Store(54681, 'Louis Vuitton', 'media/Nike-Art-City-1024x717-1-q0sr379m5q1a26f05nltoe3sct9yfndmrltr412f1c.png', 'bags',39566),
    Store(54681, 'Louis Vuitton', 'media/Nike-Art-City-1024x717-1-q0sr379m5q1a26f05nltoe3sct9yfndmrltr412f1c.png', 'bags',39566),
    Store(54681, 'Louis Vuitton', 'media/Nike-Art-City-1024x717-1-q0sr379m5q1a26f05nltoe3sct9yfndmrltr412f1c.png', 'bags',39566),
    Store(54681, 'Louis Vuitton', 'media/Nike-Art-City-1024x717-1-q0sr379m5q1a26f05nltoe3sct9yfndmrltr412f1c.png', 'bags',39566),
    Store(54681, 'Louis Vuitton', 'media/Nike-Art-City-1024x717-1-q0sr379m5q1a26f05nltoe3sct9yfndmrltr412f1c.png', 'bags',39566),
    Store(54681, 'Louis Vuitton', 'media/Nike-Art-City-1024x717-1-q0sr379m5q1a26f05nltoe3sct9yfndmrltr412f1c.png', 'bags',39566),
    Store(54681, 'Louis Vuitton', 'media/Nike-Art-City-1024x717-1-q0sr379m5q1a26f05nltoe3sct9yfndmrltr412f1c.png', 'bags',39566),*/
  ];


  List<PromoCode> CodePromo = [
    PromoCode(213515, 'abcd123', 30),
    PromoCode(468468, 'ayoub14', 10),
    PromoCode(56848, 'ahmed5', 20),
    PromoCode(2121, 'ziyani10', 5),
    PromoCode(0004, 'xxxxx10', 70),
  ];


  Locale get appLocale => _appLocale;

  void setAppLocale(Locale locale) {
    _appLocale = locale;
    notifyListeners();
  }
  Future<void> _loadLocale() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final languageCode = preferences.getString('languageCode') ?? 'en';
    final countryCode = preferences.getString('countryCode') ?? 'US';
    _appLocale = Locale(languageCode, countryCode);
    notifyListeners();
  }

  Future<void> setLocale(Locale newLocale) async {
    _appLocale = newLocale;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('languageCode', newLocale.languageCode);
    await preferences.setString('countryCode', newLocale.countryCode ?? '');
    notifyListeners();
  }

  Future<void> saveFvrt() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final favIds = prdliste.where((e) => e.fav).map((e) => e.id).toList();

    final favIdsAsString = favIds.join(',');
    preferences.setString('favList', favIdsAsString);
  }

  Future<void> loadFvrt() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final favListAsString = preferences.getString('favList') ?? '';
    final favIds = favListAsString.split(',');

    prdliste.forEach((e) {
      if (favIds.contains(e.id.toString())) {
        e.fav = true;
      } else {
        e.fav = false;
      }
    });
  }

  KeepProvider() {
    _loadLocale();
    loadFvrt();
  }

}