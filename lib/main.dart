import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flutter/pages/booking/booking_bloc/add_turist_bloc.dart';
import 'package:task_flutter/pages/booking/booking_bloc/booking_bloc.dart';
import 'package:task_flutter/pages/hotel/hotel_bloc/hotel_bloc.dart';
import 'package:task_flutter/pages/hotel/hotel_page.dart';
import 'pages/number/number_bloc/number_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HotelBloc()),
        BlocProvider(create: (context) => NumberBloc()),
        BlocProvider(create: (context) => BookingBloc()),
        BlocProvider(create: (context) => TuristBloc()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // Цвет фона приложения
            scaffoldBackgroundColor: Colors.grey[200],
            elevatedButtonTheme: ElevatedButtonThemeData(
              // Цвет кнопки
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xFF0D72FF)),
                // Цвет текста кнопки
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
            ),
            // Цвет разделителя
            dividerColor: Colors.transparent,
          ),
          home: HotelPage()),
    );
  }
}
