import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flutter/pages/hotel/hotel_bloc/hotel_bloc.dart';
import 'package:task_flutter/pages/number/number_page.dart';
import 'package:task_flutter/res/app_strings.dart';

class HotelPage extends StatelessWidget {
  HotelPage({super.key});

  String _hotelName = '';
  final _bloc = HotelBloc()..add(HotelInitEvent());

  //Добавление пробела
  String addSpacesToNumber(String input) {
    // Количество символов в группе
    const int groupSize = 3;
    final StringBuffer result = StringBuffer();

    // Добавляем пробел после каждой группы символов
    for (int i = 0; i < input.length; i++) {
      if (i > 0 && (input.length - i) % groupSize == 0) {
        result.write(' ');
      }
      result.write(input[i]);
    }

    return result.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<HotelBloc, HotelState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is HotelLoadedState) {
              _hotelName = state.hotelList.name.toString();
              return ListView(
                children: [
                  //Отель
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          AppStrings.hotel,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        //Карусель
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          height: 250,
                          child: Swiper(
                            itemBuilder: (BuildContext context, int index) {
                              return ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(18),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: state.hotelList.imageUrls![index],
                                  fit: BoxFit.fill,
                                  placeholder: _loader,
                                  errorWidget: _error,
                                ),
                              );
                            },
                            itemCount: 3,
                            pagination: SwiperPagination(
                              builder: DotSwiperPaginationBuilder(
                                color: Colors.grey[400],
                                activeColor: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
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
                                    "${state.hotelList.rating} ${state.hotelList.ratingName}",
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
                          state.hotelList.name.toString(),
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        //Адрес
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            state.hotelList.adress.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0D72FF),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        //Цена
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(
                              AppStrings.from +
                                  addSpacesToNumber(
                                      state.hotelList.minimalPrice.toString()) +
                                  AppStrings.currency,
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                style: const TextStyle(color: Colors.grey),
                                state.hotelList.priceForIt.toString(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  //Об отеле
                  Container(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppStrings.about,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey[50]),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    state.hotelList.aboutTheHotel!
                                        .peculiarities![0]
                                        .toString(),
                                    style: const TextStyle(
                                        color: Color(0xFF828796),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey[50]),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    state.hotelList.aboutTheHotel!
                                        .peculiarities![2]
                                        .toString(),
                                    style: const TextStyle(
                                        color: Color(0xFF828796),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey[50]),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    state.hotelList.aboutTheHotel!
                                        .peculiarities![1]
                                        .toString(),
                                    style: const TextStyle(
                                        color: Color(0xFF828796),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.grey[50]),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    state.hotelList.aboutTheHotel!
                                        .peculiarities![3]
                                        .toString(),
                                    style: const TextStyle(
                                        color: Color(0xFF828796),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        //Описание отеля
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              state.hotelList.aboutTheHotel!.description
                                  .toString(),
                              style: const TextStyle(fontSize: 16),
                            )),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(145, 250, 250, 250)),
                          child: const Column(
                            children: [
                              ListTile(
                                trailing: Icon(
                                  Icons.navigate_next,
                                  size: 32,
                                ),
                                leading: Image(
                                  image: AssetImage(AppStrings.emojiHappy),
                                ),
                                title: Text(AppStrings.facilities),
                                subtitle: Text(AppStrings.essentials),
                              ),
                              Divider(),
                              ListTile(
                                trailing: Icon(
                                  Icons.navigate_next,
                                  size: 32,
                                ),
                                leading: Image(
                                  image: AssetImage(AppStrings.tickSquare),
                                ),
                                title: Text(AppStrings.included),
                                subtitle: Text(AppStrings.essentials),
                              ),
                              Divider(),
                              ListTile(
                                trailing: Icon(
                                  Icons.navigate_next,
                                  size: 32,
                                ),
                                leading: Image(
                                  image: AssetImage(AppStrings.closeSquare),
                                ),
                                title: Text(AppStrings.notIncluded),
                                subtitle: Text(AppStrings.essentials),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            }
            if (state is HotelFailureException) {
              return Center(child: Text(state.exception.toString()));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ), //Кнопка к выбору номера
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: Colors.white,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => (NumberPage(
                        hotelName: _hotelName,
                      ))));
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text(AppStrings.choiceOfRoom),
          ),
        ),
      ),
    );
  }
}

Widget _loader(BuildContext context, String url) {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Widget _error(BuildContext context, String url, dynamic error) {
  return const Center(child: Text(AppStrings.loadingError));
}
