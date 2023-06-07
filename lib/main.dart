import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:halo_smoothie/models/list_coupon.dart';
import 'package:halo_smoothie/models/list_materials.dart';
import 'package:halo_smoothie/models/list_order_material.dart';
import 'package:halo_smoothie/models/list_products_intime.dart';
import 'package:halo_smoothie/models/list_rest_products.dart';
import 'package:halo_smoothie/models/office.dart';
import 'package:halo_smoothie/models/profile.dart';
import 'package:halo_smoothie/models/token.dart';
import 'package:halo_smoothie/providers/final_color_provider.dart';
import 'package:halo_smoothie/providers/list_orders_provider.dart';
import 'package:halo_smoothie/providers/price_provider.dart';
import 'package:halo_smoothie/providers/total_price_provider.dart';
import 'package:halo_smoothie/services/auth_service.dart';
import 'package:halo_smoothie/firebase_options.dart';
import 'package:halo_smoothie/views/account/account_screen.dart';
import 'package:halo_smoothie/services/local_notification_service.dart';
import 'package:halo_smoothie/views/login/login_screen.dart';
import 'package:halo_smoothie/views/scan_qrcode/offices_scan.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //LocalNotificationService.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // messaging.getToken().then((token) {
  //   print('MyToken is = $token');
  // });
  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );

  // const AndroidNotificationChannel channel = AndroidNotificationChannel(
  //   'high_importance_channel', // id
  //   'High Importance Notifications', // title
  //   //'This channel is used for important notifications.', // description
  //   importance: Importance.max,
  // );

  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);

  //FirebaseMessaging.instance.getInitialMessage().then((message) {});
  //Foreground
  FirebaseMessaging.onMessage.listen((message) {
    if (message.notification != null) {
      print(message.notification!.body);
      print(message.notification!.title);
      NotificationApi.showNotification(
          id: DateTime.now().millisecond,
          title: message.notification!.title,
          body: message.notification!.body);
      //LocalNotificationService.display(message);
    }
  });

  // RemoteNotification notification = message.notification!;
  // AndroidNotification? android = message.notification!.android;

  // If `onMessage` is triggered with a notification, construct our own
  // local notification to show to users using the created channel.
  //   if (notification != null && android != null) {
  //     String action = jsonEncode(message.data);
  //     flutterLocalNotificationsPlugin.show(
  //         notification.hashCode,
  //         notification.title,
  //         notification.body,
  //         NotificationDetails(
  //           android: AndroidNotificationDetails(
  //             channel.id,
  //             channel.name,
  //             //channel.description,
  //             channelShowBadge: true,
  //             priority: Priority.high,
  //             importance: Importance.max,
  //             styleInformation: DefaultStyleInformation(true, true),
  //             autoCancel: true,
  //             icon: android.smallIcon,
  //             // other properties...
  //           ),
  //         ),
  //         payload: action);
  //   }
  // });

  // Foreground
  //FirebaseMessaging.onMessage.listen((message) {
  //if (message.notification != null) {}
  //});
  //print('User granted permission: ${settings.authorizationStatus}');
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  runApp(HaloSmoothieApp());
}

class HaloSmoothieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ListenableProvider<TokenModel>(
            create: (_) => TokenModel(accessToken: ''),
          ),
          ListenableProvider<ListProductsInTime>(
            create: (_) => ListProductsInTime(
              id: 0,
              name: '',
              startTime: '',
              endTime: '',
              products: [],
              office: OfficeModel(
                  id: 0, name: '', address: '', phone: '', img: '', status: 0),
            ),
          ),
          ListenableProvider<ListRestProduct>(
            create: (_) =>
                ListRestProduct(statusCode: 0, message: '', data: []),
          ),
          ListenableProvider<ListOrdersProvider>(
              create: (_) => ListOrdersProvider(orderDetails: [])),
          ListenableProvider<ListMaterials>(
            create: (_) => ListMaterials(statusCode: 0, message: '', data: []),
          ),
          ListenableProvider<ListOrderMaterials>(
            create: (_) => ListOrderMaterials(),
          ),
          ListenableProvider<ListCoupon>(
            create: (_) => ListCoupon(statusCode: 0, message: "", data: []),
          ),
          ListenableProvider<PriceProvider>(
            create: (_) => PriceProvider(),
          ),
          ListenableProvider<FinalColorProvider>(
            create: (_) => FinalColorProvider(),
          ),
          ListenableProvider<OfficeModel>(
            create: (_) => OfficeModel(
              id: 0,
              name: '',
              address: '',
              phone: '',
              img: '',
              status: 0,
            ),
          ),
          ListenableProvider<ProfileRes>(
            create: (_) => ProfileRes(
                statusCode: 0,
                message: '',
                data: Profile(
                    id: '',
                    firstName: '',
                    lastName: '',
                    email: '',
                    status: 0,
                    image: '')),
          ),
          ListenableProvider<TotalPriceProvider>(
              create: (_) => TotalPriceProvider())
        ],
        child: MaterialApp(
          routes: {Routes.firstPage: (BuildContext context) => QRCodeScanner()},
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          home: AuthService().handleAuthState(),
        ));
  }
}

class Routes {
  static const String firstPage = '/scan';
}

class ControllerLogin extends StatelessWidget {
  const ControllerLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Halo Smoothie',
      home: MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _widgetOptions = <Widget>[
    OfficeScannerPage(),
    Text('Search'),
    Text('Add'),
    AccountPage(),
  ];

  Future<void> signOut() async {
    GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: GNav(
              backgroundColor: Colors.white,
              color: Colors.grey,
              tabBackgroundColor: Colors.orange.withOpacity(.15),
              activeColor: Colors.orange.withOpacity(.8),
              gap: 8,
              onTabChange: _onItemTapped,
              padding: EdgeInsets.all(16), // navigation bar padding
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.heart,
                  text: 'Likes',
                ),
                GButton(
                  icon: LineIcons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                )
              ]),
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
