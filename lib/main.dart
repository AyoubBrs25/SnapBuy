import 'package:SnapBuy/Pages/Home.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:SnapBuy/Sides/Provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geocoding/geocoding.dart';



void main() {
  /*runApp(Phoenix(
    child: ChangeNotifierProvider(
        create: (context) => KeepProvider(),
        child: const SnapBuy(),
    ),
  ));*/
  runApp(ChangeNotifierProvider(
      create: (context) => KeepProvider(),
      child: const SnapBuy(),
    ));
}

class SnapBuy extends StatefulWidget {
  const SnapBuy({super.key});

  @override
  State<SnapBuy> createState() => _SnapBuyState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _SnapBuyState? state = context.findAncestorStateOfType<_SnapBuyState>();
    state?.setLocale(newLocale);
  }
}

class _SnapBuyState extends State<SnapBuy> {
  Locale? _locale;



  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  late KeepProvider prvd;

  @override
  initState()  {
    super.initState();
    prvd = Provider.of<KeepProvider>(context, listen: false);
  }

  @override
  void didChangeDependencies() {
    final prvd = Provider.of<KeepProvider>(context);
    setLocale(prvd.appLocale);
    prvd.loadFvrt();
    super.didChangeDependencies();
  }

  @override
  Future<void> setState(VoidCallback a) async {
    super.setState(a);
    Future<Position> userLocation() async {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        //await Geolocator.getPositionStream();
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are permanently denied, shutting down the application.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied, shutting down the application.');
      }

      return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    }

    Future<List<Placemark>> GetUserAddress(Position position)async {
      List<Placemark> userAdress = await placemarkFromCoordinates(position.latitude, position.longitude);
      return userAdress;
    }

    Position userPosition = await userLocation();
    prvd.userAdress = await GetUserAddress(userPosition);
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        platform: TargetPlatform.iOS,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
          platform: TargetPlatform.iOS,
          brightness: Brightness.dark,
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) =>  /*AllSPages(),*/AllPages(),//Start(),
      },
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: _locale,
    );
  }
}
