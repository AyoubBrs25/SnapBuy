import 'dart:async';
import 'dart:io';
import 'package:SnapBuy/Pages/Home.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../Sides/Provider.dart';

class ChoosePge extends StatefulWidget {
  const ChoosePge({super.key});

  @override
  State<ChoosePge> createState() => _ChoosePgeState();
}

class _ChoosePgeState extends State<ChoosePge> with TickerProviderStateMixin {
  bool isFile = false;
  File? prfimg;
  bool clicked = false;
  bool clicked1 = false;

  PhoneNumber _initnum = PhoneNumber(isoCode: 'DZ');

  String? gender;

  late AnimationController _scalanimationcnt0;
  late AnimationController _scalanimationcnt;
  late AnimationController _scalanimationcnt1;

  late Animation<double> _scale0;
  late Animation<double> _scale;
  late Animation<double> _scale1;

  bool slid = false;

  @override
  void initState() {
    super.initState();
    _scalanimationcnt =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _scalanimationcnt1 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _scalanimationcnt0 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _scale0 = Tween(begin: 1.0, end: 1.05).animate(_scalanimationcnt0)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _scalanimationcnt0.reverse();
        }
      });
    _scale = Tween(begin: 1.0, end: 1.05).animate(_scalanimationcnt)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _scalanimationcnt.reverse();
        }
      });
    _scale1 = Tween(begin: 1.0, end: 1.05).animate(_scalanimationcnt1)
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
    _scalanimationcnt1.dispose();
    _scalanimationcnt0.dispose();
  }

  DateTime _birthdate = DateTime.now();

  FocusNode fcsnm = FocusNode();
  TextEditingController lastcnt = TextEditingController();
  TextEditingController firstcnt = TextEditingController();
  TextEditingController phnnmcnt = TextEditingController();

  bool sallermd = false;

  @override
  Widget build(BuildContext context) {
    KeepProvider prvd = Provider.of<KeepProvider>(context, listen: false);
    double scrwidth = MediaQuery.of(context).size.width;
    double scrheight = MediaQuery.of(context).size.height;
    return Container(
      width: scrwidth,
      height: scrheight,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          image: DecorationImage(
              image: AssetImage('media/Wave-12.5s-1536px.png'),
              fit: BoxFit.contain,
              alignment: Alignment.topCenter)),
      child:Scaffold(
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
              EvaIcons.arrowIosBack,
              size: (7.5 * scrwidth) / 100,
              color:
                  Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                      ? Colors.black87
                      : Color(0xfffef7ff),
            ),
          ),
          title: Text(
            'Create Profile',
            style: TextStyle(
              fontFamily: 'Kunika',
              fontWeight: FontWeight.bold,
              fontSize: (6.3888 * scrwidth) / 100,
              color:
                  Theme.of(context).colorScheme.surface == Color(0xfffef7ff)
                      ? Colors.black87
                      : Color(0xfffef7ff),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Container(
              height: (87.5 * scrheight) / 100,
              width: scrwidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Animate(
                    effects: [
                      ScaleEffect(duration: 700.ms),
                      FadeEffect(duration: 700.ms)
                    ],
                    child: Container(
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
                  ),
                  Animate(
                    effects: [
                      SlideEffect(
                          delay: 200.ms,
                          duration: 900.ms,
                          begin: Offset(0, 1),
                          end: Offset(0, 0)),
                      FadeEffect(duration: 700.ms)
                    ],
                    child: Container(
                      padding:
                          EdgeInsets.only(top: (0.78125 * scrheight) / 100),
                      width: scrwidth,
                      height: (62.5 * scrheight) / 100,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface ==
                                  Color(0xfffef7ff)
                              ? Colors.white
                              : Colors.black87,
                          boxShadow: [
                            BoxShadow(
                                color: Color(0x29000000),
                                offset: Offset(0, 3),
                                blurRadius: 10,
                                spreadRadius: 1),
                          ],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35))),
                      child: SingleChildScrollView(
                          child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            (5.5555 * scrwidth) / 100,
                            (3.125 * scrheight) / 100,
                            (5.5555 * scrwidth) / 100,
                            (3.125 * scrheight) / 100),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Animate(
                                effects: [
                                  FadeEffect(delay: 900.ms, duration: 700.ms),
                                  SlideEffect(delay: 900.ms, duration: 700.ms)
                                ],
                                child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: (3.4375 * scrheight) / 100),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: (2.7777 * scrwidth) / 100),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context)
                                                .colorScheme
                                                .surface ==
                                            Color(0xff1c1b1f)
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
                                                'FirstName',
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
                              ),
                              Animate(
                                effects: [
                                  FadeEffect(delay: 900.ms, duration: 700.ms),
                                  SlideEffect(delay: 900.ms, duration: 700.ms)
                                ],
                                child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: (3.4375 * scrheight) / 100),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: (2.7777 * scrwidth) / 100),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context)
                                                .colorScheme
                                                .surface ==
                                            Color(0xff1c1b1f)
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
                                                'LastName',
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
                              ),
                              Animate(
                                effects: [
                                  FadeEffect(delay: 900.ms, duration: 700.ms),
                                  SlideEffect(delay: 900.ms, duration: 700.ms)
                                ],
                                child: Container(
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
                                            Color(0xff1c1b1f)
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
                              ),
                              Animate(
                                effects: [
                                  FadeEffect(delay: 900.ms, duration: 700.ms),
                                  SlideEffect(delay: 900.ms, duration: 700.ms)
                                ],
                                child: Container(
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
                                            Color(0xff1c1b1f)
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
                                          'PhoneNumber',
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
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: (1.5625 * scrheight) / 100),
                                width: (55.5555 * scrwidth) / 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Animate(
                                      effects: [
                                        FadeEffect(
                                            delay: 1000.ms, duration: 700.ms),
                                        SlideEffect(
                                            delay: 1000.ms,
                                            duration: 700.ms,
                                            begin: Offset(-1, 0),
                                            end: Offset(0, 0))
                                      ],
                                      child: Column(
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
                                                              Color(0xff1c1b1f)
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
                                            'Male',
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
                                                            Color(0xff1c1b1f)
                                                        ? Color(0xfffef7ff)
                                                        : Colors.black87),
                                                letterSpacing: 2),
                                          )
                                        ],
                                      ),
                                    ),
                                    Animate(
                                      effects: [
                                        FadeEffect(
                                            delay: 1000.ms, duration: 700.ms),
                                        SlideEffect(
                                            delay: 1000.ms,
                                            duration: 700.ms,
                                            begin: Offset(1, 0),
                                            end: Offset(0, 0))
                                      ],
                                      child: Column(
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
                                                              Color(0xff1c1b1f)
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
                                            'Female',
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
                                                            Color(0xff1c1b1f)
                                                        ? Color(0xfffef7ff)
                                                        : Colors.black87),
                                                letterSpacing: 2),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Seller Mode',
                                    style: TextStyle(
                                        fontFamily: 'Kunika',
                                        fontSize: (6.9444 * scrwidth) / 100,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context)
                                                    .colorScheme
                                                    .surface ==
                                                Color(0xff1c1b1f)
                                            ? Color(0xfffef7ff)
                                            : Colors.black87,
                                        letterSpacing: 2),
                                  ),
                                  Switch.adaptive(
                                    thumbColor: WidgetStatePropertyAll<Color>(
                                        Colors.white),
                                    inactiveThumbColor: prvd.first,
                                    inactiveTrackColor: Theme.of(context)
                                                .colorScheme
                                                .surface ==
                                            Color(0xff1c1b1f)
                                        ? Color(0xd8ffffff)
                                        : Color(0x1A000000),
                                    activeTrackColor: prvd.first,
                                    value: sallermd,
                                    onChanged: (v) {
                                      setState(() {
                                        sallermd = v;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Animate(
                                  effects: [
                                    SlideEffect(
                                        delay: 600.ms, duration: 700.ms),
                                    FadeEffect(delay: 600.ms, duration: 700.ms)
                                  ],
                                  child: AnimatedBuilder(
                                    animation: _scalanimationcnt0,
                                    builder: (context, child) =>
                                        Transform.scale(
                                      scale: _scale0.value,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: (2.34375 * scrheight) / 100),
                                        width: (41.6666 * scrwidth) / 100,
                                        height: (7.8125 * scrheight) / 100,
                                        decoration: BoxDecoration(
                                          color: !lastcnt.text.isEmpty &&
                                                  !firstcnt.text.isEmpty &&
                                                  !phnnmcnt.text.isEmpty &&
                                                  (DateTime.now().year -
                                                          _birthdate.year) >=
                                                      18 &&
                                                  gender != null
                                              ? prvd.first
                                              : prvd.first.withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(50),
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
                                              overlayColor:
                                                  WidgetStatePropertyAll<
                                                          Color>(
                                                      Colors.transparent)),
                                          onPressed: () {
                                            _scalanimationcnt0.forward();
                                            if (!lastcnt.text.isEmpty &&
                                                !firstcnt.text.isEmpty &&
                                                !phnnmcnt.text.isEmpty &&
                                                (DateTime.now().year -
                                                        _birthdate.year) >=
                                                    18 &&
                                                gender != null &&
                                                sallermd) {
                                              setState(() {
                                                slid = !slid;
                                              });
                                              Future.delayed(
                                                  Duration(milliseconds: 1550),
                                                  () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            StorePage()));
                                                setState(() {
                                                  slid = !slid;
                                                });
                                              });
                                            }
                                            if (!lastcnt.text.isEmpty &&
                                                !firstcnt.text.isEmpty &&
                                                !phnnmcnt.text.isEmpty &&
                                                (DateTime.now().year -
                                                    _birthdate.year) >=
                                                    18 &&
                                                gender != null &&
                                                !sallermd) {
                                              setState(() {
                                                slid = !slid;
                                              });
                                              Future.delayed(
                                                  Duration(milliseconds: 1550),
                                                      () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                AllPages()));
                                                    setState(() {
                                                      slid = !slid;
                                                    });
                                                  });
                                            }
                                          },
                                          child: Animate(
                                              effects: [
                                                FadeEffect(
                                                    delay: 700.ms,
                                                    duration: 700.ms),
                                                SlideEffect(
                                                    delay: 700.ms,
                                                    duration: 700.ms,
                                                    begin: Offset(0, 1))
                                              ],
                                              child: AnimatedSwitcher(
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
                                                    ? LoadingAnimationWidget.fourRotatingDots(
                                                        color: Theme.of(context)
                                                                    .colorScheme
                                                                    .surface ==
                                                                Color(
                                                                    0xfffffbfe)
                                                            ? Colors.white
                                                            : Colors.black87,
                                                        size: (8.3333 *
                                                                scrwidth) /
                                                            100)
                                                    : Text(
                                                        sallermd
                                                            ? 'Next'
                                                            : 'Create',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: 'Kunika',
                                                          fontSize: (5.8333 *
                                                                  scrwidth) /
                                                              100,
                                                          color: Theme.of(context)
                                                                      .colorScheme
                                                                      .surface ==
                                                                  Color(
                                                                      0xfffffbfe)
                                                              ? Colors.white
                                                              : Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .surface,
                                                        ),
                                                      ),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ))
                            ]),
                      )),
                    ),
                  )
                ],
              )),
        ),
    ),
    );
  }

  ImageProvider<Object> buildFileImage() {
    if (prfimg == null) {
      return AssetImage('media/default.jpg');
    } else {
      return FileImage(prfimg as File);
    }
  }
}

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> with TickerProviderStateMixin {
  File? prfimg;
  bool isFile = false;
  bool slctd = false;
  String? catgr;
  TextEditingController strname = TextEditingController();
  double min = 0;
  DraggableScrollableController ctgcntr = DraggableScrollableController();

  bool slid = false;

  late AnimationController _scalanimationcnt0;

  late Animation<double> _scale0;

  @override
  void initState() {
    super.initState();
    _scalanimationcnt0 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _scale0 = Tween(begin: 1.0, end: 1.05).animate(_scalanimationcnt0)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _scalanimationcnt0.reverse();
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _scalanimationcnt0.dispose();
  }

  @override
  Widget build(BuildContext context) {
    KeepProvider prvd = Provider.of<KeepProvider>(context, listen: false);
    double scrwidth = MediaQuery.of(context).size.width;
    double scrheight = MediaQuery.of(context).size.height;
    return Container(
      height: scrheight,
      width: scrwidth,
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
                EvaIcons.arrowIosBack,
                size: (7.5 * scrwidth) / 100,
                color: Theme.of(context).colorScheme.surface ==
                        Color(0xfffef7ff)
                    ? Colors.black87
                    : Color(0xfffef7ff),
              ),
            ),
            title: Text(
              'Create Store',
              style: TextStyle(
                fontFamily: 'Kunika',
                fontWeight: FontWeight.bold,
                fontSize: (6.3889 * scrwidth) / 100,
                color: Theme.of(context).colorScheme.surface ==
                        Color(0xfffef7ff)
                    ? Colors.black87
                    : Color(0xfffef7ff),
              ),
            ),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: Container(
                  width: scrwidth,
                  padding: EdgeInsets.fromLTRB((5.5555 * scrwidth) / 100, 0,
                      (5.5555 * scrwidth) / 100, (3.125 * scrheight) / 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Animate(
                        effects: [
                          ScaleEffect(duration: 700.ms),
                          FadeEffect(duration: 700.ms)
                        ],
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: (3.4375 * scrheight) / 100),
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
                                        BorderRadius.all(Radius.circular(50)),
                                  ),
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                        padding: EdgeInsets.only(
                                            top: (1.5625 * scrheight) / 100),
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
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                TextButton(
                                                  style: ButtonStyle(
                                                      overlayColor:
                                                          WidgetStatePropertyAll<
                                                                  Color>(
                                                              Colors
                                                                  .transparent)),
                                                  onPressed: () async {
                                                    Navigator.pop(context);
                                                    final picker =
                                                        ImagePicker();
                                                    final pickedimg =
                                                        await picker.pickImage(
                                                            source: ImageSource
                                                                .gallery);

                                                    if (pickedimg == null)
                                                      return;

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
                                                        (16.6666 * scrwidth) /
                                                            100,
                                                    height:
                                                        (9.375 * scrheight) /
                                                            100,
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
                                                            color: Color(
                                                                0x29000000),
                                                            offset:
                                                                Offset(0, 3),
                                                            blurRadius: 10,
                                                            spreadRadius: 1),
                                                      ],
                                                    ),
                                                    child: Center(
                                                      child: SizedBox(
                                                        height: (4.6875 *
                                                                scrheight) /
                                                            100,
                                                        width: (8.3333 *
                                                                scrwidth) /
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
                                                              Colors
                                                                  .transparent)),
                                                  onPressed: () async {
                                                    final picker =
                                                        ImagePicker();
                                                    final pickedimg =
                                                        await picker.pickImage(
                                                            source: ImageSource
                                                                .camera);

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
                                                        (16.6666 * scrwidth) /
                                                            100,
                                                    height:
                                                        (9.375 * scrheight) /
                                                            100,
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
                                                            color: Color(
                                                                0x29000000),
                                                            offset:
                                                                Offset(0, 3),
                                                            blurRadius: 10,
                                                            spreadRadius: 1),
                                                      ],
                                                    ),
                                                    child: Center(
                                                      child: SizedBox(
                                                        height: (4.6875 *
                                                                scrheight) /
                                                            100,
                                                        width: (8.3333 *
                                                                scrwidth) /
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
                                                              Colors
                                                                  .transparent)),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    setState(() {
                                                      prfimg = null;
                                                    });
                                                  },
                                                  child: Container(
                                                    //margin: EdgeInsets.only(right: (5.5555*scrwidth)/100),
                                                    width:
                                                        (16.6666 * scrwidth) /
                                                            100,
                                                    height:
                                                        (9.375 * scrheight) /
                                                            100,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle ,
                                                      color: Theme.of(context)
                                                                  .colorScheme
                                                                  .surface ==
                                                              Color(0xfffef7ff)
                                                          ? Color(0xfffef7ff)
                                                          : Colors.black87,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Color(
                                                                0x29000000),
                                                            offset:
                                                                Offset(0, 3),
                                                            blurRadius: 10,
                                                            spreadRadius: 1),
                                                      ],
                                                    ),
                                                    child: Center(
                                                      child: SizedBox(
                                                        height: (4.6875 *
                                                                scrheight) /
                                                            100,
                                                        width: (8.3333 *
                                                                scrwidth) /
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
                              padding: EdgeInsets.only(bottom: 5),
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
                                    fit: BoxFit.cover,
                                  )),
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
                                      size: (5.5556 * scrwidth) / 100,
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
                      ),
                      Animate(
                        effects: [
                          FadeEffect(delay: 200.ms, duration: 700.ms),
                          SlideEffect(delay: 200.ms, duration: 700.ms)
                        ],
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: (3.4375 * scrheight) / 100),
                          padding: EdgeInsets.symmetric(
                              horizontal: (2.7777 * scrwidth) / 100),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.surface ==
                                    Color(0xff1c1b1f)
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
                                child: Icon(
                                  EvaIcons.shoppingBag,
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
                                  controller: strname,
                                  style: TextStyle(
                                      fontSize: (5 * scrwidth) / 100,
                                      fontFamily: 'Kunika',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: (1.25 * scrheight) / 100),
                                    label: Padding(
                                      padding: EdgeInsets.only(
                                          left: (1.38888 * scrwidth) / 100),
                                      child: Text(
                                        'StoreName',
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
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: (3.4375 * scrheight) / 100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Animate(
                              effects: [
                                FadeEffect(delay: 200.ms, duration: 700.ms),
                                SlideEffect(
                                    delay: 200.ms,
                                    duration: 700.ms,
                                    begin: Offset(-1, 0),
                                    end: Offset(0, 0))
                              ],
                              child: Text(
                                'Category',
                                style: TextStyle(
                                  fontFamily: 'Kunika',
                                  fontWeight: FontWeight.bold,
                                  fontSize: (6.3867 * scrwidth) / 100,
                                  color: Theme.of(context)
                                              .colorScheme
                                              .surface ==
                                          Color(0xfffef7ff)
                                      ? Colors.black87
                                      : Color(0xfffef7ff),
                                ),
                              ),
                            ),
                            Animate(
                              effects: [
                                FadeEffect(delay: 200.ms, duration: 700.ms),
                                SlideEffect(
                                    delay: 200.ms,
                                    duration: 700.ms,
                                    begin: Offset(1, 0),
                                    end: Offset(0, 0))
                              ],
                              child: IconButton(
                                style: ButtonStyle(
                                    overlayColor:
                                        WidgetStatePropertyAll<Color>(
                                            Colors.transparent)),
                                onPressed: () {
                                  if (min == 0) {
                                    setState(() {
                                      min = 0.3;
                                    });
                                  } else {
                                    ctgcntr.reset();
                                  }
                                },
                                icon: Icon(
                                  EvaIcons.plusCircle,
                                  size: (7.7778 * scrwidth) / 100,
                                  color: prvd.first,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      slctd
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: (2.7777 * scrwidth) / 100),
                              width: scrwidth,
                              height: (7.8125 * scrheight) / 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    Theme.of(context).colorScheme.surface ==
                                            Color(0xff1c1b1f)
                                        ? Color(0xd8ffffff)
                                        : Color(0x1A000000),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(
                                        (1.25 * scrheight) / 100),
                                    height: (6.25 * scrheight) / 100,
                                    width: (11.1111 * scrwidth) / 100,
                                    decoration: BoxDecoration(
                                        color: prvd.first.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Image.asset('media/$catgr.png'),
                                    ),
                                  ),
                                  Text(
                                    '$catgr',
                                    style: TextStyle(
                                      fontFamily: 'Kunika',
                                      fontWeight: FontWeight.w500,
                                      fontSize: (7.5 * scrwidth) / 100,
                                      letterSpacing: 1.5,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  IconButton(
                                    style: ButtonStyle(
                                        overlayColor:
                                            WidgetStatePropertyAll<Color>(
                                                Colors.transparent)),
                                    onPressed: () {
                                      setState(() {
                                        slctd = false;
                                        catgr = null;
                                      });
                                    },
                                    icon: FaIcon(
                                      FontAwesomeIcons.trash,
                                      size: (5.5556 * scrwidth) / 100,
                                      color: Color(0xFFF67952),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Animate(
                              effects: [
                                FadeEffect(delay: 200.ms, duration: 700.ms),
                                SlideEffect(delay: 200.ms, duration: 700.ms)
                              ],
                              child: Text(
                                'No Category',
                                style: TextStyle(
                                  fontFamily: 'Kunika',
                                  fontWeight: FontWeight.w500,
                                  fontSize: (7.5 * scrwidth) / 100,
                                  letterSpacing: 1.5,
                                  color: Theme.of(context)
                                              .colorScheme
                                              .surface ==
                                          Color(0xfffef7ff)
                                      ? Colors.black87
                                      : Color(0xfffef7ff),
                                ),
                              ),
                            ),
                      Animate(
                          effects: [
                            SlideEffect(delay: 200.ms, duration: 700.ms),
                            FadeEffect(delay: 200.ms, duration: 700.ms)
                          ],
                          child: AnimatedBuilder(
                            animation: _scalanimationcnt0,
                            builder: (context, child) => Transform.scale(
                              scale: _scale0.value,
                              child: Container(
                                margin: EdgeInsets.only(top: (6.25 * scrheight) / 100),
                                width: (41.6666 * scrwidth) / 100,
                                height: (7.8125 * scrheight) / 100,
                                decoration: BoxDecoration(
                                  color:
                                      strname.text.isNotEmpty && catgr != null
                                          ? prvd.first
                                          : prvd.first.withOpacity(0.7),
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
                                      overlayColor:
                                          WidgetStatePropertyAll<Color>(
                                              Colors.transparent)),
                                  onPressed: () {
                                    _scalanimationcnt0.forward();
                                    if (strname.text.isNotEmpty &&
                                        catgr != null) {
                                      setState(() {
                                        slid = !slid;
                                      });
                                      Future.delayed(
                                          Duration(milliseconds: 1550), () {

                                        setState(() {
                                          slid = !slid;
                                        });
                                      });
                                    }
                                  },
                                  child: Animate(
                                      effects: [
                                        FadeEffect(
                                            delay: 700.ms, duration: 700.ms),
                                        SlideEffect(
                                            delay: 700.ms,
                                            duration: 700.ms,
                                            begin: Offset(0, 1))
                                      ],
                                      child: AnimatedSwitcher(
                                        duration: Duration(milliseconds: 300),
                                        transitionBuilder: (child, animation) {
                                          return ScaleTransition(
                                            scale: animation
                                                .drive(Tween(begin: 0, end: 1)),
                                            child: child,
                                          );
                                        },
                                        child: slid
                                            ? LoadingAnimationWidget
                                                .fourRotatingDots(
                                                    color: Theme.of(context)
                                                                .colorScheme
                                                                .surface ==
                                                            Color(0xfffef7ff)
                                                        ? Colors.white
                                                        : Colors.black87,
                                                    size: (8.33333 * scrwidth) /
                                                        100)
                                            : Text(
                                                'Create',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Kunika',
                                                  fontSize:
                                                      (5.83333 * scrwidth) /
                                                          100,
                                                  color: Theme.of(context)
                                                              .colorScheme
                                                              .surface ==
                                                          Color(0xfffef7ff)
                                                      ? Colors.white
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .surface,
                                                ),
                                              ),
                                      )),
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              DraggableScrollableSheet(
                controller: ctgcntr,
                initialChildSize: min,
                maxChildSize: 0.8,
                minChildSize: 0,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                    padding: EdgeInsets.only(
                        top: (1.5625 * scrheight) / 100, left: (2.7777 * scrwidth) / 100),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface ==
                                Color(0xfffef7ff)
                            ? Color(0xd8ffffff)
                            : Colors.black87,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30))),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RadioListTile(
                            activeColor: prvd.first,
                            value: 'clothes',
                            groupValue: catgr,
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  catgr = value.toString();
                                  slctd = true;
                                });
                              }
                            },
                            toggleable: true,
                            secondary: Image(
                              height: (4.6875 * scrheight) / 100,
                              width: (8.3333 * scrwidth) / 100,
                              image: AssetImage(
                                  Theme.of(context).colorScheme.surface ==
                                          Color(0xfffef7ff)
                                      ? 'media/clothesDark.png'
                                      : 'media/clothesLight.png'),
                            ),
                            title: Text(
                              'Clothes',
                              style: TextStyle(
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.bold,
                                fontSize: (6.3889 * scrwidth) / 100,
                                color:
                                    Theme.of(context).colorScheme.surface ==
                                            Color(0xfffef7ff)
                                        ? Colors.black87
                                        : Color(0xfffef7ff),
                              ),
                            ),
                            controlAffinity: ListTileControlAffinity.trailing,
                          ),
                          RadioListTile(
                            overlayColor: WidgetStatePropertyAll<Color>(
                                Colors.transparent),
                            activeColor: prvd.first,
                            value: 'shoes',
                            groupValue: catgr,
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  catgr = value.toString();
                                  slctd = true;
                                });
                              }
                            },
                            toggleable: true,
                            secondary: Image(
                              height: (4.6875 * scrheight) / 100,
                              width: (8.3333 * scrwidth) / 100,
                              image: AssetImage(
                                  Theme.of(context).colorScheme.surface ==
                                          Color(0xfffef7ff)
                                      ? 'media/shoesDark.png'
                                      : 'media/shoesLight.png'),
                            ),
                            title: Text(
                              'Shoes',
                              style: TextStyle(
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.bold,
                                fontSize: (6.3889 * scrwidth) / 100,
                                color:
                                    Theme.of(context).colorScheme.surface ==
                                            Color(0xfffef7ff)
                                        ? Colors.black87
                                        : Color(0xfffef7ff),
                              ),
                            ),
                            controlAffinity: ListTileControlAffinity.trailing,
                          ),
                          RadioListTile(
                            overlayColor: WidgetStatePropertyAll<Color>(
                                Colors.transparent),
                            activeColor: prvd.first,
                            tileColor: Colors.transparent,
                            value: 'bags',
                            groupValue: catgr,
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  catgr = value.toString();
                                  slctd = true;
                                });
                              }
                            },
                            toggleable: true,
                            secondary: Image(
                              height: (4.6875 * scrheight) / 100,
                              width: (8.3333 * scrwidth) / 100,
                              image: AssetImage(
                                  Theme.of(context).colorScheme.surface ==
                                          Color(0xfffef7ff)
                                      ? 'media/bagsDark.png'
                                      : 'media/bagsLight.png'),
                            ),
                            title: Text(
                              'Bags',
                              style: TextStyle(
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.bold,
                                fontSize: (6.3889 * scrwidth) / 100,
                                color:
                                    Theme.of(context).colorScheme.surface ==
                                            Color(0xfffef7ff)
                                        ? Colors.black87
                                        : Color(0xfffef7ff),
                              ),
                            ),
                            controlAffinity: ListTileControlAffinity.trailing,
                          ),
                          RadioListTile(
                            overlayColor: WidgetStatePropertyAll<Color>(
                                Colors.transparent),
                            activeColor: prvd.first,
                            tileColor: Colors.transparent,
                            value: 'electronics',
                            groupValue: catgr,
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  catgr = value.toString();
                                  slctd = true;
                                });
                              }
                            },
                            toggleable: true,
                            secondary: Image(
                              height: (4.6875 * scrheight) / 100,
                              width: (8.3333 * scrwidth) / 100,
                              image: AssetImage(
                                  Theme.of(context).colorScheme.surface ==
                                          Color(0xfffef7ff)
                                      ? 'media/electronicsDark.png'
                                      : 'media/electronicsLight.png'),
                            ),
                            title: Text(
                              'Electronics',
                              style: TextStyle(
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.bold,
                                fontSize: (6.3889 * scrwidth) / 100,
                                color:
                                    Theme.of(context).colorScheme.surface ==
                                            Color(0xfffef7ff)
                                        ? Colors.black87
                                        : Color(0xfffef7ff),
                              ),
                            ),
                            controlAffinity: ListTileControlAffinity.trailing,
                          ),
                          RadioListTile(
                            overlayColor: WidgetStatePropertyAll<Color>(
                                Colors.transparent),
                            activeColor: prvd.first,
                            tileColor: Colors.transparent,
                            value: 'watchs',
                            groupValue: catgr,
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  catgr = value.toString();
                                  slctd = true;
                                });
                              }
                            },
                            toggleable: true,
                            secondary: Image(
                              height: (4.6875 * scrheight) / 100,
                              width: (8.3333 * scrwidth) / 100,
                              image: AssetImage(
                                  Theme.of(context).colorScheme.surface ==
                                          Color(0xfffef7ff)
                                      ? 'media/watchsDark.png'
                                      : 'media/watchsLight.png'),
                            ),
                            title: Text(
                              'watchs',
                              style: TextStyle(
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.bold,
                                fontSize: (6.3889 * scrwidth) / 100,
                                color:
                                    Theme.of(context).colorScheme.surface ==
                                            Color(0xfffef7ff)
                                        ? Colors.black87
                                        : Color(0xfffef7ff),
                              ),
                            ),
                            controlAffinity: ListTileControlAffinity.trailing,
                          ),
                          RadioListTile(
                            overlayColor: WidgetStatePropertyAll<Color>(
                                Colors.transparent),
                            activeColor: prvd.first,
                            tileColor: Colors.transparent,
                            value: 'jewelry',
                            groupValue: catgr,
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  catgr = value.toString();
                                  slctd = true;
                                });
                              }
                            },
                            toggleable: true,
                            secondary: Image(
                              height: (4.6875 * scrheight) / 100,
                              width: (8.3333 * scrwidth) / 100,
                              image: AssetImage(
                                  Theme.of(context).colorScheme.surface ==
                                          Color(0xfffef7ff)
                                      ? 'media/jewelryDark.png'
                                      : 'media/jewelryLight.png'),
                            ),
                            title: Text(
                              'Jewelry',
                              style: TextStyle(
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.bold,
                                fontSize: (6.3889 * scrwidth) / 100,
                                color:
                                    Theme.of(context).colorScheme.surface ==
                                            Color(0xfffef7ff)
                                        ? Colors.black87
                                        : Color(0xfffef7ff),
                              ),
                            ),
                            controlAffinity: ListTileControlAffinity.trailing,
                          ),
                          RadioListTile(
                            overlayColor: WidgetStatePropertyAll<Color>(
                                Colors.transparent),
                            activeColor: prvd.first,
                            tileColor: Colors.transparent,
                            value: 'kitchen',
                            groupValue: catgr,
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  catgr = value.toString();
                                  slctd = true;
                                });
                              }
                            },
                            toggleable: true,
                            secondary: Image(
                              height: (4.6875 * scrheight) / 100,
                              width: (8.3333 * scrwidth) / 100,
                              image: AssetImage(
                                  Theme.of(context).colorScheme.surface ==
                                          Color(0xfffef7ff)
                                      ? 'media/kitchenDark.png'
                                      : 'media/kitchenLight.png'),
                            ),
                            title: Text(
                              'Kitchen',
                              style: TextStyle(
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.bold,
                                fontSize: (6.3889 * scrwidth) / 100,
                                color:
                                    Theme.of(context).colorScheme.surface ==
                                            Color(0xfffef7ff)
                                        ? Colors.black87
                                        : Color(0xfffef7ff),
                              ),
                            ),
                            controlAffinity: ListTileControlAffinity.trailing,
                          ),
                          RadioListTile(
                            overlayColor: WidgetStatePropertyAll<Color>(
                                Colors.transparent),
                            activeColor: prvd.first,
                            tileColor: Colors.transparent,
                            value: 'toys',
                            groupValue: catgr,
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  catgr = value.toString();
                                  slctd = true;
                                });
                              }
                            },
                            toggleable: true,
                            secondary: Image(
                              height: (4.6875 * scrheight) / 100,
                              width: (8.3333 * scrwidth) / 100,
                              image: AssetImage(
                                  Theme.of(context).colorScheme.surface ==
                                          Color(0xfffef7ff)
                                      ? 'media/toysDark.png'
                                      : 'media/toysLight.png'),
                            ),
                            title: Text(
                              'Toys',
                              style: TextStyle(
                                fontFamily: 'Kunika',
                                fontWeight: FontWeight.bold,
                                fontSize: (6.3889 * scrwidth) / 100,
                                color:
                                    Theme.of(context).colorScheme.surface ==
                                            Color(0xfffef7ff)
                                        ? Colors.black87
                                        : Color(0xfffef7ff),
                              ),
                            ),
                            controlAffinity: ListTileControlAffinity.trailing,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          )),
    );
  }

  ImageProvider<Object> buildFileImage() {
    if (prfimg == null) {
      return AssetImage('media/default-store-350x350.jpg');
    } else {
      return FileImage(prfimg as File);
    }
  }
}
