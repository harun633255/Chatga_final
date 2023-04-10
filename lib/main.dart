import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:siddikbhai_c/Chatga_to_English/fourth_option.dart';
import 'package:siddikbhai_c/Constants.dart';
import 'package:siddikbhai_c/Gallery/gallery_option.dart';
import 'package:siddikbhai_c/Home/home_screen.dart';
import 'package:siddikbhai_c/Sobdosomuh/option_one.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:siddikbhai_c/KothonpokThon/fifth_option.dart';
import 'package:siddikbhai_c/Sobdosomuh/sobdo_option.dart';
import 'package:siddikbhai_c/SplashScreen.dart';
import 'package:siddikbhai_c/Upazila/sixth_option.dart';
import 'package:siddikbhai_c/probad/sobdo_option.dart';
import 'package:siddikbhai_c/test.dart';

import 'Ithis/itihas_option.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.', // description
  importance:Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

// FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
 // print('Handling a background message ${message.messageId}');
 // AwesomeNotifications().createNotificationFromJsonData(message.data);

  String body = message.data['body'];
  List<String> parts = body!.split("?v=");
  String? ids = parts[1];

  String images =  "http://img.youtube.com/vi/"+ids+"/maxresdefault.jpg";


  AwesomeNotifications().createNotification(
      content: NotificationContent( //with image from URL
          id: 1,
          channelKey: 'key1',
          title: message.data["title"],
          bigPicture: images,
          notificationLayout: NotificationLayout.BigPicture,
          payload: {"id":"1"}
      )
  );
 /* FirebaseMessaging.onMessageOpenedApp.listen((event) {
    // go to youtube play

    var logger = Logger();
    logger.d("dkfjdklfjdklfjd  clicked");

    print(".............................Notificaiton Clicked........................................");

    Navigator.push(
        //get global context
        NavigationService.navigatorKey.currentContext!,
        MaterialPageRoute(
            builder: (context) => SobdoOption()));
  });*/
}

void SubscribeToTopic(BuildContext context) async {
  await FirebaseMessaging.instance.subscribeToTopic('all').then((value) => print("all"));

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    /*AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'key1',
        title: message.notification!.title,
        body: message.notification!.body,
        notificationLayout: NotificationLayout.BigPicture,
        bigPicture: 'asset://assets/images/ll.png',
        // ontap go to youtube play
        showWhen: true,
        displayOnBackground: true,
        payload: {'url': 'https://www.youtube.com/watch?v=9bZkp7q19f0'},
      ),

    );*/

    bool isallowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isallowed) {
      //no permission of local notification
      AwesomeNotifications().requestPermissionToSendNotifications();
    }else{
      //show notification
      String body = message.data['body'];
      List<String> parts = body!.split("?v=");
      String? ids = parts[1];

      String images =  "http://img.youtube.com/vi/"+ids+"/maxresdefault.jpg";


      AwesomeNotifications().createNotification(
          content: NotificationContent( //with image from URL
              id: 1,
              channelKey: 'key1',
              title: message.data["title"],
              bigPicture: images,
              notificationLayout: NotificationLayout.BigPicture,
              payload: {"id":"1"}
          )
      );
    }

  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    // go to youtube play

    var logger = Logger();
    logger.d("dkfjdklfjdklfjd  clicked");

    print(".............................Notificaiton Clicked........................................");

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SobdoOption()));
  });



}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /*await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );*/
  // Awsomenotification init with default icon
/*
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'key1',
        channelName: 'Default notifications',
        channelDescription: 'Notification channel for default notifications',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white,
      ),

    ],


  );*/



  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();


}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: MyApp.navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home:SplashPage() ,

      debugShowCheckedModeBanner: false,
    );
  }
  @override
  void initState() {
    SubscribeToTopic(context);
    super.initState();
    // Load ads.
    final BannerAd myBanner = BannerAd(
      adUnitId: '<ca-app-pub-3940256099942544/6300978111>',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(),
    );
    /* myBanner.load();
    final AdWidget adWidget = AdWidget(ad: myBanner);
    final Container adContainer = Container(
      alignment: Alignment.center,
      child: adWidget,
      width: myBanner.size.width.toDouble(),
      height: myBanner.size.height.toDouble(),
    );*/
    SubscribeToTopic(context);
  }
}


class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageIndex = 0;

  double bottom_icon_size = 20;

  double bottom_font_size = 12;

  double bottom_gap_between_icon_text = 4;

  @override
  void initState() {
    // TODO: implement initState
    SubscribeToTopic(context);
    super.initState();
    SubscribeToTopic(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                BootstrapIcons.grid,
                color: Colors.grey, // Change Custom Drawer Icon Color
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
        title:Container(
            child:
            Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(right: 50,top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 2),
                          height: 50.0,
                          width: 100.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: new BoxDecoration(
                                  //borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight:Radius.circular(15),),

                                    image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: Image.asset("assets/images/ll.png",
                                      ).image,
                                    )
                                ),
                              )

                              /* Text(
                      "Chatga",
                      style: TextStyle(
                          fontFamily: "bangla",
                          fontSize: 18,
                          color:Color(0xFF282C7D),
                      ),
                    ),*/
                              /*Text(
                      "চাটগাঁ",
                      style: TextStyle(
                          fontFamily: "bangla",
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),*/
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child:
                    Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFF5F4F4),
                          ),
                          color: Color(0xFFEFEFEF),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      padding: EdgeInsets.all(5),
                      child: Center(
                          child: Image.asset("assets/images/crown.png"
                            ,width: 30,height: 30,)
                      ),
                    ))
              ],
            )),
      ),
      body:HomeScreen() ,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF043E99),
              ),
              child: Center(
                child:

                Text(
                  'চাটগাঁ',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: "bangla"
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: const Text(' শব্দ সমূহ '),
              trailing:Icon(Icons.chevron_right_sharp) ,
              onTap: () {
                //go to option one
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SobdoOption()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: const Text(' চাঁটগা থেকে ইংরেজি '),
              trailing:Icon(Icons.chevron_right_sharp) ,
              onTap: () {
                /* setState(() {
                    pageIndex = 1;
                  });*/
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FourthOption()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: const Text(' চট্টগ্রামের ইতিহাস '),
              trailing:Icon(Icons.chevron_right_sharp) ,
              onTap: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ItihasOption()),
                  );
                });

              },
            ),
            ListTile(
              leading: Icon(Icons.person_add),
              title: const Text(' কথোপোকথন '),
              trailing:Icon(Icons.chevron_right_sharp) ,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FifthOption()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.ac_unit),
              title: const Text(' প্রবাদ-প্রচ্চন '),
              trailing:Icon(Icons.chevron_right_sharp) ,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProbadOption()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.place),
              title: const Text('ঊপজেলা'),
              trailing:Icon(Icons.chevron_right_sharp) ,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SixthOption()),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 65,
      margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
      padding: EdgeInsets.only(left: 10,right: 10),
      decoration: BoxDecoration(
        color:  Color(0xFFE1E2FD),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFD4D2D2),
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 15.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 55,
            width: MediaQuery.of(context).size.width*0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Constants.PRIMARYCOLOR,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFD4D2D2),
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            alignment: Alignment.center,
            child:Center(
              child:MaterialButton(
                onPressed: () {
                  /* setState(() {
                  pageIndex = 0;
                });*/
                },
                child: Icon(
                  BootstrapIcons.house,
                  size: 20,
                  color: Colors.white,
                  /* color: pageIndex == 0 ? Colors.redAccent : Colors.grey,
                    size: bottom_icon_size,*/
                ),
              ) ,
            )
            ,
          ),
          Container(
            height: 55,
            width: MediaQuery.of(context).size.width*0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Color(0xFFE1E2FD),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFD4D2D2),
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            alignment: Alignment.center,
            child:Center(
              child:MaterialButton(
                onPressed: () {
                  /* setState(() {
                  pageIndex = 0;
                });*/
                  //go to option one
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SobdoOption()),
                  );
                },
                child: Icon(
                  BootstrapIcons.book,
                  size: 20,
                  color: Constants.PRIMARYCOLOR,
                  /* color: pageIndex == 0 ? Colors.redAccent : Colors.grey,
                    size: bottom_icon_size,*/
                ),
              ) ,
            )
            ,
          ),
          Container(
            height: 55,
            width: MediaQuery.of(context).size.width*0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Color(0xFFE1E2FD),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFD4D2D2),
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            alignment: Alignment.center,
            child:Center(
              child:MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FourthOption()),
                  );
                },
                child: Icon(
                  BootstrapIcons.translate,
                  size: 20,
                  color: Constants.PRIMARYCOLOR,

                  /* color: pageIndex == 0 ? Colors.redAccent : Colors.grey,
                    size: bottom_icon_size,*/
                ),
              ) ,
            )
            ,
          ),
          Container(
            height: 55,
            width: MediaQuery.of(context).size.width*0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Color(0xFFE1E2FD),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFD4D2D2),
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            alignment: Alignment.center,
            child:Center(
              child:MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SixthOption()),
                  );
                },
                child: Icon(
                  BootstrapIcons.geo_alt,
                  size: 20,
                  color: Constants.PRIMARYCOLOR,
                  /* color: pageIndex == 0 ? Colors.redAccent : Colors.grey,
                    size: bottom_icon_size,*/
                ),
              ) ,
            )
            ,
          ),
          Container(
            height: 55,
            width: MediaQuery.of(context).size.width*0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Color(0xFFE1E2FD),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFD4D2D2),
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            alignment: Alignment.center,
            child:Center(
              child:MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GalleryOption()),
                  );
                },
                child: Icon(
                  BootstrapIcons.images,
                  size: 20,
                  color: Constants.PRIMARYCOLOR,
                  /* color: pageIndex == 0 ? Colors.redAccent : Colors.grey,
                    size: bottom_icon_size,*/
                ),
              ) ,
            )
            ,
          ),


        ],
      ),
    );
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();
}






