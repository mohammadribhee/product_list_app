import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_list_app/blocs/auth/auth_cubit.dart';
import 'package:product_list_app/blocs/cart/cart_cubit.dart';
import 'package:product_list_app/blocs/products/product_cubit.dart';
import 'package:product_list_app/firebase_options.dart';
import 'package:product_list_app/screens/products/product_list_screen.dart';
import 'package:product_list_app/services/product_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => ProductCubit(_productService)..fetchProducts()),
        BlocProvider(create: (_) => CartCubit()),
        BlocProvider(create: (_) => AuthCubit())
      ],
      child: MaterialApp(
        title: 'Product List App',
        home: ProductListScreen(),
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
