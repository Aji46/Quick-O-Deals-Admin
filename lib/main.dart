import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickdealsadmin/Controller/provider/category_add_getx.dart';
import 'package:quickdealsadmin/Controller/provider/email_auth.dart';
import 'package:quickdealsadmin/Controller/provider/people_provider.dart';
import 'package:quickdealsadmin/Controller/provider/side_panal_provider.dart';
import 'package:quickdealsadmin/Model/auth.dart';
import 'package:quickdealsadmin/View/pages/dashboard.dart';
import 'package:quickdealsadmin/View/pages/home.dart';
import 'package:quickdealsadmin/View/pages/product_detaile.dart';
import 'package:quickdealsadmin/View/pages/user_detaile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyC64sHg59kVrTjm2IC4ueuq2qaTht2-bmU",
          authDomain: "quick-o-deals.firebaseapp.com",
          projectId: "quick-o-deals",
          storageBucket: "quick-o-deals.appspot.com",
          messagingSenderId: "874253348818",
          appId: "1:874253348818:web:12137a642eefb4a3ae220b",
        ),
      );
    } else {
      await Firebase.initializeApp();
    }
    print('Firebase initialized successfully');
  } catch (e) {
    if (kDebugMode) {
      print('Failed to initialize Firebase: $e');
    }
  }

  // Initialize AuthRepository
  final authRepository = AuthRepository();

  // Register controllers with GetX
  Get.put(AuthController(authRepository: authRepository));

  Get.put(SidePanelController());
  Get.put(CategoryController());
   Get.lazyPut<PeopleController>(() => PeopleController());
     Get.put(PeopleController());


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
       routes: {
        '/ProductDetailPage': (context) => const ProductDetailPage(),
        '/ProfileDetailPage': (context) => ProfileDetailPage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BaseLayout(content: Dashboard())
      // LoginScreen(),
    );
  }
}


// flutter run -d chrome --web-renderer html