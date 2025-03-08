import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:SnapBuy/Sides/Provider.dart';
import 'package:provider/provider.dart';
import 'package:SnapBuy/Pages/logaregister.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> with TickerProviderStateMixin {
  PageController cntr = PageController();
  bool lastpage = false;
  bool slid = false;
  late AnimationController _scalanimationcnt;

  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _scalanimationcnt = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _scale = Tween(begin: 1.0, end: 1.05).animate(_scalanimationcnt)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _scalanimationcnt.reverse();
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _scalanimationcnt.dispose();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('media/Onlineshopping-pana.png'), context);
    precacheImage(AssetImage('media/Credit Card Payment-pana.png'), context);
    precacheImage(AssetImage('media/Delivery-pana.png'), context);
    double scrwidth = MediaQuery.of(context).size.width;
    double scrheight = MediaQuery.of(context).size.height;
    KeepProvider prvd = Provider.of<KeepProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: <Widget>[
          PageView(
            onPageChanged: (index) {
              setState(() {
                lastpage = (index == 2);
              });
            },
            //reverse: true,
            controller: cntr,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Animate(
                      effects: [FadeEffect(duration: 700.ms)],
                      child: Container(
                        margin: EdgeInsets.only(
                            top: (3.125 * scrheight) / 100,
                            bottom: (6.25 * scrheight) / 100),
                        child: Image(
                          image: AssetImage('media/Onlineshopping-pana.png'),
                        ),
                      ),
                    ),
                    Animate(
                      effects: [FadeEffect(duration: 700.ms, delay: 200.ms)],
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 0, bottom: (2.03125 * scrheight) / 100),
                        child: Text(
                          'Choose Product',
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: 'Kunika',
                              fontWeight: FontWeight.w500,
                              fontSize: (11.11 * scrwidth) / 100),
                        ),
                      ),
                    ),
                    Animate(
                      effects: [FadeEffect(duration: 700.ms, delay: 400.ms)],
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: (3.125 * scrheight) / 100),
                        child: Text(
                          textAlign: TextAlign.center,
                          'A product is the item offered for sale. Product can be a service or an item.It can be physical or in virtual cyber form',
                          style: TextStyle(
                              fontFamily: 'Kunika',
                              fontSize: (5 * scrwidth) / 100,
                              color: Colors.grey),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          top: (3.125 * scrheight) / 100,
                          bottom: (6.25 * scrheight) / 100),
                      child: Image(
                        image: AssetImage('media/Credit Card Payment-pana.png'),
                      ),
                    ).animate().slide(duration: 700.ms, begin: Offset(1, 0)),
                    Animate(
                      effects: [FadeEffect(duration: 700.ms, delay: 200.ms)],
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 0, bottom: (2.03125 * scrheight) / 100),
                        child: Text(
                          'Make Payment',
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: 'Kunika',
                              fontWeight: FontWeight.w500,
                              fontSize: (11.11 * scrwidth) / 100),
                        ),
                      ),
                    ),
                    Animate(
                      effects: [FadeEffect(duration: 700.ms, delay: 400.ms)],
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: (3.125 * scrheight) / 100),
                        child: Text(
                          textAlign: TextAlign.center,
                          'Payment is the transfer of money services is exchange product or payments typically made terms agreed',
                          style: TextStyle(
                              fontFamily: 'Kunika',
                              fontSize: (5 * scrwidth) / 100,
                              color: Colors.grey),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          top: (4.6875 * scrheight) / 100,
                          bottom: (4.6875 * scrheight) / 100),
                      child: Image(
                        image: AssetImage('media/Delivery-pana.png'),
                      ).animate().slide(duration: 700.ms, begin: Offset(1, 0)),
                    ),
                    Animate(
                      effects: [FadeEffect(duration: 700.ms, delay: 200.ms)],
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 0, bottom: (2.03125 * scrheight) / 100),
                        child: Text(
                          'Get Your Order',
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: 'Kunika',
                              fontWeight: FontWeight.w500,
                              fontSize: (11.11 * scrwidth) / 100),
                        ),
                      ),
                    ),
                    Animate(
                      effects: [FadeEffect(duration: 700.ms, delay: 400.ms)],
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: (3.125 * scrheight) / 100),
                        child: Text(
                          textAlign: TextAlign.center,
                          'Business or commerce an order is a stated itention either spoken to engage in a commercial transaction specific products',
                          style: TextStyle(
                              fontFamily: 'Kunika',
                              fontSize: (5 * scrwidth) / 100,
                              color: Colors.grey),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
                bottom: (6.25 * scrheight) / 100,
                left: (5.5555 * scrwidth) / 100),
            alignment: Alignment.bottomLeft,
            child: SmoothPageIndicator(
              controller: cntr,
              count: 3,
              effect: ExpandingDotsEffect(
                  dotHeight: (1.5625 * scrheight) / 100,
                  dotWidth: (3.3333 * scrwidth) / 100,
                  dotColor: Theme.of(context).colorScheme.surface ==
                          Color(0xfffef7ff)
                      ? Colors.grey
                      : Colors.white,
                  activeDotColor: prvd.first),
            ),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: AnimatedBuilder(
                animation: _scalanimationcnt,
                builder: (context, child) => Transform.scale(
                  scale: _scale.value,
                  child: Container(
                      margin: EdgeInsets.only(
                          bottom: (3.125 * scrheight) / 100,
                          right: (5.5555 * scrwidth) / 100),
                      width: (13.8888 * scrwidth) / 100,
                      height: (7.8125 * scrheight) / 100,
                      decoration: BoxDecoration(
                          color: prvd.first,
                          shape: BoxShape.circle),
                      child: IconButton(
                        style: ButtonStyle(
                            overlayColor: WidgetStateProperty.all<Color>(
                                Colors.transparent)),
                        onPressed: () {
                          _scalanimationcnt.forward();
                          if (lastpage) {
                            setState(() {
                              slid = !slid;
                            });
                            Future.delayed(Duration(milliseconds: 1550), () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EnterPage()));
                              setState(() {
                                slid = !slid;
                              });
                            });
                          } else {
                            cntr.nextPage(
                              duration: Duration(milliseconds: 600),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        icon: lastpage == true
                            ? Animate(
                                effects: [
                                    RotateEffect(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                    ),
                                    FadeEffect(
                                        duration: Duration(milliseconds: 500)),
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
                                                size:
                                                    (4.6875 * scrheight) / 100)
                                        : Icon(
                                            EvaIcons.checkmark,
                                            color: Theme.of(context)
                                                        .colorScheme
                                                        .surface ==
                                                    Color(0xfffef7ff)
                                                ? Colors.white
                                                : Colors.black,
                                            size: (8.3333 * scrwidth) / 100,
                                          )))
                            : Icon(
                                EvaIcons.arrowIosForward,
                                color:
                                    Theme.of(context).colorScheme.surface ==
                                            Color(0xfffef7ff)
                                        ? Colors.white
                                        : Colors.black,
                                size: (8.3333 * scrwidth) / 100,
                              ),
                      )),
                ),
              ))
        ],
      ),
    );
  }
}
