import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';
import '../Pages/language.dart';
import '../Saller/AllPages.dart';
import '../Sides/Provider.dart';
import '../main.dart';
import 'langugecode.dart';


class AllPages extends StatefulWidget {
  const AllPages({super.key});

  @override
  State<AllPages> createState() => _AllPagesState();
}



class _AllPagesState extends State<AllPages> {

  List<Widget> pages = [
    HomePage(),
    CartItem(),
    Orders(),
    Products(),
    UserProfile()
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

    scrheight = MediaQuery.of(context).size.height;
    scrwidth = MediaQuery.of(context).size.width;

    print(Theme.of(context).colorScheme.surface);

    return Scaffold(

      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: [
          FontAwesomeIcons.house,
          FontAwesomeIcons.cartShopping,
          FontAwesomeIcons.bagShopping,
          FontAwesomeIcons.box,
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
        borderColor: (Theme.of(context)
            .colorScheme.surface == Color(0xff141218) && page_inx == 1) ? Colors.transparent : Colors.grey.shade300,
        shadow: Shadow(
          color: page_inx == 1 ? Colors.transparent : Color(0x29000000),
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
        leftCornerRadius: page_inx == 1 ? 0 : 30,
        rightCornerRadius: page_inx == 1 ? 0 : 30,
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




class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  late double scrheight;
  late double scrwidth;
  late String imgPrf;
  late DateTime time;
  late String Fullname;
  bool notvsb = true;

  late List<Promo> promoList ;

  late PageController cntr ;

  int crnt_page = 0;
  late Timer tim;

  late List<Color> itemColors;
  late List<String> listTpe;

  late List<Product> pprdList;
  late List<Store> bstrList;

  late String fltrc ;
  late String fltrp;
  late KeepProvider prvd;


  SfRangeValues price = SfRangeValues(500, 3500);

  late AnimationController _scalanimationcnt;
  late Animation<double> _scale;

  late AnimationController _scalanimationcnt1;
  late Animation<double> _scale1;

  late int discount;

  @override
  void initState() {
    super.initState();
    prvd = Provider.of<KeepProvider>(context, listen: false);

    cntr = PageController(initialPage: crnt_page);

    Fullname = prvd.user.firstname + ' ' + prvd.user.lastname;
    imgPrf = prvd.user.user_img;


    startscroll();

    itemColors = List.filled(9, Colors.transparent);

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
    _scale1 = Tween(begin: 1.0, end: 1.05).animate(_scalanimationcnt1)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _scalanimationcnt1.reverse();
        }
      });
    pprdList = prvd.prdliste.where((e) => e.sold >= 2000 && e.rate >= 4.5).toList();

    bstrList = prvd.strliste.where((e) => e.prd_seles >= 20000).toList();

    promoList = prvd.prmliste;

  }

  @override
  void dispose() {
    super.dispose();
    cntr.dispose();
    tim.cancel();
    _scalanimationcnt.dispose();
    _scalanimationcnt1.dispose();
  }

  void startscroll(){
    tim = Timer.periodic(Duration(seconds: 3), (t) {
      if(promoList.length < 5){
        if (crnt_page < promoList.length - 1){
          crnt_page++;
        }else{
          crnt_page = 0;
        }
      }else{
        if (crnt_page < 4){
          crnt_page++;
        }else{
          crnt_page = 0;
        }
      }

      cntr.animateToPage(crnt_page,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease);

    });
  }

  Product fetch(int id) {
    return prvd.prdliste.where((e) => e.id == id).first;
  }


  Widget build(BuildContext context) {

    time = DateTime.now();

    List<String> listTpe = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.clths,
      AppLocalizations.of(context)!.bgs,
      AppLocalizations.of(context)!.elct,
      AppLocalizations.of(context)!.jwlr,
      AppLocalizations.of(context)!.ktch,
      AppLocalizations.of(context)!.shs,
      AppLocalizations.of(context)!.tys,
      AppLocalizations.of(context)!.wtch,
    ];

    scrheight = MediaQuery.of(context).size.height;
    scrwidth = MediaQuery.of(context).size.width;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Theme.of(context).brightness == Brightness.light ? Brightness.dark : Brightness.light,
      statusBarBrightness: Theme.of(context).brightness,
    ));
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Container(
              height: scrheight,
              width: scrwidth,
              padding: EdgeInsets.fromLTRB((4.16666*scrwidth)/100, (4.6875*scrheight)/100, (4.16666*scrwidth)/100, 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => AllSPages() ));
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
                            SizedBox(
                              width: (2.7777*scrwidth)/100,
                            ),
                            GestureDetector(
                              onTap: () async{
                                String refresh = await Navigator.push(context, MaterialPageRoute(builder: (context) => Favorite()));
                                if(refresh == 'refresh'){
                                  setState(() {});
                                }
                              },
                              child: Icon(
                                EvaIcons.heartOutline,
                                size: (7.5000*scrwidth)/100,
                                color: Theme.of(context)
                                    .colorScheme
                                    .surface ==
                                    Color(0xfffef7ff)
                                    ? Colors.black87
                                    : Color(0xfffef7ff),
                              )
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: (3.125*scrheight)/100,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric( horizontal: (2.7777*scrwidth)/100),
                      width: scrwidth,
                      height: (8.59375*scrheight)/100,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                              EvaIcons.searchOutline,
                            size: (6.9444*scrwidth)/100,
                            color: Colors.grey.withOpacity(0.8),
                          ),
                          SizedBox(
                            width: (1.38888*scrwidth)/100,
                          ),
                          SizedBox(
                            width: (69.4444*scrwidth)/100,
                            child: TextFormField(
                              readOnly: true,
                              style: TextStyle(
                                  fontSize: (5 * scrwidth) / 100,
                                  fontFamily: 'Kunika',
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surface ==
                                      Color(0xfffef7ff)
                                      ? Colors.black87
                                      : Color(0xfffef7ff)
                              ),
                              decoration: InputDecoration(
                                contentPadding:
                                EdgeInsets.zero,
                                hintText:AppLocalizations.of(context)!.make_fl + (prvd.appLocale.languageCode == 'en' ? ' ->' : '<- ') ,
                                hintStyle:  TextStyle(
                                    fontFamily: 'Kunika',
                                    fontSize:
                                    (5.5556*scrwidth)/100,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.withOpacity(0.4)),
                                border: InputBorder.none,
                              ),
                              cursorColor: prvd.first,
                            ),
                          ),
                          SizedBox(
                            width: (1.38888*scrwidth)/100,
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                  ),
                                context: context,
                                builder: (BuildContext context){
                                  return StatefulBuilder(
                                    builder: (BuildContext context, StateSetter setState){
                                      return Container(
                                        padding: EdgeInsets.symmetric(horizontal: (4.16666*scrwidth)/100, vertical: (1.5625*scrheight)/100),
                                        width: scrwidth,
                                        height: (57.8125*scrheight)/100,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                topLeft: Radius.circular(20))),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  bottom: (1.5625 * scrheight) /
                                                      100),
                                              width: (8.3333 * scrwidth) / 100,
                                              height:
                                              (0.46875 * scrheight) / 100,
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surface ==
                                                      Color(0xfffef7ff)
                                                      ? Colors.black87
                                                      : Color(0xfffef7ff),
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      50)),
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!.filtr,
                                              style: TextStyle(
                                                  fontFamily: 'Kunika',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: (8.89*scrwidth)/100,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surface ==
                                                      Color(0xfffef7ff)
                                                      ? Colors.black87
                                                      : Color(0xfffef7ff),
                                                  letterSpacing: 1),
                                            ),
                                            SizedBox(
                                              height: (1.40625*scrheight)/100,
                                            ),
                                            Container(
                                              width: scrwidth,
                                              height: (0.234375*scrheight)/100,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(50),
                                                  color: Colors.grey.withOpacity(0.2)
                                              ),
                                            ),
                                            SizedBox(
                                              height: (2.03125*scrheight)/100,
                                            ),
                                            SizedBox(
                                                width: scrwidth,
                                                child: Text(
                                                  AppLocalizations.of(context)!.catg,
                                                  style: TextStyle(
                                                      fontFamily: 'Kunika',
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: (5.26*scrwidth)/100,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .surface ==
                                                          Color(0xfffef7ff)
                                                          ? Colors.black87
                                                          : Color(0xfffef7ff),
                                                      letterSpacing: 1),
                                                )
                                            ),
                                            SizedBox(
                                              height: (2.03125*scrheight)/100,
                                            ),
                                            SizedBox(
                                              height: (6.25*scrheight)/100,
                                              child: ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                itemCount: listTpe.length,
                                                itemBuilder: (context, index){
                                                  return Container(
                                                    margin: prvd.appLocale.languageCode == 'ar'? EdgeInsets.only(left: (2.7777*scrwidth)/100) : EdgeInsets.only(right: (2.7777*scrwidth)/100),
                                                    padding: EdgeInsets.symmetric(horizontal: (4.16666*scrwidth)/100),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(50),
                                                        border: Border.all(
                                                            color: itemColors[index] == prvd.first? Colors.transparent:
                                                            (Theme.of(context)
                                                                .colorScheme
                                                                .surface ==
                                                                Color(0xfffef7ff)
                                                                ? Colors.black87
                                                                : Color(0xfffef7ff)),
                                                            width: (0.3333*scrwidth)/100
                                                        ),
                                                        color: itemColors[index] == prvd.first? prvd.first : Colors.transparent
                                                    ),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          fltrc = listTpe[index];
                                                          itemColors = List.filled(9, Colors.transparent);
                                                          itemColors[index] = (itemColors[index] == prvd.first) ? Colors.transparent : prvd.first;
                                                        });
                                                      },
                                                      child: Center(
                                                        child: Text(
                                                          listTpe[index],
                                                          style: TextStyle(
                                                              fontFamily: 'Kunika',
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: (5.26*scrwidth)/100,
                                                              color: Theme.of(context)
                                                                  .colorScheme
                                                                  .surface ==
                                                                  Color(0xfffef7ff)
                                                                  ? Colors.black87
                                                                  : Color(0xfffef7ff),
                                                              letterSpacing: 1),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: (2.03125*scrheight)/100,
                                            ),
                                            SizedBox(
                                                width: scrwidth,
                                                child: Text(
                                                  AppLocalizations.of(context)!.pricrange,
                                                  style: TextStyle(
                                                      fontFamily: 'Kunika',
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: (5.26*scrwidth)/100,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .surface ==
                                                          Color(0xfffef7ff)
                                                          ? Colors.black87
                                                          : Color(0xfffef7ff),
                                                      letterSpacing: 1),
                                                )
                                            ),
                                            SizedBox(
                                              height: (2.03125*scrheight)/100,
                                            ),
                                            SfRangeSlider(
                                              min: 0,
                                              max: 6500,
                                              numberFormat: NumberFormat.compact(),
                                              values: price,
                                              stepSize: 100,
                                              enableTooltip: true,
                                              onChanged: (values){
                                                setState(() {
                                                  price = values;
                                                });
                                              },
                                              activeColor: prvd.first,
                                              inactiveColor: Theme.of(context)
                                                  .colorScheme
                                                  .surface ==
                                                  Color(0xfffef7ff)
                                                  ? Colors.black87
                                                  : Color(0xfffef7ff),
                                              tooltipShape: SfPaddleTooltipShape(),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                AnimatedBuilder(
                                                  animation: _scalanimationcnt,
                                                  builder: (context, child) => Transform.scale(
                                                    scale: _scale.value,
                                                    child: Container(
                                                      margin: EdgeInsets.only(top: (3.125 * scrheight) / 100),
                                                      width: (41.6666 * scrwidth) / 100,
                                                      height: (7.8125 * scrheight) / 100,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey.shade300,
                                                        borderRadius: BorderRadius.circular(50),
                                                      ),
                                                      child: TextButton(
                                                        style: ButtonStyle(
                                                            overlayColor: WidgetStatePropertyAll<Color>(
                                                                Colors.transparent)),
                                                        onPressed: () {
                                                          _scalanimationcnt.forward();
                                                          setState(() {
                                                            itemColors = List.filled(9, Theme.of(context).colorScheme.surface);
                                                            fltrc = '';
                                                            price = SfRangeValues(500, 3500);
                                                          });
                                                        },
                                                        child: Text(
                                                              AppLocalizations.of(context)!.rst,
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
                                                            )),
                                                      ),
                                                    ),
                                                ),
                                                AnimatedBuilder(
                                                  animation: _scalanimationcnt1,
                                                  builder: (context, child) => Transform.scale(
                                                    scale: _scale1.value,
                                                    child: Container(
                                                      margin: EdgeInsets.only(top: (3.125 * scrheight) / 100),
                                                      width: (41.6666 * scrwidth) / 100,
                                                      height: (7.8125 * scrheight) / 100,
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
                                                      child: TextButton(
                                                        style: ButtonStyle(
                                                            overlayColor: WidgetStatePropertyAll<Color>(
                                                                Colors.transparent)),
                                                        onPressed: () {
                                                          _scalanimationcnt1.forward();
                                                        },
                                                        child: Text(
                                                              AppLocalizations.of(context)!.appl,
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
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                  );
                                }
                              );
                            },
                            child: FaIcon(
                              FontAwesomeIcons.sliders,
                              size: (5.26*scrwidth)/100,
                              color:  prvd.first
                            )
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
                          AppLocalizations.of(context)!.sp_off,
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
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SpecialOffers()));
                          },
                          child: Text(
                            AppLocalizations.of(context)!.see_all,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Kunika',
                              fontSize:
                              (4.98*scrwidth)/100,
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
                      height: (3.125*scrheight)/100,
                    ),
                    promoList.isEmpty? Text(
                       AppLocalizations.of(context)!.offr_null,
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
                     )
                    :Container(
                      height: (25*scrheight)/100,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          PageView.builder(
                            controller: cntr,
                            itemCount: promoList.length < 5 ? promoList.length : 5,
                            itemBuilder: (context, ind){
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(prdct: fetch(promoList[ind].id_prd))));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: (4.16666*scrwidth)/100),
                                  width: scrwidth,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: scrwidth/2,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${promoList[ind].prctg}' + '%',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Kunika',
                                                fontSize:
                                                (11.11*scrwidth)/100,
                                                color: Colors.black87
                                              ),
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!.offr_spe,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Kunika',
                                                fontSize:
                                                (5.83 * scrwidth)/ 100,
                                                color: Colors.black87
                                            )
                                            ),
                                            SizedBox(
                                              height: (7.8125 * scrheight)/100,
                                              child: Text(
                                                  promoList[ind].desc,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: 'Kunika',
                                                      fontSize: (4.17*scrwidth)/100,
                                                      color: Colors.grey.shade500,
                                                  ),
                                                overflow: TextOverflow.ellipsis,
                                                ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: (33.3333*scrwidth)/100,
                                        height: (18.75*scrheight)/100,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(fetch(promoList[ind].id_prd).images[0]),
                                            fit: BoxFit.cover
                                          )
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: (1.5625*scrheight)/100),
                            alignment: Alignment.bottomCenter,
                            child: SmoothPageIndicator(
                              controller: cntr,
                              count: promoList.length < 5 ? promoList.length : 5,
                              effect: ExpandingDotsEffect(
                                  dotHeight: (0.625*scrheight)/100,
                                  dotWidth: (1.1111*scrwidth)/100,
                                  dotColor: Colors.grey.shade600,
                                  activeDotColor: prvd.first),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: (3.125*scrheight)/100,
                    ),
                    SizedBox(
                      width: scrwidth,
                      child: Text(
                        AppLocalizations.of(context)!.catg,
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
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: (2.1275*scrheight)/100,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Category(ctgr: 'clothes')));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all((1.875*scrheight)/100),
                                    height: (7.8125*scrheight)/100,
                                    width: (13.8888*scrwidth)/100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.shade300
                                    ),
                                    child: Center(
                                      child: Image.asset('media/clothes.png'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: (1.093759*scrheight)/100,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.clths,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Kunika',
                                    fontSize:
                                    (4.17*scrwidth)/100,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surface ==
                                        Color(0xfffef7ff)
                                        ? Colors.black87
                                        : Color(0xfffef7ff),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Category(ctgr: 'shoes')));

                                  },
                                  child: Container(
                                    padding: EdgeInsets.all((1.875*scrheight)/100),
                                    height: (7.8125*scrheight)/100,
                                    width: (13.8888*scrwidth)/100,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.shade300
                                    ),
                                    child: Center(
                                      child: Image.asset('media/shoes.png'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: (1.093759*scrheight)/100,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.shs,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Kunika',
                                    fontSize:
                                    (4.17*scrwidth)/100,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surface ==
                                        Color(0xfffef7ff)
                                        ? Colors.black87
                                        : Color(0xfffef7ff),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Category(ctgr: 'bags')));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all((1.875*scrheight)/100),
                                    height: (7.8125*scrheight)/100,
                                    width: (13.8888*scrwidth)/100,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.shade300
                                    ),
                                    child: Center(
                                      child: Image.asset('media/bags.png'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: (1.093759*scrheight)/100,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.bgs,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Kunika',
                                    fontSize:
                                    (4.17*scrwidth)/100,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surface ==
                                        Color(0xfffef7ff)
                                        ? Colors.black87
                                        : Color(0xfffef7ff),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Category(ctgr: 'electronics')));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all((1.875*scrheight)/100),
                                    height: (7.8125*scrheight)/100,
                                    width: (13.8888*scrwidth)/100,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.shade300
                                    ),
                                    child: Center(
                                      child: Image.asset('media/electronics.png'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: (1.093759*scrheight)/100,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.elct,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Kunika',
                                    fontSize:
                                    (4.17*scrwidth)/100,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surface ==
                                        Color(0xfffef7ff)
                                        ? Colors.black87
                                        : Color(0xfffef7ff),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: (2.34375*scrheight)/100,
                        ),
                        Padding(
                          padding: prvd.appLocale.languageCode == 'en'? EdgeInsets.only(right: (1.38888*scrwidth)/100) : EdgeInsets.only(left: (1.38888*scrwidth)/100),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Category(ctgr: 'watchs')));

                                    },
                                    child: Container(
                                      padding: EdgeInsets.all((1.875*scrheight)/100),
                                      height: (7.8125*scrheight)/100,
                                      width: (13.8888*scrwidth)/100,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.shade300
                                      ),
                                      child: Center(
                                        child: Image.asset('media/watchs.png'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: (1.093759*scrheight)/100,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.wtch,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Kunika',
                                      fontSize:
                                      (4.17*scrwidth)/100,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface ==
                                          Color(0xfffef7ff)
                                          ? Colors.black87
                                          : Color(0xfffef7ff),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Category(ctgr: 'jewelry')));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all((1.875*scrheight)/100),
                                      height: (7.8125*scrheight)/100,
                                      width: (13.8888*scrwidth)/100,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.shade300
                                      ),
                                      child: Center(
                                        child: Image.asset('media/jewelry.png'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: (1.093759*scrheight)/100,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.jwlr,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Kunika',
                                      fontSize:
                                      (4.17*scrwidth)/100,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface ==
                                          Color(0xfffef7ff)
                                          ? Colors.black87
                                          : Color(0xfffef7ff),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Category(ctgr: 'kitchen')));

                                    },
                                    child: Container(
                                      padding: EdgeInsets.all((1.875*scrheight)/100),
                                      height: (7.8125*scrheight)/100,
                                      width: (13.8888*scrwidth)/100,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.shade300
                                      ),
                                      child: Center(
                                        child: Image.asset('media/kitchen.png'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: (1.093759*scrheight)/100,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.ktch,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Kunika',
                                      fontSize:
                                      (4.17*scrwidth)/100,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface ==
                                          Color(0xfffef7ff)
                                          ? Colors.black87
                                          : Color(0xfffef7ff),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Category(ctgr: 'toys')));

                                    },
                                    child: Container(
                                      padding: EdgeInsets.all((1.875*scrheight)/100),
                                      height: (7.8125*scrheight)/100,
                                      width: (13.8888*scrwidth)/100,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.shade300
                                      ),
                                      child: Center(
                                        child: Image.asset('media/toys.png'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: (1.093759*scrheight)/100,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.tys,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Kunika',
                                      fontSize:
                                      (4.17*scrwidth)/100,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface ==
                                          Color(0xfffef7ff)
                                          ? Colors.black87
                                          : Color(0xfffef7ff),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: (3.125*scrheight)/100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.mst_pplr,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Kunika',
                            fontSize:
                            (5.83* scrwidth) / 100,
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MostPopular()));
                          },
                          child: Text(
                            AppLocalizations.of(context)!.see_all,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Kunika',
                              fontSize:
                              (4.98*scrwidth)/100,
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
                    SizedBox(height: (0.78125 *scrheight)/100),
                    SizedBox(
                        height: (41.40625 * scrheight)/100,
                        child: pprdList.isNotEmpty? GridView.builder(
                          padding: EdgeInsets.all((1.5625*scrheight)/100),
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.57,
                              crossAxisSpacing: 20
                          ),
                          itemCount: 2,
                          itemBuilder: (context, ind) {
                            return GestureDetector(
                              onTap: () async{
                                String refresh = await Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(prdct: pprdList[ind])));
                                if(refresh == 'refresh'){
                                  setState(() {});
                                }
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
                                              if(pprdList[ind].fav == true){
                                                pprdList[ind].fav = false;
                                                setState(() {});
                                              }else{
                                                pprdList[ind].fav = true;
                                                setState(() {});
                                              }
                                            },
                                            child: Container(
                                                padding: EdgeInsets.all((0.625*scrheight)/100),
                                                decoration: BoxDecoration(
                                                  color: prvd.first,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: pprdList[ind].fav ? Icon(
                                                  EvaIcons.heart,
                                                  size: (5.28*scrwidth)/100,
                                                  color: Colors.red,
                                                ) : Icon(
                                                  EvaIcons.heartOutline,
                                                  size: (5.28*scrwidth)/100,
                                                  color: Theme.of(context).colorScheme.surface,
                                                )
                                            ),
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
                              (5.83 * scrwidth) / 100,
                              color: Theme.of(context)
                                  .colorScheme
                                  .surface ==
                                  Color(0xfffef7ff)
                                  ? Colors.black87
                                  : Color(0xfffef7ff),
                            ),
                          ),
                        )
                    ),
                    SizedBox(
                      height: (2.34375*scrheight)/100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.bst_seling,
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BestStors()));
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
                      height: (15.625*scrheight)/100,
                      child: GridView.builder(
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
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => StoreProfile(str: bstrList[ind])));
                                },
                                contentPadding: EdgeInsets.symmetric(horizontal: (2.7777*scrwidth)/100),
                                leading: Container(
                                  width: (16.6666*scrwidth)/100,
                                  height: (9.375*scrheight)/100,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage(bstrList[ind].str_image),
                                          fit: BoxFit.fill
                                      )
                                  ),
                                ),
                                title: Text(
                                    bstrList[ind].str_name,
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
                                subtitle: Text(
                                  prvd.appLocale.languageCode == 'en'?'${bstrList[ind].prd_seles}' + ' ' + AppLocalizations.of(context)!.prdc :'${bstrList[ind].prd_seles}' + ' ' +  AppLocalizations.of(context)!.prdc,
                                  style: TextStyle(
                                    fontFamily: 'Kunika',
                                    fontWeight: FontWeight.w500,
                                    fontSize: (3.61*scrwidth)/100,
                                    color: Colors.grey.shade400,
                                    letterSpacing: 1,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                          );
                        },
                      ),
                    )
                  ],
                ),
              )),
        );
  }
}

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}


class _FavoriteState extends State<Favorite> {
  late double scrheight;
  late double scrwidth;
  late KeepProvider prvd;

  List<Product> fav_list = [];

  @override
  void initState() {
    super.initState();
    prvd = Provider.of<KeepProvider>(context, listen: false);
  }

  Widget build(BuildContext context) {
    fav_list = prvd.prdliste.where((e) => e.fav == true).toList();
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
          AppLocalizations.of(context)!.fav,
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
      body: fav_list.isNotEmpty ? GridView.builder(
            padding: EdgeInsets.only(top: (2.34375*scrheight)/100, left: (4.16666*scrwidth)/100, right: (4.16666*scrwidth)/100),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.63,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20
              ),
              itemCount: fav_list.length,
              itemBuilder: (context, ind){
                return GestureDetector(
                  onTap: () async{
                    String refresh = await Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(prdct: fav_list[ind])));
                    if(refresh == 'refresh'){
                      setState(() {});
                    }                  },
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
                                tag: fav_list[ind].images[0],
                                child: Image(
                                  image: AssetImage('${fav_list[ind].images[0]}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: (1.5625*scrheight)/100,
                              right: (2.7777*scrwidth)/100,
                              child: GestureDetector(
                                onTap: () {
                                  fav_list[ind].fav = false;
                                  setState(() {});
                                },
                                child: Container(
                                    padding: EdgeInsets.all((0.625*scrheight)/100),
                                    decoration: BoxDecoration(
                                      color: prvd.first,
                                      shape: BoxShape.circle,
                                    ),
                                    child: fav_list[ind].fav ? Icon(
                                      EvaIcons.heart,
                                      size: (5.28*scrwidth)/100,
                                      color: Colors.red,
                                    ) : Icon(
                                      EvaIcons.heartOutline,
                                      size: (5.28*scrwidth)/100,
                                      color: Theme.of(context).colorScheme.surface,
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: (0.46875*scrheight)/100),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              fav_list[ind].name,
                              style: TextStyle(
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.w500,
                                fontSize: (6.11*scrwidth)/100,
                                color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                    ? Colors.black87
                                    : Color(0xfffef7ff),
                                letterSpacing: 1,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  fav_list[ind].rate >= 4.9 ? FontAwesomeIcons.solidStar : FontAwesomeIcons.starHalfStroke,
                                  color: prvd.first,
                                  size: (4.72*scrwidth)/100,
                                ),
                                SizedBox(width: (1.38888*scrwidth)/100),
                                Text(
                                  '${fav_list[ind].rate}',
                                  style: TextStyle(
                                    fontFamily: 'Kunika',
                                    fontWeight: FontWeight.w500,
                                    fontSize: (5.00*scrwidth)/100,
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
                                    prvd.appLocale.languageCode == 'en' ? '${fav_list[ind].sold}'+' '+AppLocalizations.of(context)!.sld : '${fav_list[ind].sold}' + ' '+ AppLocalizations.of(context)!.sld,
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
                              prvd.appLocale.languageCode == 'en' ? '${fav_list[ind].price}'+' '+AppLocalizations.of(context)!.dn : '${fav_list[ind].price}' + ' '+ AppLocalizations.of(context)!.dn,
                              style: TextStyle(
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.w500,
                                fontSize: (5.00*scrwidth)/100,
                                color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                    ? Colors.black87
                                    : Color(0xfffef7ff),
                                letterSpacing: 1,
                              ),
                            )
                          ],
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
    );
  }
}



class SpecialOffers extends StatefulWidget {
  const SpecialOffers({super.key});

  @override
  State<SpecialOffers> createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {

  List<Promo> promoList = [];
  late double scrheight;
  late double scrwidth;

  late KeepProvider prvd;

  Product fetch(int id) {
    return prvd.prdliste.where((e) => e.id == id).first;
  }

  @override
  void initState() {
    super.initState();
    prvd = Provider.of<KeepProvider>(context, listen: false);
    promoList = prvd.prmliste;
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
          AppLocalizations.of(context)!.sp_off,
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
      body: GestureDetector(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.only(top: (2.34375*scrheight)/100, bottom: (1.5625*scrheight)/100, left: (4.16666*scrwidth)/100, right: (4.16666*scrwidth)/100),
          width: scrwidth,
          height: scrheight,
          child: ListView.builder(
            itemCount: promoList.length,
            itemBuilder: (context,ind){
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(prdct: fetch(promoList[ind].id_prd))));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: (3.125*scrheight)/100),
                  padding: EdgeInsets.symmetric(horizontal: (4.16666*scrwidth)/100),
                  height: (25*scrheight)/100,
                  width: scrwidth,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: scrwidth/2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${promoList[ind].prctg}' + '%',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Kunika',
                                  fontSize:
                                  (11.11*scrwidth)/100,
                                  color: Colors.black87
                              ),
                            ),
                            Text(
                                AppLocalizations.of(context)!.offr_spe,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Kunika',
                                    fontSize:
                                    (5.83 * scrwidth) / 100,
                                    color: Colors.black87
                                )
                            ),
                            Text(
                                promoList[ind].desc,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Kunika',
                                  fontSize: (4.17*scrwidth)/100,
                                  color: Colors.grey.shade500,
                                )
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: (33.3333*scrwidth)/100,
                        height: (18.75*scrheight)/100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(fetch(promoList[ind].id_prd).images[0]),
                                fit: BoxFit.cover
                            )
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class MostPopular extends StatefulWidget {
  const MostPopular({super.key});

  @override
  State<MostPopular> createState() => _MostPopularState();
}

class _MostPopularState extends State<MostPopular> {

  late double scrheight;
  late double scrwidth;

  late KeepProvider prvd;

  late List<Color> catgColors;

  late List<Product> pprdList;
  late List<Product> prodKpr;

  late Color catColor;

  late bool fav;

  @override
  void initState() {
    super.initState();


    prvd = Provider.of<KeepProvider>(context, listen: false);

    catgColors = List.filled(9, Colors.transparent);
    catgColors[0] = prvd.first;

    pprdList =  prvd.prdliste.where((e) => e.sold >= 4000 || e.rate >= 4.5).toList();

    prodKpr = pprdList;

  }

  Widget build(BuildContext context) {

    List<String> listTpe = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.clths,
      AppLocalizations.of(context)!.bgs,
      AppLocalizations.of(context)!.elct,
      AppLocalizations.of(context)!.jwlr,
      AppLocalizations.of(context)!.ktch,
      AppLocalizations.of(context)!.shs,
      AppLocalizations.of(context)!.tys,
      AppLocalizations.of(context)!.wtch,
    ];

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
          AppLocalizations.of(context)!.mst_pplr,
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: (6.25*scrheight)/100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listTpe.length,
                  itemBuilder: (context, index){
                    return Container(
                      margin: prvd.appLocale.languageCode == 'ar'? EdgeInsets.only(left: (2.7777*scrwidth)/100) : EdgeInsets.only(right: (2.7777*scrwidth)/100),
                      padding: EdgeInsets.symmetric(horizontal: (4.16666*scrwidth)/100),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: catgColors[index] == prvd.first? Colors.transparent:
                              (Theme.of(context)
                                  .colorScheme
                                  .surface ==
                                  Color(0xfffef7ff)
                                  ? Colors.black87
                                  : Color(0xfffef7ff)),
                              width: (0.3333*scrwidth)/100
                          ),
                          color: catgColors[index] == prvd.first? prvd.first : Colors.transparent
                      ),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            catgColors = List.filled(9, Colors.transparent);
                            catgColors[index] = (catgColors[index] == prvd.first) ? Colors.transparent : prvd.first;
                            pprdList = Updatelist(listTpe[index]);
                          });
                        },
                        child: Center(
                          child: Text(
                            listTpe[index],
                            style: TextStyle(
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.w500,
                                fontSize: (5.28*scrwidth)/100,
                                color: Theme.of(context)
                                    .colorScheme
                                    .surface ==
                                    Color(0xfffef7ff)
                                    ? Colors.black87
                                    : Color(0xfffef7ff),
                                letterSpacing: 1),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: (1.09375*scrheight)/100),
              SizedBox(
                height: (75*scrheight)/100,
                    child: pprdList.isNotEmpty ? GridView.builder(
                      padding: EdgeInsets.only(left: (2.7777*scrwidth)/100, top: (2.34375*scrheight)/100, right: (2.7777*scrwidth)/100, bottom: 0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.59,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20
                      ),
                      itemCount: pprdList.length,
                      itemBuilder: (context, ind) {
                        return GestureDetector(
                          onTap: () async{
                            String refresh = await Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(prdct: pprdList[ind])));
                            if(refresh == 'refresh'){
                              setState(() {});
                            }                          },
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
                                            if(pprdList[ind].fav == true){
                                              pprdList[ind].fav = false;
                                              setState(() {});
                                            }else{
                                              pprdList[ind].fav = true;
                                              setState(() {});
                                            }
                                          },
                                          child: Container(
                                              padding: EdgeInsets.all((0.625*scrheight)/100),
                                              decoration: BoxDecoration(
                                                color: prvd.first,
                                                shape: BoxShape.circle,
                                              ),
                                              child: pprdList[ind].fav ? Icon(
                                                EvaIcons.heart,
                                                size: (5.28*scrwidth)/100,
                                                color: Colors.red,
                                              ) : Icon(
                                                EvaIcons.heartOutline,
                                                size: (5.28*scrwidth)/100,
                                                color: Theme.of(context).colorScheme.surface,
                                              )
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: (0.46875*scrheight)/100),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                              fontSize: (5.00*scrwidth)/100,
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
                                          fontSize: (5.00*scrwidth)/100,
                                          color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                              ? Colors.black87
                                              : Color(0xfffef7ff),
                                          letterSpacing: 1,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                            ),
                          ),
                        );
                      },
                    ):  Center(
                      child: Text(
                        AppLocalizations.of(context)!.prdc_null,
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
                    )
                  ),
            ],
          ),
        ),
      ),
    );
  }



  List<Product> Updatelist(String catg){
    List<Product> Reslist= [];
    if(catg == 'Clothes'||catg =='الملابس'){
      Reslist = prodKpr.where((elem) => elem.category == 'clothes').toList();
    }else if(catg == 'Electronics'||catg=='الإلكترونيات'){
      Reslist = prodKpr.where((elem) => elem.category == 'electronics').toList();
    }else if(catg == 'Shoes'||catg=='الأحذية'){
      Reslist = prodKpr.where((elem) => elem.category == 'shoes').toList();
    }else if(catg == 'Bags'||catg=='الحقائب'){
      Reslist = prodKpr.where((elem) => elem.category == 'bags').toList();
    }else if(catg == 'Watches'||catg=='الساعات'){
      Reslist = prodKpr.where((elem) => elem.category == 'watches').toList();
    }else if(catg == 'Jewelry'||catg=='المجوهرات'){
      Reslist = prodKpr.where((elem) => elem.category == 'jewelry').toList();
    }else if(catg == 'Kitchen'||catg=='المطبخ'){
      Reslist = prodKpr.where((elem) => elem.category == 'kitchen').toList();
    }else if(catg == 'Toys'||catg=='الألعاب'){
      Reslist = prodKpr.where((elem) => elem.category == 'toys').toList();
    }else{
      Reslist = prodKpr;
    }
    return Reslist;
  }
}

class BestStors extends StatefulWidget {
  const BestStors({super.key});

  @override
  State<BestStors> createState() => _BestStorsState();
}

class _BestStorsState extends State<BestStors> {

  late double scrheight;
  late double scrwidth;

  late KeepProvider prvd;

  late List<Color> catgColors;

  late List<Store> bstrList;
  late List<Store> strKpr;

  late Color catColor;

  @override
  void initState() {
    super.initState();

    prvd = Provider.of<KeepProvider>(context, listen: false);

    catgColors = List.filled(9, Colors.transparent);
    catgColors[0] = prvd.first;

    bstrList =  prvd.strliste.where((e) => e.prd_seles >= 10000).toList();

    strKpr = bstrList;

  }

  Widget build(BuildContext context) {

    List<String> listTpe = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.clths,
      AppLocalizations.of(context)!.bgs,
      AppLocalizations.of(context)!.elct,
      AppLocalizations.of(context)!.jwlr,
      AppLocalizations.of(context)!.ktch,
      AppLocalizations.of(context)!.shs,
      AppLocalizations.of(context)!.tys,
      AppLocalizations.of(context)!.wtch,
    ];

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
          AppLocalizations.of(context)!.bst_seling,
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
      body:  Container(
        height: scrheight,
        width: scrwidth,
        padding: EdgeInsets.fromLTRB((4.16666*scrwidth)/100, (1.5625*scrheight)/100, (4.16666*scrwidth)/100, (1.5625*scrheight)/100),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: (6.25*scrheight)/100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listTpe.length,
                  itemBuilder: (context, index){
                    return Container(
                      margin: prvd.appLocale.languageCode == 'ar'? EdgeInsets.only(left: (2.7777*scrwidth)/100) : EdgeInsets.only(right: (2.7777*scrwidth)/100),
                      padding: EdgeInsets.symmetric(horizontal: (4.16666*scrwidth)/100),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: catgColors[index] == prvd.first? Colors.transparent:
                              (Theme.of(context)
                                  .colorScheme
                                  .surface ==
                                  Color(0xfffef7ff)
                                  ? Colors.black87
                                  : Color(0xfffef7ff)),
                              width: (0.3333*scrwidth)/100
                          ),
                          color: catgColors[index] == prvd.first? prvd.first : Colors.transparent
                      ),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            catgColors = List.filled(9, Colors.transparent);
                            catgColors[index] = (catgColors[index] == prvd.first) ? Colors.transparent : prvd.first;
                            bstrList = Updatelist(listTpe[index]);
                          });
                        },
                        child: Center(
                          child: Text(
                            listTpe[index],
                            style: TextStyle(
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.w500,
                                fontSize: (5.28*scrwidth)/100,
                                color: Theme.of(context)
                                    .colorScheme
                                    .surface ==
                                    Color(0xfffef7ff)
                                    ? Colors.black87
                                    : Color(0xfffef7ff),
                                letterSpacing: 1),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: (1.09375*scrheight)/100),
              SizedBox(
                  height: (78.125*scrheight)/100 ,
                  child: bstrList.isNotEmpty ? GridView.builder(
                    padding: EdgeInsets.symmetric(vertical: (1.5625*scrheight)/100),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.89,
                        crossAxisSpacing: 12,
                      mainAxisSpacing: 15,
                    ),
                    itemCount: bstrList.length,
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
                              },
                              contentPadding: EdgeInsets.symmetric(horizontal: (2.7777*scrwidth)/100),
                              leading: Container(
                                width: (16.6666*scrwidth)/100,
                                height: (9.375*scrheight)/100,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(bstrList[ind].str_image),
                                        fit: BoxFit.fill
                                    )
                                ),
                              ),
                              title: Text(
                                bstrList[ind].str_name,
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
                              subtitle: Text(
                                prvd.appLocale.languageCode == 'en'?'${bstrList[ind].prd_seles}' + ' ' + AppLocalizations.of(context)!.prdc :'${bstrList[ind].prd_seles}' + ' ' +  AppLocalizations.of(context)!.prdc,
                                style: TextStyle(
                                  fontFamily: 'Kunika',
                                  fontWeight: FontWeight.w500,
                                  fontSize: (3.61*scrwidth)/100,
                                  color: Colors.grey.shade400,
                                  letterSpacing: 1,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                      );
                    },
                  ) :  Center(
                    child: Text(
                      AppLocalizations.of(context)!.str_null,
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
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Store> Updatelist(String catg){
    List<Store> Reslist= [];
    if(catg == 'Clothes'||catg =='الملابس'){
      Reslist = strKpr.where((elem) => elem.str_catg == 'clothes').toList();
    }else if(catg == 'Electronics'||catg=='الإلكترونيات'){
      Reslist = strKpr.where((elem) => elem.str_catg == 'electronics').toList();
    }else if(catg == 'Shoes'||catg=='الأحذية'){
      Reslist = strKpr.where((elem) => elem.str_catg == 'shoes').toList();
    }else if(catg == 'Bags'||catg=='الحقائب'){
      Reslist = strKpr.where((elem) => elem.str_catg == 'bags').toList();
    }else if(catg == 'Watches'||catg=='الساعات'){
      Reslist = strKpr.where((elem) => elem.str_catg == 'watches').toList();
    }else if(catg == 'Jewelry'||catg=='المجوهرات'){
      Reslist = strKpr.where((elem) => elem.str_catg == 'jewelry').toList();
    }else if(catg == 'Kitchen'||catg=='المطبخ'){
      Reslist = strKpr.where((elem) => elem.str_catg == 'kitchen').toList();
    }else if(catg == 'Toys'||catg=='الألعاب'){
      Reslist = strKpr.where((elem) => elem.str_catg == 'toys').toList();
    }else{
      Reslist = strKpr;
    }
    return Reslist;
  }

}

class ProductPage extends StatefulWidget {

  final Product prdct;

  const ProductPage({super.key, required this.prdct});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> with TickerProviderStateMixin{

  late double scrheight;
  late double scrwidth;

  late Product prd;
  late KeepProvider prvd;

  late Store prs_str;

  late List<Color> catgColors;
  late List<IconData> checkColr;

  late AnimationController _scalanimationcnt;
  late Animation<double> _scale;

  String size = '';
  Color clr = Colors.transparent;

  int qte = 0;

  late int discount;

  Product fetch(int id) {
    return prvd.prdliste.where((e) => e.id == id).first;
  }

  @override
  void initState() {
    super.initState();

    _scalanimationcnt =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _scale = Tween(begin: 1.0, end: 1.05).animate(_scalanimationcnt)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _scalanimationcnt.reverse();
        }
      });

    prvd = Provider.of<KeepProvider>(context, listen: false);

    prd = widget.prdct;

    catgColors = List.filled(prd.sizes.length, Colors.transparent);
    checkColr = List.filled(prd.colors.length, FontAwesomeIcons.x);

    prs_str = prvd.strliste.where((e) => prd.id_store == e.str_id).single;

    discount = 0;
    prvd.prmliste.forEach((e) {
     if(fetch(e.id_prd).id == prd.id){
       discount = e.prctg;
     }
   });

  }

  @override
  void dispose() {
    super.dispose();
    _scalanimationcnt.dispose();
  }

  Widget build(BuildContext context) {

    scrheight = MediaQuery.of(context).size.height;
    scrwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: scrwidth,
        height: scrheight,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
        ),
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                  width: scrwidth,
                  height: (40.625*scrheight)/100,
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: prd.images.length,
                    itemBuilder: (context,ind){
                      return Container(
                        child: Hero(
                          tag: prd.images[ind],
                          child: Image(
                              image: AssetImage('${prd.images[ind]}'),
                              fit: BoxFit.contain
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: prd.prd_qte == 0 ? true : false,
                  child: Positioned(
                    top: (7.8125*scrheight)/100,
                    left: (27.7777*scrwidth)/100,
                    child: Container(
                      width: (41.6666*scrwidth)/100,
                      height: (23.4375*scrheight)/100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('media/soldout.png'),
                          fit: BoxFit.contain
                        )
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: (2.34375*scrheight)/100,
                  child: IconButton(
                    style: ButtonStyle(
                        overlayColor:
                        WidgetStatePropertyAll<Color>(Colors.transparent)),
                    onPressed: () {
                      Navigator.pop(context, 'refresh');
                    },
                    icon: Icon(
                        prvd.appLocale.languageCode == 'ar'?EvaIcons.arrowIosForward : EvaIcons.arrowIosBack,
                        size: (7.5 * scrwidth) / 100,
                        color: Colors.black87
                    ),
                  ),
                )
              ],
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.6,
              minChildSize: 0.6,
              maxChildSize: prd.prd_qte == 0 ? 0.75 : 0.86,
              builder: (BuildContext context, ScrollController scrollController){
                return  Container(
                  padding: EdgeInsets.only(top: (3.125*scrheight)/100, left: (5.5555*scrwidth)/100, right: (5.5555*scrwidth)/100, bottom: (1.5625*scrheight)/100),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: (69.4444*scrwidth)/100,
                              child: Text(
                                prd.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Kunika',
                                  fontSize: (9.72*scrwidth)/100,
                                  decoration: TextDecoration.none,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surface ==
                                      Color(0xfffef7ff)
                                      ? Colors.black87
                                      : Color(0xfffef7ff),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if(prd.fav == true){
                                  prd.fav = false;
                                  setState(() {});
                                }else{
                                  prd.fav = true;
                                  setState(() {});
                                }
                              },
                              child: prd.fav  ? FaIcon(
                                FontAwesomeIcons.solidHeart,
                                size: (6.94*scrwidth)/100,
                                color: Colors.red
                              ) : FaIcon(
                                FontAwesomeIcons.heart,
                                size: (6.94*scrwidth)/100,
                                color: Theme.of(context)
                                    .colorScheme
                                    .surface ==
                                    Color(0xfffef7ff)
                                    ? Colors.black87
                                    : Color(0xfffef7ff),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: (1.5625*scrheight)/100),
                        Row(
                          children: [
                            FaIcon(
                              prd.rate >= 4.9 ? FontAwesomeIcons.solidStar : FontAwesomeIcons.starHalfStroke,
                              color: prvd.first,
                              size: (5.56*scrwidth)/100,
                            ),
                            SizedBox(width: (1.38888*scrwidth)/100),
                            Text(
                              '${prd.rate}',
                              style: TextStyle(
                                  fontFamily: 'Kunika',
                                  fontWeight: FontWeight.w500,
                                  fontSize: (6.11*scrwidth)/100,
                                  color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                      ? Colors.black87
                                      : Color(0xfffef7ff),
                                  letterSpacing: 1,
                                  decoration: TextDecoration.none
                              ),
                            ),
                            SizedBox(width: (1.38888*scrwidth)/100),
                            Text(
                              prvd.appLocale.languageCode == 'en'?'(${prd.total_rvw}' + ' ' + AppLocalizations.of(context)!.rvw + ')' :'(${prd.total_rvw}' + ' ' +  AppLocalizations.of(context)!.rvw + ')',
                              style: TextStyle(
                                  fontFamily: 'Kunika',
                                  fontWeight: FontWeight.w500,
                                  fontSize: (6.11*scrwidth)/100,
                                  color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                      ? Colors.black87
                                      : Color(0xfffef7ff),
                                  letterSpacing: 1,
                                  decoration: TextDecoration.none
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: (1.875*scrheight)/100),
                        Divider(
                          height: (0.15625*scrheight)/100,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(height: (1.5625*scrheight)/100),
                        Text(
                          AppLocalizations.of(context)!.dsc,
                          style: TextStyle(
                              fontFamily: 'Kunika',
                              fontWeight: FontWeight.w500,
                              fontSize: (6.67*scrwidth)/100,
                              color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                  ? Colors.black87
                                  : Color(0xfffef7ff),
                              letterSpacing: 1,
                              decoration: TextDecoration.none
                          ),
                        ),
                        SizedBox(height: (1.5625*scrheight)/100),
                        Text(
                          prd.desc,
                          style: TextStyle(
                              fontFamily: 'Kunika',
                              fontWeight: FontWeight.w500,
                              fontSize: (4.72*scrwidth)/100,
                              color: Colors.grey.shade500,
                              letterSpacing: 1,
                              decoration: TextDecoration.none
                          ),
                        ),
                        SizedBox(height: (2.03125*scrheight)/100),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.stk,
                              style: TextStyle(
                                  fontFamily: 'Kunika',
                                  fontWeight: FontWeight.w500,
                                  fontSize: (5.56*scrwidth)/100,
                                  color: Colors.grey.shade600,
                                  letterSpacing: 1,
                                  decoration: TextDecoration.none
                              ),
                            ),
                            SizedBox(width: (1.38888*scrheight)/100),
                            Text(
                              prd.prd_qte > 0 ? AppLocalizations.of(context)!.in_stk : AppLocalizations.of(context)!.out_stk,
                              style: TextStyle(
                                  fontFamily: 'Kunika',
                                  fontWeight: FontWeight.w500,
                                  fontSize: (6.39*scrwidth)/100,
                                  color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                      ? Colors.black87
                                      : Color(0xfffef7ff),
                                  letterSpacing: 1,
                                  decoration: TextDecoration.none
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: (2.03125*scrheight)/100),
                        Container(
                            width: (50*scrwidth)/100,
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
                                },
                                contentPadding: EdgeInsets.symmetric(horizontal: (2.7777*scrwidth)/100),
                                leading: Container(
                                  width: (16.6666*scrwidth)/100,
                                  height: (9.375*scrheight)/100,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage(prs_str.str_image),
                                          fit: BoxFit.fill
                                      )
                                  ),
                                ),
                                title: Text(
                                  prs_str.str_name,
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
                                subtitle: Text(
                                  prvd.appLocale.languageCode == 'en'?'${prs_str.prd_seles}' + ' ' + AppLocalizations.of(context)!.prdc :'${prs_str.prd_seles}' + ' ' +  AppLocalizations.of(context)!.prdc,
                                  style: TextStyle(
                                    fontFamily: 'Kunika',
                                    fontWeight: FontWeight.w500,
                                    fontSize: (3.61*scrwidth)/100,
                                    color: Colors.grey.shade400,
                                    letterSpacing: 1,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                        ),
                        Visibility(
                          visible: prd.prd_qte == 0 || (prd.sizes.isEmpty && prd.colors.isEmpty) ? false : true,
                          child: SizedBox(
                              height: (4.6875*scrheight)/100
                          ),
                        ),
                        Visibility(
                          visible: prd.prd_qte == 0 || (prd.sizes.isEmpty && prd.colors.isEmpty) ? false : true,
                          child: Row(
                            mainAxisAlignment: prd.sizes.isEmpty ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
                           children: [
                          prd.sizes.isNotEmpty ? Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text(
                                     AppLocalizations.of(context)!.size,
                                     style: TextStyle(
                                       fontFamily: 'Kunika',
                                       fontWeight: FontWeight.w500,
                                       fontSize: (6.94*scrwidth)/100,
                                       color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                           ? Colors.black87
                                           : Color(0xfffef7ff),
                                       letterSpacing: 1,
                                     ),
                                   ),
                                   SizedBox(
                                     height: (7.8125*scrheight)/100,
                                     width: (40.27777*scrwidth)/100,
                                     child: ListView.separated(
                                       separatorBuilder: (BuildContext c, int i) => SizedBox(width: 10),
                                       scrollDirection: Axis.horizontal,
                                       itemCount: prd.sizes.length,
                                       itemBuilder: (context, ind){
                                         return GestureDetector(
                                           onTap: () {
                                             setState(() {
                                               catgColors = List.filled(prd.sizes.length, Colors.transparent);
                                               catgColors[ind] = (catgColors[ind] == prvd.first) ? Colors.transparent : prvd.first;
                                               size = prd.sizes[ind];
                                             });
                                           },
                                           child: Container(
                                             width: (11.1111*scrwidth)/100,
                                             height: (6.25*scrheight)/100,
                                             decoration: BoxDecoration(
                                               color: catgColors[ind] == prvd.first? prvd.first : Colors.transparent,
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
                                                 prd.sizes[ind],
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
                                   )
                                 ],
                             ) : SizedBox(),
                             Visibility(
                               visible: prd.colors.isEmpty ? false : true,
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text(
                                     AppLocalizations.of(context)!.color,
                                     style: TextStyle(
                                       fontFamily: 'Kunika',
                                       fontWeight: FontWeight.w500,
                                       fontSize: ( 6.94*scrwidth)/100,
                                       color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                           ? Colors.black87
                                           : Color(0xfffef7ff),
                                       letterSpacing: 1,
                                     ),
                                   ),
                                   SizedBox(
                                     height: (7.8125*scrheight)/100,
                                     width: (40.27777*scrwidth)/100,
                                     child: ListView.separated(
                                       separatorBuilder: (BuildContext c, int i) => SizedBox(width: 10),
                                       scrollDirection: Axis.horizontal,
                                       itemCount: prd.colors.length,
                                       itemBuilder: (context, ind){
                                         return GestureDetector(
                                           onTap: () {
                                             setState(() {
                                               checkColr = List.filled(prd.colors.length, FontAwesomeIcons.x);
                                               checkColr[ind] = (checkColr[ind] == FontAwesomeIcons.check) ? FontAwesomeIcons.x : FontAwesomeIcons.check;
                                               clr = prd.colors[ind];
                                             });
                                           },
                                           child: Container(
                                             width: (11.1111*scrwidth)/100,
                                             height: (6.25*scrheight)/100,
                                             decoration: BoxDecoration(
                                                 color: prd.colors[ind],
                                                 shape: BoxShape.circle,
                                                 border: Border.all(
                                                   width: (0.5555*scrwidth)/100,
                                                   color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                                       ? Colors.black87
                                                       : Color(0xfffef7ff),
                                                 )
                                             ),
                                             child: Center(
                                               child: FaIcon(
                                                 checkColr[ind] == FontAwesomeIcons.check ? FontAwesomeIcons.check : FontAwesomeIcons.x,
                                                 color: prvd.first,
                                                 size: checkColr[ind] == FontAwesomeIcons.check ? (5.28*scrwidth)/100 : 0,
                                               ),
                                             ),
                                           ),
                                         );
                                       },
                                     ),
                                   )
                                 ],
                               ),
                             ),
                           ],
                          ),
                        ),
                        Visibility(
                            visible: prd.prd_qte == 0 ? false : true,
                            child: SizedBox(height: (4.6875*scrheight)/100)),
                        Visibility(
                          visible: prd.prd_qte == 0 ? false : true,
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.qte,
                                style: TextStyle(
                                    fontFamily: 'Kunika',
                                    fontWeight: FontWeight.w500,
                                    fontSize: (6.67*scrwidth)/100,
                                    color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                        ? Colors.black87
                                        : Color(0xfffef7ff),
                                    letterSpacing: 1,
                                    decoration: TextDecoration.none
                                ),
                              ),
                              SizedBox(width: (4.16666*scrwidth)/100),
                              Container(
                                padding: EdgeInsets.all((0.78125*scrheight)/100),
                                width: (33.3333*scrwidth)/100,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(50)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if(qte > 0){
                                          setState(() {
                                            qte--;
                                          });
                                        }
                                      },
                                      child: Icon(
                                        EvaIcons.minus,
                                        size: (5.28*scrwidth)/100,
                                        color: Colors.black87
                                      ),
                                    ),
                                    Text(
                                      '$qte',
                                      style: TextStyle(
                                          fontFamily: 'Kunika',
                                          fontWeight: FontWeight.w500,
                                          fontSize: (5.56*scrwidth)/100,
                                          color: Colors.black87,
                                          letterSpacing: 1,
                                          decoration: TextDecoration.none
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if(qte < prd.prd_qte){
                                          setState(() {
                                            qte++;
                                          });
                                        }
                                      },
                                      child: Icon(
                                          EvaIcons.plus,
                                        size: (5.28*scrwidth)/100,
                                        color: Colors.black87
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: (4.6875*scrheight)/100),
                        Divider(
                          height: (0.15625*scrheight)/100,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(height: (2.34375*scrheight)/100),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.ttl_price,
                                  style: TextStyle(
                                      fontFamily: 'Kunika',
                                      fontWeight: FontWeight.w500,
                                      fontSize: (4.72*scrwidth)/100,
                                      color: Colors.grey.shade500,
                                      letterSpacing: 1,
                                      decoration: TextDecoration.none
                                  ),
                                ),
                                discount == 0 ? Text(
                                  prvd.appLocale.languageCode == 'en' ? '${prd.price}'+' '+AppLocalizations.of(context)!.dn : '${prd.price}' + ' '+ AppLocalizations.of(context)!.dn,
                                  style: TextStyle(
                                      fontFamily: 'Kunika',
                                      fontWeight: FontWeight.w500,
                                      fontSize: (8.33*scrwidth)/100,
                                      color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                          ? Colors.black87
                                          : Color(0xfffef7ff),
                                      letterSpacing: 1,
                                      decoration: TextDecoration.none
                                  ),
                                ): Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: (1.38888*scrwidth)/100),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Text(
                                          '${discount}' + '%',
                                        style: TextStyle(
                                            fontFamily: 'Kunika',
                                            fontWeight: FontWeight.w500,
                                            fontSize: (5*scrwidth)/100,
                                            color: Theme.of(context).colorScheme.surface,
                                            letterSpacing: 1,
                                            decoration: TextDecoration.none
                                        ),
                                      ),
                                    ),

                                    SizedBox(width: (1.38888*scrwidth)/100),
                                    Text(
                                      prvd.appLocale.languageCode == 'en' ? '${(prd.price * discount)/100}'+' '+AppLocalizations.of(context)!.dn : '${(prd.price * discount)/100}' + ' '+ AppLocalizations.of(context)!.dn,
                                      style: TextStyle(
                                          fontFamily: 'Kunika',
                                          fontWeight: FontWeight.w500,
                                          fontSize: (5.83*scrwidth)/100,
                                          color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                              ? Colors.black87
                                              : Color(0xfffef7ff),
                                          letterSpacing: 1,
                                          decoration: TextDecoration.none
                                      ),

                                    )
                                  ],
                                ),
                              ],
                            ),
                            AnimatedBuilder(
                              animation: _scalanimationcnt,
                              builder: (context,child) => Transform.scale(
                                scale: _scale.value,
                                child: GestureDetector(
                                  onTap: () {
                                    _scalanimationcnt.forward();
                                    snackMsg();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB((6.94444*scrwidth)/100, (2.34375*scrheight)/100, (6.94444*scrwidth)/100, (2.34375*scrheight)/100),
                                    decoration: BoxDecoration(
                                      color: chs_color(),
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
                                        Icon(
                                            EvaIcons.shoppingCart,
                                            size: ( 8.33*scrwidth)/100,
                                            color: Theme.of(context).colorScheme.surface
                                        ),
                                        SizedBox(width: (1.38888*scrwidth)/100),
                                        Text(
                                          AppLocalizations.of(context)!.add_cart,
                                          style: TextStyle(
                                              fontFamily: 'Kunika',
                                              fontWeight: FontWeight.w500,
                                              fontSize: (5.56*scrwidth)/100,
                                              color: Theme.of(context).colorScheme.surface ,
                                              letterSpacing: 1,
                                              decoration: TextDecoration.none
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        )
      ),
    );
  }

  Color chs_color() {
    if (prd.colors.isEmpty && prd.sizes.isEmpty && qte != 0) {
      return prvd.first;
    } else if ((qte == 0 && (clr == Colors.transparent && size == ''))) {
      return prvd.first.withOpacity(0.3);
    } else if (prd.prd_qte == 0) {
      return prvd.first.withOpacity(0.3);
    } else if (prd.sizes.isEmpty && (qte == 0 || clr == Colors.transparent)) {
      return prvd.first.withOpacity(0.3);
    } else if (prd.colors.isEmpty && (qte == 0 || size == '')) {
      return prvd.first.withOpacity(0.3);
    } else if (prd.colors.isNotEmpty && prd.sizes.isNotEmpty &&
        (qte == 0 || (clr == Colors.transparent || size == ''))) {
      return prvd.first.withOpacity(0.3);
    } else if (prd.colors.isEmpty && prd.sizes.isEmpty && qte == 0) {
      return prvd.first.withOpacity(0.3);
    } else {
      return prvd.first;
    }
  }

  bool verify(Product p) {
    bool res = false;
    prvd.cart_item.forEach((e) {
      if(e.prd.id == p.id){
         res = true;
      }
    });
    return res;
  }

  void snackMsg() {
    if(prd.colors.isNotEmpty && prd.sizes.isNotEmpty){
      if(prd.prd_qte > 0 && qte > 0 && clr != Colors.transparent && size != '' && !verify(prd)){
        prvd.cart_item.add(Cart(prd, qte, discount, clr, size));

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                child: Text(
                  AppLocalizations.of(context)!.prd_add,
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
      }else if(clr == Colors.transparent && size == '' && prd.prd_qte !=0){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                child: Text(
                  AppLocalizations.of(context)!.obg_sel,
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
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                child: Text(
                  popMsg(), /*prd.prd_qte == 0 ? AppLocalizations.of(context)!.prd_out : (qte == 0 ? AppLocalizations.of(context)!.qte_null :AppLocalizations.of(context)!.prd_exist),*/
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
    }else if(prd.colors.isNotEmpty){
      if(prd.prd_qte > 0 && qte > 0 && clr != Colors.transparent && !verify(prd)){
        prvd.cart_item.add(Cart(prd, qte, discount, clr, size));

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                child: Text(
                  AppLocalizations.of(context)!.prd_add,
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
      }else if(clr == Colors.transparent && prd.prd_qte !=0){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                child: Text(
                  AppLocalizations.of(context)!.obg_sel_clr,
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
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                child: Text(
                  prd.prd_qte == 0 ? AppLocalizations.of(context)!.prd_out : (qte == 0 ? AppLocalizations.of(context)!.qte_null :AppLocalizations.of(context)!.prd_exist),
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
    }else if (prd.sizes.isNotEmpty){
      if(prd.prd_qte > 0 && qte > 0 && size != '' && !verify(prd)){
        prvd.cart_item.add(Cart(prd, qte, discount, clr, size));

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                child: Text(
                  AppLocalizations.of(context)!.prd_add,
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
      }else if(size == '' && prd.prd_qte !=0){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                child: Text(
                  AppLocalizations.of(context)!.obg_sel_sz,
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
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                child: Text(
                  popMsg(),
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
    }else{
      if(prd.prd_qte > 0 && qte > 0 && !verify(prd)){
        prvd.cart_item.add(Cart(prd, qte, discount, clr, size));

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                child: Text(
                  AppLocalizations.of(context)!.prd_add,
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
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                child: Text(
                  prd.prd_qte == 0 ? AppLocalizations.of(context)!.prd_out : (qte == 0 ? AppLocalizations.of(context)!.qte_null :AppLocalizations.of(context)!.prd_exist),
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
    }

  }

  String popMsg(){
    if(prd.prd_qte == 0){
      return  AppLocalizations.of(context)!.prd_out;
    }else if(prd.sizes.isNotEmpty && size == ''){
      return AppLocalizations.of(context)!.obg_sel_sz;
    }else if(prd.colors.isNotEmpty && clr == Colors.transparent){
      return AppLocalizations.of(context)!.obg_sel_clr;
    }else{
      return AppLocalizations.of(context)!.qte_null;
    }
  }

}

class CartItem extends StatefulWidget {
  const CartItem({super.key});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> with TickerProviderStateMixin{

  late double scrheight;
  late double scrwidth;

  late KeepProvider prvd;

  late double items_price;

  late AnimationController _scalanimationcnt;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    prvd = Provider.of<KeepProvider>(context, listen: false);

    _scalanimationcnt =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _scale = Tween(begin: 1.0, end: 1.05).animate(_scalanimationcnt)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _scalanimationcnt.reverse();
        }
      });

  }

  Widget build(BuildContext context) {
    precacheImage(AssetImage('media/Vectorlogo_ext2.png'), context);

    items_price = 0;
    prvd.cart_item.forEach((e) {
      if(e.prd_discount > 0){
        items_price += ((e.prd.price * e.prd_discount)/100) * e.prd_qte;
      }else{
        items_price += (e.prd.price) * e.prd_qte;
      }
    });

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
          AppLocalizations.of(context)!.my_crt,
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
      body: Container(
        width: scrwidth,
        height: (78.125*scrheight)/100,
        child: Stack(
          children: [
             SizedBox(
               height: (62.5*scrheight)/100,
               child: prvd.cart_item.isNotEmpty ? ListView.builder(
                 padding: EdgeInsets.only(top: (2.34375*scrheight)/100, right: (4.16666*scrwidth)/100, left: (4.16666*scrwidth)/100),
                    itemCount: prvd.cart_item.length,
                    itemBuilder: (context, ind){
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: (1.5625*scrheight)/100, horizontal: (4.16666*scrwidth)/100),
                        margin: EdgeInsets.only(bottom: (3.125*scrheight)/100),
                        width: scrwidth,
                        height: (20.3125*scrheight)/100,
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
                        child: Row(
                          children: [
                            Container(
                              width: (27.7777*scrwidth)/100,
                              height: (15.625*scrheight)/100,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(18),
                                image: DecorationImage(
                                  image: AssetImage(prvd.cart_item[ind].prd.images[0]),
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
                                          prvd.cart_item[ind].prd.name,
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
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            prvd.cart_item.remove(prvd.cart_item[ind]);
                                          });
                                        },
                                        child: FaIcon(
                                          FontAwesomeIcons.circleXmark,
                                          size: (6.11*scrwidth)/100,
                                          color: prvd.first,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: (0.78125*scrheight)/100),
                                  Visibility(
                                    visible: prvd.cart_item[ind].prd_sz == '' && prvd.cart_item[ind].prd_clr == Colors.transparent ? false : true,
                                    child: Row(
                                      children: [
                                        prvd.cart_item[ind].prd_clr != Colors.transparent ? Container(
                                          width: (5.5555*scrwidth)/100,
                                          height: (3.125*scrheight)/100,
                                          decoration: BoxDecoration(
                                            color: prvd.cart_item[ind].prd_clr,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              width: (0.5555*scrwidth)/100,
                                              color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                                  ? Colors.black87
                                                  : Color(0xfffef7ff),
                                            )
                                          ),
                                        ) : SizedBox(),
                                        prvd.cart_item[ind].prd_clr != Colors.transparent ? SizedBox(width: (1.38888*scrwidth)/100) : SizedBox(),
                                        prvd.cart_item[ind].prd_clr != Colors.transparent ? Text(
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
                                        prvd.cart_item[ind].prd_clr != Colors.transparent ? SizedBox(width: (2.2222*scrwidth)/100) : SizedBox(),
                                        prvd.cart_item[ind].prd_clr != Colors.transparent ? Container(
                                          width: (0.5555*scrwidth)/100,
                                          height: (2.34375*scrheight)/100,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                                ? Colors.black87
                                                : Color(0xfffef7ff),
                                            borderRadius: BorderRadius.circular(50)
                                          ),
                                        ) : SizedBox(),
                                        prvd.cart_item[ind].prd_clr != Colors.transparent ? SizedBox(width: (2.2222*scrwidth)/100) : SizedBox(),
                                        prvd.cart_item[ind].prd_sz != '' ? Text(
                                          AppLocalizations.of(context)!.size + ' = ' + prvd.cart_item[ind].prd_sz,
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
                                          prvd.appLocale.languageCode == 'en' ? '${Priceprd(prvd.cart_item[ind])}'+' '+AppLocalizations.of(context)!.dn : '${Priceprd(prvd.cart_item[ind])}' + ' '+ AppLocalizations.of(context)!.dn,
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
                                            borderRadius: BorderRadius.circular(50)
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                if(prvd.cart_item[ind].prd_qte > 1){
                                                  setState(() {
                                                    prvd.cart_item[ind].prd_qte--;
                                                    items_price -= (Priceprd(prvd.cart_item[ind]) * prvd.cart_item[ind].prd_qte);
                                                  });
                                                }
                                              },
                                              child: Icon(
                                                  EvaIcons.minus,
                                                  size: (4.72*scrwidth)/100,
                                                  color: Colors.black87
                                              ),
                                            ),
                                            Text(
                                              '${prvd.cart_item[ind].prd_qte}',
                                              style: TextStyle(
                                                  fontFamily: 'Kunika',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: (5*scrwidth)/100,
                                                  color: Colors.black87,
                                                  letterSpacing: 1,
                                                  decoration: TextDecoration.none
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                if(prvd.cart_item[ind].prd_qte < prvd.cart_item[ind].prd.prd_qte){
                                                  setState(() {
                                                    prvd.cart_item[ind].prd_qte++;
                                                    items_price += (Priceprd(prvd.cart_item[ind]) * prvd.cart_item[ind].prd_qte);
                                                  });
                                                }
                                              },
                                              child: Icon(
                                                  EvaIcons.plus,
                                                  size: (4.72*scrwidth)/100,
                                                  color: Colors.black87
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ) : Center(
                 child: Text(
                   AppLocalizations.of(context)!.cart_null,
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
             ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: (4.16666*scrwidth)/100, vertical: (2.34375*scrheight)/100),
                width: scrwidth,
                height: (15.625*scrheight)/100,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)
                    ),
                  border: Border(
                    top: BorderSide(
                      color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff) ? Colors.transparent : Colors.grey.shade300,
                      width: (0.5555*scrwidth)/100
                    )
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff) ? Color(0x29000000) : Colors.transparent,
                        offset: Offset(0, 3),
                        blurRadius: 10,
                        spreadRadius: 1),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.ttl_price,
                          style: TextStyle(
                              fontFamily: 'Kunika',
                              fontWeight: FontWeight.w500,
                              fontSize: (4.72*scrwidth)/100,
                              color: Colors.grey.shade500,
                              letterSpacing: 1,
                              decoration: TextDecoration.none
                          ),
                        ),
                        Text(
                          prvd.appLocale.languageCode == 'en' ? '${items_price}'+' '+AppLocalizations.of(context)!.dn : '${items_price}' + ' '+ AppLocalizations.of(context)!.dn,
                          style: TextStyle(
                              fontFamily: 'Kunika',
                              fontWeight: FontWeight.w500,
                              fontSize: (7.78*scrwidth)/100,
                              color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                  ? Colors.black87
                                  : Color(0xfffef7ff),
                              letterSpacing: 1,
                              decoration: TextDecoration.none
                          ),
                        )
                      ],
                    ),
                    AnimatedBuilder(
                      animation: _scalanimationcnt,
                      builder: (context,child) => Transform.scale(
                        scale: _scale.value,
                        child: GestureDetector(
                          onTap: () {
                            _scalanimationcnt.forward();
                            if(prvd.cart_item.isNotEmpty && prvd.userAdress.isNotEmpty){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => checkoutPage(items_price: items_price)));
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Center(
                                      child: Text(
                                        AppLocalizations.of(context)!.y_cart_null,
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
                            padding: EdgeInsets.fromLTRB((6.94444*scrwidth)/100, (2.34375*scrheight)/100, (6.94444*scrwidth)/100, (2.34375*scrheight)/100),
                            decoration: BoxDecoration(
                              color: items_price == 0 ? prvd.first.withOpacity(0.3) : prvd.first,
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
                                  AppLocalizations.of(context)!.check,
                                  style: TextStyle(
                                      fontFamily: 'Kunika',
                                      fontWeight: FontWeight.w500,
                                      fontSize: (5.56*scrwidth)/100,
                                      color: Theme.of(context).colorScheme.surface ,
                                      letterSpacing: 1,
                                      decoration: TextDecoration.none
                                  ),
                                ),
                                SizedBox(width: (1.38888*scrwidth)/100),
                                Icon(
                                    prvd.appLocale.languageCode == 'en' ? EvaIcons.arrowIosForward : EvaIcons.arrowIosBack,
                                    size: (6.39*scrwidth)/100,
                                    color: Theme.of(context).colorScheme.surface
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  double Priceprd(Cart c){
    double ttl = 0;
    if(c.prd_discount > 0){
      ttl += ((c.prd.price * c.prd_discount)/100 * c.prd_qte);
    }else{
      ttl += (c.prd.price * c.prd_qte);
    }

    return ttl;
  }

}

class checkoutPage extends StatefulWidget {
  final double items_price;
  const checkoutPage({Key? key, required this.items_price}) : super(key: key);

  @override
  State<checkoutPage> createState() => _checkoutPageState();
}

class _checkoutPageState extends State<checkoutPage> with TickerProviderStateMixin{

  late KeepProvider prvd;

  late double scrheight;
  late double scrwidth;

  double ttl_price = 0;


  late AnimationController _scalanimationcnt;
  late Animation<double> _scale;

  late AnimationController _scalanimationcnt1;
  late Animation<double> _scale1;

  late int discount;

  TextEditingController promocnt = TextEditingController();
  bool errprom = false ;
  late bool res;

  @override
  void dispose() {
    super.dispose();
    _scalanimationcnt.dispose();
    _scalanimationcnt1.dispose();
  }

  void initState() {
    super.initState();
    prvd = Provider.of<KeepProvider>(context, listen: false);

    ttl_price = widget.items_price;

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
    _scale1 = Tween(begin: 1.0, end: 1.05).animate(_scalanimationcnt1)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _scalanimationcnt1.reverse();
        }
      });
  }

  Widget build(BuildContext context) {
    res = false;

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
        AppLocalizations.of(context)!.check,
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
      body: Stack(
        children: [
          Container(
            width: scrwidth,
            height: scrheight,
            padding: EdgeInsets.fromLTRB((4.16666*scrwidth)/100, (2.34375*scrheight)/100, (4.16666*scrwidth)/100, (1.5625*scrheight)/100),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Divider(
                    height: (0.15625*scrheight)/100,
                    color: Colors.grey.shade300,
                  ),
                  SizedBox(height: (2.34375*scrheight)/100),
                  SizedBox(
                      width: scrwidth,
                      child: Text(
                        AppLocalizations.of(context)!.shp_addr,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Kunika',
                          fontSize: (6.39*scrwidth)/100,
                          color: Theme.of(context)
                              .colorScheme
                              .surface ==
                              Color(0xfffef7ff)
                              ? Colors.black87
                              : Color(0xfffef7ff),
                        ),
                        textAlign: TextAlign.start,
                      )
                  ),
                  SizedBox(height: (2.34375*scrheight)/100),
                  Container(
                    padding: EdgeInsets.all((2.5*scrheight)/100),
                    width: scrwidth,
                    height: Theme.of(context).colorScheme.surface == Color(0xfffef7ff) ? (12.5*scrheight)/100 : (12.8125*scrheight)/100,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surface ==
                                  Color(0xfffef7ff)
                                  ? Color(0x29000000) : Colors.transparent,
                              offset: Offset(0, 3),
                              blurRadius: 10,
                              spreadRadius: 1),
                        ],
                        border: Border.all(
                            width: Theme.of(context)
                                .colorScheme
                                .surface ==
                                Color(0xfffef7ff)
                                ? 0 : (0.416666*scrwidth)/100,
                            color: Theme.of(context)
                                .colorScheme
                                .surface ==
                                Color(0xfffef7ff)
                                ? Colors.transparent : Colors.grey.shade300
                        )
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all((0.625*scrheight)/100),
                          width: (13.8888*scrwidth)/100,
                          height: (7.8125*scrheight)/100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: (0.416666*scrwidth)/100,
                                  color: Colors.grey.shade300
                              )
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: prvd.first,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surface ==
                                        Color(0xfffef7ff)
                                        ? Color(0x29000000) : Colors.transparent,
                                    offset: Offset(0, 3),
                                    blurRadius: 10,
                                    spreadRadius: 1),
                              ],
                            ),
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.locationDot,
                                size: (5.56*scrwidth)/100,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: (4.16666*scrwidth)/100),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.hm,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Kunika',
                                fontSize: (5.28*scrwidth)/100,
                                color: Theme.of(context)
                                    .colorScheme
                                    .surface ==
                                    Color(0xfffef7ff)
                                    ? Colors.black87
                                    : Color(0xfffef7ff),
                              ),
                            ),
                            SizedBox(
                              width: (34.375*scrheight)/100,
                              child: Text(
                                '${prvd.userAdress[0].street} ' + '${prvd.userAdress[0].subLocality} ' + '${prvd.userAdress[0].administrativeArea} ' + ', ' + '${prvd.userAdress[0].country}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Kunika',
                                  fontSize: (3.89*scrwidth)/100,
                                  color: Colors.grey.shade400,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: (3.90625*scrheight)/100),
                  Divider(
                    height: (0.15625*scrheight)/100,
                    color: Colors.grey.shade300,
                  ),
                  SizedBox(height: (2.03125*scrheight)/100),
                  SizedBox(
                    width: scrwidth,
                    child: Text(
                      AppLocalizations.of(context)!.ord_list,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Kunika',
                        fontSize: (6.39*scrwidth)/100,
                        color: Theme.of(context)
                            .colorScheme
                            .surface ==
                            Color(0xfffef7ff)
                            ? Colors.black87
                            : Color(0xfffef7ff),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(height: (2.03125*scrheight)/100),
                  SizedBox(
                    width: scrwidth,
                    height: (37.5*scrheight)/100,
                    child: ListView.separated(
                      padding: EdgeInsets.all((1.5625*scrheight)/100),
                      separatorBuilder: (BuildContext c, int i) => SizedBox(height: (0.15625*scrheight)/100),
                      itemCount: prvd.cart_item.length,
                      itemBuilder: (context, ind){
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: (1.5625*scrheight)/100, horizontal: (4.16666*scrwidth)/100),
                          margin: EdgeInsets.only(bottom: (3.125*scrheight)/100),
                          width: scrwidth,
                          height: (20.3125*scrheight)/100,
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
                          child: Row(
                            children: [
                              Container(
                                width: (27.7777*scrwidth)/100,
                                height: (15.625*scrheight)/100,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(18),
                                    image: DecorationImage(
                                        image: AssetImage(prvd.cart_item[ind].prd.images[0]),
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
                                            prvd.cart_item[ind].prd.name,
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
                                      ],
                                    ),
                                    SizedBox(height: (0.78125*scrheight)/100),
                                    Visibility(
                                      visible: prvd.cart_item[ind].prd_sz == '' && prvd.cart_item[ind].prd_clr == Colors.transparent ? false : true,
                                      child: Row(
                                        children: [
                                          prvd.cart_item[ind].prd_clr != Colors.transparent ? Container(
                                            width: (5.5555*scrwidth)/100,
                                            height: (3.125*scrheight)/100,
                                            decoration: BoxDecoration(
                                                color: prvd.cart_item[ind].prd_clr,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  width: (0.5555*scrwidth)/100,
                                                  color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                                      ? Colors.black87
                                                      : Color(0xfffef7ff),
                                                )
                                            ),
                                          ) : SizedBox(),
                                          prvd.cart_item[ind].prd_clr != Colors.transparent ? SizedBox(width: (1.38888*scrwidth)/100) : SizedBox(),
                                          prvd.cart_item[ind].prd_clr != Colors.transparent ? Text(
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
                                          prvd.cart_item[ind].prd_clr != Colors.transparent ? SizedBox(width: (2.2222*scrwidth)/100) : SizedBox(),
                                          prvd.cart_item[ind].prd_clr != Colors.transparent ? Container(
                                            width: (0.5555*scrwidth)/100,
                                            height: (2.34375*scrheight)/100,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                                    ? Colors.black87
                                                    : Color(0xfffef7ff),
                                                borderRadius: BorderRadius.circular(50)
                                            ),
                                          ) : SizedBox(),
                                          prvd.cart_item[ind].prd_clr != Colors.transparent ? SizedBox(width: (2.2222*scrwidth)/100) : SizedBox(),
                                          prvd.cart_item[ind].prd_sz != '' ? Text(
                                            AppLocalizations.of(context)!.size + ' = ' + prvd.cart_item[ind].prd_sz,
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
                                            prvd.appLocale.languageCode == 'en' ? '${Priceprd(prvd.cart_item[ind])}'+' '+AppLocalizations.of(context)!.dn : '${Priceprd(prvd.cart_item[ind])}' + ' '+ AppLocalizations.of(context)!.dn,
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
                                          padding: EdgeInsets.all((1.5625*scrheight)/100),
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              shape: BoxShape.circle
                                          ),
                                          child: Center(
                                            child: Text(
                                              '${prvd.cart_item[ind].prd_qte}',
                                              style: TextStyle(
                                                  fontFamily: 'Kunika',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: (4.17*scrwidth)/100,
                                                  color: Colors.black87,
                                                  letterSpacing: 1,
                                                  decoration: TextDecoration.none
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all((2.34375*scrheight)/100),
              width: scrwidth,
              height: (12.5*scrheight)/100,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                    ? Colors.white
                    : Colors.black,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x29000000),
                        offset: Offset(0, 3),
                        blurRadius: 10,
                        spreadRadius: 1),
                  ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
                )
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(50)),
                        ),
                        context: context,
                        builder: (BuildContext context){
                          return StatefulBuilder(
                              builder: (BuildContext context, StateSetter setState){
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: (4.16666*scrwidth)/100, vertical: (1.5625*scrheight)/100),
                                  width: scrwidth,
                                  height: (38.28125 * scrheight)/100,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20))),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom: (1.5625 * scrheight) /
                                                100),
                                        width: (8.3333 * scrwidth) / 100,
                                        height:
                                        (0.46875 * scrheight) / 100,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface ==
                                                Color(0xfffef7ff)
                                                ? Colors.black87
                                                : Color(0xfffef7ff),
                                            borderRadius:
                                            BorderRadius.circular(
                                                50)),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.prm,
                                        style: TextStyle(
                                            fontFamily: 'Kunika',
                                            fontWeight: FontWeight.w500,
                                            fontSize: (7.78 * scrwidth)/100,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface ==
                                                Color(0xfffef7ff)
                                                ? Colors.black87
                                                : Color(0xfffef7ff),
                                            letterSpacing: 1),
                                      ),
                                      SizedBox(
                                        height: (1.40625*scrheight)/100,
                                      ),
                                      Container(
                                        width: scrwidth,
                                        height: (0.234375*scrheight)/100,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            color: Colors.grey.withOpacity(0.2)
                                        ),
                                      ),
                                      SizedBox(
                                        height: (2.34375*scrheight)/100,
                                      ),
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
                                                width: (0.28 * scrwidth)/100,
                                                color: errprom ? Colors.red : Colors.transparent)),
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
                                              child: Center(
                                                child: FaIcon(
                                                  FontAwesomeIcons.code,
                                                  color: prvd.first,
                                                  size: (3.125*scrheight)/100,
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
                                                controller: promocnt,
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
                                                      AppLocalizations.of(context)!.prm,
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
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          AnimatedBuilder(
                                            animation: _scalanimationcnt,
                                            builder: (context, child) => Transform.scale(
                                              scale: _scale.value,
                                              child: Container(
                                                margin: EdgeInsets.only(top: (3.125 * scrheight) / 100),
                                                width: (41.6666 * scrwidth) / 100,
                                                height: (7.8125 * scrheight) / 100,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  borderRadius: BorderRadius.circular(50),
                                                ),
                                                child: TextButton(
                                                    style: ButtonStyle(
                                                        overlayColor: WidgetStatePropertyAll<Color>(
                                                            Colors.transparent)),
                                                    onPressed: () {
                                                      _scalanimationcnt.forward();
                                                      Navigator.pop(context);
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChsShipping(prix: ttl_price,)));
                                                    },
                                                    child: Text(
                                                      AppLocalizations.of(context)!.cnl,
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
                                                    )),
                                              ),
                                            ),
                                          ),
                                          AnimatedBuilder(
                                            animation: _scalanimationcnt1,
                                            builder: (context, child) => Transform.scale(
                                              scale: _scale1.value,
                                              child: Container(
                                                margin: EdgeInsets.only(top: (3.125 * scrheight) / 100),
                                                width: (41.6666 * scrwidth) / 100,
                                                height: (7.8125 * scrheight) / 100,
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
                                                child: TextButton(
                                                    style: ButtonStyle(
                                                        overlayColor: WidgetStatePropertyAll<Color>(
                                                            Colors.transparent)),
                                                    onPressed: () {
                                                      _scalanimationcnt1.forward();
                                                      prvd.CodePromo.forEach((e) {
                                                        if(e.name == promocnt.text){
                                                          res = true;
                                                          ttl_price = (ttl_price * e.discount_rate)/100;
                                                        }
                                                      });
                                                      if(promocnt.text.isNotEmpty){
                                                        if(res){
                                                          promocnt.clear();
                                                          res = !res;
                                                          Navigator.pop(context);
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                              SnackBar(
                                                                content: Center(
                                                                  child: Text(
                                                                    AppLocalizations.of(context)!.prm_crct,
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
                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChsShipping(prix: ttl_price)));
                                                        }else{
                                                          setState(() {
                                                            errprom = !errprom;
                                                          });
                                                          Future.delayed(Duration(milliseconds: 500), (){
                                                            Vibration.vibrate(duration: 200);
                                                            setState(() {
                                                              errprom = !errprom;
                                                            });
                                                          });
                                                        }
                                                      }else{
                                                        setState(() {
                                                          errprom = !errprom;
                                                        });
                                                        Future.delayed(Duration(milliseconds: 500), (){
                                                          Vibration.vibrate(duration: 200);
                                                          setState(() {
                                                            errprom = !errprom;
                                                          });
                                                        });
                                                      }

                                                    },
                                                    child: Text(
                                                      AppLocalizations.of(context)!.add,
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
                                                    )),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }
                          );
                        }
                    );
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
                            AppLocalizations.of(context)!.paymnt,
                            style: TextStyle(
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.w500,
                                fontSize: (5.56*scrwidth)/100,
                                color: Theme.of(context).colorScheme.surface,
                                letterSpacing: 1,
                                decoration: TextDecoration.none
                            ),
                          ),
                          SizedBox(width: (1.38888*scrwidth)/100),
                          Icon(
                              prvd.appLocale.languageCode == 'en' ? EvaIcons.arrowIosForward : EvaIcons.arrowIosBack,
                              size: (6.39*scrwidth)/100,
                              color: Theme.of(context).colorScheme.surface
                          ),
                        ],
                      ),
                    ),
                ),
                ),
              ),
            ),
        ],
      )
    );
  }
  double Priceprd(Cart c){
    double ttl = 0;
    if(c.prd_discount > 0){
      ttl += ((c.prd.price * c.prd_discount)/100 * c.prd_qte);
    }else{
      ttl += (c.prd.price * c.prd_qte);
    }

    return ttl;
  }
}

class ChsShipping extends StatefulWidget {
  final double prix;
  const ChsShipping({super.key, required this.prix});

  @override
  State<ChsShipping> createState() => _ChsShippingState();
}

class _ChsShippingState extends State<ChsShipping> {

  late KeepProvider prvd;
  late double scrheight;
  late double scrwidth;

  DateTime arr_date = DateTime.now();

  String? shipping;

  late double prx;

  void initState() {
    super.initState();
    prvd = Provider.of<KeepProvider>(context, listen: false);
    prx = widget.prix;
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
          AppLocalizations.of(context)!.chs_ship,
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
      body: Container(
          //padding: EdgeInsets.fromLTRB((4.16666*scrwidth)/100, (2.34375*scrheight)/100, (4.16666*scrwidth)/100, (1.5625*scrheight)/100),
          width: scrwidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all((4.17*scrwidth)/100),
                child: Column(
                  children: [
                    Container(
                      width: scrwidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                            ? Colors.white
                            : Colors.black,
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x29000000),
                              offset: Offset(0, 3),
                              blurRadius: 10,
                              spreadRadius: 1),
                        ],
                      ),
                      child: ListTile(
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            shipping = 'economy';
                          });
                        },
                        leading: Container(
                          padding: EdgeInsets.all(13),
                          width: (13.89 * scrwidth)/100,
                          height: (7.8125 * scrheight)/100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: prvd.first,
                          ),
                          child: Image(
                            image: Theme.of(context).colorScheme.surface == Color(0xfffef7ff) ? AssetImage('media/econnomy_light.png') : AssetImage('media/econnomy_dark.png'),
                          ),
                        ),
                        title: Text(
                          AppLocalizations.of(context)!.ecnm + ' (300'+ AppLocalizations.of(context)!.dn + ')',
                          style: TextStyle(
                            fontFamily: 'Kunika',
                            fontWeight: FontWeight.bold,
                            fontSize: (5.56 * scrwidth)/100,
                            color:
                            Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                ? Colors.black87
                                : Color(0xfffef7ff),
                          ),
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context)!.arv_date + ', ' + DateFormat('MMM').format(arr_date) + ' ${arr_date.day + 1}' + '-' + '${arr_date.day + 4}',
                          style: TextStyle(
                            fontFamily: 'Kunika',
                            fontWeight: FontWeight.bold,
                            fontSize: (3.33 * scrwidth)/100,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        trailing: Radio(
                          value: 'economy',
                          groupValue: shipping,
                          onChanged: (v) {
                            setState(() {
                              shipping = v.toString();
                            });
                          },
                          activeColor: prvd.first,
                          splashRadius: 0,
                        ),
                        ),
                    ),
                    SizedBox(height: (5.56*scrwidth)/100),
                    Container(
                      width: scrwidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                            ? Colors.white
                            : Colors.black,
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x29000000),
                              offset: Offset(0, 3),
                              blurRadius: 10,
                              spreadRadius: 1),
                        ],
                      ),
                      child: ListTile(
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            shipping = 'regular';
                          });
                        },
                        leading: Container(
                          padding: EdgeInsets.all(13),
                          width: (13.89 * scrwidth)/100,
                          height: (7.8125 * scrheight)/100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: prvd.first,
                          ),
                          child: Image(
                            image: Theme.of(context).colorScheme.surface == Color(0xfffef7ff) ? AssetImage('media/regular_light.png') : AssetImage('media/regular_dark.png'),
                          ),
                        ),
                        title: Text(
                          AppLocalizations.of(context)!.reg + ' (350'+ AppLocalizations.of(context)!.dn + ')',
                          style: TextStyle(
                            fontFamily: 'Kunika',
                            fontWeight: FontWeight.bold,
                            fontSize: (5.56 * scrwidth)/100,
                            color:
                            Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                ? Colors.black87
                                : Color(0xfffef7ff),
                          ),
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context)!.arv_date + ', ' + DateFormat('MMM').format(arr_date) + ' ${arr_date.day + 2}' + '-' + '${arr_date.day + 4}',
                          style: TextStyle(
                            fontFamily: 'Kunika',
                            fontWeight: FontWeight.bold,
                            fontSize: (3.33 * scrwidth)/100,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        trailing: Radio(
                          value: 'regular',
                          groupValue: shipping,
                          onChanged: (v) {
                            setState(() {
                              shipping = v.toString();
                            });
                          },
                          activeColor: prvd.first,
                          splashRadius: 0,
                        ),
                      ),
                    ),
                    SizedBox(height: (5.56*scrwidth)/100),
                    Container(
                      width: scrwidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                            ? Colors.white
                            : Colors.black,
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x29000000),
                              offset: Offset(0, 3),
                              blurRadius: 10,
                              spreadRadius: 1),
                        ],
                      ),
                      child: ListTile(
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            shipping = 'cargo';
                          });
                        },
                        leading: Container(
                          padding: EdgeInsets.all(13),
                          width: (13.89 * scrwidth)/100,
                          height: (7.8125 * scrheight)/100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: prvd.first,
                          ),
                          child: Image(
                            image: Theme.of(context).colorScheme.surface == Color(0xfffef7ff) ? AssetImage('media/cargo_light.png') : AssetImage('media/cargo_dark.png'),
                          ),
                        ),
                        title: Text(
                          AppLocalizations.of(context)!.crg + ' (500'+ AppLocalizations.of(context)!.dn + ')',
                          style: TextStyle(
                            fontFamily: 'Kunika',
                            fontWeight: FontWeight.bold,
                            fontSize: (5.56 * scrwidth)/100,
                            color:
                            Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                ? Colors.black87
                                : Color(0xfffef7ff),
                          ),
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context)!.arv_date + ', ' + DateFormat('MMM').format(arr_date) + ' ${arr_date.day + 1}' + '-' + '${arr_date.day + 2}',
                          style: TextStyle(
                            fontFamily: 'Kunika',
                            fontWeight: FontWeight.bold,
                            fontSize: (3.33 * scrwidth)/100,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        trailing: Radio(
                          value: 'cargo',
                          groupValue: shipping,
                          onChanged: (v) {
                            setState(() {
                              shipping = v.toString();
                            });
                          },
                          activeColor: prvd.first,
                          splashRadius: 0,
                        ),
                      ),
                    ),
                    SizedBox(height: (5.56*scrwidth)/100),
                    Container(
                      width: scrwidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                            ? Colors.white
                            : Colors.black,
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x29000000),
                              offset: Offset(0, 3),
                              blurRadius: 10,
                              spreadRadius: 1),
                        ],
                      ),
                      child: ListTile(
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            shipping = 'express';
                          });
                        },
                        leading: Container(
                          padding: EdgeInsets.all(13),
                          width: (13.89 * scrwidth)/100,
                          height: (7.8125 * scrheight)/100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: prvd.first,
                          ),
                          child: Image(
                            image: Theme.of(context).colorScheme.surface == Color(0xfffef7ff) ? AssetImage('media/fast_light.png') : AssetImage('media/fast_dark.png'),
                          ),
                        ),
                        title: Text(
                          AppLocalizations.of(context)!.exp + ' (700'+ AppLocalizations.of(context)!.dn + ')',
                          style: TextStyle(
                            fontFamily: 'Kunika',
                            fontWeight: FontWeight.bold,
                            fontSize: (5.56 * scrwidth)/100,
                            color:
                            Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                ? Colors.black87
                                : Color(0xfffef7ff),
                          ),
                        ),
                        subtitle: Text(
                          AppLocalizations.of(context)!.arv_date + ', ' + DateFormat('MMM').format(arr_date) + ' ${arr_date.day}' + '-' + '${arr_date.day + 1}',
                          style: TextStyle(
                            fontFamily: 'Kunika',
                            fontWeight: FontWeight.bold,
                            fontSize: (3.33 * scrwidth)/100,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        trailing: Radio(
                          value: 'express',
                          groupValue: shipping,
                          onChanged: (v) {
                            setState(() {
                              shipping = v.toString();
                            });
                          },
                          activeColor: prvd.first,
                          splashRadius: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all((2.34375*scrheight)/100),
                width: scrwidth,
                height: (12.5*scrheight)/100,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                        ? Colors.white
                        : Colors.black,
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 10,
                          spreadRadius: 1),
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)
                    )
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      if(shipping != null){
                        int id_order = Random.secure().nextInt(5);
                        prvd.ords.add(Order(prvd.user.id,id_order, prvd.userAdress[0], shipping!, 'ongoing', DateTime.now(), prx));
                        prvd.cart_item.forEach((e) {
                          prvd.ordr_itelms.add(Order_item(e.prd, id_order, e.prd_qte, e.prd_clr, e.prd_sz, e.prd_discount));
                        });
                        prvd.cart_item.clear();
                        sttchnge();
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.ord_succ,
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
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                        /*r.didReplace(MaterialPageRoute(builder: (context) => CartItem())));*/
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: (1.5625*scrheight)/100),
                      width: scrwidth,
                      decoration: BoxDecoration(
                        color: shipping == null ?  prvd.first.withOpacity(0.3) : prvd.first,
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
                            AppLocalizations.of(context)!.app,
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
                ),
            ],
          )
        ),
    );
  }




  void sttchnge()  {
    if(shipping == 'economy'){
      Future.delayed(Duration(seconds: 20), () {
        chng_st1(prvd.ordr_itelms, prvd.ords);
      });
    }else if(shipping == 'regular'){
      Future.delayed(Duration(seconds: 15), () {
        chng_st1(prvd.ordr_itelms, prvd.ords);
      });
    }else if(shipping == 'cargo'){
      Future.delayed(Duration(seconds: 10), () {
        chng_st1(prvd.ordr_itelms, prvd.ords);
      });
    }else if(shipping == 'express'){
      print('ayoub');
      Future.delayed(Duration(seconds: 5), () {
        chng_st1(prvd.ordr_itelms, prvd.ords);
      });
    }
  }

   void chng_st1(List<Order_item> a, List<Order> b ){
    List<Order_item> copyA = List.of(a);
    List<Order> copyB = List.of(b);
    for (Order x in copyB){
      for (Order_item y in copyA){
        if(x.id == y.id_ord){
          print('zella');
          x.stauts = 'completed';
        }
      }
    }
  }



}

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> with TickerProviderStateMixin{
  late double scrheight;
  late double scrwidth;

  late KeepProvider prvd;

  late TabController tab;

  late AnimationController _scalanimationcnt;
  late Animation<double> _scale;

  late AnimationController _scalanimationcnt1;
  late Animation<double> _scale1;


  TextEditingController rev_text = TextEditingController();

  double ord_rat = 0;

  @override
  void initState() {
    super.initState();
    prvd = Provider.of<KeepProvider>(context, listen: false);
    tab = TabController(length: 2, vsync: this);

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
    _scale1 = Tween(begin: 1.0, end: 1.05).animate(_scalanimationcnt1)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _scalanimationcnt1.reverse();
        }
      });


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
          AppLocalizations.of(context)!.ords,
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
                text: AppLocalizations.of(context)!.ord_go,
              ),
              Tab(
                text: AppLocalizations.of(context)!.ord_cmp,
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
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: (1.5625*scrheight)/100, horizontal: (4.16666*scrwidth)/100),
                      margin: EdgeInsets.only(bottom: (3.125*scrheight)/100),
                      width: scrwidth,
                      //height: (20.3125*scrheight)/100,
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
                          SizedBox(height: 12,),
                          Divider(
                            height: 1,
                            color:Colors.grey.shade400,
                          ),
                          SizedBox(height: 12,),
                          GestureDetector(
                            onTap: () {
                              if(CheckStatu(prvd.ordr_itelms[ind])){
                                setState(() {
                                  prvd.hist_item = prvd.hist_item + chng_st(prvd.ordr_itelms, prvd.ords);
                                });
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Center(
                                        child: Text(
                                          AppLocalizations.of(context)!.rev_sbm,
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
                              padding: EdgeInsets.symmetric(vertical: 5),
                              width: scrwidth,
                              decoration: BoxDecoration(
                                color: CheckStatu(prvd.ordr_itelms[ind]) ? prvd.first : prvd.first.withOpacity(0.3),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)
                                )
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.cnfr,
                                style: TextStyle(
                                    fontFamily: 'Kunika',
                                    fontWeight: FontWeight.w500,
                                    fontSize: (4.17 * scrwidth)/100,
                                    color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                        ? Colors.black87
                                        : Color(0xfffef7ff),
                                    letterSpacing: 1,
                                    decoration: TextDecoration.none
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      )
                    );
                  },
                ) : Center(
                  child: Text(
                    AppLocalizations.of(context)!.nth,
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
                    return Container(
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
                          SizedBox(height: 12,),
                          Divider(
                            height: 1,
                            color:Colors.grey.shade400,
                          ),
                          SizedBox(height: 12,),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                  ),
                                  context: context,
                                  builder: (BuildContext context){
                                    return StatefulBuilder(
                                        builder: (BuildContext context, StateSetter setState){
                                          return Container(
                                            padding: EdgeInsets.symmetric(horizontal: (4.16666*scrwidth)/100, vertical: (1.5625*scrheight)/100),
                                            width: scrwidth,
                                            height: 500,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .surface,
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(20),
                                                    topLeft: Radius.circular(20))),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: (1.5625 * scrheight) /
                                                          100),
                                                  width: (8.3333 * scrwidth) / 100,
                                                  height:
                                                  (0.46875 * scrheight) / 100,
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .surface ==
                                                          Color(0xfffef7ff)
                                                          ? Colors.black87
                                                          : Color(0xfffef7ff),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)!.lv_rvw,
                                                  style: TextStyle(
                                                      fontFamily: 'Kunika',
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: (8.89*scrwidth)/100,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .surface ==
                                                          Color(0xfffef7ff)
                                                          ? Colors.black87
                                                          : Color(0xfffef7ff),
                                                      letterSpacing: 1),
                                                ),
                                                SizedBox(
                                                  height: (1.40625*scrheight)/100,
                                                ),
                                                Divider(
                                                  height: (0.3125 * scrheight)/100,
                                                  color: Colors.grey.shade300,
                                                ),
                                                SizedBox(
                                                  height: (2.03125*scrheight)/100,
                                                ),
                                                Container(
                                                  width: scrwidth,
                                                  height: (20.3125*scrheight)/100,
                                                  padding: EdgeInsets.symmetric(vertical: (1.5625*scrheight)/100, horizontal: (4.16666*scrwidth)/100),
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
                                                  child: Row(
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
                                                                    )
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: (2.03125*scrheight)/100,
                                                ),
                                                Divider(
                                                  height: (0.3125 * scrheight)/100,
                                                  color: Colors.grey.shade300,
                                                ),
                                                SizedBox(
                                                  height: (2.03125*scrheight)/100,
                                                ),
                                                SizedBox(
                                                    width: scrwidth,
                                                    child: Text(
                                                      AppLocalizations.of(context)!.ordr_rate,
                                                      style: TextStyle(
                                                          fontFamily: 'Kunika',
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: (7.78 * scrwidth)/100,
                                                          color: Theme.of(context)
                                                              .colorScheme
                                                              .surface ==
                                                              Color(0xfffef7ff)
                                                              ? Colors.black87
                                                              : Color(0xfffef7ff),
                                                          letterSpacing: 1),
                                                      textAlign: TextAlign.center,
                                                    )
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                RatingBar.builder(
                                                  minRating: 1,
                                                  itemBuilder: (context,_) {
                                                    return FaIcon(
                                                      FontAwesomeIcons.solidStar,
                                                      color: prvd.first,
                                                    );
                                                  },
                                                  onRatingUpdate: (rating) {
                                                    ord_rat = rating;
                                                  },
                                                  itemPadding: EdgeInsets.symmetric(horizontal: 10),
                                                  itemSize: 30,
                                                  glow: false,
                                                  allowHalfRating: true,
                                                  unratedColor: Theme.of(context)
                                                      .colorScheme
                                                      .surface ==
                                                      Color(0xfffef7ff)
                                                      ? Colors.black87
                                                      : Color(0xfffef7ff),
                                                  updateOnDrag: true,
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Container(
                                                  padding:
                                                  EdgeInsets.symmetric(horizontal: (2.7777 * scrwidth) / 100),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: Theme.of(context).colorScheme.surface ==
                                                          Color(0xff141218)
                                                          ? Color(0xd8ffffff)
                                                          : Color(0x1A000000),
                                                      ),
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
                                                        child: Center(
                                                          child: FaIcon(
                                                            FontAwesomeIcons.keyboard,
                                                            color: prvd.first,
                                                            size: (3.125*scrheight)/100,
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
                                                          controller: rev_text,
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
                                                                AppLocalizations.of(context)!.lv_rvw,
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
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    AnimatedBuilder(
                                                      animation: _scalanimationcnt,
                                                      builder: (context, child) => Transform.scale(
                                                        scale: _scale.value,
                                                        child: Container(
                                                          margin: EdgeInsets.only(top: (3.125 * scrheight) / 100),
                                                          width: (41.6666 * scrwidth) / 100,
                                                          height: (7.8125 * scrheight) / 100,
                                                          decoration: BoxDecoration(
                                                            color: Colors.grey.shade300,
                                                            borderRadius: BorderRadius.circular(50),
                                                          ),
                                                          child: TextButton(
                                                              style: ButtonStyle(
                                                                  overlayColor: WidgetStatePropertyAll<Color>(
                                                                      Colors.transparent)),
                                                              onPressed: () {
                                                                _scalanimationcnt.forward();
                                                                Navigator.pop(context);
                                                                rev_text.clear();
                                                              },
                                                              child: Text(
                                                                AppLocalizations.of(context)!.cnl,
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
                                                              )),
                                                        ),
                                                      ),
                                                    ),
                                                    AnimatedBuilder(
                                                      animation: _scalanimationcnt1,
                                                      builder: (context, child) => Transform.scale(
                                                        scale: _scale1.value,
                                                        child: Container(
                                                          margin: EdgeInsets.only(top: (3.125 * scrheight) / 100),
                                                          width: (41.6666 * scrwidth) / 100,
                                                          height: (7.8125 * scrheight) / 100,
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
                                                          child: TextButton(
                                                              style: ButtonStyle(
                                                                  overlayColor: WidgetStatePropertyAll<Color>(
                                                                      Colors.transparent)),
                                                              onPressed: () {
                                                                _scalanimationcnt1.forward();
                                                                if(rev_text.text.isNotEmpty && ord_rat > 0){
                                                                  var id_c = Random().nextInt(1000);
                                                                  prvd.ords_rvws.add(Review(prvd.hist_item[ind].p.id, id_c, ord_rat, rev_text.text));
                                                                  Navigator.pop(context);
                                                                  rev_text.clear();
                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                      SnackBar(
                                                                        content: Center(
                                                                          child: Text(
                                                                            AppLocalizations.of(context)!.rev_sbm,
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
                                                              child: Text(
                                                                AppLocalizations.of(context)!.sbmt,
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
                                                              )),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        }
                                    );
                                  }
                              );
                            },
                            child: SizedBox(
                              width: scrwidth,
                              child: Text(
                                AppLocalizations.of(context)!.lv_rvw,
                                style: TextStyle(
                                    fontFamily: 'Kunika',
                                    fontWeight: FontWeight.w500,
                                    fontSize: (4.17 * scrwidth)/100,
                                    color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                        ? Colors.black87
                                        : Color(0xfffef7ff),
                                    letterSpacing: 1,
                                    decoration: TextDecoration.none
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      )
                    );
                  },
                ) : Center(
                  child: Text(
                    AppLocalizations.of(context)!.nth1,
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
      ),
    );
  }
  
  bool CheckStatu(Order_item ord){
    bool res = false;
    prvd.ords.forEach((e) {
      if(e.id == ord.id_ord){
        print('jamal');
        if(e.stauts == 'completed'){
          res = true;
        }
      }
    });
    return res;
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

  List<Order_item> chng_st(List<Order_item> a, List<Order> b ){
    List<Order_item> res = [];
    List<Order_item> copyA = List.of(a);
    List<Order> copyB = List.of(b);
    for (Order x in copyB){
      for (Order_item y in copyA){
        if(x.id == y.id_ord){
          print('zella');
          res.add(y);
          a.remove(y);
        }
      }
    }
    return res;
  }


}


class Category extends StatefulWidget {
  final String ctgr;
  const Category({super.key, required this.ctgr});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  late double scrheight;
  late double scrwidth;

  late KeepProvider prvd;

  late List<Product> prdList;
  late List<Product> prodKpr;

  late String catrogy;

  TextEditingController srchcnt = TextEditingController();

  @override
  void initState() {
    super.initState();

    prvd = Provider.of<KeepProvider>(context, listen: false);

    catrogy = widget.ctgr;
    prodKpr = prvd.prdliste;
    prdList = Updatelist(catrogy);

  }

  Widget build(BuildContext context) {

    scrheight = MediaQuery.of(context).size.height;
    scrwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:  AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation: 0,
        leading:  Container(
          margin: prvd.appLocale.languageCode == 'en' ? EdgeInsets.only(left: (4.16666*scrwidth)/100) : EdgeInsets.only(right: (4.16666*scrwidth)/100),
          child: Image(
            image: AssetImage('media/$catrogy.png'),
          ),
        ),
        title: Text(
          ctg_name(catrogy),
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
        centerTitle: true,
      ),
      body: Container(
        height: scrheight,
        width: scrwidth,
        padding: EdgeInsets.fromLTRB((4.16666*scrwidth)/100, (1.5625*scrheight)/100, (4.16666*scrwidth)/100, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric( horizontal: (2.7777*scrwidth)/100),
                width: scrwidth,
                height: (8.59375*scrheight)/100,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      EvaIcons.searchOutline,
                      size: (6.9444*scrwidth)/100,
                      color: Colors.grey.withOpacity(0.8),
                    ),
                    SizedBox(
                      width: (1.38888*scrwidth)/100,
                    ),
                    SizedBox(
                      width: (69.4444*scrwidth)/100,
                      child: TextFormField(
                        controller: srchcnt,
                        onChanged: (v) {
                        },
                        style: TextStyle(
                            fontSize: (5 * scrwidth) / 100,
                            fontFamily: 'Kunika',
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context)
                                .colorScheme
                                .surface ==
                                Color(0xfffef7ff)
                                ? Colors.black87
                                : Color(0xfffef7ff)
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                          EdgeInsets.zero,
                          hintText:AppLocalizations.of(context)!.srch,
                          hintStyle:  TextStyle(
                              fontFamily: 'Kunika',
                              fontSize:
                              (5.5556*scrwidth)/100,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.withOpacity(0.4)),
                          border: InputBorder.none,
                        ),
                        cursorColor: prvd.first,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: (1.09375*scrheight)/100),
              SizedBox(
                  height: (78.125 * scrheight)/100,
                  child: prdList.isNotEmpty ? GridView.builder(
                    padding: EdgeInsets.only(left: (2.7777*scrwidth)/100, top: (2.34375*scrheight)/100, right: (2.7777*scrwidth)/100, bottom: (0.78125 * scrheight)/100),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.59,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20
                    ),
                    itemCount: prdList.length,
                    itemBuilder: (context, ind) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(prdct: prdList[ind])));
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
                                      tag: prdList[ind].images[0],
                                      child: Image(
                                        image: AssetImage('${prdList[ind].images[0]}'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: (1.5625*scrheight)/100,
                                    right: (2.7777*scrwidth)/100,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                        });
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all((0.625*scrheight)/100),
                                          decoration: BoxDecoration(
                                            color: prvd.first,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            EvaIcons.heartOutline,
                                            size: (5.28*scrwidth)/100,
                                            color: Theme.of(context).colorScheme.surface,
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: (0.46875*scrheight)/100),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    prdList[ind].name,
                                    style: TextStyle(
                                      fontFamily: 'Kunika',
                                      fontWeight: FontWeight.w500,
                                      fontSize: (6.11*scrwidth)/100,
                                      color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                          ? Colors.black87
                                          : Color(0xfffef7ff),
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FaIcon(
                                        prdList[ind].rate >= 4.9 ? FontAwesomeIcons.solidStar : FontAwesomeIcons.starHalfStroke,
                                        color: prvd.first,
                                        size: (4.72*scrwidth)/100,
                                      ),
                                      SizedBox(width: (1.38888*scrwidth)/100),
                                      Text(
                                        '${prdList[ind].rate}',
                                        style: TextStyle(
                                          fontFamily: 'Kunika',
                                          fontWeight: FontWeight.w500,
                                          fontSize: (5.00*scrwidth)/100,
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
                                          prvd.appLocale.languageCode == 'en' ? '${prdList[ind].sold}'+' '+AppLocalizations.of(context)!.sld : '${prdList[ind].sold}' + ' '+ AppLocalizations.of(context)!.sld,
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
                                    prvd.appLocale.languageCode == 'en' ? '${prdList[ind].price}'+' '+AppLocalizations.of(context)!.dn : '${prdList[ind].price}' + ' '+ AppLocalizations.of(context)!.dn,
                                    style: TextStyle(
                                      fontFamily: 'Kunika',
                                      fontWeight: FontWeight.w500,
                                      fontSize: (5.00*scrwidth)/100,
                                      color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                          ? Colors.black87
                                          : Color(0xfffef7ff),
                                      letterSpacing: 1,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ):  Center(
                    child: Text(
                      AppLocalizations.of(context)!.prdc_null,
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
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  String ctg_name(String a){
    String b = '';
    if(a == 'clothes'||a =='الملابس'){
      b = AppLocalizations.of(context)!.clths;
    }else if(a == 'electronics'||a=='الإلكترونيات'){
      b = AppLocalizations.of(context)!.elct;
    }else if(a == 'shoes'||a=='الأحذية'){
      b = AppLocalizations.of(context)!.shs;
    }else if(a == 'bags'||a=='الحقائب'){
      b = AppLocalizations.of(context)!.bgs;
    }else if(a == 'watchs'||a=='الساعات'){
      b = AppLocalizations.of(context)!.wtch;
    }else if(a == 'jewelry'||a=='المجوهرات'){
      b = AppLocalizations.of(context)!.jwlr;
    }else if(a == 'kitchen'||a=='المطبخ'){
      b = AppLocalizations.of(context)!.ktch;
    }else if(a == 'toys'||a=='الألعاب'){
      b = AppLocalizations.of(context)!.tys;
    }else{
      b = '';
    }
    return b;
  }

  List<Product> Updatelist(String catg){
    List<Product> Reslist= [];
    if(catg == 'clothes'||catg =='الملابس'){
      Reslist = prodKpr.where((elem) => elem.category == 'clothes').toList();
    }else if(catg == 'electronics'||catg=='الإلكترونيات'){
      Reslist = prodKpr.where((elem) => elem.category == 'electronics').toList();
    }else if(catg == 'shoes'||catg=='الأحذية'){
      Reslist = prodKpr.where((elem) => elem.category == 'shoes').toList();
    }else if(catg == 'bags'||catg=='الحقائب'){
      Reslist = prodKpr.where((elem) => elem.category == 'bags').toList();
    }else if(catg == 'watchs'||catg=='الساعات'){
      Reslist = prodKpr.where((elem) => elem.category == 'watches').toList();
    }else if(catg == 'jewelry'||catg=='المجوهرات'){
      Reslist = prodKpr.where((elem) => elem.category == 'jewelry').toList();
    }else if(catg == 'kitchen'||catg=='المطبخ'){
      Reslist = prodKpr.where((elem) => elem.category == 'kitchen').toList();
    }else if(catg == 'toys'||catg=='الألعاب'){
      Reslist = prodKpr.where((elem) => elem.category == 'toys').toList();
    }else{
      Reslist = prodKpr;
    }
    return Reslist;
  }
}


class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

  late double scrheight;
  late double scrwidth;

  late KeepProvider prvd;

  late List<Color> catgColors;

  late List<Product> prdList;
  late List<Product> prodKpr;

  late Color catColor;

  bool slid = false;

  TextEditingController srchcnt = TextEditingController();

  @override
  void initState() {
    super.initState();

    prvd = Provider.of<KeepProvider>(context, listen: false);

    catgColors = List.filled(9, Colors.transparent);
    catgColors[0] = prvd.first;

    prdList =  prvd.prdliste;

    prodKpr = prdList;

  }

  Widget build(BuildContext context) {
    precacheImage(AssetImage('media/Vectorlogo_ext2.png'), context);

    List<String> listTpe = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.clths,
      AppLocalizations.of(context)!.bgs,
      AppLocalizations.of(context)!.elct,
      AppLocalizations.of(context)!.jwlr,
      AppLocalizations.of(context)!.ktch,
      AppLocalizations.of(context)!.shs,
      AppLocalizations.of(context)!.tys,
      AppLocalizations.of(context)!.wtch,
    ];

    scrheight = MediaQuery.of(context).size.height;
    scrwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:  AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation: 0,
        leading:  Container(
          margin: prvd.appLocale.languageCode == 'en' ? EdgeInsets.only(left: (4.16666*scrwidth)/100) : EdgeInsets.only(right: (4.16666*scrwidth)/100),
          child: Image(
            image: AssetImage('media/Vectorlogo_ext2.png'),
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.prds,
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
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: (4.72 * scrwidth)/100),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  slid = !slid;
                });
              },
              child: FaIcon(
                slid ? FontAwesomeIcons.x : FontAwesomeIcons.magnifyingGlass,
                color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                    ? Colors.black87
                    : Color(0xfffef7ff),
                size: (5.56 * scrwidth)/100,
              ),
            ),
          )
        ],
      ),
      body: Container(
        height: scrheight,
        width: scrwidth,
        padding: EdgeInsets.fromLTRB((4.16666*scrwidth)/100, (1.5625*scrheight)/100, (4.16666*scrwidth)/100, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AnimatedSwitcher(
                duration:
                Duration(milliseconds: 300),
                transitionBuilder:
                    (child, animation) {
                  return ScaleTransition(
                    scale: animation.drive(
                        Tween(
                            begin: 0, end: 1)),
                    child: child,
                  );
                },
                child: slid
                    ? Container(
                  padding: EdgeInsets.symmetric( horizontal: (2.7777*scrwidth)/100),
                  width: scrwidth,
                  height: (8.59375*scrheight)/100,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        EvaIcons.searchOutline,
                        size: (6.9444*scrwidth)/100,
                        color: Colors.grey.withOpacity(0.8),
                      ),
                      SizedBox(
                        width: (1.38888*scrwidth)/100,
                      ),
                      SizedBox(
                        width: (69.4444*scrwidth)/100,
                        child: TextFormField(
                          controller: srchcnt,
                          onChanged: (v) {
                          },
                          style: TextStyle(
                              fontSize: (5 * scrwidth) / 100,
                              fontFamily: 'Kunika',
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context)
                                  .colorScheme
                                  .surface ==
                                  Color(0xfffef7ff)
                                  ? Colors.black87
                                  : Color(0xfffef7ff)
                          ),
                          decoration: InputDecoration(
                            contentPadding:
                            EdgeInsets.zero,
                            hintText:AppLocalizations.of(context)!.srch,
                            hintStyle:  TextStyle(
                                fontFamily: 'Kunika',
                                fontSize:
                                (5.5556*scrwidth)/100,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.withOpacity(0.4)),
                            border: InputBorder.none,
                          ),
                          cursorColor: prvd.first,
                        ),
                      ),
                    ],
                  ),
                ) : SizedBox(
                  height: (6.25*scrheight)/100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: listTpe.length,
                    itemBuilder: (context, index){
                      return Container(
                        margin: prvd.appLocale.languageCode == 'ar'? EdgeInsets.only(left: (2.7777*scrwidth)/100) : EdgeInsets.only(right: (2.7777*scrwidth)/100),
                        padding: EdgeInsets.symmetric(horizontal: (4.16666*scrwidth)/100),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color: catgColors[index] == prvd.first? Colors.transparent:
                                (Theme.of(context)
                                    .colorScheme
                                    .surface ==
                                    Color(0xfffef7ff)
                                    ? Colors.black87
                                    : Color(0xfffef7ff)),
                                width: (0.3333*scrwidth)/100
                            ),
                            color: catgColors[index] == prvd.first? prvd.first : Colors.transparent
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              catgColors = List.filled(9, Colors.transparent);
                              catgColors[index] = (catgColors[index] == prvd.first) ? Colors.transparent : prvd.first;
                              prdList = Updatelist(listTpe[index]);
                            });
                          },
                          child: Center(
                            child: Text(
                              listTpe[index],
                              style: TextStyle(
                                  fontFamily: 'Kunika',
                                  fontWeight: FontWeight.w500,
                                  fontSize: (5.28*scrwidth)/100,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surface ==
                                      Color(0xfffef7ff)
                                      ? Colors.black87
                                      : Color(0xfffef7ff),
                                  letterSpacing: 1),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: (1.09375*scrheight)/100),
              SizedBox(
                  height: (68.75 *scrheight)/100,
                  child: prdList.isNotEmpty ? GridView.builder(
                    padding: EdgeInsets.only(left: (2.7777*scrwidth)/100, top: (2.34375*scrheight)/100, right: (2.7777*scrwidth)/100, bottom: (0.78125 * scrheight)/100),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.59,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20
                    ),
                    itemCount: prdList.length,
                    itemBuilder: (context, ind) {
                      return GestureDetector(
                        onTap: () async{
                          String refresh = await Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(prdct: prdList[ind])));
                            if(refresh == 'refresh'){
                              setState(() {});
                            }
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
                                      tag: prdList[ind].images[0],
                                      child: Image(
                                        image: AssetImage('${prdList[ind].images[0]}'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: (1.5625*scrheight)/100,
                                    right: (2.7777*scrwidth)/100,
                                    child: GestureDetector(
                                      onTap: () {
                                        if(prdList[ind].fav == true){
                                          prdList[ind].fav = false;
                                          setState(() {});
                                        }else{
                                          prdList[ind].fav = true;
                                          setState(() {});
                                        }
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all((0.625*scrheight)/100),
                                          decoration: BoxDecoration(
                                            color: prvd.first,
                                            shape: BoxShape.circle,
                                          ),
                                          child: prdList[ind].fav ? Icon(
                                            EvaIcons.heart,
                                            size: (5.28*scrwidth)/100,
                                            color: Colors.red,
                                          ) : Icon(
                                            EvaIcons.heartOutline,
                                            size: (5.28*scrwidth)/100,
                                            color: Theme.of(context).colorScheme.surface,
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: (0.46875*scrheight)/100),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    prdList[ind].name,
                                    style: TextStyle(
                                      fontFamily: 'Kunika',
                                      fontWeight: FontWeight.w500,
                                      fontSize: (6.11*scrwidth)/100,
                                      color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                          ? Colors.black87
                                          : Color(0xfffef7ff),
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FaIcon(
                                        prdList[ind].rate >= 4.9 ? FontAwesomeIcons.solidStar : FontAwesomeIcons.starHalfStroke,
                                        color: prvd.first,
                                        size: (4.72*scrwidth)/100,
                                      ),
                                      SizedBox(width: (1.38888*scrwidth)/100),
                                      Text(
                                        '${prdList[ind].rate}',
                                        style: TextStyle(
                                          fontFamily: 'Kunika',
                                          fontWeight: FontWeight.w500,
                                          fontSize: (5.00*scrwidth)/100,
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
                                          prvd.appLocale.languageCode == 'en' ? '${prdList[ind].sold}'+' '+AppLocalizations.of(context)!.sld : '${prdList[ind].sold}' + ' '+ AppLocalizations.of(context)!.sld,
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
                                    prvd.appLocale.languageCode == 'en' ? '${prdList[ind].price}'+' '+AppLocalizations.of(context)!.dn : '${prdList[ind].price}' + ' '+ AppLocalizations.of(context)!.dn,
                                    style: TextStyle(
                                      fontFamily: 'Kunika',
                                      fontWeight: FontWeight.w500,
                                      fontSize: (5.00*scrwidth)/100,
                                      color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                          ? Colors.black87
                                          : Color(0xfffef7ff),
                                      letterSpacing: 1,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ):  Center(
                    child: Text(
                      AppLocalizations.of(context)!.prdc_null,
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
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Product> Updatelist(String catg){
    List<Product> Reslist= [];
    if(catg == 'Clothes'||catg =='الملابس'){
      Reslist = prodKpr.where((elem) => elem.category == 'clothes').toList();
    }else if(catg == 'Electronics'||catg=='الإلكترونيات'){
      Reslist = prodKpr.where((elem) => elem.category == 'electronics').toList();
    }else if(catg == 'Shoes'||catg=='الأحذية'){
      Reslist = prodKpr.where((elem) => elem.category == 'shoes').toList();
    }else if(catg == 'Bags'||catg=='الحقائب'){
      Reslist = prodKpr.where((elem) => elem.category == 'bags').toList();
    }else if(catg == 'Watches'||catg=='الساعات'){
      Reslist = prodKpr.where((elem) => elem.category == 'watches').toList();
    }else if(catg == 'Jewelry'||catg=='المجوهرات'){
      Reslist = prodKpr.where((elem) => elem.category == 'jewelry').toList();
    }else if(catg == 'Kitchen'||catg=='المطبخ'){
      Reslist = prodKpr.where((elem) => elem.category == 'kitchen').toList();
    }else if(catg == 'Toys'||catg=='الألعاب'){
      Reslist = prodKpr.where((elem) => elem.category == 'toys').toList();
    }else{
      Reslist = prodKpr;
    }
    return Reslist;
  }
}


class StoreProfile extends StatefulWidget {
  final Store str;
  const StoreProfile({super.key, required this.str});

  @override
  State<StoreProfile> createState() => _StoreProfileState();
}

class _StoreProfileState extends State<StoreProfile> {
  late double scrwidth;
  late double scrheight;
  late KeepProvider prvd;

  late List<Product> strPrd;



  late Store store;

  @override
  void initState() {
    super.initState();
    prvd = Provider.of<KeepProvider>(context, listen: false);
    store = widget.str;

    strPrd = prvd.prdliste.where((e) => e.id_store == store.str_id).toList();
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
                          image: AssetImage(store.str_image),
                          fit: BoxFit.fill,
                        )
                    )
                ),
                SizedBox(
                  height: (1.5625 * scrheight)/100,
                ),
                Text(
                  store.str_name,
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
                        AppLocalizations.of(context)!.prd_of + ' ' + store.str_name,
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
                        childAspectRatio: 0.58,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 15
                    ),
                    itemCount: strPrd.length,
                    itemBuilder: (context, ind) {
                      return GestureDetector(
                        onTap: () async {
                          String refresh = await Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(prdct: strPrd[ind])));
                          if(refresh == 'refresh'){
                            setState(() {});
                          }
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
                                        if(strPrd[ind].fav == true){
                                          strPrd[ind].fav = false;
                                          setState(() {});
                                        }else{
                                          strPrd[ind].fav = true;
                                          setState(() {});
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all((0.625*scrheight)/100),
                                        decoration: BoxDecoration(
                                          color: prvd.first,
                                          shape: BoxShape.circle,
                                        ),
                                        child: strPrd[ind].fav ? Icon(
                                          EvaIcons.heart,
                                          size: (5.28*scrwidth)/100,
                                          color: Colors.red,
                                        ) : Icon(
                                          EvaIcons.heartOutline,
                                          size: (5.28*scrwidth)/100,
                                          color: Theme.of(context).colorScheme.surface,
                                        )
                                      ),
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
                                      fontSize: (3.4375*scrheight)/100,
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
                                        size: (2.65625*scrheight)/100,
                                      ),
                                      SizedBox(width: (1.38888*scrwidth)/100),
                                      Text(
                                        '${strPrd[ind].rate}',
                                        style: TextStyle(
                                          fontFamily: 'Kunika',
                                          fontWeight: FontWeight.w500,
                                          fontSize: (2.8125*scrheight)/100,
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
                                            fontSize: (1.875*scrheight)/100,
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
                                      fontSize: (2.8125*scrheight)/100,
                                      color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                                          ? Colors.black87
                                          : Color(0xfffef7ff),
                                      letterSpacing: 1,
                                    ),
                                  )
                                ],
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


class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late double scrwidth;
  late double scrheight;
  late KeepProvider prvd;

  File? prfimg;
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
                          return ImageBig(path: prvd.user.user_img);
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
                      tag: prvd.user.user_img,
                      child: ClipOval(
                        child: Image(
                          image: buildFileImage(),
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
                    prvd.user.firstname + ' ' + prvd.user.lastname,
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
                  '${prvd.user.num}',
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Edite_profile()));
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Security()));
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
  ImageProvider<Object> buildFileImage() {
    if (prfimg == null) {
      return AssetImage(prvd.user.user_img);
    } else {
      return FileImage(prfimg as File);
    }
  }
}

class ImageBig extends StatefulWidget {
  final String path;

  const ImageBig({super.key, required this.path});

  @override
  State<ImageBig> createState() => _ImageBigState();
}

class _ImageBigState extends State<ImageBig> {
  late KeepProvider prvd;
  late String imgPath;

  @override
  void initState() {
    super.initState();
    prvd = Provider.of<KeepProvider>(context, listen: false);
    imgPath = widget.path;
  }
  Widget build(BuildContext context) {

    return Container(
        child: Center(
          child: Hero(
            tag: imgPath,
            child: Image(
              image: AssetImage(imgPath),
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
        )
    );
  }
}


class Edite_profile extends StatefulWidget {
  const Edite_profile({super.key});

  @override
  State<Edite_profile> createState() => _Edite_profileState();
}

class _Edite_profileState extends State<Edite_profile> with TickerProviderStateMixin{

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
    firstcnt = TextEditingController(text: prvd.user.firstname);
    lastcnt = TextEditingController(text: prvd.user.lastname);
    phnnmcnt = TextEditingController(text: prvd.user.num.toString());
    emailcnt = TextEditingController(text: prvd.user.email);
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
      return AssetImage(prvd.user.user_img);
    } else {
      return FileImage(prfimg as File);
    }
  }
}


class Security extends StatefulWidget {
  const Security({super.key});

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {

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

class Languages extends StatefulWidget {
  const Languages({super.key});

  @override
  State<Languages> createState() => _LanguagesState();
}

class _LanguagesState extends State<Languages> {

  late KeepProvider prvd;
  late double scrwidth;
  late double scrheight;

  late String lgnggroup;

  @override
  void initState() {
    super.initState();
    prvd = Provider.of<KeepProvider>(context, listen: false);
    lgnggroup = prvd.appLocale.languageCode;
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
          AppLocalizations.of(context)!.lng,
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
        padding: EdgeInsets.fromLTRB((4.16666*scrwidth)/100, 10, (4.16666*scrwidth)/100, 10),
        child: ListView.builder(
          itemCount: Language.languageList.length,
          itemBuilder: (context, ind){
            return ListTile(
              splashColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              onTap: () async{
                  setState(() {
                    lgnggroup = Language.languageList[ind].languageCode;
                  });
                  Locale _locale = await setLocale(Language.languageList[ind].languageCode);
                  SnapBuy.setLocale(context, _locale);
                  prvd.setAppLocale(_locale);
              },
              leading: Text(
                  Language.languageList[ind].name + ' (${Language.languageList[ind].languageCode})',
                style: TextStyle(
                  fontFamily: 'Kunika',
                  fontWeight: FontWeight.w500,
                  fontSize: 23,
                  color:
                  Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                      ? Colors.black87
                      : Color(0xfffef7ff),
                ),
              ),
              trailing:  Radio(
                value: Language.languageList[ind].languageCode,
                groupValue: lgnggroup,
                onChanged: (v) async{
                  setState(() {
                    lgnggroup = v.toString();
                  });
                  Locale _locale = await setLocale(Language.languageList[ind].languageCode);
                  SnapBuy.setLocale(context, _locale);
                  prvd.setAppLocale(_locale);
                },
                activeColor: prvd.first,
                splashRadius: 0,
              ),
            );
          },
        )
      ),
    );
  }
}



class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  late KeepProvider prvd;
  late double scrwidth;
  late double scrheight;

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
          AppLocalizations.of(context)!.prv_plc,
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
        padding: EdgeInsets.fromLTRB((4.16666*scrwidth)/100, 10, (4.16666*scrwidth)/100, 10),
        child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1. ' + AppLocalizations.of(context)!.tpdata,
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
                  SizedBox(height: 15),
                  Text(
                    AppLocalizations.of(context)!.tpdatasec,
                    style: TextStyle(
                      fontFamily: 'Kunika',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.grey.shade500
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '2. ' + AppLocalizations.of(context)!.prsdata,
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
                  SizedBox(height: 15),
                  Text(
                    AppLocalizations.of(context)!.tpprsdata,
                    style: TextStyle(
                        fontFamily: 'Kunika',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey.shade500
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '3. ' + AppLocalizations.of(context)!.disdata,
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
                  SizedBox(height: 15),
                  Text(
                    AppLocalizations.of(context)!.tpdisdata,
                    style: TextStyle(
                        fontFamily: 'Kunika',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey.shade500
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '4. ' + AppLocalizations.of(context)!.scdata,
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
                  SizedBox(height: 15),
                  Text(
                    AppLocalizations.of(context)!.tpscdata,
                    style: TextStyle(
                        fontFamily: 'Kunika',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey.shade500
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}

class HelpCenter extends StatefulWidget {
  const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  late KeepProvider prvd;
  late double scrwidth;
  late double scrheight;

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
          AppLocalizations.of(context)!.hlp_cnt,
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
        padding: EdgeInsets.fromLTRB((4.16666*scrwidth)/100, 10, (4.16666*scrwidth)/100, 10),
        child: Column(
          children: [
            Container(
              width: scrwidth,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                      ? Colors.white
                      : Colors.black,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x29000000),
                        offset: Offset(0, 3),
                        blurRadius: 10,
                        spreadRadius: 1),
                  ],
                  border: Border.all(
                      width: Theme.of(context).colorScheme.surface == Color(0xfffef7ff) ? 0 : 1.5,
                      color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff) ? Colors.transparent : Colors.grey
                  )
              ),
              child: ListTile(
                onTap: () async {
                  final url = Uri.parse('mailto:ayoubboursas25@gmail.com');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Center(
                            child: Text(
                              AppLocalizations.of(context)!.err + ' ' + url.toString(),
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
                splashColor: Colors.transparent,
                leading: FaIcon(
                  FontAwesomeIcons.google,
                  color: Color(0xFFD14836),
                ),
                title: Text(
                  AppLocalizations.of(context)!.geml,
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
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: scrwidth,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                      ? Colors.white
                      : Colors.black,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x29000000),
                        offset: Offset(0, 3),
                        blurRadius: 10,
                        spreadRadius: 1),
                  ],
                  border: Border.all(
                      width: Theme.of(context).colorScheme.surface == Color(0xfffef7ff) ? 0 : 1.5,
                      color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff) ? Colors.transparent : Colors.grey
                  )
              ),
              child: ListTile(
                onTap: () async {
                  final url = Uri.parse('https://www.facebook.com/profile.php?id=100008383781748');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Center(
                            child: Text(
                              AppLocalizations.of(context)!.err + ' ' + url.toString(),
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
                splashColor: Colors.transparent,
                leading: FaIcon(
                  FontAwesomeIcons.facebook,
                  color: Color(0xFF1877F2)
                ),
                title: Text(
                  AppLocalizations.of(context)!.fac,
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
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: scrwidth,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                      ? Colors.white
                      : Colors.black,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x29000000),
                        offset: Offset(0, 3),
                        blurRadius: 10,
                        spreadRadius: 1),
                  ],
                  border: Border.all(
                      width: Theme.of(context).colorScheme.surface == Color(0xfffef7ff) ? 0 : 1.5,
                      color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff) ? Colors.transparent : Colors.grey
                  )
              ),
              child: ListTile(
                onTap: () async {
                  final url = Uri.parse('whatsapp://send?phone=+213696135644');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Center(
                            child: Text(
                              AppLocalizations.of(context)!.err + ' ' + url.toString(),
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
                splashColor: Colors.transparent,
                leading: FaIcon(
                    FontAwesomeIcons.whatsapp,
                    color: Color(0xFF25D366)
                ),
                title: Text(
                  AppLocalizations.of(context)!.whs,
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
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: scrwidth,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                      ? Colors.white
                      : Colors.black,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x29000000),
                        offset: Offset(0, 3),
                        blurRadius: 10,
                        spreadRadius: 1),
                  ],
                  border: Border.all(
                      width: Theme.of(context).colorScheme.surface == Color(0xfffef7ff) ? 0 : 1.5,
                      color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff) ? Colors.transparent : Colors.grey
                  )
              ),
              child: ListTile(
                onTap: () async {
                  final url = Uri.parse('https://x.com/BoursasAyo99257');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Center(
                            child: Text(
                              AppLocalizations.of(context)!.err + ' ' + url.toString(),
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
                splashColor: Colors.transparent,
                leading: FaIcon(
                    FontAwesomeIcons.xTwitter,
                    color: Color(0xFF657786)
                ),
                title: Text(
                  AppLocalizations.of(context)!.twt,
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
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: scrwidth,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                      ? Colors.white
                      : Colors.black,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x29000000),
                        offset: Offset(0, 3),
                        blurRadius: 10,
                        spreadRadius: 1),
                  ],
                  border: Border.all(
                      width: Theme.of(context).colorScheme.surface == Color(0xfffef7ff) ? 0 : 1.5,
                      color: Theme.of(context).colorScheme.surface == Color(0xfffef7ff) ? Colors.transparent : Colors.grey
                  )
              ),
              child: ListTile(
                onTap: () async {
                  final url = Uri.parse('https://www.instagram.com/its._.ayo_ub/');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Center(
                            child: Text(
                              AppLocalizations.of(context)!.err + ' ' + url.toString(),
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
                splashColor: Colors.transparent,
                leading: FaIcon(
                    FontAwesomeIcons.instagram,
                    color: Color(0xFF833AB4)
                ),
                title: Text(
                  AppLocalizations.of(context)!.ins,
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
              ),
            )
          ],
        ),
      ),
    );
  }

}




class Promo{
  final int id_prd;
  final int prctg;
  final String desc;
  Promo(this.id_prd, this.prctg, this.desc);
}

class Product{
  final int id;
  final int id_store;
  String name;
  double price;
  final List<String> images;
  /*final*/ int sold;
  final double rate;
  final String category;
  String desc;
  bool fav;
  List<Color> colors;
  List<String> sizes;
  final int total_rvw;
  int prd_qte;
  Product(this.id, this.id_store, this.name, this.price, this.images, this.rate, this.sold, this.category, this.desc, this.fav, this.colors, this.sizes, this.total_rvw, this.prd_qte);
}

class Store{
  final int slr_id;
  final int str_id;
  final String str_name;
  final String str_image;
  final int prd_seles;
  final String str_catg;

  Store(this.slr_id ,this.str_id, this.str_name, this.str_image, this.str_catg, this.prd_seles);
}

class Cart{
  final Product prd;
  int prd_qte;
  final int prd_discount;
  final Color prd_clr;
  final String prd_sz;
  Cart(this.prd, this.prd_qte, this.prd_discount, this.prd_clr, this.prd_sz);
}

class PromoCode{
  final int id;
  final String name;
  final int discount_rate;
  PromoCode(this.id, this.name, this.discount_rate);
}

class Order{
  final int id_clnt;
  final int id;
  final Placemark adress;
  final String mthd_liv;
  String stauts;
  final DateTime date;
  final double ttl_prix;
  Order(this.id_clnt, this.id, this.adress, this.mthd_liv, this.stauts, this.date, this.ttl_prix);
}

class Order_item{
  final Product p;
  final int id_ord;
  final int qte_p;
  final Color clr;
  final String size;
  final int discount;
  Order_item(this.p, this.id_ord, this.qte_p, this.clr, this.size, this.discount);
}

class Review{
  final int id_order_item;
  final int id_client;
  final double rate;
  final String commnt;
  Review(this.id_order_item, this.id_client, this.rate, this.commnt);
}

class User {
  final int id;
  final String firstname;
  final String lastname;
  final DateTime date_brth;
  final String email;
  final int num;
  final String gndr;
  final String user_nm;
  final String user_img;

  User(this.id,this.firstname, this.lastname, this.date_brth, this.email, this.num, this.gndr, this.user_nm, this.user_img);
}