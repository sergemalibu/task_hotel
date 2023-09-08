import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:task_flutter/pages/booking/booking_bloc/add_turist_bloc.dart';
import 'package:task_flutter/pages/booking/booking_bloc/booking_bloc.dart';
import 'package:task_flutter/pages/paid_page.dart';
import 'package:task_flutter/res/app_strings.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  static const turistNumber = [
    'Первый турист',
    'Второй турист',
    'Третий турист'
  ];

  final _bloc = BookingBloc()..add(BookingInitEvent());
  final _turistBloc = TuristBloc()..add(AddTuristEvent());

  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  // Маска для номера телефона
  final _phoneNumberMaskFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  // Валидация почты
  bool isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }

  //Проверка форм
  void submitForm() {
    if (_formKey.currentState!.validate() &&
        _formKey2.currentState!.validate()) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const PaidPage()));
    }
  }

  //Cложение сумм
  String toPay(int? tourPrice, int? fuelCharge, int? serviceCharge) {
    final int res = (tourPrice ?? 0) + (fuelCharge ?? 0) + (serviceCharge ?? 0);
    return res.toString();
  }

  String addSpacesToNumber(String input) {
    // Количество символов в группе
    const int groupSize = 3;
    final StringBuffer result = StringBuffer();

    for (int i = 0; i < input.length; i++) {
      if (i > 0 && (input.length - i) % groupSize == 0) {
        // Добавляем пробел после каждой группы символов
        result.write(' ');
      }
      result.write(input[i]);
    }

    return result.toString();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        AppStrings.booking,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
      )),
      body: BlocBuilder<BookingBloc, BookingState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is BookingLoadedState) {
            return ListView(
              children: <Widget>[
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Рейтинг
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 200, 0, 0.201),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(5),
                          child: IntrinsicWidth(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 18,
                                  color: Color.fromARGB(255, 255, 170, 0),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  state.booking.horating.toString(),
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 255, 170, 0),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  state.booking.ratingName.toString(),
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 255, 170, 0),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                      //Название отеля
                      Text(
                        state.booking.hotelName.toString(),
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),
                      //Адрес
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          state.booking.hotelAdress.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF0D72FF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                //Подробности тура
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Expanded(
                              flex: 3,
                              child: Text(
                                AppStrings.departure,
                                style: TextStyle(color: Colors.grey),
                              )),
                          Expanded(
                              flex: 5,
                              child: Text(state.booking.departure.toString()))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Expanded(
                              flex: 3,
                              child: Text(
                                AppStrings.countryCity,
                                style: TextStyle(color: Colors.grey),
                              )),
                          Expanded(
                            flex: 5,
                            child: Text(
                              state.booking.arrivalCountry.toString(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Expanded(
                              flex: 3,
                              child: Text(
                                AppStrings.dates,
                                style: TextStyle(color: Colors.grey),
                              )),
                          Expanded(
                            flex: 5,
                            child: Text(
                              state.booking.tourDateStart.toString() +
                                  AppStrings.dash +
                                  state.booking.tourDateStop.toString(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Expanded(
                              flex: 3,
                              child: Text(
                                AppStrings.valueNights,
                                style: TextStyle(color: Colors.grey),
                              )),
                          Expanded(
                            flex: 5,
                            child: Text(
                              state.booking.numberOfNights.toString(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Expanded(
                              flex: 3,
                              child: Text(
                                AppStrings.hotel,
                                style: TextStyle(color: Colors.grey),
                              )),
                          Expanded(
                            flex: 5,
                            child: Text(
                              state.booking.hotelName.toString(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Expanded(
                              flex: 3,
                              child: Text(
                                AppStrings.number,
                                style: TextStyle(color: Colors.grey),
                              )),
                          Expanded(
                            flex: 5,
                            child: Text(
                              state.booking.room.toString(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Expanded(
                              flex: 3,
                              child: Text(
                                AppStrings.nutrition,
                                style: TextStyle(color: Colors.grey),
                              )),
                          Expanded(
                            flex: 5,
                            child: Text(
                              state.booking.nutrition.toString(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                //Информация о покупателе
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18)),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppStrings.buyerInformation,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            //Номер телефона
                            TextFormField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xFFF6F6F9),
                                labelText: AppStrings.phoneNumber,
                                hintText: AppStrings.hiddenNumber,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                              inputFormatters: [_phoneNumberMaskFormatter],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            //Почта
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xFFF6F6F9),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                labelText: AppStrings.mail,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (email) {
                                if (!isEmailValid(email!)) {
                                  return AppStrings.invalidEmailAddress;
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                //Первый турист
                Form(
                  key: _formKey2,
                  child: BlocBuilder<TuristBloc, int>(
                      bloc: _turistBloc,
                      builder: (BuildContext context, state) {
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.only(
                                    top: 5, left: 16, right: 16),
                                margin: const EdgeInsets.only(
                                  top: 10,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: ExpansionTile(
                                  tilePadding: EdgeInsets.zero,
                                  title: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      turistNumber[index],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                  children: [
                                    // Имя
                                    const SizedBox(height: 10),
                                    TextFormField(
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color(0xFFF6F6F9),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          labelText: AppStrings.name),
                                      onChanged: (value) {},
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return AppStrings.enterTouristName;
                                        }
                                        return null;
                                      },
                                    ),

                                    const SizedBox(height: 10),
                                    // Фамилия
                                    TextFormField(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color(0xFFF6F6F9),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        labelText: AppStrings.surname,
                                      ),
                                      onChanged: (value) {},
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return AppStrings.enterTouristSurname;
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    // Дата рождения
                                    TextFormField(
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color(0xFFF6F6F9),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        labelText: AppStrings.dateOfBirth,
                                      ),
                                      onChanged: (value) {},
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return AppStrings.enterdateOfBirth;
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    // Гражданство
                                    TextFormField(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color(0xFFF6F6F9),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        labelText: AppStrings.citizenship,
                                      ),
                                      onChanged: (value) {},
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return AppStrings.citizenship;
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    // Номер загранпаспорта
                                    TextFormField(
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color(0xFFF6F6F9),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        labelText: AppStrings.passportNumber,
                                      ),
                                      onChanged: (value) {},
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return AppStrings.enterPassportNumber;
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    // Срок действия загранпаспорта
                                    TextFormField(
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color(0xFFF6F6F9),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        labelText: AppStrings.passportValidity,
                                      ),
                                      onChanged: (value) {},
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return AppStrings
                                              .enterPassportValidity;
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                              );
                            });
                      }),
                ),
                const SizedBox(height: 10),
                //Добавить туриста
                Container(
                  padding: const EdgeInsets.only(
                      bottom: 10, left: 16, top: 10, right: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        AppStrings.addTourist,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 22,
                        ),
                      ),
                      FloatingActionButton(
                        mini: true,
                        elevation: 0,
                        backgroundColor: Colors.blue[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        onPressed: () {
                          _turistBloc.add(AddTuristEvent());
                        },
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.tour,
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          Text(
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                              state.booking.tourPrice.toString() +
                                  AppStrings.currency)
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.fuelSurcharge,
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          Text(
                            state.booking.fuelCharge.toString() +
                                AppStrings.currency,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.serviceFee,
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          Text(
                            state.booking.serviceCharge.toString() +
                                AppStrings.currency,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.toPay,
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          Text(
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue[800],
                                fontWeight: FontWeight.w600),
                            addSpacesToNumber(toPay(
                                    state.booking.tourPrice,
                                    state.booking.fuelCharge,
                                    state.booking.serviceCharge)) +
                                AppStrings.currency,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            );
          }
          if (state is BookingFailureException) {
            return Center(child: Text(state.exception.toString()));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      //Кнопка оплатить
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: ElevatedButton(
          onPressed: () {
            submitForm();
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: BlocBuilder<BookingBloc, BookingState>(
            bloc: _bloc,
            builder: (BuildContext context, state) {
              if (state is BookingLoadedState) {
                return Text(
                  AppStrings.pay +
                      addSpacesToNumber(
                        toPay(state.booking.tourPrice, state.booking.fuelCharge,
                            state.booking.serviceCharge),
                      ) +
                      AppStrings.currency,
                );
              }

              return const Text(AppStrings.empty);
            },
          ),
        ),
      ),
    );
  }
}
