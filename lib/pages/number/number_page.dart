import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flutter/pages/booking/booking_page.dart';
import 'package:task_flutter/res/app_strings.dart';
import 'number_bloc/number_bloc.dart';

class NumberPage extends StatelessWidget {
  NumberPage({super.key, required String hotelName}) : _hotelName = hotelName;

  final _bloc = NumberBloc()..add(NumberInitEvent());
  final String _hotelName;

  // Количество символов в группе
  String addSpacesToNumber(String input) {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _hotelName,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
      body: BlocBuilder<NumberBloc, NumberState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is NumberLoadedState) {
            return ListView(
              children: [
                const SizedBox(height: 10),
                //Room 1
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      )),
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      height: 250,
                      child: Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: state
                                  .hotelDetail.rooms![0].imageUrls![index]
                                  .toString(),
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
                    const SizedBox(height: 10),
                    //Название
                    Text(
                      state.hotelDetail.rooms![0].name.toString(),
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    Row(
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
                                state.hotelDetail.rooms![0].peculiarities![0]
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
                                state.hotelDetail.rooms![0].peculiarities![1]
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
                      height: 10,
                    ),
                    //Подробнее
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(5),
                        child: IntrinsicWidth(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.aboutRoom,
                                style: TextStyle(
                                    color: Colors.blue[800],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                Icons.navigate_next,
                                size: 24,
                                color: Colors.blue[800],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //Цена
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          addSpacesToNumber(
                                state.hotelDetail.rooms![0].price.toString(),
                              ) +
                              AppStrings.currency,
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          style: const TextStyle(color: Colors.grey),
                          state.hotelDetail.rooms![0].pricePer.toString(),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 48,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => (const BookingPage())));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(AppStrings.selectNumber),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: 10),
                //Room 2
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18)),
                        height: 250,
                        child: Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(18),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: state
                                    .hotelDetail.rooms![1].imageUrls![index]
                                    .toString(),
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
                      const SizedBox(height: 10),
                      //Название
                      Text(
                        state.hotelDetail.rooms![0].name.toString(),
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),
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
                                  state.hotelDetail.rooms![1].peculiarities![0]
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
                                  state.hotelDetail.rooms![1].peculiarities![1]
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
                                  state.hotelDetail.rooms![1].peculiarities![2]
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
                        height: 10,
                      ),
                      //Подробнее
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(5),
                          child: IntrinsicWidth(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.aboutRoom,
                                  style: TextStyle(
                                      color: Colors.blue[800],
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                                const SizedBox(width: 5),
                                Icon(
                                  Icons.navigate_next,
                                  size: 24,
                                  color: Colors.blue[800],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //Цена
                      Row(
                        children: [
                          Text(
                            addSpacesToNumber(
                                  state.hotelDetail.rooms![1].price.toString(),
                                ) +
                                AppStrings.currency,
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            style: const TextStyle(color: Colors.grey),
                            state.hotelDetail.rooms![0].pricePer.toString(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 48,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => (const BookingPage())));
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(AppStrings.selectNumber),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          if (state is NumberFailureException) {
            return Center(child: Text(state.exception.toString()));
          }
          return const Center(child: CircularProgressIndicator());
        },
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
