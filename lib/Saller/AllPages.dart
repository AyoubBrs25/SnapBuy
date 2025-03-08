import 'dart:io';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vibration/vibration.dart';
import '../Pages/Home.dart';
import '../Sides/Provider.dart';

class AllSPages extends StatefulWidget {
  const AllSPages({super.key});

  @override
  State<AllSPages> createState() => _AllSPagesState();
}



class _AllSPagesState extends State<AllSPages> {

  List<Widget> pages = [
    SallerHome(),
    MyStore(),
    TheOrders(),
    SellerProfile()
  ];

  late double scrheight;
  late double scrwidth;

  int page_inx = 0;
  late KeepProvider prvd;
  @override
  void initState() {
    super.initState();
    prvd = Provider.of<KeepProvider>(context, listen: false);
  }

  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Theme.of(context).brightness == Brightness.light ? Brightness.dark : Brightness.light,
      statusBarBrightness: Theme.of(context).brightness,
    ));

    scrheight = MediaQuery.of(context).size.height;
    scrwidth = MediaQuery.of(context).size.width;

    return Scaffold(

      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: [
          FontAwesomeIcons.house,
          FontAwesomeIcons.store,
          FontAwesomeIcons.clipboardList,
          FontAwesomeIcons.solidUser
        ],
        backgroundColor: Theme.of(context)
            .colorScheme
            .surface ==
            Color(0xfffef7ff)
            ? Color(0xfffef7ff)
            :Color(0xff141218),
        height: (9.375*scrheight)/100,
        borderWidth: Theme.of(context)
            .colorScheme
            .surface == Color(0xff141218) ? (0.5555*scrwidth)/100 : 0,
        borderColor: Theme.of(context)
            .colorScheme
            .surface == Color(0xff141218) ? Colors.grey.shade300 : Colors.transparent,
        shadow: Shadow(
          color: Color(0x29000000),
          offset: Offset(0, 3),
          blurRadius: 15,
        ),
        splashRadius: 0,
        scaleFactor: 1.3,
        gapWidth: (2.7777*scrwidth)/100,
        iconSize: (5.83333*scrwidth)/100,
        activeColor: prvd.first,
        inactiveColor: Theme.of(context)
            .colorScheme
            .surface ==
            Color(0xfffef7ff)
            ? Colors.black87
            : Color(0xfffef7ff),
        activeIndex: page_inx,
        leftCornerRadius: 30,
        rightCornerRadius: 30,
        gapLocation: GapLocation.none,
        onTap: (v) {
          setState(() {
            page_inx = v;
          });
        },
      ),
      body: pages[page_inx],
    );
  }
}


class SallerHome extends StatefulWidget {
  const SallerHome({super.key});

  @override
  State<SallerHome> createState() => _SallerHomeState();
}

class _SallerHomeState extends State<SallerHome> {
  late double scrheight;
  late double scrwidth;
  late KeepProvider prvd;
  late String imgPrf;
  late DateTime time;
  late String Fullname;
  bool notvsb = true;

  late int sales = 0;
  late int prdct = 0;
  late double revns = 0;
  late int cstmrs = 0;

  late List<Product> bst_prod = [];

  late List<User> clients = [];
  /*List<User> fetchuser(int id) {
    prvd.user.
  }*/

  @override
  void initState() {
    super.initState();
    prvd = Provider.of<KeepProvider>(context, listen: false);
    Fullname = prvd.sllr.firstname + ' ' + prvd.sllr.lastname;
    imgPrf = prvd.sllr.slr_img;

    prvd.hist_item.forEach((e) {
      prvd.strliste.forEach((x) {
        if(e.p.id_store == x.str_id && x.slr_id == prvd.sllr.id){
          sales += (1 * e.qte_p);
        }
      });
    });

    prvd.hist_item.forEach((e) {
      prvd.strliste.forEach((x) {
        if(e.p.id_store == x.str_id && x.slr_id == prvd.sllr.id){
          prdct ++;
        }
      });
    });

    prvd.hist_item.forEach((e) {
      prvd.strliste.forEach((x) {
        if (e.p.id_store == x.str_id && x.slr_id == prvd.sllr.id) {
          if (e.discount > 0) {
            revns += ((e.p.price * e.discount) / 100) * e.qte_p;
          } else {
            revns += (e.p.price * e.qte_p);
          }
        };
      });
    });

    List<int> ids = [];

    prvd.ords.forEach((y) {
      prvd.hist_item.forEach((e) {
        prvd.strliste.forEach((x) {
          if(y.id == e.id_ord && x.str_id == e.p.id_store && x.slr_id == prvd.sllr.id){
            if(!ids.contains(y.id_clnt)){
              ids.add(y.id_clnt);
            }
          }
        });
      });
    });

    cstmrs = ids.length;

    prvd.hist_item.forEach((e) {
      prvd.strliste.forEach((x) {
        if(e.p.id_store == x.str_id && x.slr_id == prvd.sllr.id){
          if(!bst_prod.contains(e.p)){
            bst_prod.add(e.p);
          }
        }
      });
    });

  }


  Widget build(BuildContext context) {

    time = DateTime.now();

    scrheight = MediaQuery.of(context).size.height;
    scrwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        height: scrheight,
        width: scrwidth,
        padding: EdgeInsets.fromLTRB((4.16666*scrwidth)/100, (4.6875*scrheight)/100, (4.16666*scrwidth)/100, 0),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: (6.9444* scrwidth) / 100,
                        backgroundImage: AssetImage(imgPrf),
                      ),
                      SizedBox(
                        width: (2.7777*scrwidth)/100,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            prvd.appLocale.languageCode == 'ar'
                                ? (time.hour >= 15 || time.hour <= 6
                                ? AppLocalizations.of(context)!
                                .afternoon +
                                ' ' +
                                AppLocalizations.of(context)!.gd +
                                '👋'
                                : AppLocalizations.of(context)!
                                .morning +
                                ' ' +
                                AppLocalizations.of(context)!.gd +
                                '👋')
                                : (time.hour >= 15 || time.hour < 6
                                ? AppLocalizations.of(context)!.gd +
                                ' ' +
                                AppLocalizations.of(context)!
                                    .afternoon +
                                '👋'
                                : AppLocalizations.of(context)!.gd +
                                ' ' +
                                AppLocalizations.of(context)!
                                    .morning +
                                '👋'),
                            style: TextStyle(
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.w500,
                                fontSize: (4.1667*scrwidth)/100,
                                color: Colors.grey),
                          ),
                          Text(
                            Fullname,
                            style: TextStyle(
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.w500,
                                fontSize: (6.1111*scrwidth)/100,
                                color: Theme.of(context)
                                    .colorScheme
                                    .surface ==
                                    Color(0xfffef7ff)
                                    ? Colors.black87
                                    : Color(0xfffef7ff),
                                letterSpacing: 0.5),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Stack(
                        alignment: prvd.appLocale.languageCode == 'ar'? Alignment.topLeft : Alignment.topRight,
                        children: [
                          GestureDetector(
                              onTap: () {
                              },
                              child: Icon(
                                EvaIcons.bellOutline,
                                size: (6.9444*scrwidth)/100,
                                color: Theme.of(context)
                                    .colorScheme
                                    .surface ==
                                    Color(0xfffef7ff)
                                    ? Colors.black87
                                    : Color(0xfffef7ff),
                              )
                          ),
                          Visibility(
                            visible: notvsb,
                            child: Container(
                              margin: prvd.appLocale.languageCode == 'ar'? EdgeInsets.only(left: 3): EdgeInsets.only(right: 3),
                              width: (2.5*scrwidth)/100,
                              height: (1.40625*scrheight)/100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: prvd.first
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: (3.125*scrheight)/100,
              ),
              SizedBox(
                width: scrwidth,
                child: Text(
                  AppLocalizations.of(context)!.dash,
                  style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'Kunika',
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context)
                          .colorScheme
                          .surface ==
                          Color(0xfffef7ff)
                          ? Colors.black87
                          : Color(0xfffef7ff)
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: (3.125*scrheight)/100,
              ),
              SizedBox(
                width: scrwidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .surface ==
                                Color(0xfffef7ff)
                                ? Colors.black87
                                : Color(0xfffef7ff),
                            borderRadius: BorderRadius.circular(30)
                          ),
                          width: 155,
                          height: 220,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.chartSimple,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surface ==
                                      Color(0xfffef7ff)
                                      ? Color(0xfffef7ff)
                                      : Colors.black87,
                                  size: 30,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  formatNumber(sales),
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontFamily: 'Kunika',
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface ==
                                          Color(0xfffef7ff)
                                          ? Color(0xfffef7ff)
                                          : Colors.black87
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.sls,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Kunika',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surface ==
                                  Color(0xfffef7ff)
                                  ? Colors.black87
                                  : Color(0xfffef7ff),
                              borderRadius: BorderRadius.circular(30)
                          ),
                          width: 155,
                          height: 180,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.boxesStacked,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surface ==
                                      Color(0xfffef7ff)
                                      ? Color(0xfffef7ff)
                                      : Colors.black87,
                                  size: 30,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  formatNumber(prdct),
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontFamily: 'Kunika',
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface ==
                                          Color(0xfffef7ff)
                                          ? Color(0xfffef7ff)
                                          : Colors.black87
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.prds,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Kunika',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: prvd.first,
                              borderRadius: BorderRadius.circular(30)
                          ),
                          width: 155,
                          height: 180,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.coins,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surface ==
                                      Color(0xfffef7ff)
                                      ? Color(0xfffef7ff)
                                      : Colors.black87,
                                  size: 30,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  formatNumber(revns),
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontFamily: 'Kunika',
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface ==
                                          Color(0xfffef7ff)
                                          ? Color(0xfffef7ff)
                                          : Colors.black87
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.rvns,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Kunika',
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).colorScheme.surface
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surface ==
                                  Color(0xfffef7ff)
                                  ? Colors.black87
                                  : Color(0xfffef7ff),
                              borderRadius: BorderRadius.circular(30)
                          ),
                          width: 155,
                          height: 220,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.users,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surface ==
                                      Color(0xfffef7ff)
                                      ? Color(0xfffef7ff)
                                      : Colors.black87,
                                  size: 30,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  formatNumber(cstmrs),
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontFamily: 'Kunika',
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface ==
                                          Color(0xfffef7ff)
                                          ? Color(0xfffef7ff)
                                          : Colors.black87
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.csmts,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Kunika',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: (3.125*scrheight)/100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.bst_prod,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Kunika',
                      fontSize:
                      (3.28125 * scrheight) / 100,
                      color: Theme.of(context)
                          .colorScheme
                          .surface ==
                          Color(0xfffef7ff)
                          ? Colors.black87
                          : Color(0xfffef7ff),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BetsProducts()));
                    },
                    child: Text(
                      AppLocalizations.of(context)!.see_all,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Kunika',
                        fontSize:
                        (2.8125*scrheight)/100,
                        color: Theme.of(context)
                            .colorScheme
                            .surface ==
                            Color(0xfffef7ff)
                            ? Colors.black87
                            : Color(0xfffef7ff),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                  height: 300,
                  child: bst_prod.length > 1 ? GridView.builder(
                    padding: EdgeInsets.all((1.5625*scrheight)/100),
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.51,
                        crossAxisSpacing: 20
                    ),
                    itemCount: 2,
                    itemBuilder: (context, ind) {
                      return GestureDetector(
                        onTap: () async{
                        },
                        child: Container(
                          padding: EdgeInsets.all((0.3125*scrheight)/100),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  width: (0.416666*scrwidth)/100,
                                  color: Colors.grey.shade300
                              )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all((1.5625*scrheight)/100),
                                    width: (41.6666*scrheight)/100,
                                    height: (23.4375*scrheight)/100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: Colors.grey.shade300,
                                    ),
                                    child: Hero(
                                      tag: bst_prod[ind].images[0],
                                      child: Image(
                                        image: AssetImage('${bst_prod[ind].images[0]}'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: (1.5625*scrheight)/100,
                                    right: (2.7777*scrwidth)/100,
                                    child: GestureDetector(
                                      onTap: () {

                                      },
                                      child: FaIcon(
                                        FontAwesomeIcons.trash,
                                        size: (5.28*scrwidth)/100,
                                        color: Colors.red,
                                      )
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: (1.09375*scrheight)/100),
                              Column(
                                children: [
                                  Text(
                                    bst_prod[ind].name,
                                    style: TextStyle(
                                      fontFamily: 'Kunika',
                                      fontWeight: FontWeight.w500,
                                      fontSize: (6.11*scrwidth)/100,
                                      color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                          ? Colors.black87
                                          : Color(0xfffef7ff),
                                      letterSpacing: 1,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FaIcon(
                                        bst_prod[ind].rate >= 4.9 ? FontAwesomeIcons.solidStar : FontAwesomeIcons.starHalfStroke,
                                        color: prvd.first,
                                        size: (4.72*scrwidth)/100,
                                      ),
                                      SizedBox(width: (1.38888*scrwidth)/100),
                                      Text(
                                        '${bst_prod[ind].rate}',
                                        style: TextStyle(
                                          fontFamily: 'Kunika',
                                          fontWeight: FontWeight.w500,
                                          fontSize: (4.98*scrwidth)/100,
                                          color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                              ? Colors.black87
                                              : Color(0xfffef7ff),
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      SizedBox(width: (1.38888*scrwidth)/100),
                                      Container(
                                        height: (2.5*scrheight)/100,
                                        width: (0.5555*scrwidth)/100,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            color: Colors.grey.shade300
                                        ),
                                      ),
                                      SizedBox(width: (1.38888*scrwidth)/100),
                                      Container(
                                        padding: EdgeInsets.all((0.78125*scrheight)/100),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius: BorderRadius.circular(8)
                                        ),
                                        child: Text(
                                          prvd.appLocale.languageCode == 'en' ? '${bst_prod[ind].sold}'+' '+AppLocalizations.of(context)!.sld : '${bst_prod[ind].sold}' + ' '+ AppLocalizations.of(context)!.sld,
                                          style:  TextStyle(
                                            fontFamily: 'Kunika',
                                            fontWeight: FontWeight.w500,
                                            fontSize: (3.33*scrwidth)/100,
                                            color: Colors.black87,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    prvd.appLocale.languageCode == 'en' ? '${bst_prod[ind].price}'+' '+AppLocalizations.of(context)!.dn : '${bst_prod[ind].price}' + ' '+ AppLocalizations.of(context)!.dn,
                                    style: TextStyle(
                                      fontFamily: 'Kunika',
                                      fontWeight: FontWeight.w500,
                                      fontSize: (4.98*scrwidth)/100,
                                      color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                          ? Colors.black87
                                          : Color(0xfffef7ff),
                                      letterSpacing: 1,
                                    ),
                                  )
                                ],
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () async{
                                    String refresh = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditProduct(prd: bst_prod[ind])));
                                    if(refresh == 'refresh'){
                                      setState(() {});
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color: prvd.first,
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15)
                                      )
                                    ),
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of(context)!.edt,
                                        style: TextStyle(
                                          fontFamily: 'Kunika',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17,
                                          color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                              ? Colors.black87
                                              : Color(0xfffef7ff),
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ): Center(
                    child: Text(
                      AppLocalizations.of(context)!.prd_lss,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Kunika',
                        fontSize:
                        (5.83 * scrwidth) / 100,
                        color: Theme.of(context)
                            .colorScheme
                            .surface ==
                            Color(0xfffef7ff)
                            ? Colors.black87
                            : Color(0xfffef7ff),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
              ),
              SizedBox(
                height: (3.125*scrheight)/100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.bst_cstm,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Kunika',
                      fontSize:
                      (3.28125 * scrheight) / 100,
                      color: Theme.of(context)
                          .colorScheme
                          .surface ==
                          Color(0xfffef7ff)
                          ? Colors.black87
                          : Color(0xfffef7ff),
                    ),
                  ),
                  GestureDetector(
                    child: Text(
                      AppLocalizations.of(context)!.see_all,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Kunika',
                        fontSize:
                        (2.8125*scrheight)/100,
                        color: Theme.of(context)
                            .colorScheme
                            .surface ==
                            Color(0xfffef7ff)
                            ? Colors.black87
                            : Color(0xfffef7ff),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: (15.625*scrheight)/100,
                child: clients.isNotEmpty ? GridView.builder(
                  padding: EdgeInsets.only(top: (1.5625*scrheight)/100),
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.89,
                      crossAxisSpacing: 12
                  ),
                  itemCount: 2,
                  itemBuilder: (context, ind){
                    return Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: (0.416666*scrwidth)/100,
                                color: Colors.grey.shade300
                            ),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Center(
                          child: ListTile(
                            splashColor: Colors.transparent,
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile(cl:clients[ind])));
                            },
                            contentPadding: EdgeInsets.symmetric(horizontal: (2.7777*scrwidth)/100),
                            leading: Container(
                              width: (16.6666*scrwidth)/100,
                              height: (9.375*scrheight)/100,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(clients[ind].user_img),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                            title: Text(
                              clients[ind].firstname + ' ' + clients[ind].lastname,
                              style: TextStyle(
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.w500,
                                fontSize: (5.28*scrwidth)/100,
                                color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                    ? Colors.black87
                                    : Color(0xfffef7ff),
                                letterSpacing: 1,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                    );
                  },
                ) : Center(
                  child: Text(
                    AppLocalizations.of(context)!.cln_null,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Kunika',
                      fontSize:
                      (5.83 * scrwidth) / 100,
                      color: Theme.of(context)
                          .colorScheme
                          .surface ==
                          Color(0xfffef7ff)
                          ? Colors.black87
                          : Color(0xfffef7ff),
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              )
            ],
          )
        ),
      )
    );
  }

  void delet_prod(Product){
    if(prvd.prdliste.contains(Product)){
      prvd.prdliste.remove(Product);
    }
  }

  String formatNumber(var number) {
    if (number >= 10000 && number < 1000000) {
      return (number / 10000).toStringAsFixed(1) + 'K';
    } else if (number >= 1000000 && number < 1000000000) {
      return (number / 1000000).toStringAsFixed(1) + 'M';
    } else if (number >= 1000000000) {
      return (number / 1000000000).toStringAsFixed(1) + 'B';
    } else {
      return number.toString();
    }
  }
}



class BetsProducts extends StatefulWidget {
  const BetsProducts({super.key});

  @override
  State<BetsProducts> createState() => _BetsProductsState();
}

class _BetsProductsState extends State<BetsProducts> {

  late double scrheight;
  late double scrwidth;

  late KeepProvider prvd;

  late List<Product> pprdList = [];

  @override
  void initState() {
    super.initState();


    prvd = Provider.of<KeepProvider>(context, listen: false);

    prvd.hist_item.forEach((e) {
      prvd.strliste.forEach((x) {
        if(e.p.id_store == x.str_id && x.slr_id == prvd.sllr.id){
          if(!pprdList.contains(e.p)){
            pprdList.add(e.p);
          }
        }
      });
    });



  }

  Widget build(BuildContext context) {

    scrheight = MediaQuery.of(context).size.height;
    scrwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:  AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation: 0,
        leading: IconButton(
          style: ButtonStyle(
              overlayColor:
              WidgetStatePropertyAll<Color>(Colors.transparent)),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            prvd.appLocale.languageCode == 'ar'?EvaIcons.arrowIosForward : EvaIcons.arrowIosBack,
            size: (7.5 * scrwidth) / 100,
            color:
            Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                ? Colors.black87
                : Color(0xfffef7ff),
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.bst_prod,
          style: TextStyle(
            fontFamily: 'Kunika',
            fontWeight: FontWeight.bold,
            fontSize: ( 7.78*scrwidth)/100,
            color:
            Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                ? Colors.black87
                : Color(0xfffef7ff),
          ),
        ),
      ),
      body: Container(
        height: scrheight,
        width: scrwidth,
        padding: EdgeInsets.fromLTRB((4.16666*scrwidth)/100, (1.5625*scrheight)/100, (4.16666*scrwidth)/100, (1.5625*scrheight)/100),
        child: SizedBox(
            height: (75*scrheight)/100,
            child: pprdList.length > 1 ? GridView.builder(
              padding: EdgeInsets.only(left: (2.7777*scrwidth)/100, top: (2.34375*scrheight)/100, right: (2.7777*scrwidth)/100, bottom: 0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.51,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20
              ),
              itemCount: pprdList.length,
              itemBuilder: (context, ind) {
                return GestureDetector(
                  onTap: () async{
                  },
                  child: Container(
                    padding: EdgeInsets.all((0.3125*scrheight)/100),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: (0.416666*scrwidth)/100,
                            color: Colors.grey.shade300
                        )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.all((1.5625*scrheight)/100),
                              width: (41.6666*scrheight)/100,
                              height: (23.4375*scrheight)/100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.grey.shade300,
                              ),
                              child: Hero(
                                tag: pprdList[ind].images[0],
                                child: Image(
                                  image: AssetImage('${pprdList[ind].images[0]}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: (1.5625*scrheight)/100,
                              right: (2.7777*scrwidth)/100,
                              child: GestureDetector(
                                  onTap: () {

                                  },
                                  child: FaIcon(
                                    FontAwesomeIcons.trash,
                                    size: (5.28*scrwidth)/100,
                                    color: Colors.red,
                                  )
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: (1.09375*scrheight)/100),
                        Column(
                          children: [
                            Text(
                              pprdList[ind].name,
                              style: TextStyle(
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.w500,
                                fontSize: (6.11*scrwidth)/100,
                                color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                    ? Colors.black87
                                    : Color(0xfffef7ff),
                                letterSpacing: 1,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  pprdList[ind].rate >= 4.9 ? FontAwesomeIcons.solidStar : FontAwesomeIcons.starHalfStroke,
                                  color: prvd.first,
                                  size: (4.72*scrwidth)/100,
                                ),
                                SizedBox(width: (1.38888*scrwidth)/100),
                                Text(
                                  '${pprdList[ind].rate}',
                                  style: TextStyle(
                                    fontFamily: 'Kunika',
                                    fontWeight: FontWeight.w500,
                                    fontSize: (4.98*scrwidth)/100,
                                    color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                        ? Colors.black87
                                        : Color(0xfffef7ff),
                                    letterSpacing: 1,
                                  ),
                                ),
                                SizedBox(width: (1.38888*scrwidth)/100),
                                Container(
                                  height: (2.5*scrheight)/100,
                                  width: (0.5555*scrwidth)/100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.grey.shade300
                                  ),
                                ),
                                SizedBox(width: (1.38888*scrwidth)/100),
                                Container(
                                  padding: EdgeInsets.all((0.78125*scrheight)/100),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Text(
                                    prvd.appLocale.languageCode == 'en' ? '${pprdList[ind].sold}'+' '+AppLocalizations.of(context)!.sld : '${pprdList[ind].sold}' + ' '+ AppLocalizations.of(context)!.sld,
                                    style:  TextStyle(
                                      fontFamily: 'Kunika',
                                      fontWeight: FontWeight.w500,
                                      fontSize: (3.33*scrwidth)/100,
                                      color: Colors.black87,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              prvd.appLocale.languageCode == 'en' ? '${pprdList[ind].price}'+' '+AppLocalizations.of(context)!.dn : '${pprdList[ind].price}' + ' '+ AppLocalizations.of(context)!.dn,
                              style: TextStyle(
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.w500,
                                fontSize: (4.98*scrwidth)/100,
                                color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                    ? Colors.black87
                                    : Color(0xfffef7ff),
                                letterSpacing: 1,
                              ),
                            )
                          ],
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () async{
                              String refresh = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditProduct(prd: pprdList[ind])));
                              if(refresh == 'refresh'){
                                setState(() {});
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              width: 150,
                              decoration: BoxDecoration(
                                  color: prvd.first,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15)
                                  )
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.edt,
                                  style: TextStyle(
                                    fontFamily: 'Kunika',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                        ? Colors.black87
                                        : Color(0xfffef7ff),
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ):  Center(
              child: Text(
                AppLocalizations.of(context)!.prd_lss,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Kunika',
                  fontSize:
                  (5.83 * scrwidth) / 100,
                  color: Theme.of(context)
                      .colorScheme
                      .surface ==
                      Color(0xfffef7ff)
                      ? Colors.black87
                      : Color(0xfffef7ff),
                ),
                textAlign: TextAlign.center,
              ),
            )
        ),
      ),
    );
  }

}

class UserProfile extends StatefulWidget {
  final User cl;
  const UserProfile({super.key, required this.cl});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late double scrwidth;
  late double scrheight;
  late KeepProvider prvd;

  late List<Product> strPrd;



  late User client;

  @override
  void initState() {
    super.initState();
    prvd = Provider.of<KeepProvider>(context, listen: false);
    client = widget.cl;
    
  }

  Widget build(BuildContext context) {
    precacheImage(AssetImage('media/Wave-12.5s-1536px.png'), context);
    scrwidth = MediaQuery.of(context).size.width;
    scrheight = MediaQuery.of(context).size.height;
    return Container(
      width: scrwidth,
      height: scrheight,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        image: DecorationImage(
            image: AssetImage('media/Wave-12.5s-1536px.png'),
            fit: BoxFit.contain,
            alignment: Alignment.topCenter),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          forceMaterialTransparency: true,
          scrolledUnderElevation: 0,
          leading: IconButton(
            style: ButtonStyle(
                overlayColor:
                WidgetStatePropertyAll<Color>(Colors.transparent)),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              prvd.appLocale.languageCode == 'en' ? EvaIcons.arrowIosBack : EvaIcons.arrowIosForward,
              size: (7.5 * scrwidth) / 100,
              color: Theme.of(context).colorScheme.surface ==
                  Color(0xfffef7ff)
                  ? Colors.black87
                  : Color(0xfffef7ff),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB((4.16666*scrwidth)/100, 0, (4.16666*scrwidth)/100, 15),
          child: Stack(
            children: [
               SizedBox(
                  width: scrwidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height: (18.75 * scrheight)/100,
                          width: (33.4 * scrwidth)/100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: (0.5555 * scrwidth) / 100,
                                color: Theme.of(context)
                                    .colorScheme
                                    .surface ==
                                    Color(0xfffef7ff)
                                    ? Colors.transparent
                                    : Color(0xfffef7ff),
                              ),
                              image: DecorationImage(
                                image: AssetImage(client.user_img),
                                fit: BoxFit.cover,
                              )
                          )
                      ),
                      SizedBox(
                        height: (1.5625 * scrheight)/100,
                      ),
                      Text(
                        client.firstname + ' ' + client.lastname,
                        style: TextStyle(
                            fontFamily: 'Kunika',
                            fontWeight: FontWeight.w500,
                            fontSize: 25,
                            color: Theme.of(context).colorScheme.surface ==
                                Color(0xfffef7ff)
                                ? Colors.black87
                                : Color(0xfffef7ff),
                            letterSpacing: 1,
                            decoration: TextDecoration.none
                        ),
                      ),
                      SizedBox(
                        height: (0.78125 * scrheight)/100,
                      ),
                      Divider(
                          height: (0.3125 * scrheight)/100,
                          color: Colors.grey.shade400
                      ),
                      SizedBox(
                        height: (2.34375 * scrheight)/100,
                      ),
                      SizedBox(
                        width: scrwidth,
                        child: Text(
                            AppLocalizations.of(context)!.usr + client.user_nm,
                            style: TextStyle(
                              fontFamily: 'Kunika',
                              fontWeight: FontWeight.w500,
                              fontSize: 22,
                              color: Theme.of(context).colorScheme.surface ==
                                  Color(0xfffef7ff)
                                  ? Colors.black87
                                  : Color(0xfffef7ff),
                              letterSpacing: 1,
                            )
                        ),
                      ),
                      SizedBox(
                        height: (2.34375 * scrheight)/100,
                      ),
                      SizedBox(
                        width: scrwidth,
                        child: Text(
                            AppLocalizations.of(context)!.age + '${DateTime.now().year - client.date_brth.year}',
                            style: TextStyle(
                              fontFamily: 'Kunika',
                              fontWeight: FontWeight.w500,
                              fontSize: 22,
                              color: Theme.of(context).colorScheme.surface ==
                                  Color(0xfffef7ff)
                                  ? Colors.black87
                                  : Color(0xfffef7ff),
                              letterSpacing: 1,
                            )
                        ),
                      ),
                      SizedBox(
                        height: (2.34375 * scrheight)/100,
                      ),
                      SizedBox(
                        width: scrwidth,
                        child: Text(
                            AppLocalizations.of(context)!.phn + '${client.num}',
                            style: TextStyle(
                              fontFamily: 'Kunika',
                              fontWeight: FontWeight.w500,
                              fontSize: 22,
                              color: Theme.of(context).colorScheme.surface ==
                                  Color(0xfffef7ff)
                                  ? Colors.black87
                                  : Color(0xfffef7ff),
                              letterSpacing: 1,
                            )
                        ),
                      ),
                      SizedBox(
                        height: (2.34375 * scrheight)/100,
                      ),
                      SizedBox(
                        width: scrwidth,
                        child: Text(
                            AppLocalizations.of(context)!.gndr + '${client.gndr}',
                            style: TextStyle(
                              fontFamily: 'Kunika',
                              fontWeight: FontWeight.w500,
                              fontSize: 22,
                              color: Theme.of(context).colorScheme.surface ==
                                  Color(0xfffef7ff)
                                  ? Colors.black87
                                  : Color(0xfffef7ff),
                              letterSpacing: 1,
                            )
                        ),
                      )
                    ],
                  ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () async {
                    String phoneNumber = '+213' + '${client.num}';
                    final url = 'tel:$phoneNumber';
                    if (await canLaunchUrlString(url)) {
                    await launchUrlString(url);
                    } else {
                    throw 'Could not make phone call';
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: (1.5625*scrheight)/100),
                    width: scrwidth,
                    height: 50,
                    decoration: BoxDecoration(
                      color: prvd.first,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x29000000),
                            offset: Offset(0, 3),
                            blurRadius: 10,
                            spreadRadius: 1),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.call,
                        style: TextStyle(
                            fontFamily: 'Kunika',
                            fontWeight: FontWeight.w500,
                            fontSize: (5.56*scrwidth)/100,
                            color: Theme.of(context).colorScheme.surface,
                            letterSpacing: 1,
                            decoration: TextDecoration.none
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}


class EditProduct extends StatefulWidget {
  final Product prd;
  const EditProduct({super.key, required this.prd});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {

  late double scrheight;
  late double scrwidth;

  late KeepProvider prvd;

  late Product prod;

  late TextEditingController namcnt;
  late TextEditingController desctcnt;
  late TextEditingController prccnt;
  late TextEditingController qtecnt;

  FocusNode decfc = FocusNode();
  FocusNode prcfc = FocusNode();
  FocusNode qtefc = FocusNode();
  TextEditingController size = TextEditingController();

  Color clr = Colors.transparent;

  @override
  void initState() {
    super.initState();

    prvd = Provider.of<KeepProvider>(context, listen: false);
    prod = widget.prd;

    namcnt = TextEditingController(text: prod.name);
    desctcnt = TextEditingController(text: prod.desc);
    prccnt = TextEditingController(text: prod.price.toString());
    qtecnt = TextEditingController(text: prod.prd_qte.toString());


  }

  Widget build(BuildContext context) {

    scrheight = MediaQuery.of(context).size.height;
    scrwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar:  AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation: 0,
        leading: IconButton(
          style: ButtonStyle(
              overlayColor:
              WidgetStatePropertyAll<Color>(Colors.transparent)),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            prvd.appLocale.languageCode == 'ar'?EvaIcons.arrowIosForward : EvaIcons.arrowIosBack,
            size: (7.5 * scrwidth) / 100,
            color:
            Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                ? Colors.black87
                : Color(0xfffef7ff),
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.edt_prdc,
          style: TextStyle(
            fontFamily: 'Kunika',
            fontWeight: FontWeight.bold,
            fontSize: (7.78*scrwidth)/100,
            color:
            Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                ? Colors.black
                : Color(0xfffef7ff),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB((4.16666*scrwidth)/100, 15, (4.16666*scrwidth)/100, 10),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  bottom: (3.4375 * scrheight) / 100),
              padding: EdgeInsets.symmetric(
                  horizontal: (2.7777 * scrwidth) / 100),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context)
                    .colorScheme
                    .surface ==
                    Color(0xff141218)
                    ? Color(0xd8ffffff)
                    : Color(0x1A000000),
              ),
              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: (12.5 * scrwidth) / 100,
                    height: (7.03125 * scrheight) / 100,
                    decoration: BoxDecoration(
                        color: prvd.first.withOpacity(0.2),
                        borderRadius:
                        BorderRadius.circular(10)),
                    child: Center(
                      child: FaIcon(
                       FontAwesomeIcons.signature,
                        color: prvd.first,
                        size: (6.9444 * scrwidth) / 100,
                      ),
                    ),
                  ),
                  Container(
                    width: (69.4444 * scrwidth) / 100,
                    padding: EdgeInsets.only(
                        left: (1.94444 * scrwidth) / 100,
                        right: (0.5555 * scrwidth) / 100),
                    child: TextFormField(
                      onChanged: (v) {
                        setState(() {});
                      },
                      onEditingComplete: () {
                        FocusScope.of(context)
                            .requestFocus(decfc);
                      },
                      controller: namcnt,
                      style: TextStyle(
                          fontSize: (5 * scrwidth) / 100,
                          fontFamily: 'Kunika',
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(
                            vertical:
                            (1.25 * scrheight) /
                                100),
                        label: Padding(
                          padding: EdgeInsets.only(
                              left: (1.38888 * scrwidth) /
                                  100),
                          child: Text(
                            AppLocalizations.of(context)!.prd_nam,
                            style: TextStyle(
                                fontFamily: 'Kunika',
                                fontSize:
                                (5 * scrwidth) / 100,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff252525)),
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                      cursorColor: prvd.first,
                      cursorWidth: 2,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(
                  bottom: (3.4375 * scrheight) / 100),
              padding: EdgeInsets.symmetric(
                  horizontal: (2.7777 * scrwidth) / 100),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context)
                    .colorScheme
                    .surface ==
                    Color(0xff141218)
                    ? Color(0xd8ffffff)
                    : Color(0x1A000000),
              ),
              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: (12.5 * scrwidth) / 100,
                    height: (7.03125 * scrheight) / 100,
                    decoration: BoxDecoration(
                        color: prvd.first.withOpacity(0.2),
                        borderRadius:
                        BorderRadius.circular(10)),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.solidComment,
                        color: prvd.first,
                        size: (6.9444 * scrwidth) / 100,
                      ),
                    ),
                  ),
                  Container(
                    width: (69.4444 * scrwidth) / 100,
                    padding: EdgeInsets.only(
                        left: (1.94444 * scrwidth) / 100,
                        right: (0.5555 * scrwidth) / 100),
                    child: TextFormField(
                      focusNode: decfc,
                      onEditingComplete: () {
                        FocusScope.of(context)
                            .requestFocus(prcfc);
                      },
                      controller: desctcnt,
                      style: TextStyle(
                          fontSize: (5 * scrwidth) / 100,
                          fontFamily: 'Kunika',
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(
                            vertical:
                            (1.25 * scrheight) /
                                100),
                        label: Padding(
                          padding: EdgeInsets.only(
                              left: (1.38888 * scrwidth) /
                                  100),
                          child: Text(
                            AppLocalizations.of(context)!.prd_dec,
                            style: TextStyle(
                                fontFamily: 'Kunika',
                                fontSize:
                                (5 * scrwidth) / 100,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff252525)),
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                      cursorColor: prvd.first,
                      cursorWidth: 2,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(
                  bottom: (3.4375 * scrheight) / 100),
              padding: EdgeInsets.symmetric(
                  horizontal: (2.7777 * scrwidth) / 100),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context)
                    .colorScheme
                    .surface ==
                    Color(0xff141218)
                    ? Color(0xd8ffffff)
                    : Color(0x1A000000),
              ),
              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: (12.5 * scrwidth) / 100,
                    height: (7.03125 * scrheight) / 100,
                    decoration: BoxDecoration(
                        color: prvd.first.withOpacity(0.2),
                        borderRadius:
                        BorderRadius.circular(10)),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.moneyCheckDollar,
                        color: prvd.first,
                        size: (6.9444 * scrwidth) / 100,
                      ),
                    ),
                  ),
                  Container(
                    width: (69.4444 * scrwidth) / 100,
                    padding: EdgeInsets.only(
                        left: (1.94444 * scrwidth) / 100,
                        right: (0.5555 * scrwidth) / 100),
                    child: TextFormField(
                      focusNode: prcfc,
                      onEditingComplete: () {
                        FocusScope.of(context)
                            .requestFocus(qtefc);
                      },
                      controller: prccnt,
                      style: TextStyle(
                          fontSize: (5 * scrwidth) / 100,
                          fontFamily: 'Kunika',
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(
                            vertical:
                            (1.25 * scrheight) /
                                100),
                        label: Padding(
                          padding: EdgeInsets.only(
                              left: (1.38888 * scrwidth) /
                                  100),
                          child: Text(
                            AppLocalizations.of(context)!.prd_prc,
                            style: TextStyle(
                                fontFamily: 'Kunika',
                                fontSize:
                                (5 * scrwidth) / 100,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff252525)),
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                      cursorColor: prvd.first,
                      cursorWidth: 2,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(
                  bottom: (3.4375 * scrheight) / 100),
              padding: EdgeInsets.symmetric(
                  horizontal: (2.7777 * scrwidth) / 100),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context)
                    .colorScheme
                    .surface ==
                    Color(0xff141218)
                    ? Color(0xd8ffffff)
                    : Color(0x1A000000),
              ),
              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: (12.5 * scrwidth) / 100,
                    height: (7.03125 * scrheight) / 100,
                    decoration: BoxDecoration(
                        color: prvd.first.withOpacity(0.2),
                        borderRadius:
                        BorderRadius.circular(10)),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.boxesStacked,
                        color: prvd.first,
                        size: (6.9444 * scrwidth) / 100,
                      ),
                    ),
                  ),
                  Container(
                    width: (69.4444 * scrwidth) / 100,
                    padding: EdgeInsets.only(
                        left: (1.94444 * scrwidth) / 100,
                        right: (0.5555 * scrwidth) / 100),
                    child: TextFormField(
                      focusNode: qtefc,
                      controller: qtecnt,
                      style: TextStyle(
                          fontSize: (5 * scrwidth) / 100,
                          fontFamily: 'Kunika',
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(
                            vertical:
                            (1.25 * scrheight) /
                                100),
                        label: Padding(
                          padding: EdgeInsets.only(
                              left: (1.38888 * scrwidth) /
                                  100),
                          child: Text(
                            AppLocalizations.of(context)!.prd_qte,
                            style: TextStyle(
                                fontFamily: 'Kunika',
                                fontSize:
                                (5 * scrwidth) / 100,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff252525)),
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                      cursorColor: prvd.first,
                      cursorWidth: 2,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    AppLocalizations.of(context)!.add_prm,
                    style: TextStyle(
                        fontFamily: 'Kunika',
                        fontSize:
                        23,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context)
                            .colorScheme
                            .surface ==
                            Color(0xfffef7ff)
                            ? Colors.black87
                            : Color(0xfffef7ff))
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddPromo(id: prod.id)));
                  },
                  child: FaIcon(
                    FontAwesomeIcons.circlePlus,
                    size: 28,
                    color: prvd.first,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              width: scrwidth,
              child: Text(
                AppLocalizations.of(context)!.prd_clrs,
                style: TextStyle(
                    fontFamily: 'Kunika',
                    fontSize:
                    22,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context)
                        .colorScheme
                        .surface ==
                        Color(0xfffef7ff)
                        ? Colors.black87
                        : Color(0xfffef7ff)
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                SizedBox(
                  height: (7.8125*scrheight)/100,
                  width: 230,
                  child: ListView.separated(
                    separatorBuilder: (BuildContext c, int i) => SizedBox(width: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: prod.colors.length,
                    itemBuilder: (context, ind){
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            prod.colors.remove(prod.colors[ind]);
                          });
                        },
                        child: Container(
                          width: (11.1111*scrwidth)/100,
                          height: (6.25*scrheight)/100,
                          decoration: BoxDecoration(
                              color: prod.colors[ind],
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: (0.5555*scrwidth)/100,
                                color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                    ? Colors.black87
                                    : Color(0xfffef7ff),
                              )
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                          AppLocalizations.of(context)!.chs_color,
                          style: TextStyle(
                              fontFamily: 'Kunika',
                              fontSize:
                              20,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context)
                                  .colorScheme
                                  .surface ==
                                  Color(0xfffef7ff)
                                  ? Colors.black87
                                  : Color(0xfffef7ff)
                          ),
                        ),
                        content: Column(
                          children: [
                            ColorPicker(
                              pickerColor: clr,
                              onColorChanged: (color) {
                                clr = color;
                              },
                              labelTypes: [],
                            ),
                            GestureDetector(
                              onTap: () {
                                if(!prod.colors.contains(clr)){
                                  setState(() {
                                    prod.colors.add(clr);
                                  });
                                  Navigator.pop(context);
                                }else{
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Center(
                                          child: Text(
                                            AppLocalizations.of(context)!.clr_err,
                                            style: TextStyle(
                                                fontFamily: 'Kunika',
                                                fontWeight: FontWeight.w500,
                                                fontSize: (5*scrwidth)/100,
                                                color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                                    ? Colors.black87
                                                    : Color(0xfffef7ff),
                                                letterSpacing: 1,
                                                decoration: TextDecoration.none
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        margin: EdgeInsets.only(left: (13.8888*scrwidth)/100, right: (13.8888*scrwidth)/100, bottom: (3.125*scrheight)/100),
                                        padding: EdgeInsets.all((1.5625*scrheight)/100),
                                        backgroundColor: Colors.grey.shade400.withOpacity(0.4),
                                        duration: Duration(seconds: 1),
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                      )
                                  );
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                                decoration: BoxDecoration(
                                    color: prvd.first,
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.slct,
                                  style: TextStyle(
                                      fontFamily: 'Kunika',
                                      fontSize:
                                      20,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface ==
                                          Color(0xfffef7ff)
                                          ? Colors.black87
                                          : Color(0xfffef7ff)
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    );
                  },
                  child: FaIcon(
                    FontAwesomeIcons.circlePlus,
                    size: 28,
                    color: prvd.first,
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  height: (7.8125*scrheight)/100,
                  width: 230,
                  child: ListView.separated(
                    separatorBuilder: (BuildContext c, int i) => SizedBox(width: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: prod.sizes.length,
                    itemBuilder: (context, ind){
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            prod.sizes.remove(prod.sizes[ind]);
                          });
                        },
                        child: Container(
                          width: (11.1111*scrwidth)/100,
                          height: (6.25*scrheight)/100,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: (0.5555*scrwidth)/100,
                                color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                    ? Colors.black87
                                    : Color(0xfffef7ff),
                              )
                          ),
                          child: Center(
                            child: Text(
                              prod.sizes[ind],
                              style: TextStyle(
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.w500,
                                fontSize: ( 4.72*scrwidth)/100,
                                color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                    ? Colors.black87
                                    : Color(0xfffef7ff),
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            AppLocalizations.of(context)!.chs_size,
                            style: TextStyle(
                                fontFamily: 'Kunika',
                                fontSize:
                                20,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context)
                                    .colorScheme
                                    .surface ==
                                    Color(0xfffef7ff)
                                    ? Colors.black87
                                    : Color(0xfffef7ff)
                            ),
                          ),
                          content: SizedBox(
                            height: 130,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom: (3.4375 * scrheight) / 100),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: (2.7777 * scrwidth) / 100),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surface ==
                                        Color(0xff141218)
                                        ? Color(0xd8ffffff)
                                        : Color(0x1A000000),
                                  ),
                                  child: Container(
                                    width: (69.4444 * scrwidth) / 100,
                                    padding: EdgeInsets.only(
                                        left: (1.94444 * scrwidth) / 100,
                                        right: (0.5555 * scrwidth) / 100),
                                    child: TextFormField(
                                      controller: size,
                                      style: TextStyle(
                                          fontSize: (5 * scrwidth) / 100,
                                          fontFamily: 'Kunika',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87),
                                      decoration: InputDecoration(
                                        contentPadding:
                                        EdgeInsets.symmetric(
                                            vertical:
                                            (1.25 * scrheight) /
                                                100),
                                        label: Padding(
                                          padding: EdgeInsets.only(
                                              left: (1.38888 * scrwidth) /
                                                  100),
                                          child: Text(
                                            AppLocalizations.of(context)!.size,
                                            style: TextStyle(
                                                fontFamily: 'Kunika',
                                                fontSize:
                                                (5 * scrwidth) / 100,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff252525)),
                                          ),
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      cursorColor: prvd.first,
                                      cursorWidth: 2,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if(!prod.sizes.contains(size.text)){
                                      setState(() {
                                        prod.sizes.add(size.text);
                                      });
                                      Navigator.pop(context);
                                    }else{
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Center(
                                              child: Text(
                                                AppLocalizations.of(context)!.sz_err,
                                                style: TextStyle(
                                                    fontFamily: 'Kunika',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: (5*scrwidth)/100,
                                                    color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                                        ? Colors.black87
                                                        : Color(0xfffef7ff),
                                                    letterSpacing: 1,
                                                    decoration: TextDecoration.none
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            margin: EdgeInsets.only(left: (13.8888*scrwidth)/100, right: (13.8888*scrwidth)/100, bottom: (3.125*scrheight)/100),
                                            padding: EdgeInsets.all((1.5625*scrheight)/100),
                                            backgroundColor: Colors.grey.shade400.withOpacity(0.4),
                                            duration: Duration(seconds: 1),
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(50),
                                            ),
                                          )
                                      );
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                                    decoration: BoxDecoration(
                                        color: prvd.first,
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!.add_sz,
                                      style: TextStyle(
                                          fontFamily: 'Kunika',
                                          fontSize:
                                          20,
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface ==
                                              Color(0xfffef7ff)
                                              ? Colors.black87
                                              : Color(0xfffef7ff)
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    );
                  },
                  child: FaIcon(
                    FontAwesomeIcons.circlePlus,
                    size: 28,
                    color: prvd.first,
                  ),
                )
              ],
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                if(namcnt.text.isNotEmpty && desctcnt.text.isNotEmpty && prccnt.text.isNotEmpty && qtecnt.text.isNotEmpty){
                  setState(() {
                    prod.name = namcnt.text;
                    prod.desc = desctcnt.text;
                    prod.prd_qte = int.parse(qtecnt.text);
                    prod.price = double.parse(prccnt.text);
                  });
                  Navigator.pop(context,'refresh');
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Center(
                          child: Text(
                            AppLocalizations.of(context)!.chk_data,
                            style: TextStyle(
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.w500,
                                fontSize: (5*scrwidth)/100,
                                color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                    ? Colors.black87
                                    : Color(0xfffef7ff),
                                letterSpacing: 1,
                                decoration: TextDecoration.none
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        margin: EdgeInsets.only(left: (13.8888*scrwidth)/100, right: (13.8888*scrwidth)/100, bottom: (3.125*scrheight)/100),
                        padding: EdgeInsets.all((1.5625*scrheight)/100),
                        backgroundColor: Colors.grey.shade400.withOpacity(0.4),
                        duration: Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      )
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: (1.5625*scrheight)/100),
                width: scrwidth,
                height: 50,
                decoration: BoxDecoration(
                  color: prvd.first,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x29000000),
                        offset: Offset(0, 3),
                        blurRadius: 10,
                        spreadRadius: 1),
                  ],
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.updt,
                    style: TextStyle(
                        fontFamily: 'Kunika',
                        fontWeight: FontWeight.w500,
                        fontSize: (5.56*scrwidth)/100,
                        color: Theme.of(context).colorScheme.surface,
                        letterSpacing: 1,
                        decoration: TextDecoration.none
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyStore extends StatefulWidget {

  const MyStore({super.key});

  @override
  State<MyStore> createState() => _MyStoreState();
}

class _MyStoreState extends State<MyStore> {
  late double scrwidth;
  late double scrheight;
  late KeepProvider prvd;

  late List<Product> strPrd;




  late Store str;

  @override
  void initState() {
    super.initState();
    prvd = Provider.of<KeepProvider>(context, listen: false);

    prvd.strliste.forEach((e){
      if(e.slr_id == prvd.sllr.id){
        str = e;
      }
    });

    strPrd = prvd.prdliste.where((e) => e.id_store == str.str_id).toList();
  }

  Widget build(BuildContext context) {
    precacheImage(AssetImage('media/Wave-12.5s-1536px.png'), context);
    scrwidth = MediaQuery.of(context).size.width;
    scrheight = MediaQuery.of(context).size.height;
    return Container(
      width: scrwidth,
      height: scrheight,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        image: DecorationImage(
            image: AssetImage('media/Wave-12.5s-1536px.png'),
            fit: BoxFit.contain,
            alignment: Alignment.topCenter),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: SizedBox(),
          forceMaterialTransparency: true,
          scrolledUnderElevation: 0,
          title: Text(
            AppLocalizations.of(context)!.my_str,
            style: TextStyle(
                fontFamily: 'Kunika',
                fontWeight: FontWeight.bold,
                fontSize: (4.375*scrheight)/100,
                color:
                Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                    ? Colors.black87
                    : Color(0xfffef7ff),
                letterSpacing: 1
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB((4.16666*scrwidth)/100, 0, (4.16666*scrwidth)/100, 0),
          child: SizedBox(
            width: scrwidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: (18.75 * scrheight)/100,
                    width: (33.4 * scrwidth)/100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: (0.5555 * scrwidth) / 100,
                          color: Theme.of(context)
                              .colorScheme
                              .surface ==
                              Color(0xfffef7ff)
                              ? Colors.transparent
                              : Color(0xfffef7ff),
                        ),
                        image: DecorationImage(
                          image: AssetImage(str.str_image),
                          fit: BoxFit.fill,
                        )
                    )
                ),
                SizedBox(
                  height: (1.5625 * scrheight)/100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      str.str_name,
                      style: TextStyle(
                          fontFamily: 'Kunika',
                          fontWeight: FontWeight.w500,
                          fontSize: (8.33 * scrwidth)/100,
                          color: Theme.of(context).colorScheme.surface ==
                              Color(0xfffef7ff)
                              ? Colors.black87
                              : Color(0xfffef7ff),
                          letterSpacing: 1,
                          decoration: TextDecoration.none
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddProduct()));
                      },
                      child: FaIcon(
                        FontAwesomeIcons.circlePlus,
                        color: prvd.first,
                        size: 25,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: (0.78125 * scrheight)/100,
                ),
                Divider(
                    height: (0.3125 * scrheight)/100,
                    color: Colors.grey.shade400
                ),
                SizedBox(
                  height: (2.34375 * scrheight)/100,
                ),
                SizedBox(
                  width: scrwidth,
                  child: Align(
                    alignment: prvd.appLocale.languageCode == 'en' ? Alignment.centerLeft : Alignment.centerRight,
                    child: SizedBox(
                      width: (55.6 * scrwidth)/100,
                      child: Text(
                        AppLocalizations.of(context)!.prd_of + ' ' + str.str_name,
                        style: TextStyle(
                            fontFamily: 'Kunika',
                            fontWeight: FontWeight.w500,
                            fontSize: (6.9 * scrwidth)/100,
                            color: Theme.of(context).colorScheme.surface ==
                                Color(0xfffef7ff)
                                ? Colors.black87
                                : Color(0xfffef7ff),
                            letterSpacing: 1,
                            decoration: TextDecoration.none
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: strPrd.isNotEmpty ? GridView.builder(
                    padding: EdgeInsets.all((1.5625*scrheight)/100),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.51,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 15
                    ),
                    itemCount: strPrd.length,
                    itemBuilder: (context, ind) {
                      return GestureDetector(
                        onTap: () async{
                        },
                        child: Container(
                          padding: EdgeInsets.all((0.3125*scrheight)/100),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  width: (0.416666*scrwidth)/100,
                                  color: Colors.grey.shade300
                              )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all((1.5625*scrheight)/100),
                                    width: (41.6666*scrheight)/100,
                                    height: (23.4375*scrheight)/100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: Colors.grey.shade300,
                                    ),
                                    child: Hero(
                                      tag: strPrd[ind].images[0],
                                      child: Image(
                                        image: AssetImage('${strPrd[ind].images[0]}'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: (1.5625*scrheight)/100,
                                    right: (2.7777*scrwidth)/100,
                                    child: GestureDetector(
                                        onTap: () {

                                        },
                                        child: FaIcon(
                                          FontAwesomeIcons.trash,
                                          size: (5.28*scrwidth)/100,
                                          color: Colors.red,
                                        )
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: (1.09375*scrheight)/100),
                              Column(
                                children: [
                                  Text(
                                    strPrd[ind].name,
                                    style: TextStyle(
                                      fontFamily: 'Kunika',
                                      fontWeight: FontWeight.w500,
                                      fontSize: (6.11*scrwidth)/100,
                                      color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                          ? Colors.black87
                                          : Color(0xfffef7ff),
                                      letterSpacing: 1,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FaIcon(
                                        strPrd[ind].rate >= 4.9 ? FontAwesomeIcons.solidStar : FontAwesomeIcons.starHalfStroke,
                                        color: prvd.first,
                                        size: (4.72*scrwidth)/100,
                                      ),
                                      SizedBox(width: (1.38888*scrwidth)/100),
                                      Text(
                                        '${strPrd[ind].rate}',
                                        style: TextStyle(
                                          fontFamily: 'Kunika',
                                          fontWeight: FontWeight.w500,
                                          fontSize: (4.98*scrwidth)/100,
                                          color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                              ? Colors.black87
                                              : Color(0xfffef7ff),
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      SizedBox(width: (1.38888*scrwidth)/100),
                                      Container(
                                        height: (2.5*scrheight)/100,
                                        width: (0.5555*scrwidth)/100,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            color: Colors.grey.shade300
                                        ),
                                      ),
                                      SizedBox(width: (1.38888*scrwidth)/100),
                                      Container(
                                        padding: EdgeInsets.all((0.78125*scrheight)/100),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius: BorderRadius.circular(8)
                                        ),
                                        child: Text(
                                          prvd.appLocale.languageCode == 'en' ? '${strPrd[ind].sold}'+' '+AppLocalizations.of(context)!.sld : '${strPrd[ind].sold}' + ' '+ AppLocalizations.of(context)!.sld,
                                          style:  TextStyle(
                                            fontFamily: 'Kunika',
                                            fontWeight: FontWeight.w500,
                                            fontSize: (3.33*scrwidth)/100,
                                            color: Colors.black87,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    prvd.appLocale.languageCode == 'en' ? '${strPrd[ind].price}'+' '+AppLocalizations.of(context)!.dn : '${strPrd[ind].price}' + ' '+ AppLocalizations.of(context)!.dn,
                                    style: TextStyle(
                                      fontFamily: 'Kunika',
                                      fontWeight: FontWeight.w500,
                                      fontSize: (4.98*scrwidth)/100,
                                      color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                          ? Colors.black87
                                          : Color(0xfffef7ff),
                                      letterSpacing: 1,
                                    ),
                                  )
                                ],
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () async{
                                    String refresh = await Navigator.push(context, MaterialPageRoute(builder: (context) => EditProduct(prd: strPrd[ind])));
                                    if(refresh == 'refresh'){
                                      setState(() {});
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: prvd.first,
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(15)
                                        )
                                    ),
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of(context)!.edt,
                                        style: TextStyle(
                                          fontFamily: 'Kunika',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17,
                                          color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                              ? Colors.black87
                                              : Color(0xfffef7ff),
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ): Center(
                    child: Text(
                      AppLocalizations.of(context)!.prdc_null,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Kunika',
                        fontSize:
                        (3.28125 * scrheight) / 100,
                        color: Theme.of(context)
                            .colorScheme
                            .surface ==
                            Color(0xfffef7ff)
                            ? Colors.black87
                            : Color(0xfffef7ff),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class TheOrders extends StatefulWidget {
  const TheOrders({super.key});

  @override
  State<TheOrders> createState() => _TheOrdersState();
}

class _TheOrdersState extends State<TheOrders> with TickerProviderStateMixin{

  late double scrheight;
  late double scrwidth;
  late KeepProvider prvd;

  late TabController tab;

  late List<Order_item> cmplt_ords;


  @override
  void initState() {
    super.initState();
    prvd = Provider.of<KeepProvider>(context, listen: false);

    tab = TabController(length: 2, vsync: this);

  }

  Widget build(BuildContext context) {
    precacheImage(AssetImage('media/Vectorlogo_ext2.png'), context);
    scrheight = MediaQuery.of(context).size.height;
    scrwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation: 0,
        leading:  Container(
          margin: prvd.appLocale.languageCode == 'en' ? EdgeInsets.only(left: (4.16666*scrwidth)/100) : EdgeInsets.only(right: (4.16666*scrwidth)/100),
          child: Image(
            image: AssetImage('media/Vectorlogo_ext2.png'),
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.th_ord,
          style: TextStyle(
              fontFamily: 'Kunika',
              fontWeight: FontWeight.bold,
              fontSize: (7.78*scrwidth)/100,
              color:
              Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                  ? Colors.black87
                  : Color(0xfffef7ff),
              letterSpacing: 1
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          TabBar(
            labelStyle: TextStyle(
                fontFamily: 'Kunika',
                fontWeight: FontWeight.bold,
                fontSize: (5.56 * scrwidth)/100,
                color: prvd.first,
                letterSpacing: 1
            ),
            unselectedLabelColor: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                ? Colors.black87
                : Color(0xfffef7ff),
            overlayColor: WidgetStatePropertyAll<Color>(Colors.transparent),
            padding: EdgeInsets.symmetric(horizontal: (4.16 * scrwidth) /100),
            indicatorColor: prvd.first,
            controller: tab,
            tabs: [
              Tab(
                text: AppLocalizations.of(context)!.ord_wt,
              ),
              Tab(
                text: AppLocalizations.of(context)!.ord_cnf,
              )
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tab,
              children: [
                prvd.ordr_itelms.isNotEmpty ? ListView.builder(
                  padding: EdgeInsets.only(top: (2.34375*scrheight)/100, right: (4.16666*scrwidth)/100, left: (4.16666*scrwidth)/100),
                  itemCount: prvd.ordr_itelms.length,
                  itemBuilder: (context, ind){
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPage(ord: prvd.ordr_itelms[ind])));
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: (1.5625*scrheight)/100, horizontal: (4.16666*scrwidth)/100),
                          margin: EdgeInsets.only(bottom: (3.125*scrheight)/100),
                          width: scrwidth,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                ? Colors.white
                                : Colors.black,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff) ? Color(0x29000000) : Colors.transparent,
                                  offset: Offset(0, 3),
                                  blurRadius: 10,
                                  spreadRadius: 1),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: (27.7777*scrwidth)/100,
                                    height: (15.625*scrheight)/100,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(18),
                                        image: DecorationImage(
                                            image: AssetImage(prvd.ordr_itelms[ind].p.images[0]),
                                            fit: BoxFit.contain
                                        )
                                    ),
                                  ),
                                  SizedBox(
                                    width: (2.7777*scrwidth)/100,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: (41.6666*scrwidth)/100,
                                              child: Text(
                                                prvd.ordr_itelms[ind].p.name,
                                                style: TextStyle(
                                                    fontFamily: 'Kunika',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: (6.11*scrwidth)/100,
                                                    color:
                                                    Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                                        ? Colors.black87
                                                        : Color(0xfffef7ff),
                                                    letterSpacing: 1
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!.qty + ' = ' + '${prvd.ordr_itelms[ind].qte_p}',
                                              style: TextStyle(
                                                  fontFamily: 'Kunika',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: (4.44*scrwidth)/100,
                                                  color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                                      ? Colors.black87
                                                      : Color(0xfffef7ff),
                                                  letterSpacing: 1,
                                                  decoration: TextDecoration.none
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: (0.78125*scrheight)/100),
                                        Visibility(
                                          visible: prvd.ordr_itelms[ind].size == '' && prvd.ordr_itelms[ind].clr == Colors.transparent ? false : true,
                                          child: Row(
                                            children: [
                                              prvd.ordr_itelms[ind].size != Colors.transparent ? Container(
                                                width: (5.5555*scrwidth)/100,
                                                height: (3.125*scrheight)/100,
                                                decoration: BoxDecoration(
                                                    color: prvd.ordr_itelms[ind].clr,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      width: (0.5555*scrwidth)/100,
                                                      color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                                          ? Colors.black87
                                                          : Color(0xfffef7ff),
                                                    )
                                                ),
                                              ) : SizedBox(),
                                              prvd.ordr_itelms[ind].clr != Colors.transparent ? SizedBox(width: (1.38888*scrwidth)/100) : SizedBox(),
                                              prvd.ordr_itelms[ind].clr != Colors.transparent ? Text(
                                                AppLocalizations.of(context)!.color,
                                                style: TextStyle(
                                                    fontFamily: 'Kunika',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: (4.44*scrwidth)/100,
                                                    color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                                        ? Colors.black87
                                                        : Color(0xfffef7ff),
                                                    letterSpacing: 1,
                                                    decoration: TextDecoration.none
                                                ),
                                              ) : SizedBox(),
                                              prvd.ordr_itelms[ind].clr != Colors.transparent ? SizedBox(width: (2.2222*scrwidth)/100) : SizedBox(),
                                              prvd.ordr_itelms[ind].clr != Colors.transparent ? Container(
                                                width: (0.5555*scrwidth)/100,
                                                height: (2.34375*scrheight)/100,
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                                        ? Colors.black87
                                                        : Color(0xfffef7ff),
                                                    borderRadius: BorderRadius.circular(50)
                                                ),
                                              ) : SizedBox(),
                                              prvd.ordr_itelms[ind].clr != Colors.transparent ? SizedBox(width: (2.2222*scrwidth)/100) : SizedBox(),
                                              prvd.ordr_itelms[ind].size != '' ? Text(
                                                AppLocalizations.of(context)!.size + ' = ' + prvd.ordr_itelms[ind].size,
                                                style: TextStyle(
                                                    fontFamily: 'Kunika',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: (4.44*scrwidth)/100,
                                                    color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                                        ? Colors.black87
                                                        : Color(0xfffef7ff),
                                                    letterSpacing: 1,
                                                    decoration: TextDecoration.none
                                                ),
                                              ) : SizedBox(),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: (0.78125*scrheight)/100),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: (27.7777*scrwidth)/100,
                                              child: Text(
                                                prvd.appLocale.languageCode == 'en' ? '${Priceprd(prvd.ordr_itelms[ind])}'+' '+AppLocalizations.of(context)!.dn : '${Priceprd(prvd.ordr_itelms[ind])}' + ' '+ AppLocalizations.of(context)!.dn,
                                                style: TextStyle(
                                                    fontFamily: 'Kunika',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: (5.56*scrwidth)/100,
                                                    color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                                        ? Colors.black87
                                                        : Color(0xfffef7ff),
                                                    letterSpacing: 1,
                                                    decoration: TextDecoration.none
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                                padding: EdgeInsets.all((0.78125*scrheight)/100),
                                                width: (20 * scrwidth)/100,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade300,
                                                    borderRadius: BorderRadius.circular(15)
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    AppLocalizations.of(context)!.dlvr,
                                                    style: TextStyle(
                                                        fontFamily: 'Kunika',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: (3.33 * scrwidth)/100,
                                                        color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                                            ? Color(0xfffef7ff)
                                                            : Colors.black87,
                                                        letterSpacing: 1,
                                                        decoration: TextDecoration.none
                                                    ),
                                                  ),
                                                )
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                      ),
                    );
                  },
                ) : Center(
                  child: Text(
                    AppLocalizations.of(context)!.nth3,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Kunika',
                      fontSize:
                      (5.83 * scrwidth) / 100,
                      color: Theme.of(context)
                          .colorScheme
                          .surface ==
                          Color(0xfffef7ff)
                          ? Colors.black87
                          : Color(0xfffef7ff),
                    ),
                  ),
                ),
                prvd.hist_item.isNotEmpty ? ListView.builder(
                  padding: EdgeInsets.only(top: (2.34375*scrheight)/100, right: (4.16666*scrwidth)/100, left: (4.16666*scrwidth)/100),
                  itemCount: prvd.hist_item.length,
                  itemBuilder: (context, ind){
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPage(ord: prvd.hist_item[ind])));
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: (1.5625*scrheight)/100, horizontal: (4.16666*scrwidth)/100),
                          margin: EdgeInsets.only(bottom: (3.125*scrheight)/100),
                          width: scrwidth,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                ? Colors.white
                                : Colors.black,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff) ? Color(0x29000000) : Colors.transparent,
                                  offset: Offset(0, 3),
                                  blurRadius: 10,
                                  spreadRadius: 1),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: (27.7777*scrwidth)/100,
                                    height: (15.625*scrheight)/100,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(18),
                                        image: DecorationImage(
                                            image: AssetImage(prvd.hist_item[ind].p.images[0]),
                                            fit: BoxFit.contain
                                        )
                                    ),
                                  ),
                                  SizedBox(
                                    width: (2.7777*scrwidth)/100,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: (41.6666*scrwidth)/100,
                                              child: Text(
                                                prvd.hist_item[ind].p.name,
                                                style: TextStyle(
                                                    fontFamily: 'Kunika',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: (6.11*scrwidth)/100,
                                                    color:
                                                    Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                                        ? Colors.black87
                                                        : Color(0xfffef7ff),
                                                    letterSpacing: 1
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!.qty + ' = ' + '${prvd.hist_item[ind].qte_p}',
                                              style: TextStyle(
                                                  fontFamily: 'Kunika',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: (4.44*scrwidth)/100,
                                                  color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                                      ? Colors.black87
                                                      : Color(0xfffef7ff),
                                                  letterSpacing: 1,
                                                  decoration: TextDecoration.none
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: (0.78125*scrheight)/100),
                                        Visibility(
                                          visible: prvd.hist_item[ind].size == '' && prvd.hist_item[ind].clr == Colors.transparent ? false : true,
                                          child: Row(
                                            children: [
                                              prvd.hist_item[ind].size != Colors.transparent ? Container(
                                                width: (5.5555*scrwidth)/100,
                                                height: (3.125*scrheight)/100,
                                                decoration: BoxDecoration(
                                                    color: prvd.hist_item[ind].clr,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      width: (0.5555*scrwidth)/100,
                                                      color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                                          ? Colors.black87
                                                          : Color(0xfffef7ff),
                                                    )
                                                ),
                                              ) : SizedBox(),
                                              prvd.hist_item[ind].clr != Colors.transparent ? SizedBox(width: (1.38888*scrwidth)/100) : SizedBox(),
                                              prvd.hist_item[ind].clr != Colors.transparent ? Text(
                                                AppLocalizations.of(context)!.color,
                                                style: TextStyle(
                                                    fontFamily: 'Kunika',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: (4.44*scrwidth)/100,
                                                    color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                                        ? Colors.black87
                                                        : Color(0xfffef7ff),
                                                    letterSpacing: 1,
                                                    decoration: TextDecoration.none
                                                ),
                                              ) : SizedBox(),
                                              prvd.hist_item[ind].clr != Colors.transparent ? SizedBox(width: (2.2222*scrwidth)/100) : SizedBox(),
                                              prvd.hist_item[ind].clr != Colors.transparent ? Container(
                                                width: (0.5555*scrwidth)/100,
                                                height: (2.34375*scrheight)/100,
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                                        ? Colors.black87
                                                        : Color(0xfffef7ff),
                                                    borderRadius: BorderRadius.circular(50)
                                                ),
                                              ) : SizedBox(),
                                              prvd.hist_item[ind].clr != Colors.transparent ? SizedBox(width: (2.2222*scrwidth)/100) : SizedBox(),
                                              prvd.hist_item[ind].size != '' ? Text(
                                                AppLocalizations.of(context)!.size + ' = ' + prvd.hist_item[ind].size,
                                                style: TextStyle(
                                                    fontFamily: 'Kunika',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: (4.44*scrwidth)/100,
                                                    color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                                        ? Colors.black87
                                                        : Color(0xfffef7ff),
                                                    letterSpacing: 1,
                                                    decoration: TextDecoration.none
                                                ),
                                              ) : SizedBox(),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: (0.78125*scrheight)/100),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: (27.7777*scrwidth)/100,
                                              child: Text(
                                                prvd.appLocale.languageCode == 'en' ? '${Priceprd(prvd.hist_item[ind])}'+' '+AppLocalizations.of(context)!.dn : '${Priceprd(prvd.hist_item[ind])}' + ' '+ AppLocalizations.of(context)!.dn,
                                                style: TextStyle(
                                                    fontFamily: 'Kunika',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: (5.56*scrwidth)/100,
                                                    color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                                        ? Colors.black87
                                                        : Color(0xfffef7ff),
                                                    letterSpacing: 1,
                                                    decoration: TextDecoration.none
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                                padding: EdgeInsets.all((0.78125*scrheight)/100),
                                                width: (20 * scrwidth)/100,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade300,
                                                    borderRadius: BorderRadius.circular(15)
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    AppLocalizations.of(context)!.ord_cmp,
                                                    style: TextStyle(
                                                        fontFamily: 'Kunika',
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: (3.33 * scrwidth)/100,
                                                        color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                                            ? Color(0xfffef7ff)
                                                            : Colors.black87,
                                                        letterSpacing: 1,
                                                        decoration: TextDecoration.none
                                                    ),
                                                  ),
                                                )
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                      ),
                    );
                  },
                ) : Center(
                  child: Text(
                    AppLocalizations.of(context)!.nth4,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Kunika',
                      fontSize:
                      (5.83 * scrwidth) / 100,
                      color: Theme.of(context)
                          .colorScheme
                          .surface ==
                          Color(0xfffef7ff)
                          ? Colors.black87
                          : Color(0xfffef7ff),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
  double Priceprd(Order_item c){
    double ttl = 0;
    if(c.discount > 0){
      ttl += ((c.p.price * c.discount)/100 * c.qte_p);
    }else{
      ttl += (c.p.price * c.qte_p);
    }
    return ttl;
  }
}


class OrderPage extends StatefulWidget {
  final Order_item ord;
  const OrderPage({super.key, required this.ord});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late double scrheight;
  late double scrwidth;
  late KeepProvider prvd;
  
  late Order order;

  late Order_item ordr;
  @override
  void initState() {
    super.initState();
    prvd = Provider.of<KeepProvider>(context, listen: false);
    
    ordr = widget.ord;

    prvd.ords.forEach((e) {
      if(e.id == ordr.id_ord){
        order = e;
      }
    });
  }


  Widget build(BuildContext context) {
    scrheight = MediaQuery.of(context).size.height;
    scrwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation: 0,
        leading: IconButton(
          style: ButtonStyle(
              overlayColor:
              WidgetStatePropertyAll<Color>(Colors.transparent)),
          onPressed: () {
            Navigator.pop(context,'refresh');
          },
          icon: Icon(
            prvd.appLocale.languageCode == 'ar'?EvaIcons.arrowIosForward : EvaIcons.arrowIosBack,
            size: (7.5 * scrwidth) / 100,
            color:
            Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                ? Colors.black87
                : Color(0xfffef7ff),
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.ord_page,
          style: TextStyle(
            fontFamily: 'Kunika',
            fontWeight: FontWeight.bold,
            fontSize: (7.78*scrwidth)/100,
            color:
            Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                ? Colors.black87
                : Color(0xfffef7ff),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB((4.16666*scrwidth)/100, 10, (4.16666*scrwidth)/100, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.ord,
              style: TextStyle(
                fontFamily: 'Kunika',
                fontWeight: FontWeight.bold,
                fontSize: (7.78*scrwidth)/100,
                color:
                Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                    ? Colors.black87
                    : Color(0xfffef7ff),
              ),
            ),
            SizedBox(height: 15),
      Container(
          padding: EdgeInsets.symmetric(vertical: (1.5625*scrheight)/100, horizontal: (4.16666*scrwidth)/100),
          margin: EdgeInsets.only(bottom: (3.125*scrheight)/100),
          width: scrwidth,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                ? Colors.white
                : Colors.black,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff) ? Color(0x29000000) : Colors.transparent,
                  offset: Offset(0, 3),
                  blurRadius: 10,
                  spreadRadius: 1),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: (27.7777*scrwidth)/100,
                    height: (15.625*scrheight)/100,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(18),
                        image: DecorationImage(
                            image: AssetImage(ordr.p.images[0]),
                            fit: BoxFit.contain
                        )
                    ),
                  ),
                  SizedBox(
                    width: (2.7777*scrwidth)/100,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: (41.6666*scrwidth)/100,
                              child: Text(
                                ordr.p.name,
                                style: TextStyle(
                                    fontFamily: 'Kunika',
                                    fontWeight: FontWeight.bold,
                                    fontSize: (6.11*scrwidth)/100,
                                    color:
                                    Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                        ? Colors.black87
                                        : Color(0xfffef7ff),
                                    letterSpacing: 1
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.qty + ' = ' + '${ordr.qte_p}',
                              style: TextStyle(
                                  fontFamily: 'Kunika',
                                  fontWeight: FontWeight.w500,
                                  fontSize: (4.44*scrwidth)/100,
                                  color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                      ? Colors.black87
                                      : Color(0xfffef7ff),
                                  letterSpacing: 1,
                                  decoration: TextDecoration.none
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: (0.78125*scrheight)/100),
                        Visibility(
                          visible: ordr.size == '' && ordr.clr == Colors.transparent ? false : true,
                          child: Row(
                            children: [
                              ordr.size != Colors.transparent ? Container(
                                width: (5.5555*scrwidth)/100,
                                height: (3.125*scrheight)/100,
                                decoration: BoxDecoration(
                                    color: ordr.clr,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: (0.5555*scrwidth)/100,
                                      color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                          ? Colors.black87
                                          : Color(0xfffef7ff),
                                    )
                                ),
                              ) : SizedBox(),
                              ordr.clr != Colors.transparent ? SizedBox(width: (1.38888*scrwidth)/100) : SizedBox(),
                              ordr.clr != Colors.transparent ? Text(
                                AppLocalizations.of(context)!.color,
                                style: TextStyle(
                                    fontFamily: 'Kunika',
                                    fontWeight: FontWeight.w500,
                                    fontSize: (4.44*scrwidth)/100,
                                    color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                        ? Colors.black87
                                        : Color(0xfffef7ff),
                                    letterSpacing: 1,
                                    decoration: TextDecoration.none
                                ),
                              ) : SizedBox(),
                              ordr.clr != Colors.transparent ? SizedBox(width: (2.2222*scrwidth)/100) : SizedBox(),
                              ordr.clr != Colors.transparent ? Container(
                                width: (0.5555*scrwidth)/100,
                                height: (2.34375*scrheight)/100,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                        ? Colors.black87
                                        : Color(0xfffef7ff),
                                    borderRadius: BorderRadius.circular(50)
                                ),
                              ) : SizedBox(),
                              ordr.clr != Colors.transparent ? SizedBox(width: (2.2222*scrwidth)/100) : SizedBox(),
                              ordr.size != '' ? Text(
                                AppLocalizations.of(context)!.size + ' = ' + ordr.size,
                                style: TextStyle(
                                    fontFamily: 'Kunika',
                                    fontWeight: FontWeight.w500,
                                    fontSize: (4.44*scrwidth)/100,
                                    color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                        ? Colors.black87
                                        : Color(0xfffef7ff),
                                    letterSpacing: 1,
                                    decoration: TextDecoration.none
                                ),
                              ) : SizedBox(),
                            ],
                          ),
                        ),
                        SizedBox(height: (0.78125*scrheight)/100),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: (27.7777*scrwidth)/100,
                              child: Text(
                                prvd.appLocale.languageCode == 'en' ? '${Priceprd(ordr)}'+' '+AppLocalizations.of(context)!.dn : '${Priceprd(ordr)}' + ' '+ AppLocalizations.of(context)!.dn,
                                style: TextStyle(
                                    fontFamily: 'Kunika',
                                    fontWeight: FontWeight.w500,
                                    fontSize: (5.56*scrwidth)/100,
                                    color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                        ? Colors.black87
                                        : Color(0xfffef7ff),
                                    letterSpacing: 1,
                                    decoration: TextDecoration.none
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          )
      ),
            SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.clt,
              style: TextStyle(
                fontFamily: 'Kunika',
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color:
                Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                    ? Colors.black87
                    : Color(0xfffef7ff),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.liv,
                  style: TextStyle(
                    fontFamily: 'Kunika',
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color:
                    Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                        ? Colors.black87
                        : Color(0xfffef7ff),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  order.mthd_liv,
                  style: TextStyle(
                    fontFamily: 'Kunika',
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color:
                    Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                        ? Colors.black87
                        : Color(0xfffef7ff),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.ord_dt,
                  style: TextStyle(
                    fontFamily: 'Kunika',
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color:
                    Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                        ? Colors.black87
                        : Color(0xfffef7ff),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  '${order.date}',
                  style: TextStyle(
                    fontFamily: 'Kunika',
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                    color:
                    Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                        ? Colors.black87
                        : Color(0xfffef7ff),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.shp_addrs,
              style: TextStyle(
                fontFamily: 'Kunika',
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color:
                Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                    ? Colors.black87
                    : Color(0xfffef7ff),
              ),
            ),
            SizedBox(height: 8),
            Text(
              order.adress.name.toString() + ' ' + order.adress.subLocality.toString() + ' ' +  order.adress.administrativeArea.toString() + ' ' + order.adress.country.toString(),
              style: TextStyle(
                fontFamily: 'Kunika',
                fontWeight: FontWeight.bold,
                fontSize: 19,
                color:
                Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                    ? Colors.black87
                    : Color(0xfffef7ff),
              ),
            ),
          ],
        ),
      ),
    );
  }
  double Priceprd(Order_item c){
    double ttl = 0;
    if(c.discount > 0){
      ttl += ((c.p.price * c.discount)/100 * c.qte_p);
    }else{
      ttl += (c.p.price * c.qte_p);
    }
    return ttl;
  }
}


class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  late double scrheight;
  late double scrwidth;

  late KeepProvider prvd;


  TextEditingController namcnt = TextEditingController();
  TextEditingController desctcnt = TextEditingController();
  TextEditingController prccnt = TextEditingController();
  TextEditingController qtecnt = TextEditingController();

  FocusNode decfc = FocusNode();
  FocusNode prcfc = FocusNode();
  FocusNode qtefc = FocusNode();
  TextEditingController size = TextEditingController();

  Color clr = Colors.transparent;

  List<Color> product_clr = [];
  List<String> product_sz = [];
  List<File> prdct_images = [];

  bool isFile = false;

  @override
  void initState() {
    super.initState();

    prvd = Provider.of<KeepProvider>(context, listen: false);
  }

  /*Future<Uint8List> removeBgApi(File imagePath) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse("https://api.remove.bg/v1.0/removebg"));
    request.files
        .add(await http.MultipartFile.fromPath("image_file", imagePath.path));
    request.headers.addAll({"removeApi": "iUTmgDz1rxgaSDDRan5tP6Cu"}); //Put Your API key HERE
    final response = await request.send();
    if (response.statusCode == 200) {
      http.Response imgRes = await http.Response.fromStream(response);
      return imgRes.bodyBytes;
    } else {
      throw Exception("Error occurred with response ${response.statusCode}");
    }
  }*/

  Widget build(BuildContext context) {

    scrheight = MediaQuery.of(context).size.height;
    scrwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar:  AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation: 0,
        leading: IconButton(
          style: ButtonStyle(
              overlayColor:
              WidgetStatePropertyAll<Color>(Colors.transparent)),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            prvd.appLocale.languageCode == 'ar'?EvaIcons.arrowIosForward : EvaIcons.arrowIosBack,
            size: (7.5 * scrwidth) / 100,
            color:
            Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                ? Colors.black87
                : Color(0xfffef7ff),
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.add_prd,
          style: TextStyle(
            fontFamily: 'Kunika',
            fontWeight: FontWeight.bold,
            fontSize: (7.78*scrwidth)/100,
            color:
            Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                ? Colors.black
                : Color(0xfffef7ff),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB((4.16666*scrwidth)/100, 15, (4.16666*scrwidth)/100, 10),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  bottom: (3.4375 * scrheight) / 100),
              padding: EdgeInsets.symmetric(
                  horizontal: (2.7777 * scrwidth) / 100),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context)
                    .colorScheme
                    .surface ==
                    Color(0xff141218)
                    ? Color(0xd8ffffff)
                    : Color(0x1A000000),
              ),
              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: (12.5 * scrwidth) / 100,
                    height: (7.03125 * scrheight) / 100,
                    decoration: BoxDecoration(
                        color: prvd.first.withOpacity(0.2),
                        borderRadius:
                        BorderRadius.circular(10)),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.signature,
                        color: prvd.first,
                        size: (6.9444 * scrwidth) / 100,
                      ),
                    ),
                  ),
                  Container(
                    width: (69.4444 * scrwidth) / 100,
                    padding: EdgeInsets.only(
                        left: (1.94444 * scrwidth) / 100,
                        right: (0.5555 * scrwidth) / 100),
                    child: TextFormField(
                      onChanged: (v) {
                        setState(() {});
                      },
                      onEditingComplete: () {
                        FocusScope.of(context)
                            .requestFocus(decfc);
                      },
                      controller: namcnt,
                      style: TextStyle(
                          fontSize: (5 * scrwidth) / 100,
                          fontFamily: 'Kunika',
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(
                            vertical:
                            (1.25 * scrheight) /
                                100),
                        label: Padding(
                          padding: EdgeInsets.only(
                              left: (1.38888 * scrwidth) /
                                  100),
                          child: Text(
                            AppLocalizations.of(context)!.prd_nam,
                            style: TextStyle(
                                fontFamily: 'Kunika',
                                fontSize:
                                (5 * scrwidth) / 100,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff252525)),
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                      cursorColor: prvd.first,
                      cursorWidth: 2,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(
                  bottom: (3.4375 * scrheight) / 100),
              padding: EdgeInsets.symmetric(
                  horizontal: (2.7777 * scrwidth) / 100),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context)
                    .colorScheme
                    .surface ==
                    Color(0xff141218)
                    ? Color(0xd8ffffff)
                    : Color(0x1A000000),
              ),
              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: (12.5 * scrwidth) / 100,
                    height: (7.03125 * scrheight) / 100,
                    decoration: BoxDecoration(
                        color: prvd.first.withOpacity(0.2),
                        borderRadius:
                        BorderRadius.circular(10)),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.solidComment,
                        color: prvd.first,
                        size: (6.9444 * scrwidth) / 100,
                      ),
                    ),
                  ),
                  Container(
                    width: (69.4444 * scrwidth) / 100,
                    padding: EdgeInsets.only(
                        left: (1.94444 * scrwidth) / 100,
                        right: (0.5555 * scrwidth) / 100),
                    child: TextFormField(
                      focusNode: decfc,
                      onEditingComplete: () {
                        FocusScope.of(context)
                            .requestFocus(prcfc);
                      },
                      controller: desctcnt,
                      style: TextStyle(
                          fontSize: (5 * scrwidth) / 100,
                          fontFamily: 'Kunika',
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(
                            vertical:
                            (1.25 * scrheight) /
                                100),
                        label: Padding(
                          padding: EdgeInsets.only(
                              left: (1.38888 * scrwidth) /
                                  100),
                          child: Text(
                            AppLocalizations.of(context)!.prd_dec,
                            style: TextStyle(
                                fontFamily: 'Kunika',
                                fontSize:
                                (5 * scrwidth) / 100,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff252525)),
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                      cursorColor: prvd.first,
                      cursorWidth: 2,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(
                  bottom: (3.4375 * scrheight) / 100),
              padding: EdgeInsets.symmetric(
                  horizontal: (2.7777 * scrwidth) / 100),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context)
                    .colorScheme
                    .surface ==
                    Color(0xff141218)
                    ? Color(0xd8ffffff)
                    : Color(0x1A000000),
              ),
              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: (12.5 * scrwidth) / 100,
                    height: (7.03125 * scrheight) / 100,
                    decoration: BoxDecoration(
                        color: prvd.first.withOpacity(0.2),
                        borderRadius:
                        BorderRadius.circular(10)),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.moneyCheckDollar,
                        color: prvd.first,
                        size: (6.9444 * scrwidth) / 100,
                      ),
                    ),
                  ),
                  Container(
                    width: (69.4444 * scrwidth) / 100,
                    padding: EdgeInsets.only(
                        left: (1.94444 * scrwidth) / 100,
                        right: (0.5555 * scrwidth) / 100),
                    child: TextFormField(
                      focusNode: prcfc,
                      onEditingComplete: () {
                        FocusScope.of(context)
                            .requestFocus(qtefc);
                      },
                      controller: prccnt,
                      style: TextStyle(
                          fontSize: (5 * scrwidth) / 100,
                          fontFamily: 'Kunika',
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(
                            vertical:
                            (1.25 * scrheight) /
                                100),
                        label: Padding(
                          padding: EdgeInsets.only(
                              left: (1.38888 * scrwidth) /
                                  100),
                          child: Text(
                            AppLocalizations.of(context)!.prd_prc,
                            style: TextStyle(
                                fontFamily: 'Kunika',
                                fontSize:
                                (5 * scrwidth) / 100,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff252525)),
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                      cursorColor: prvd.first,
                      cursorWidth: 2,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(
                  bottom: (3.4375 * scrheight) / 100),
              padding: EdgeInsets.symmetric(
                  horizontal: (2.7777 * scrwidth) / 100),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context)
                    .colorScheme
                    .surface ==
                    Color(0xff141218)
                    ? Color(0xd8ffffff)
                    : Color(0x1A000000),
              ),
              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: (12.5 * scrwidth) / 100,
                    height: (7.03125 * scrheight) / 100,
                    decoration: BoxDecoration(
                        color: prvd.first.withOpacity(0.2),
                        borderRadius:
                        BorderRadius.circular(10)),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.boxesStacked,
                        color: prvd.first,
                        size: (6.9444 * scrwidth) / 100,
                      ),
                    ),
                  ),
                  Container(
                    width: (69.4444 * scrwidth) / 100,
                    padding: EdgeInsets.only(
                        left: (1.94444 * scrwidth) / 100,
                        right: (0.5555 * scrwidth) / 100),
                    child: TextFormField(
                      focusNode: qtefc,
                      controller: qtecnt,
                      style: TextStyle(
                          fontSize: (5 * scrwidth) / 100,
                          fontFamily: 'Kunika',
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(
                            vertical:
                            (1.25 * scrheight) /
                                100),
                        label: Padding(
                          padding: EdgeInsets.only(
                              left: (1.38888 * scrwidth) /
                                  100),
                          child: Text(
                            AppLocalizations.of(context)!.prd_qte,
                            style: TextStyle(
                                fontFamily: 'Kunika',
                                fontSize:
                                (5 * scrwidth) / 100,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff252525)),
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                      cursorColor: prvd.first,
                      cursorWidth: 2,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: scrwidth,
              child: Text(
                AppLocalizations.of(context)!.prd_clrs,
                style: TextStyle(
                    fontFamily: 'Kunika',
                    fontSize:
                    22,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context)
                        .colorScheme
                        .surface ==
                        Color(0xfffef7ff)
                        ? Colors.black87
                        : Color(0xfffef7ff)
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                SizedBox(
                  height: (7.8125*scrheight)/100,
                  width: 230,
                  child: ListView.separated(
                    separatorBuilder: (BuildContext c, int i) => SizedBox(width: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: product_clr.length,
                    itemBuilder: (context, ind){
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            product_clr.remove(product_clr[ind]);
                          });
                        },
                        child: Container(
                          width: (11.1111*scrwidth)/100,
                          height: (6.25*scrheight)/100,
                          decoration: BoxDecoration(
                              color: product_clr[ind],
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: (0.5555*scrwidth)/100,
                                color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                    ? Colors.black87
                                    : Color(0xfffef7ff),
                              )
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            AppLocalizations.of(context)!.chs_color,
                            style: TextStyle(
                                fontFamily: 'Kunika',
                                fontSize:
                                20,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context)
                                    .colorScheme
                                    .surface ==
                                    Color(0xfffef7ff)
                                    ? Colors.black87
                                    : Color(0xfffef7ff)
                            ),
                          ),
                          content: Column(
                            children: [
                              ColorPicker(
                                pickerColor: clr,
                                onColorChanged: (color) {
                                  clr = color;
                                },
                                labelTypes: [],
                              ),
                              GestureDetector(
                                onTap: () {
                                  if(!product_clr.contains(clr)){
                                    setState(() {
                                      product_clr.add(clr);
                                    });
                                    Navigator.pop(context);
                                  }else{
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Center(
                                            child: Text(
                                              AppLocalizations.of(context)!.clr_err,
                                              style: TextStyle(
                                                  fontFamily: 'Kunika',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: (5*scrwidth)/100,
                                                  color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                                      ? Colors.black87
                                                      : Color(0xfffef7ff),
                                                  letterSpacing: 1,
                                                  decoration: TextDecoration.none
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          margin: EdgeInsets.only(left: (13.8888*scrwidth)/100, right: (13.8888*scrwidth)/100, bottom: (3.125*scrheight)/100),
                                          padding: EdgeInsets.all((1.5625*scrheight)/100),
                                          backgroundColor: Colors.grey.shade400.withOpacity(0.4),
                                          duration: Duration(seconds: 1),
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                        )
                                    );
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                                  decoration: BoxDecoration(
                                      color: prvd.first,
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!.slct,
                                    style: TextStyle(
                                        fontFamily: 'Kunika',
                                        fontSize:
                                        20,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface ==
                                            Color(0xfffef7ff)
                                            ? Colors.black87
                                            : Color(0xfffef7ff)
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                    );
                  },
                  child: FaIcon(
                    FontAwesomeIcons.circlePlus,
                    size: 28,
                    color: prvd.first,
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              width: scrwidth,
              child: Text(
                AppLocalizations.of(context)!.prd_sz,
                style: TextStyle(
                    fontFamily: 'Kunika',
                    fontSize:
                    22,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context)
                        .colorScheme
                        .surface ==
                        Color(0xfffef7ff)
                        ? Colors.black87
                        : Color(0xfffef7ff)
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Row(
              children: [
                SizedBox(
                  height: (7.8125*scrheight)/100,
                  width: 230,
                  child: ListView.separated(
                    separatorBuilder: (BuildContext c, int i) => SizedBox(width: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: product_sz.length,
                    itemBuilder: (context, ind){
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            product_sz.remove(product_sz[ind]);
                          });
                        },
                        child: Container(
                          width: (11.1111*scrwidth)/100,
                          height: (6.25*scrheight)/100,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: (0.5555*scrwidth)/100,
                                color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                    ? Colors.black87
                                    : Color(0xfffef7ff),
                              )
                          ),
                          child: Center(
                            child: Text(
                              product_sz[ind],
                              style: TextStyle(
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.w500,
                                fontSize: ( 4.72*scrwidth)/100,
                                color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                    ? Colors.black87
                                    : Color(0xfffef7ff),
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            AppLocalizations.of(context)!.chs_size,
                            style: TextStyle(
                                fontFamily: 'Kunika',
                                fontSize:
                                20,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context)
                                    .colorScheme
                                    .surface ==
                                    Color(0xfffef7ff)
                                    ? Colors.black87
                                    : Color(0xfffef7ff)
                            ),
                          ),
                          content: SizedBox(
                            height: 130,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom: (3.4375 * scrheight) / 100),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: (2.7777 * scrwidth) / 100),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surface ==
                                        Color(0xff141218)
                                        ? Color(0xd8ffffff)
                                        : Color(0x1A000000),
                                  ),
                                  child: Container(
                                    width: (69.4444 * scrwidth) / 100,
                                    padding: EdgeInsets.only(
                                        left: (1.94444 * scrwidth) / 100,
                                        right: (0.5555 * scrwidth) / 100),
                                    child: TextFormField(
                                      controller: size,
                                      style: TextStyle(
                                          fontSize: (5 * scrwidth) / 100,
                                          fontFamily: 'Kunika',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87),
                                      decoration: InputDecoration(
                                        contentPadding:
                                        EdgeInsets.symmetric(
                                            vertical:
                                            (1.25 * scrheight) /
                                                100),
                                        label: Padding(
                                          padding: EdgeInsets.only(
                                              left: (1.38888 * scrwidth) /
                                                  100),
                                          child: Text(
                                            AppLocalizations.of(context)!.size,
                                            style: TextStyle(
                                                fontFamily: 'Kunika',
                                                fontSize:
                                                (5 * scrwidth) / 100,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff252525)),
                                          ),
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      cursorColor: prvd.first,
                                      cursorWidth: 2,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if(!product_sz.contains(size.text)){
                                      setState(() {
                                        product_sz.add(size.text);
                                      });
                                      Navigator.pop(context);
                                    }else{
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Center(
                                              child: Text(
                                                AppLocalizations.of(context)!.sz_err,
                                                style: TextStyle(
                                                    fontFamily: 'Kunika',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: (5*scrwidth)/100,
                                                    color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                                        ? Colors.black87
                                                        : Color(0xfffef7ff),
                                                    letterSpacing: 1,
                                                    decoration: TextDecoration.none
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            margin: EdgeInsets.only(left: (13.8888*scrwidth)/100, right: (13.8888*scrwidth)/100, bottom: (3.125*scrheight)/100),
                                            padding: EdgeInsets.all((1.5625*scrheight)/100),
                                            backgroundColor: Colors.grey.shade400.withOpacity(0.4),
                                            duration: Duration(seconds: 1),
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(50),
                                            ),
                                          )
                                      );
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                                    decoration: BoxDecoration(
                                        color: prvd.first,
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!.add_sz,
                                      style: TextStyle(
                                          fontFamily: 'Kunika',
                                          fontSize:
                                          20,
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface ==
                                              Color(0xfffef7ff)
                                              ? Colors.black87
                                              : Color(0xfffef7ff)
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    );
                  },
                  child: FaIcon(
                    FontAwesomeIcons.circlePlus,
                    size: 28,
                    color: prvd.first,
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              width: scrwidth,
              child: Text(
                AppLocalizations.of(context)!.prd_img,
                style: TextStyle(
                    fontFamily: 'Kunika',
                    fontSize:
                    22,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context)
                        .colorScheme
                        .surface ==
                        Color(0xfffef7ff)
                        ? Colors.black87
                        : Color(0xfffef7ff)
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                SizedBox(
                  height: 150,
                  width: 230,
                  child: ListView.separated(
                    separatorBuilder: (BuildContext c, int i) => SizedBox(width: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: prdct_images.length,
                    itemBuilder: (context, ind){
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            prdct_images.remove(prdct_images[ind]);
                          });
                        },
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(prdct_images[ind]),
                              fit: BoxFit.cover
                            ),
                            shape: BoxShape.circle
                          ),
                        )
                      );
                    },
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () async {
                    ImagePicker picker = ImagePicker();
                    final XFile? pickedimg =
                        await picker.pickImage(
                        source:
                        ImageSource.gallery);

                    if (pickedimg == null) {
                      setState(() {});
                    }
                    ;

                    if (pickedimg != null) {
                      File file = File(pickedimg.path);
                      //File? file2 = (await removeBgApi(file)) as File?;
                      setState(() {
                        prdct_images.add(file);
                      });
                      print(prdct_images);
                    }
                  },
                  child: FaIcon(
                    FontAwesomeIcons.circlePlus,
                    size: 28,
                    color: prvd.first,
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                if(namcnt.text.isNotEmpty && desctcnt.text.isNotEmpty && prccnt.text.isNotEmpty && qtecnt.text.isNotEmpty){
                  setState(() {

                  });
                  Navigator.pop(context,'refresh');
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Center(
                          child: Text(
                            AppLocalizations.of(context)!.chk_data,
                            style: TextStyle(
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.w500,
                                fontSize: (5*scrwidth)/100,
                                color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                    ? Colors.black87
                                    : Color(0xfffef7ff),
                                letterSpacing: 1,
                                decoration: TextDecoration.none
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        margin: EdgeInsets.only(left: (13.8888*scrwidth)/100, right: (13.8888*scrwidth)/100, bottom: (3.125*scrheight)/100),
                        padding: EdgeInsets.all((1.5625*scrheight)/100),
                        backgroundColor: Colors.grey.shade400.withOpacity(0.4),
                        duration: Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      )
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: (1.5625*scrheight)/100),
                width: scrwidth,
                height: 50,
                decoration: BoxDecoration(
                  color: prvd.first,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x29000000),
                        offset: Offset(0, 3),
                        blurRadius: 10,
                        spreadRadius: 1),
                  ],
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.add_sz,
                    style: TextStyle(
                        fontFamily: 'Kunika',
                        fontWeight: FontWeight.w500,
                        fontSize: (5.56*scrwidth)/100,
                        color: Theme.of(context).colorScheme.surface,
                        letterSpacing: 1,
                        decoration: TextDecoration.none
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddPromo extends StatefulWidget {
  final int id;
  const AddPromo({super.key, required this.id});

  @override
  State<AddPromo> createState() => _AddPromoState();
}

class _AddPromoState extends State<AddPromo> {
  late double scrheight;
  late double scrwidth;
  late KeepProvider prvd;
  late int id_prd;

  TextEditingController namcnt = TextEditingController();
  TextEditingController descnt = TextEditingController();
  TextEditingController discnt = TextEditingController();
  TextEditingController prdcnt = TextEditingController();

  FocusNode desfc = FocusNode();
  FocusNode disfc = FocusNode();
  FocusNode prdfc = FocusNode();

  @override
  void initState() {
    super.initState();
    prvd = Provider.of<KeepProvider>(context, listen: false);

    id_prd = widget.id;

  }

  Widget build(BuildContext context) {

    scrheight = MediaQuery.of(context).size.height;
    scrwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation: 0,
        leading: IconButton(
          style: ButtonStyle(
              overlayColor:
              WidgetStatePropertyAll<Color>(Colors.transparent)),
          onPressed: () {
            Navigator.pop(context,'refresh');
          },
          icon: Icon(
            prvd.appLocale.languageCode == 'ar'?EvaIcons.arrowIosForward : EvaIcons.arrowIosBack,
            size: (7.5 * scrwidth) / 100,
            color:
            Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                ? Colors.black87
                : Color(0xfffef7ff),
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.add_prm,
          style: TextStyle(
            fontFamily: 'Kunika',
            fontWeight: FontWeight.bold,
            fontSize: (7.78*scrwidth)/100,
            color:
            Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                ? Colors.black87
                : Color(0xfffef7ff),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB((4.16666*scrwidth)/100, (1.5625*scrheight)/100, (4.16666*scrwidth)/100, (1.5625*scrheight)/100),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        bottom: (3.4375 * scrheight) / 100),
                    padding: EdgeInsets.symmetric(
                        horizontal: (2.7777 * scrwidth) / 100),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context)
                          .colorScheme
                          .surface ==
                          Color(0xff141218)
                          ? Color(0xd8ffffff)
                          : Color(0x1A000000),
                    ),
                    child: Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: (12.5 * scrwidth) / 100,
                          height: (7.03125 * scrheight) / 100,
                          decoration: BoxDecoration(
                              color: prvd.first.withOpacity(0.2),
                              borderRadius:
                              BorderRadius.circular(10)),
                          child: Center(
                            child: FaIcon(
                              FontAwesomeIcons.receipt,
                              color: prvd.first,
                              size: (6.9444 * scrwidth) / 100,
                            ),
                          ),
                        ),
                        Container(
                          width: (69.4444 * scrwidth) / 100,
                          padding: EdgeInsets.only(
                              left: (1.94444 * scrwidth) / 100,
                              right: (0.5555 * scrwidth) / 100),
                          child: TextFormField(
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(desfc);
                            },
                            controller: namcnt,
                            style: TextStyle(
                                fontSize: (5 * scrwidth) / 100,
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.w500,
                                color: Colors.black87),
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.symmetric(
                                  vertical:
                                  (1.25 * scrheight) /
                                      100),
                              label: Padding(
                                padding: EdgeInsets.only(
                                    left: (1.38888 * scrwidth) /
                                        100),
                                child: Text(
                                  AppLocalizations.of(context)!.prm_nm,
                                  style: TextStyle(
                                      fontFamily: 'Kunika',
                                      fontSize:
                                      (5 * scrwidth) / 100,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff252525)),
                                ),
                              ),
                              border: InputBorder.none,
                            ),
                            cursorColor: prvd.first,
                            cursorWidth: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: (3.4375 * scrheight) / 100),
                    padding: EdgeInsets.symmetric(
                        horizontal: (2.7777 * scrwidth) / 100),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context)
                          .colorScheme
                          .surface ==
                          Color(0xff141218)
                          ? Color(0xd8ffffff)
                          : Color(0x1A000000),
                    ),
                    child: Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: (12.5 * scrwidth) / 100,
                          height: (7.03125 * scrheight) / 100,
                          decoration: BoxDecoration(
                              color: prvd.first.withOpacity(0.2),
                              borderRadius:
                              BorderRadius.circular(10)),
                          child: Center(
                            child: FaIcon(
                              FontAwesomeIcons.solidMessage,
                              color: prvd.first,
                              size: (6.9444 * scrwidth) / 100,
                            ),
                          ),
                        ),
                        Container(
                          width: (69.4444 * scrwidth) / 100,
                          padding: EdgeInsets.only(
                              left: (1.94444 * scrwidth) / 100,
                              right: (0.5555 * scrwidth) / 100),
                          child: TextFormField(
                            focusNode: desfc,
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(disfc);
                            },
                            controller: descnt,
                            style: TextStyle(
                                fontSize: (5 * scrwidth) / 100,
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.w500,
                                color: Colors.black87),
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.symmetric(
                                  vertical:
                                  (1.25 * scrheight) /
                                      100),
                              label: Padding(
                                padding: EdgeInsets.only(
                                    left: (1.38888 * scrwidth) /
                                        100),
                                child: Text(
                                  AppLocalizations.of(context)!.prm_des,
                                  style: TextStyle(
                                      fontFamily: 'Kunika',
                                      fontSize:
                                      (5 * scrwidth) / 100,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff252525)),
                                ),
                              ),
                              border: InputBorder.none,
                            ),
                            cursorColor: prvd.first,
                            cursorWidth: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: (3.4375 * scrheight) / 100),
                    padding: EdgeInsets.symmetric(
                        horizontal: (2.7777 * scrwidth) / 100),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context)
                          .colorScheme
                          .surface ==
                          Color(0xff141218)
                          ? Color(0xd8ffffff)
                          : Color(0x1A000000),
                    ),
                    child: Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: (12.5 * scrwidth) / 100,
                          height: (7.03125 * scrheight) / 100,
                          decoration: BoxDecoration(
                              color: prvd.first.withOpacity(0.2),
                              borderRadius:
                              BorderRadius.circular(10)),
                          child: Center(
                            child: FaIcon(
                              FontAwesomeIcons.percent,
                              color: prvd.first,
                              size: (6.9444 * scrwidth) / 100,
                            ),
                          ),
                        ),
                        Container(
                          width: (69.4444 * scrwidth) / 100,
                          padding: EdgeInsets.only(
                              left: (1.94444 * scrwidth) / 100,
                              right: (0.5555 * scrwidth) / 100),
                          child: TextFormField(
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(prdfc);
                            },
                            onChanged: (v) {
                              setState(() {});
                            },
                            focusNode: disfc,
                            controller: discnt,
                            style: TextStyle(
                                fontSize: (5 * scrwidth) / 100,
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.w500,
                                color: Colors.black87),
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.symmetric(
                                  vertical:
                                  (1.25 * scrheight) /
                                      100),
                              label: Padding(
                                padding: EdgeInsets.only(
                                    left: (1.38888 * scrwidth) /
                                        100),
                                child: Text(
                                  AppLocalizations.of(context)!.prm_dis,
                                  style: TextStyle(
                                      fontFamily: 'Kunika',
                                      fontSize:
                                      (5 * scrwidth) / 100,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff252525)),
                                ),
                              ),
                              border: InputBorder.none,
                            ),
                            cursorColor: prvd.first,
                            cursorWidth: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: (3.4375 * scrheight) / 100),
                    padding: EdgeInsets.symmetric(
                        horizontal: (2.7777 * scrwidth) / 100),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context)
                          .colorScheme
                          .surface ==
                          Color(0xff141218)
                          ? Color(0xd8ffffff)
                          : Color(0x1A000000),
                    ),
                    child: Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: (12.5 * scrwidth) / 100,
                          height: (7.03125 * scrheight) / 100,
                          decoration: BoxDecoration(
                              color: prvd.first.withOpacity(0.2),
                              borderRadius:
                              BorderRadius.circular(10)),
                          child: Center(
                            child: FaIcon(
                              FontAwesomeIcons.hourglassHalf,
                              color: prvd.first,
                              size: (6.9444 * scrwidth) / 100,
                            ),
                          ),
                        ),
                        Container(
                          width: (69.4444 * scrwidth) / 100,
                          padding: EdgeInsets.only(
                              left: (1.94444 * scrwidth) / 100,
                              right: (0.5555 * scrwidth) / 100),
                          child: TextFormField(
                            onChanged: (v) {
                              setState(() {});
                            },
                            focusNode: prdfc,
                            controller: prdcnt,
                            style: TextStyle(
                                fontSize: (5 * scrwidth) / 100,
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.w500,
                                color: Colors.black87),
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.symmetric(
                                  vertical:
                                  (1.25 * scrheight) /
                                      100),
                              label: Padding(
                                padding: EdgeInsets.only(
                                    left: (1.38888 * scrwidth) /
                                        100),
                                child: Text(
                                  AppLocalizations.of(context)!.prm_prud,
                                  style: TextStyle(
                                      fontFamily: 'Kunika',
                                      fontSize:
                                      (5 * scrwidth) / 100,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff252525)),
                                ),
                              ),
                              border: InputBorder.none,
                            ),
                            cursorColor: prvd.first,
                            cursorWidth: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {

                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: (1.5625*scrheight)/100),
                  width: scrwidth,
                  height: 50,
                  decoration: BoxDecoration(
                    color: prvd.first,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 10,
                          spreadRadius: 1),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.add_sz,
                      style: TextStyle(
                          fontFamily: 'Kunika',
                          fontWeight: FontWeight.w500,
                          fontSize: (5.56*scrwidth)/100,
                          color: Theme.of(context).colorScheme.surface,
                          letterSpacing: 1,
                          decoration: TextDecoration.none
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}




class SellerProfile extends StatefulWidget {
  const SellerProfile({super.key});

  @override
  State<SellerProfile> createState() => _SellerProfileState();
}

class _SellerProfileState extends State<SellerProfile> {
  late double scrwidth;
  late double scrheight;
  late KeepProvider prvd;

  bool isFile = false;

  @override
  void initState() {
    super.initState();
    prvd = Provider.of<KeepProvider>(context, listen: false);
  }

  Widget build(BuildContext context) {
    precacheImage(AssetImage('media/Vectorlogo_ext2.png'), context);
    scrwidth = MediaQuery.of(context).size.width;
    scrheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation: 0,
        leading:  Container(
          margin: prvd.appLocale.languageCode == 'en' ? EdgeInsets.only(left: (4.16666*scrwidth)/100) : EdgeInsets.only(right: (4.16666*scrwidth)/100),
          child: Image(
            image: AssetImage('media/Vectorlogo_ext2.png'),
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.prf,
          style: TextStyle(
              fontFamily: 'Kunika',
              fontWeight: FontWeight.bold,
              fontSize: (4.375*scrheight)/100,
              color:
              Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                  ? Colors.black87
                  : Color(0xfffef7ff),
              letterSpacing: 1
          ),
        ),
        centerTitle: false,
      ),
      body: SizedBox(
        width: scrwidth,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB((4.16666*scrwidth)/100, (1.5625 * scrheight)/100, (4.16666*scrwidth)/100, 0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 300),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return ImageBig(path: prvd.sllr.slr_img);
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset(1.0, 0.0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: (0.5555 * scrwidth) / 100,
                        color: Theme.of(context)
                            .colorScheme
                            .surface ==
                            Color(0xfffef7ff)
                            ? Colors.transparent
                            : Color(0xfffef7ff),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x29000000),
                            offset: Offset(0, 3),
                            blurRadius: 10,
                            spreadRadius: 5),
                      ],
                    ),
                    child: Hero(
                      tag: prvd.sllr.slr_img,
                      child: ClipOval(
                        child: Image(
                          image: AssetImage(prvd.sllr.slr_img),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: scrwidth,
                  child: Text(
                    prvd.sllr.firstname + ' ' + prvd.sllr.lastname,
                    style: TextStyle(
                        fontFamily: 'Kunika',
                        fontWeight: FontWeight.bold,
                        fontSize: (6.1111*scrwidth)/100,
                        color: Theme.of(context)
                            .colorScheme
                            .surface ==
                            Color(0xfffef7ff)
                            ? Colors.black87
                            : Color(0xfffef7ff),
                        letterSpacing: 0.5),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  '${prvd.sllr.num}',
                  style: TextStyle(
                      fontFamily: 'Kunika',
                      fontWeight: FontWeight.w400,
                      fontSize: 19,
                      color: Theme.of(context)
                          .colorScheme
                          .surface ==
                          Color(0xfffef7ff)
                          ? Colors.black87
                          : Color(0xfffef7ff),
                      letterSpacing: 0.5),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 1,
                  color: Colors.grey.shade400.withOpacity(0.3),
                ),
                ListTile(
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Edite_Sellerprofile()));
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: FaIcon(
                    FontAwesomeIcons.solidUser,
                    size: 20,
                    color: Theme.of(context)
                        .colorScheme
                        .surface ==
                        Color(0xfffef7ff)
                        ? Colors.black87
                        : Color(0xfffef7ff),
                  ),
                  title: Text(
                      AppLocalizations.of(context)!.edt_prf,
                      style: TextStyle(
                          fontFamily: 'Kunika',
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Theme.of(context)
                              .colorScheme
                              .surface ==
                              Color(0xfffef7ff)
                              ? Colors.black87
                              : Color(0xfffef7ff),
                          letterSpacing: 0.5)
                  ),
                  trailing: Icon(
                    prvd.appLocale.languageCode == 'en' ? EvaIcons.arrowIosForward : EvaIcons.arrowIosBack,
                    color: Theme.of(context)
                        .colorScheme
                        .surface ==
                        Color(0xfffef7ff)
                        ? Colors.black87
                        : Color(0xfffef7ff),
                    size: 21,
                  ),
                ),
                ListTile(
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SellerSecurity()));
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: FaIcon(
                    FontAwesomeIcons.shieldHalved,
                    size: 20,
                    color: Theme.of(context)
                        .colorScheme
                        .surface ==
                        Color(0xfffef7ff)
                        ? Colors.black87
                        : Color(0xfffef7ff),
                  ),
                  title: Text(
                      AppLocalizations.of(context)!.scrt,
                      style: TextStyle(
                          fontFamily: 'Kunika',
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Theme.of(context)
                              .colorScheme
                              .surface ==
                              Color(0xfffef7ff)
                              ? Colors.black87
                              : Color(0xfffef7ff),
                          letterSpacing: 0.5)
                  ),
                  trailing: Icon(
                    prvd.appLocale.languageCode == 'en' ? EvaIcons.arrowIosForward : EvaIcons.arrowIosBack,
                    color: Theme.of(context)
                        .colorScheme
                        .surface ==
                        Color(0xfffef7ff)
                        ? Colors.black87
                        : Color(0xfffef7ff),
                    size: 21,
                  ),
                ),
                ListTile(
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Languages()));
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: FaIcon(
                    FontAwesomeIcons.language,
                    size: 20,
                    color: Theme.of(context)
                        .colorScheme
                        .surface ==
                        Color(0xfffef7ff)
                        ? Colors.black87
                        : Color(0xfffef7ff),
                  ),
                  title: Text(
                      AppLocalizations.of(context)!.lng,
                      style: TextStyle(
                          fontFamily: 'Kunika',
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Theme.of(context)
                              .colorScheme
                              .surface ==
                              Color(0xfffef7ff)
                              ? Colors.black87
                              : Color(0xfffef7ff),
                          letterSpacing: 0.5)
                  ),
                  trailing: Icon(
                    prvd.appLocale.languageCode == 'en' ? EvaIcons.arrowIosForward : EvaIcons.arrowIosBack,
                    color: Theme.of(context)
                        .colorScheme
                        .surface ==
                        Color(0xfffef7ff)
                        ? Colors.black87
                        : Color(0xfffef7ff),
                    size: 21,
                  ),
                ),
                ListTile(
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Edite_Store()));
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: FaIcon(
                    FontAwesomeIcons.store,
                    size: 20,
                    color: Theme.of(context)
                        .colorScheme
                        .surface ==
                        Color(0xfffef7ff)
                        ? Colors.black87
                        : Color(0xfffef7ff),
                  ),
                  title: Text(
                      AppLocalizations.of(context)!.str_edt,
                      style: TextStyle(
                          fontFamily: 'Kunika',
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Theme.of(context)
                              .colorScheme
                              .surface ==
                              Color(0xfffef7ff)
                              ? Colors.black87
                              : Color(0xfffef7ff),
                          letterSpacing: 0.5)
                  ),
                  trailing: Icon(
                    prvd.appLocale.languageCode == 'en' ? EvaIcons.arrowIosForward : EvaIcons.arrowIosBack,
                    color: Theme.of(context)
                        .colorScheme
                        .surface ==
                        Color(0xfffef7ff)
                        ? Colors.black87
                        : Color(0xfffef7ff),
                    size: 21,
                  ),
                ),
                ListTile(
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicy()));
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: FaIcon(
                    FontAwesomeIcons.lock,
                    size: 20,
                    color: Theme.of(context)
                        .colorScheme
                        .surface ==
                        Color(0xfffef7ff)
                        ? Colors.black87
                        : Color(0xfffef7ff),
                  ),
                  title: Text(
                      AppLocalizations.of(context)!.prv_plc,
                      style: TextStyle(
                          fontFamily: 'Kunika',
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Theme.of(context)
                              .colorScheme
                              .surface ==
                              Color(0xfffef7ff)
                              ? Colors.black87
                              : Color(0xfffef7ff),
                          letterSpacing: 0.5)
                  ),
                  trailing: Icon(
                    prvd.appLocale.languageCode == 'en' ? EvaIcons.arrowIosForward : EvaIcons.arrowIosBack,
                    color: Theme.of(context)
                        .colorScheme
                        .surface ==
                        Color(0xfffef7ff)
                        ? Colors.black87
                        : Color(0xfffef7ff),
                    size: 21,
                  ),
                ),
                ListTile(
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HelpCenter()));
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: FaIcon(
                    FontAwesomeIcons.circleInfo,
                    size: 20,
                    color: Theme.of(context)
                        .colorScheme
                        .surface ==
                        Color(0xfffef7ff)
                        ? Colors.black87
                        : Color(0xfffef7ff),
                  ),
                  title: Text(
                      AppLocalizations.of(context)!.hlp_cnt,
                      style: TextStyle(
                          fontFamily: 'Kunika',
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Theme.of(context)
                              .colorScheme
                              .surface ==
                              Color(0xfffef7ff)
                              ? Colors.black87
                              : Color(0xfffef7ff),
                          letterSpacing: 0.5)
                  ),
                  trailing: Icon(
                    prvd.appLocale.languageCode == 'en' ? EvaIcons.arrowIosForward : EvaIcons.arrowIosBack,
                    color: Theme.of(context)
                        .colorScheme
                        .surface ==
                        Color(0xfffef7ff)
                        ? Colors.black87
                        : Color(0xfffef7ff),
                    size: 21,
                  ),
                ),
                ListTile(
                  splashColor: Colors.transparent,
                  onTap: () {

                  },
                  contentPadding: EdgeInsets.zero,
                  leading: FaIcon(
                    prvd.appLocale.languageCode == 'en' ? EvaIcons.logOut : EvaIcons.logIn,
                    size: 25,
                    color: Colors.red,
                  ),
                  title: Text(
                      AppLocalizations.of(context)!.lg_out,
                      style: TextStyle(
                          fontFamily: 'Kunika',
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Colors.red,
                          letterSpacing: 0.5)
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


/**/


class Edite_Store extends StatefulWidget {
  const Edite_Store({super.key});

  @override
  State<Edite_Store> createState() => _Edite_StoreState();
}

class _Edite_StoreState extends State<Edite_Store> with TickerProviderStateMixin{

  late KeepProvider prvd;
  late double scrwidth;
  late double scrheight;
  File? prfimg;
  bool isFile = false;


  late TextEditingController namecnt;

  late Store str;


  @override
  void initState() {
    super.initState();

    prvd = Provider.of<KeepProvider>(context, listen: false);

    prvd.strliste.forEach((e) {
      if(e.slr_id == prvd.sllr.id){
        str = e;
      }
    });



    namecnt = TextEditingController(text: str.str_name);


  }

  Widget build(BuildContext context) {
    scrwidth = MediaQuery.of(context).size.width;
    scrheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation: 0,
        leading: IconButton(
          style: ButtonStyle(
              overlayColor:
              WidgetStatePropertyAll<Color>(Colors.transparent)),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            prvd.appLocale.languageCode == 'en' ? EvaIcons.arrowIosBack : EvaIcons.arrowIosForward,
            size: (7.5 * scrwidth) / 100,
            color:
            Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                ? Colors.black87
                : Color(0xfffef7ff),
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.edt_prf,
          style: TextStyle(
            fontFamily: 'Kunika',
            fontWeight: FontWeight.bold,
            fontSize: (7.5 * scrwidth) / 100,
            color:
            Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                ? Colors.black87
                : Color(0xfffef7ff),
          ),
        ),
      ),
      body: Container(
        width: scrwidth,
        padding: EdgeInsets.fromLTRB((4.16666*scrwidth)/100, 3, (4.16666*scrwidth)/100, 10),
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  Container(
                    margin:
                    EdgeInsets.only(bottom: (2.34375 * scrheight) / 100),
                    width: (38.8888 * scrwidth) / 100,
                    height: (21.875 * scrheight) / 100,
                    child: TextButton(
                      style: ButtonStyle(
                          overlayColor: WidgetStatePropertyAll<Color>(
                              Colors.transparent)),
                      onPressed: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(40)),
                            ),
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                  padding: EdgeInsets.only(top: (1.25*scrheight)/100),
                                  width: scrwidth,
                                  height: (15.625 * scrheight) / 100,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(50),
                                          topLeft: Radius.circular(50))),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom : (1.5625 * scrheight) / 100),
                                        width: (8.3333 * scrwidth) / 100,
                                        height: (0.46875 * scrheight) / 100,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface ==
                                                Color(0xfffef7ff)
                                                ? Colors.black87
                                                : Color(0xfffef7ff),
                                            borderRadius:
                                            BorderRadius.circular(50)),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          TextButton(
                                            style: ButtonStyle(
                                                overlayColor:
                                                WidgetStatePropertyAll<
                                                    Color>(
                                                    Colors.transparent)),
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              final picker = ImagePicker();
                                              final pickedimg =
                                              await picker.pickImage(
                                                  source: ImageSource
                                                      .gallery);

                                              if (pickedimg == null) return;

                                              if (isFile == false) {
                                                final file =
                                                File(pickedimg.path);

                                                setState(() {
                                                  prfimg = file;
                                                });
                                              }
                                            },
                                            child: Container(
                                              width:
                                              (16.6666 * scrwidth) / 100,
                                              height:
                                              (9.375 * scrheight) / 100,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .surface ==
                                                    Color(0xfffef7ff)
                                                    ? Color(0xfffef7ff)
                                                    : Colors.black87,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                      Color(0x29000000),
                                                      offset: Offset(0, 3),
                                                      blurRadius: 10,
                                                      spreadRadius: 1),
                                                ],
                                              ),
                                              child: Center(
                                                child: SizedBox(
                                                  height:
                                                  (4.6875 * scrheight) /
                                                      100,
                                                  width: (8.3333 * scrwidth) /
                                                      100,
                                                  child: Image.asset(
                                                      'media/gallery.png'),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            style: ButtonStyle(
                                                overlayColor:
                                                WidgetStatePropertyAll<
                                                    Color>(
                                                    Colors.transparent)),
                                            onPressed: () async {
                                              final picker = ImagePicker();
                                              final pickedimg =
                                              await picker.pickImage(
                                                  source:
                                                  ImageSource.camera);

                                              Navigator.pop(context);

                                              if (pickedimg == null) {
                                                setState(() {});
                                              }
                                              ;

                                              if (isFile == false) {
                                                final file =
                                                File(pickedimg!.path);
                                                setState(() {
                                                  prfimg = file;
                                                });
                                              }
                                            },
                                            child: Container(
                                              //margin: EdgeInsets.only(left: (5.5555*scrwidth)/100),
                                              width:
                                              (16.6666 * scrwidth) / 100,
                                              height:
                                              (9.375 * scrheight) / 100,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .surface ==
                                                    Color(0xfffef7ff)
                                                    ? Color(0xfffef7ff)
                                                    : Colors.black87,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                      Color(0x29000000),
                                                      offset: Offset(0, 3),
                                                      blurRadius: 10,
                                                      spreadRadius: 1),
                                                ],
                                              ),
                                              child: Center(
                                                child: SizedBox(
                                                  height:
                                                  (4.6875 * scrheight) /
                                                      100,
                                                  width: (8.3333 * scrwidth) /
                                                      100,
                                                  child: Image.asset(
                                                      'media/camera.png'),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            style: ButtonStyle(
                                                overlayColor:
                                                WidgetStatePropertyAll<
                                                    Color>(
                                                    Colors.transparent)),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              setState(() {
                                                prfimg = null;
                                              });
                                            },
                                            child: Container(
                                              //margin: EdgeInsets.only(right: (5.5555*scrwidth)/100),
                                              width:
                                              (16.6666 * scrwidth) / 100,
                                              height:
                                              (9.375 * scrheight) / 100,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .surface ==
                                                    Color(0xfffef7ff)
                                                    ? Color(0xfffef7ff)
                                                    : Colors.black87,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                      Color(0x29000000),
                                                      offset: Offset(0, 3),
                                                      blurRadius: 10,
                                                      spreadRadius: 1),
                                                ],
                                              ),
                                              child: Center(
                                                child: SizedBox(
                                                  height:
                                                  (4.6875 * scrheight) /
                                                      100,
                                                  width: (8.3333 * scrwidth) /
                                                      100,
                                                  child: Image.asset(
                                                      'media/bin.png'),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ));
                            });
                      },
                      child: Container(
                        padding: EdgeInsets.only(bottom: (0.78125 * scrheight)/100),
                        width: (33.3333 * scrwidth) / 100,
                        height: (18.75 * scrheight) / 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: (0.5555 * scrwidth) / 100,
                              color: Theme.of(context)
                                  .colorScheme
                                  .surface ==
                                  Color(0xfffef7ff)
                                  ? Colors.transparent
                                  : Color(0xfffef7ff),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0x29000000),
                                  offset: Offset(0, 3),
                                  blurRadius: 10,
                                  spreadRadius: 5),
                            ],
                            image: DecorationImage(
                                image: buildFileImage(),
                                fit: BoxFit.cover)),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: (8.3333 * scrwidth) / 100,
                            height: (4.6875 * scrheight) / 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: prvd.first),
                            child: Center(
                              child: Icon(
                                EvaIcons.edit,
                                size: ( 5.5556 * scrwidth) / 100,
                                color: Theme.of(context)
                                    .colorScheme
                                    .surface,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.grey.shade400.withOpacity(0.3),
                  ),
                  SizedBox(height: 25),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: (3.4375 * scrheight) / 100),
                    padding: EdgeInsets.symmetric(
                        horizontal: (2.7777 * scrwidth) / 100),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context)
                          .colorScheme
                          .surface ==
                          Color(0xff141218)
                          ? Color(0xd8ffffff)
                          : Color(0x1A000000),
                    ),
                    child: Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: (12.5 * scrwidth) / 100,
                          height: (7.03125 * scrheight) / 100,
                          decoration: BoxDecoration(
                              color: prvd.first.withOpacity(0.2),
                              borderRadius:
                              BorderRadius.circular(10)),
                          child: Icon(
                            EvaIcons.person,
                            color: prvd.first,
                            size: (6.9444 * scrwidth) / 100,
                          ),
                        ),
                        Container(
                          width: (69.4444 * scrwidth) / 100,
                          padding: EdgeInsets.only(
                              left: (1.94444 * scrwidth) / 100,
                              right: (0.5555 * scrwidth) / 100),
                          child: TextFormField(
                            onChanged: (v) {
                              setState(() {});
                            },
                            controller: namecnt,
                            style: TextStyle(
                                fontSize: (5 * scrwidth) / 100,
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.w500,
                                color: Colors.black87),
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.symmetric(
                                  vertical:
                                  (1.25 * scrheight) /
                                      100),
                              label: Padding(
                                padding: EdgeInsets.only(
                                    left: (1.38888 * scrwidth) /
                                        100),
                                child: Text(
                                  AppLocalizations.of(context)!.frst_nm,
                                  style: TextStyle(
                                      fontFamily: 'Kunika',
                                      fontSize:
                                      (5 * scrwidth) / 100,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff252525)),
                                ),
                              ),
                              border: InputBorder.none,
                            ),
                            cursorColor: prvd.first,
                            cursorWidth: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {

                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: (1.5625*scrheight)/100, horizontal: (5.5555*scrwidth)/100),
                  width: scrwidth,
                  decoration: BoxDecoration(
                    color: prvd.first,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 10,
                          spreadRadius: 1),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.updt,
                        style: TextStyle(
                            fontFamily: 'Kunika',
                            fontWeight: FontWeight.w500,
                            fontSize: (5.56*scrwidth)/100,
                            color: Theme.of(context).colorScheme.surface,
                            letterSpacing: 1,
                            decoration: TextDecoration.none
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ),
    );
  }
  ImageProvider<Object> buildFileImage() {
    if (prfimg == null) {
      return AssetImage(str.str_image);
    } else {
      return FileImage(prfimg as File);
    }
  }
}

class SellerSecurity extends StatefulWidget {
  const SellerSecurity({super.key});

  @override
  State<SellerSecurity> createState() => _SellerSecurityState();
}

class _SellerSecurityState extends State<SellerSecurity> {

  late KeepProvider prvd;
  late double scrwidth;
  late double scrheight;

  bool errpass = false;
  bool errpass1 = false;
  bool showpasswrd = false;
  bool showpasswrd1 = false;
  bool showpasswrd2 = false;


  TextEditingController pvpastcnt = TextEditingController();
  TextEditingController nwpastcnt = TextEditingController();
  TextEditingController cnwpastcnt = TextEditingController();

  FocusNode fcs = FocusNode();
  FocusNode fcs1 = FocusNode();

  @override
  void initState() {
    super.initState();
    prvd = Provider.of<KeepProvider>(context, listen: false);

  }


  Widget build(BuildContext context) {

    scrwidth = MediaQuery.of(context).size.width;
    scrheight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation: 0,
        leading: IconButton(
          style: ButtonStyle(
              overlayColor:
              WidgetStatePropertyAll<Color>(Colors.transparent)),
          onPressed: () {
            Navigator.pop(context,'refresh');
          },
          icon: Icon(
            prvd.appLocale.languageCode == 'en' ? EvaIcons.arrowIosBack : EvaIcons.arrowIosForward,
            size: (7.5 * scrwidth) / 100,
            color:
            Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                ? Colors.black87
                : Color(0xfffef7ff),
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.scrt,
          style: TextStyle(
            fontFamily: 'Kunika',
            fontWeight: FontWeight.bold,
            fontSize: (7.5 * scrwidth) / 100,
            color:
            Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                ? Colors.black87
                : Color(0xfffef7ff),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: scrwidth,
          height: 560,
          padding: EdgeInsets.fromLTRB((4.16666*scrwidth)/100, 10, (4.16666*scrwidth)/100, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: (2.7777 * scrwidth) / 100),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.surface ==
                            Color(0xff141218)
                            ? Color(0xd8ffffff)
                            : Color(0x1A000000),
                        border: Border.all(
                            width: 1,
                            color: Colors.transparent)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: (12.5 * scrwidth) / 100,
                            height: (7.03125 * scrheight) / 100,
                            decoration: BoxDecoration(
                                color: prvd.first.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10)),
                            child: IconButton(
                                style: ButtonStyle(
                                  overlayColor:
                                  WidgetStateProperty.all(Colors.transparent),
                                ),
                                icon: showpasswrd
                                    ? Icon(
                                  EvaIcons.eyeOff,
                                  size: (6.9444 * scrwidth) / 100,
                                  color: prvd.first,
                                )
                                    : Icon(
                                  EvaIcons.eye,
                                  size: (6.9444 * scrwidth) / 100,
                                  color: prvd.first,
                                ),
                                onPressed: () {
                                  setState(() {
                                    showpasswrd = !showpasswrd;
                                  });
                                })),
                        Container(
                          width: (69.4444 * scrwidth) / 100,
                          padding: EdgeInsets.only(
                              left: (1.94444 * scrwidth) / 100,
                              right: (0.5555 * scrwidth) / 100),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {});
                            },
                            onEditingComplete: () {
                              FocusScope.of(context).requestFocus(fcs);
                            },
                            controller: pvpastcnt,
                            style: TextStyle(
                                fontSize: (5 * scrwidth) / 100,
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.w500,
                                color: Colors.black87),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: (1.25 * scrheight) / 100),
                              label: Padding(
                                padding:
                                EdgeInsets.only(left: (1.38888 * scrwidth) / 100),
                                child: Text(
                                  AppLocalizations.of(context)!.prpass,
                                  style: TextStyle(
                                      fontFamily: 'Kunika',
                                      fontSize: (5 * scrwidth) / 100,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff252525)),
                                ),
                              ),
                              border: InputBorder.none,
                            ),
                            cursorColor: prvd.first,
                            cursorWidth: 2,
                            obscureText: !showpasswrd,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: (2.7777 * scrwidth) / 100),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.surface ==
                            Color(0xff141218)
                            ? Color(0xd8ffffff)
                            : Color(0x1A000000),
                        border: Border.all(
                            width: 1,
                            color: errpass ? Colors.red : Colors.transparent)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: (12.5 * scrwidth) / 100,
                            height: (7.03125 * scrheight) / 100,
                            decoration: BoxDecoration(
                                color: prvd.first.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10)),
                            child: IconButton(
                                style: ButtonStyle(
                                  overlayColor:
                                  WidgetStateProperty.all(Colors.transparent),
                                ),
                                icon: showpasswrd1
                                    ? Icon(
                                  EvaIcons.eyeOff,
                                  size: (6.9444 * scrwidth) / 100,
                                  color: prvd.first,
                                )
                                    : Icon(
                                  EvaIcons.eye,
                                  size: (6.9444 * scrwidth) / 100,
                                  color: prvd.first,
                                ),
                                onPressed: () {
                                  setState(() {
                                    showpasswrd1 = !showpasswrd1;
                                  });
                                })),
                        Container(
                          width: (69.4444 * scrwidth) / 100,
                          padding: EdgeInsets.only(
                              left: (1.94444 * scrwidth) / 100,
                              right: (0.5555 * scrwidth) / 100),
                          child: TextFormField(
                            focusNode: fcs,
                            onChanged: (value) {
                              setState(() {});
                            },
                            onEditingComplete: () {
                              FocusScope.of(context).requestFocus(fcs1);
                            },
                            controller: nwpastcnt,
                            style: TextStyle(
                                fontSize: (5 * scrwidth) / 100,
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.w500,
                                color: Colors.black87),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: (1.25 * scrheight) / 100),
                              label: Padding(
                                padding:
                                EdgeInsets.only(left: (1.38888 * scrwidth) / 100),
                                child: Text(
                                  AppLocalizations.of(context)!.nwpass,
                                  style: TextStyle(
                                      fontFamily: 'Kunika',
                                      fontSize: (5 * scrwidth) / 100,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff252525)),
                                ),
                              ),
                              border: InputBorder.none,
                            ),
                            cursorColor: prvd.first,
                            cursorWidth: 2,
                            obscureText: !showpasswrd1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: (2.7777 * scrwidth) / 100),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.surface ==
                            Color(0xff141218)
                            ? Color(0xd8ffffff)
                            : Color(0x1A000000),
                        border: Border.all(
                            width: 1,
                            color: errpass1 ? Colors.red : Colors.transparent)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: (12.5 * scrwidth) / 100,
                            height: (7.03125 * scrheight) / 100,
                            decoration: BoxDecoration(
                                color: prvd.first.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10)),
                            child: IconButton(
                                style: ButtonStyle(
                                  overlayColor:
                                  WidgetStateProperty.all(Colors.transparent),
                                ),
                                icon: showpasswrd2
                                    ? Icon(
                                  EvaIcons.eyeOff,
                                  size: (6.9444 * scrwidth) / 100,
                                  color: prvd.first,
                                )
                                    : Icon(
                                  EvaIcons.eye,
                                  size: (6.9444 * scrwidth) / 100,
                                  color: prvd.first,
                                ),
                                onPressed: () {
                                  setState(() {
                                    showpasswrd2 = !showpasswrd2;
                                  });
                                })),
                        Container(
                          width: (69.4444 * scrwidth) / 100,
                          padding: EdgeInsets.only(
                              left: (1.94444 * scrwidth) / 100,
                              right: (0.5555 * scrwidth) / 100),
                          child: TextFormField(
                            focusNode: fcs1,
                            onChanged: (value) {
                              setState(() {});
                            },
                            controller: cnwpastcnt,
                            style: TextStyle(
                                fontSize: (5 * scrwidth) / 100,
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.w500,
                                color: Colors.black87),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: (1.25 * scrheight) / 100),
                              label: Padding(
                                padding:
                                EdgeInsets.only(left: (1.38888 * scrwidth) / 100),
                                child: Text(
                                  AppLocalizations.of(context)!.cnpass,
                                  style: TextStyle(
                                      fontFamily: 'Kunika',
                                      fontSize: (5 * scrwidth) / 100,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff252525)),
                                ),
                              ),
                              border: InputBorder.none,
                            ),
                            cursorColor: prvd.first,
                            cursorWidth: 2,
                            obscureText: !showpasswrd2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () async{
                  if(pvpastcnt.text.isNotEmpty && nwpastcnt.text.isNotEmpty && cnwpastcnt.text.isNotEmpty && nwpastcnt.text == cnwpastcnt.text && nwpastcnt.text.length >= 6){
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Center(
                            child: Text(
                              AppLocalizations.of(context)!.upd_succ,
                              style: TextStyle(
                                  fontFamily: 'Kunika',
                                  fontWeight: FontWeight.w500,
                                  fontSize: (5*scrwidth)/100,
                                  color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                      ? Colors.black87
                                      : Color(0xfffef7ff),
                                  letterSpacing: 1,
                                  decoration: TextDecoration.none
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          margin: EdgeInsets.only(left: (13.8888*scrwidth)/100, right: (13.8888*scrwidth)/100, bottom: (3.125*scrheight)/100),
                          padding: EdgeInsets.all((1.5625*scrheight)/100),
                          backgroundColor: Colors.grey.shade400.withOpacity(0.4),
                          duration: Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        )
                    );
                  }else if(nwpastcnt.text.length < 6){
                    setState(() {
                      errpass = !errpass;
                    });
                    Vibration.vibrate(duration: 200);
                    Future.delayed(Duration(milliseconds: 500), (){
                      setState(() {
                        errpass = !errpass;
                      });
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Center(
                            child: Text(
                              AppLocalizations.of(context)!.pass6,
                              style: TextStyle(
                                  fontFamily: 'Kunika',
                                  fontWeight: FontWeight.w500,
                                  fontSize: (5*scrwidth)/100,
                                  color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                      ? Colors.black87
                                      : Color(0xfffef7ff),
                                  letterSpacing: 1,
                                  decoration: TextDecoration.none
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          margin: EdgeInsets.only(left: (13.8888*scrwidth)/100, right: (13.8888*scrwidth)/100, bottom: (3.125*scrheight)/100),
                          padding: EdgeInsets.all((1.5625*scrheight)/100),
                          backgroundColor: Colors.grey.shade400.withOpacity(0.4),
                          duration: Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        )
                    );
                  }else if(nwpastcnt.text != cnwpastcnt.text){
                    setState(() {
                      errpass = !errpass;
                      errpass1 = !errpass1;
                    });
                    Vibration.vibrate(duration: 200);
                    Future.delayed(Duration(milliseconds: 500), (){
                      setState(() {
                        errpass = !errpass;
                        errpass1 = !errpass1;
                      });
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Center(
                            child: Text(
                              AppLocalizations.of(context)!.notpass,
                              style: TextStyle(
                                  fontFamily: 'Kunika',
                                  fontWeight: FontWeight.w500,
                                  fontSize: (5*scrwidth)/100,
                                  color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                      ? Colors.black87
                                      : Color(0xfffef7ff),
                                  letterSpacing: 1,
                                  decoration: TextDecoration.none
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          margin: EdgeInsets.only(left: (13.8888*scrwidth)/100, right: (13.8888*scrwidth)/100, bottom: (3.125*scrheight)/100),
                          padding: EdgeInsets.all((1.5625*scrheight)/100),
                          backgroundColor: Colors.grey.shade400.withOpacity(0.4),
                          duration: Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        )
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: (1.5625*scrheight)/100, horizontal: (5.5555*scrwidth)/100),
                  width: scrwidth,
                  decoration: BoxDecoration(
                    color: prvd.first,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 10,
                          spreadRadius: 1),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.updt,
                        style: TextStyle(
                            fontFamily: 'Kunika',
                            fontWeight: FontWeight.w500,
                            fontSize: (5.56*scrwidth)/100,
                            color: Theme.of(context).colorScheme.surface,
                            letterSpacing: 1,
                            decoration: TextDecoration.none
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class Edite_Sellerprofile extends StatefulWidget {
  const Edite_Sellerprofile({super.key});

  @override
  State<Edite_Sellerprofile> createState() => _Edite_SellerprofileState();
}

class _Edite_SellerprofileState extends State<Edite_Sellerprofile> with TickerProviderStateMixin{

  late KeepProvider prvd;
  late double scrwidth;
  late double scrheight;
  bool isFile = false;
  File? prfimg;
  bool clicked = false;
  bool clicked1 = false;

  PhoneNumber _initnum = PhoneNumber(isoCode: 'DZ');

  String gender = '';

  late AnimationController _scalanimationcnt;
  late AnimationController _scalanimationcnt1;

  late TextEditingController lastcnt;
  late TextEditingController firstcnt;
  late TextEditingController phnnmcnt;
  late TextEditingController emailcnt;
  late DateTime _birthdate;

  late Animation<double> _scale;
  late Animation<double> _scale1;

  bool slid = false;

  @override
  void initState() {
    super.initState();

    prvd = Provider.of<KeepProvider>(context, listen: false);
    firstcnt = TextEditingController(text: prvd.sllr.firstname);
    lastcnt = TextEditingController(text: prvd.sllr.lastname);
    phnnmcnt = TextEditingController(text: prvd.sllr.num.toString());
    emailcnt = TextEditingController(text: prvd.sllr.email);
    _birthdate = prvd.user.date_brth;

    _scalanimationcnt =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _scale = Tween(begin: 1.0, end: 1.05).animate(_scalanimationcnt)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _scalanimationcnt.reverse();
        }
      });
    _scalanimationcnt1 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _scale1= Tween(begin: 1.0, end: 1.05).animate(_scalanimationcnt1)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _scalanimationcnt1.reverse();
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _scalanimationcnt.dispose();
  }



  FocusNode fcsnm = FocusNode();
  FocusNode fcseml = FocusNode();


  Widget build(BuildContext context) {
    scrwidth = MediaQuery.of(context).size.width;
    scrheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation: 0,
        leading: IconButton(
          style: ButtonStyle(
              overlayColor:
              WidgetStatePropertyAll<Color>(Colors.transparent)),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            prvd.appLocale.languageCode == 'en' ? EvaIcons.arrowIosBack : EvaIcons.arrowIosForward,
            size: (7.5 * scrwidth) / 100,
            color:
            Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                ? Colors.black87
                : Color(0xfffef7ff),
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.edt_prf,
          style: TextStyle(
            fontFamily: 'Kunika',
            fontWeight: FontWeight.bold,
            fontSize: (7.5 * scrwidth) / 100,
            color:
            Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                ? Colors.black87
                : Color(0xfffef7ff),
          ),
        ),
      ),
      body: Container(
        width: scrwidth,
        padding: EdgeInsets.fromLTRB((4.16666*scrwidth)/100, 3, (4.16666*scrwidth)/100, 0),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              Container(
                margin:
                EdgeInsets.only(bottom: (2.34375 * scrheight) / 100),
                width: (38.8888 * scrwidth) / 100,
                height: (21.875 * scrheight) / 100,
                child: TextButton(
                  style: ButtonStyle(
                      overlayColor: WidgetStatePropertyAll<Color>(
                          Colors.transparent)),
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(40)),
                        ),
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                              padding: EdgeInsets.only(top: (1.25*scrheight)/100),
                              width: scrwidth,
                              height: (15.625 * scrheight) / 100,
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surface,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(50),
                                      topLeft: Radius.circular(50))),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom : (1.5625 * scrheight) / 100),
                                    width: (8.3333 * scrwidth) / 100,
                                    height: (0.46875 * scrheight) / 100,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface ==
                                            Color(0xfffef7ff)
                                            ? Colors.black87
                                            : Color(0xfffef7ff),
                                        borderRadius:
                                        BorderRadius.circular(50)),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: <Widget>[
                                      TextButton(
                                        style: ButtonStyle(
                                            overlayColor:
                                            WidgetStatePropertyAll<
                                                Color>(
                                                Colors.transparent)),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          final picker = ImagePicker();
                                          final pickedimg =
                                          await picker.pickImage(
                                              source: ImageSource
                                                  .gallery);

                                          if (pickedimg == null) return;

                                          if (isFile == false) {
                                            final file =
                                            File(pickedimg.path);

                                            setState(() {
                                              prfimg = file;
                                            });
                                          }
                                        },
                                        child: Container(
                                          width:
                                          (16.6666 * scrwidth) / 100,
                                          height:
                                          (9.375 * scrheight) / 100,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface ==
                                                Color(0xfffef7ff)
                                                ? Color(0xfffef7ff)
                                                : Colors.black87,
                                            boxShadow: [
                                              BoxShadow(
                                                  color:
                                                  Color(0x29000000),
                                                  offset: Offset(0, 3),
                                                  blurRadius: 10,
                                                  spreadRadius: 1),
                                            ],
                                          ),
                                          child: Center(
                                            child: SizedBox(
                                              height:
                                              (4.6875 * scrheight) /
                                                  100,
                                              width: (8.3333 * scrwidth) /
                                                  100,
                                              child: Image.asset(
                                                  'media/gallery.png'),
                                            ),
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        style: ButtonStyle(
                                            overlayColor:
                                            WidgetStatePropertyAll<
                                                Color>(
                                                Colors.transparent)),
                                        onPressed: () async {
                                          final picker = ImagePicker();
                                          final pickedimg =
                                          await picker.pickImage(
                                              source:
                                              ImageSource.camera);

                                          Navigator.pop(context);

                                          if (pickedimg == null) {
                                            setState(() {});
                                          }
                                          ;

                                          if (isFile == false) {
                                            final file =
                                            File(pickedimg!.path);
                                            setState(() {
                                              prfimg = file;
                                            });
                                          }
                                        },
                                        child: Container(
                                          //margin: EdgeInsets.only(left: (5.5555*scrwidth)/100),
                                          width:
                                          (16.6666 * scrwidth) / 100,
                                          height:
                                          (9.375 * scrheight) / 100,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface ==
                                                Color(0xfffef7ff)
                                                ? Color(0xfffef7ff)
                                                : Colors.black87,
                                            boxShadow: [
                                              BoxShadow(
                                                  color:
                                                  Color(0x29000000),
                                                  offset: Offset(0, 3),
                                                  blurRadius: 10,
                                                  spreadRadius: 1),
                                            ],
                                          ),
                                          child: Center(
                                            child: SizedBox(
                                              height:
                                              (4.6875 * scrheight) /
                                                  100,
                                              width: (8.3333 * scrwidth) /
                                                  100,
                                              child: Image.asset(
                                                  'media/camera.png'),
                                            ),
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        style: ButtonStyle(
                                            overlayColor:
                                            WidgetStatePropertyAll<
                                                Color>(
                                                Colors.transparent)),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          setState(() {
                                            prfimg = null;
                                          });
                                        },
                                        child: Container(
                                          //margin: EdgeInsets.only(right: (5.5555*scrwidth)/100),
                                          width:
                                          (16.6666 * scrwidth) / 100,
                                          height:
                                          (9.375 * scrheight) / 100,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface ==
                                                Color(0xfffef7ff)
                                                ? Color(0xfffef7ff)
                                                : Colors.black87,
                                            boxShadow: [
                                              BoxShadow(
                                                  color:
                                                  Color(0x29000000),
                                                  offset: Offset(0, 3),
                                                  blurRadius: 10,
                                                  spreadRadius: 1),
                                            ],
                                          ),
                                          child: Center(
                                            child: SizedBox(
                                              height:
                                              (4.6875 * scrheight) /
                                                  100,
                                              width: (8.3333 * scrwidth) /
                                                  100,
                                              child: Image.asset(
                                                  'media/bin.png'),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ));
                        });
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: (0.78125 * scrheight)/100),
                    width: (33.3333 * scrwidth) / 100,
                    height: (18.75 * scrheight) / 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: (0.5555 * scrwidth) / 100,
                          color: Theme.of(context)
                              .colorScheme
                              .surface ==
                              Color(0xfffef7ff)
                              ? Colors.transparent
                              : Color(0xfffef7ff),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x29000000),
                              offset: Offset(0, 3),
                              blurRadius: 10,
                              spreadRadius: 5),
                        ],
                        image: DecorationImage(
                            image: buildFileImage(),
                            fit: BoxFit.cover)),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: (8.3333 * scrwidth) / 100,
                        height: (4.6875 * scrheight) / 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: prvd.first),
                        child: Center(
                          child: Icon(
                            EvaIcons.edit,
                            size: ( 5.5556 * scrwidth) / 100,
                            color: Theme.of(context)
                                .colorScheme
                                .surface,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey.shade400.withOpacity(0.3),
              ),
              SizedBox(height: 25),
              Container(
                margin: EdgeInsets.only(
                    bottom: (3.4375 * scrheight) / 100),
                padding: EdgeInsets.symmetric(
                    horizontal: (2.7777 * scrwidth) / 100),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context)
                      .colorScheme
                      .surface ==
                      Color(0xff141218)
                      ? Color(0xd8ffffff)
                      : Color(0x1A000000),
                ),
                child: Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: (12.5 * scrwidth) / 100,
                      height: (7.03125 * scrheight) / 100,
                      decoration: BoxDecoration(
                          color: prvd.first.withOpacity(0.2),
                          borderRadius:
                          BorderRadius.circular(10)),
                      child: Icon(
                        EvaIcons.person,
                        color: prvd.first,
                        size: (6.9444 * scrwidth) / 100,
                      ),
                    ),
                    Container(
                      width: (69.4444 * scrwidth) / 100,
                      padding: EdgeInsets.only(
                          left: (1.94444 * scrwidth) / 100,
                          right: (0.5555 * scrwidth) / 100),
                      child: TextFormField(
                        onChanged: (v) {
                          setState(() {});
                        },
                        onEditingComplete: () {
                          FocusScope.of(context)
                              .requestFocus(fcsnm);
                        },
                        controller: firstcnt,
                        style: TextStyle(
                            fontSize: (5 * scrwidth) / 100,
                            fontFamily: 'Kunika',
                            fontWeight: FontWeight.w500,
                            color: Colors.black87),
                        decoration: InputDecoration(
                          contentPadding:
                          EdgeInsets.symmetric(
                              vertical:
                              (1.25 * scrheight) /
                                  100),
                          label: Padding(
                            padding: EdgeInsets.only(
                                left: (1.38888 * scrwidth) /
                                    100),
                            child: Text(
                              AppLocalizations.of(context)!.frst_nm,
                              style: TextStyle(
                                  fontFamily: 'Kunika',
                                  fontSize:
                                  (5 * scrwidth) / 100,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff252525)),
                            ),
                          ),
                          border: InputBorder.none,
                        ),
                        cursorColor: prvd.first,
                        cursorWidth: 2,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Container(
                margin: EdgeInsets.only(
                    bottom: (3.4375 * scrheight) / 100),
                padding: EdgeInsets.symmetric(
                    horizontal: (2.7777 * scrwidth) / 100),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context)
                      .colorScheme
                      .surface ==
                      Color(0xff141218)
                      ? Color(0xd8ffffff)
                      : Color(0x1A000000),
                ),
                child: Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: (12.5 * scrwidth) / 100,
                      height: (7.03125 * scrheight) / 100,
                      decoration: BoxDecoration(
                          color: prvd.first.withOpacity(0.2),
                          borderRadius:
                          BorderRadius.circular(10)),
                      child: Icon(
                        EvaIcons.person,
                        color: prvd.first,
                        size: (6.9444 * scrwidth) / 100,
                      ),
                    ),
                    Container(
                      width: (69.4444 * scrwidth) / 100,
                      padding: EdgeInsets.only(
                          left: (1.94444 * scrwidth) / 100,
                          right: (0.5555 * scrwidth) / 100),
                      child: TextFormField(
                        onChanged: (v) {
                          setState(() {});
                        },
                        onEditingComplete: () {
                          FocusScope.of(context)
                              .requestFocus(fcseml);
                        },
                        focusNode: fcsnm,
                        controller: lastcnt,
                        style: TextStyle(
                            fontSize: (5 * scrwidth) / 100,
                            fontFamily: 'Kunika',
                            fontWeight: FontWeight.w500,
                            color: Colors.black87),
                        decoration: InputDecoration(
                          contentPadding:
                          EdgeInsets.symmetric(
                              vertical:
                              (1.25 * scrheight) /
                                  100),
                          label: Padding(
                            padding: EdgeInsets.only(
                                left: (1.38888 * scrwidth) /
                                    100),
                            child: Text(
                              AppLocalizations.of(context)!.lst_nm,
                              style: TextStyle(
                                  fontFamily: 'Kunika',
                                  fontSize:
                                  (5 * scrwidth) / 100,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff252525)),
                            ),
                          ),
                          border: InputBorder.none,
                        ),
                        cursorColor: prvd.first,
                        cursorWidth: 2,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Container(
                margin: EdgeInsets.only(
                    bottom: (3.4375 * scrheight) / 100),
                padding: EdgeInsets.symmetric(
                    horizontal: (2.7777 * scrwidth) / 100),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context)
                      .colorScheme
                      .surface ==
                      Color(0xff141218)
                      ? Color(0xd8ffffff)
                      : Color(0x1A000000),
                ),
                child: Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: (12.5 * scrwidth) / 100,
                      height: (7.03125 * scrheight) / 100,
                      decoration: BoxDecoration(
                          color: prvd.first.withOpacity(0.2),
                          borderRadius:
                          BorderRadius.circular(10)),
                      child: Icon(
                        EvaIcons.email,
                        color: prvd.first,
                        size: (6.9444 * scrwidth) / 100,
                      ),
                    ),
                    Container(
                      width: (69.4444 * scrwidth) / 100,
                      padding: EdgeInsets.only(
                          left: (1.94444 * scrwidth) / 100,
                          right: (0.5555 * scrwidth) / 100),
                      child: TextFormField(
                        onChanged: (v) {
                          setState(() {});
                        },
                        focusNode: fcseml,
                        controller: emailcnt,
                        style: TextStyle(
                            fontSize: (5 * scrwidth) / 100,
                            fontFamily: 'Kunika',
                            fontWeight: FontWeight.w500,
                            color: Colors.black87),
                        decoration: InputDecoration(
                          contentPadding:
                          EdgeInsets.symmetric(
                              vertical:
                              (1.25 * scrheight) /
                                  100),
                          label: Padding(
                            padding: EdgeInsets.only(
                                left: (1.38888 * scrwidth) /
                                    100),
                            child: Text(
                              AppLocalizations.of(context)!.eml,
                              style: TextStyle(
                                  fontFamily: 'Kunika',
                                  fontSize:
                                  (5 * scrwidth) / 100,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff252525)),
                            ),
                          ),
                          border: InputBorder.none,
                        ),
                        cursorColor: prvd.first,
                        cursorWidth: 2,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Container(
                height: (9.0625 * scrheight) / 100,
                margin: EdgeInsets.only(
                    bottom: (3.4375 * scrheight) / 100),
                padding: EdgeInsets.symmetric(
                    horizontal: (2.7777 * scrwidth) / 100),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context)
                      .colorScheme
                      .surface ==
                      Color(0xff141218)
                      ? Color(0xd8ffffff)
                      : Color(0x1A000000),
                ),
                child: Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: (12.5 * scrwidth) / 100,
                      height: (7.03125 * scrheight) / 100,
                      decoration: BoxDecoration(
                          color: prvd.first.withOpacity(0.2),
                          borderRadius:
                          BorderRadius.circular(10)),
                      child: IconButton(
                        onPressed: () {
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now())
                              .then((value) {
                            setState(() {
                              _birthdate = value!;
                            });
                          });
                        },
                        style: ButtonStyle(
                            overlayColor:
                            WidgetStatePropertyAll<
                                Color>(
                                Colors.transparent),
                            padding: WidgetStatePropertyAll<
                                EdgeInsetsGeometry>(
                                EdgeInsets.zero)),
                        icon: Icon(
                          EvaIcons.calendar,
                          color: prvd.first,
                          size: (6.9444 * scrwidth) / 100,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: (3.3333 * scrwidth) / 100),
                      child: Text(
                        _birthdate.day.toString() +
                            '/' +
                            _birthdate.month.toString() +
                            '/' +
                            _birthdate.year.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Kunika',
                          fontSize: (5.5556 * scrwidth) / 100,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 5),
              Container(
                margin: EdgeInsets.only(
                    bottom: (3.4375 * scrheight) / 100),
                padding: EdgeInsets.symmetric(
                    horizontal: (2.7777 * scrwidth) / 100),
                width: scrwidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context)
                      .colorScheme
                      .surface ==
                      Color(0xff141218)
                      ? Color(0xd8ffffff)
                      : Color(0x1A000000),
                ),
                child: InternationalPhoneNumberInput(
                  initialValue: _initnum,
                  textStyle: TextStyle(
                      fontFamily: 'Kunika',
                      color: Color(0xff252525),
                      fontSize: (5 * scrwidth) / 100,
                      fontWeight: FontWeight.w500),
                  onInputChanged: (v) {
                    setState(() {
                      _initnum = v;
                    });
                  },
                  formatInput: true,
                  selectorConfig: SelectorConfig(
                    leadingPadding: 0,
                    trailingSpace: false,
                    selectorType:
                    PhoneInputSelectorType.DIALOG,
                  ),
                  cursorColor: prvd.first,
                  spaceBetweenSelectorAndTextField:
                  (2.7777 * scrwidth) / 100,
                  inputDecoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical:
                        (1.09375 * scrheight) / 100),
                    border: InputBorder.none,
                    label: Padding(
                      padding: EdgeInsets.only(
                          left: (0.5555 * scrwidth) / 100,
                          top: (0.3125 * scrheight) / 100),
                      child: Text(
                        AppLocalizations.of(context)!.phn_nm,
                        style: TextStyle(
                            fontFamily: 'Kunika',
                            color: Color(0xff252525),
                            fontSize: (5 * scrwidth) / 100,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  textFieldController: phnnmcnt,
                ),
              ),
              SizedBox(height: 5),
              Container(
                margin: EdgeInsets.only(
                    bottom: (1.5625 * scrheight) / 100),
                width: (55.5555 * scrwidth) / 100,
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        AnimatedBuilder(
                          animation: _scalanimationcnt,
                          builder: (context, child) =>
                              Transform.scale(
                                scale: _scale.value,
                                child: Container(
                                  width:
                                  (13.8888 * scrwidth) / 100,
                                  height:
                                  (7.8125 * scrheight) / 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: clicked
                                        ? prvd.first
                                        : (Theme.of(context)
                                        .colorScheme
                                        .surface ==
                                        Color(0xff141218)
                                        ? Colors.black
                                        : Colors.white),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                          Color(0x29000000),
                                          offset: Offset(0, 3),
                                          blurRadius: 10,
                                          spreadRadius: 1),
                                    ],
                                  ),
                                  child: IconButton(
                                    style: ButtonStyle(
                                        overlayColor:
                                        WidgetStatePropertyAll<
                                            Color>(
                                            Colors
                                                .transparent)),
                                    onPressed: () {
                                      _scalanimationcnt.forward();
                                      setState(() {
                                        clicked = true;
                                        clicked1 = false;
                                        gender = 'male';
                                      });
                                    },
                                    icon: Icon(
                                      Icons.male_rounded,
                                      size: (8.3333 * scrwidth) /
                                          100,
                                      color: clicked
                                          ? Theme.of(context)
                                          .colorScheme
                                          .surface
                                          : prvd.first,
                                    ),
                                  ),
                                ),
                              ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.ml,
                          style: TextStyle(
                              fontFamily: 'Kunika',
                              fontSize:
                              (5.5556 * scrwidth) / 100,
                              fontWeight: FontWeight.w500,
                              color: clicked
                                  ? prvd.first
                                  : (Theme.of(context)
                                  .colorScheme
                                  .surface ==
                                  Color(0xff141218)
                                  ? Color(0xfffef7ff)
                                  : Colors.black87),
                              letterSpacing: 2),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedBuilder(
                          animation: _scalanimationcnt1,
                          builder: (context, child) =>
                              Transform.scale(
                                scale: _scale1.value,
                                child: Container(
                                  width:
                                  (13.8888 * scrwidth) / 100,
                                  height:
                                  (7.8125 * scrheight) / 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: clicked1
                                        ? prvd.first
                                        : (Theme.of(context)
                                        .colorScheme
                                        .surface ==
                                        Color(0xff141218)
                                        ? Colors.black
                                        : Colors.white),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                          Color(0x29000000),
                                          offset: Offset(0, 3),
                                          blurRadius: 10,
                                          spreadRadius: 1),
                                    ],
                                  ),
                                  child: IconButton(
                                    style: ButtonStyle(
                                        overlayColor:
                                        WidgetStatePropertyAll<
                                            Color>(
                                            Colors
                                                .transparent)),
                                    onPressed: () {
                                      _scalanimationcnt1
                                          .forward();
                                      setState(() {
                                        clicked1 = true;
                                        clicked = false;
                                        gender = 'female';
                                      });
                                    },
                                    icon: Icon(
                                      Icons.female_rounded,
                                      size: (8.3333 * scrwidth) /
                                          100,
                                      color: clicked1
                                          ? Theme.of(context)
                                          .colorScheme
                                          .surface
                                          : prvd.first,
                                    ),
                                  ),
                                ),
                              ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.fml,
                          style: TextStyle(
                              fontFamily: 'Kunika',
                              fontSize:
                              (5.5556 * scrwidth) / 100,
                              fontWeight: FontWeight.w500,
                              color: clicked1
                                  ? prvd.first
                                  : (Theme.of(context)
                                  .colorScheme
                                  .surface ==
                                  Color(0xff141218)
                                  ? Color(0xfffef7ff)
                                  : Colors.black87),
                              letterSpacing: 2),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              GestureDetector(
                onTap: () async{
                  if(firstcnt.text.isNotEmpty && lastcnt.text.isNotEmpty && emailcnt.text.isNotEmpty && (DateTime.now().year - _birthdate.year) >= 18 && gender.isNotEmpty && phnnmcnt.text.isNotEmpty){
                    //prvd.user.firstname = await firstcnt.text;
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Center(
                            child: Text(
                              AppLocalizations.of(context)!.upd_succ,
                              style: TextStyle(
                                  fontFamily: 'Kunika',
                                  fontWeight: FontWeight.w500,
                                  fontSize: (5*scrwidth)/100,
                                  color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                      ? Colors.black87
                                      : Color(0xfffef7ff),
                                  letterSpacing: 1,
                                  decoration: TextDecoration.none
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          margin: EdgeInsets.only(left: (13.8888*scrwidth)/100, right: (13.8888*scrwidth)/100, bottom: (3.125*scrheight)/100),
                          padding: EdgeInsets.all((1.5625*scrheight)/100),
                          backgroundColor: Colors.grey.shade400.withOpacity(0.4),
                          duration: Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        )
                    );
                    /*Future.delayed(Duration(milliseconds: 5000), () {
                      Phoenix.rebirth(context);
                    });*/
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: (1.5625*scrheight)/100, horizontal: (5.5555*scrwidth)/100),
                  width: scrwidth,
                  decoration: BoxDecoration(
                    color: firstcnt.text.isEmpty || lastcnt.text.isEmpty || emailcnt.text.isEmpty || (DateTime.now().year - _birthdate.year) < 18 || gender.isEmpty || phnnmcnt.text.isEmpty ?  prvd.first.withOpacity(0.3) : prvd.first,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 10,
                          spreadRadius: 1),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.updt,
                        style: TextStyle(
                            fontFamily: 'Kunika',
                            fontWeight: FontWeight.w500,
                            fontSize: (5.56*scrwidth)/100,
                            color: Theme.of(context).colorScheme.surface,
                            letterSpacing: 1,
                            decoration: TextDecoration.none
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  ImageProvider<Object> buildFileImage() {
    if (prfimg == null) {
      return AssetImage(prvd.sllr.slr_img);
    } else {
      return FileImage(prfimg as File);
    }
  }
}




class Seller{
  final int id;
  final String firstname;
  final String lastname;
  final DateTime date_brth;
  final String email;
  final String gndr;
  final int num;
  final String slr_nm;
  final String slr_img;

  Seller(this.id, this.firstname, this.lastname, this.date_brth, this.email, this.gndr, this.num,this.slr_nm, this.slr_img);
}

