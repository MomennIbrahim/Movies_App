import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/constants/constants.dart';
import '../../controller/movie_cubit.dart';
import '../../controller/movie_state.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieCubit, MovieStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              MovieCubit.get(context).changeBottomNav(index);
            },
            items:  [
              BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.movie,
                  ),
                  label: lang=='en'?'Movie': 'أفلام'),
              const BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'TV'),
            ],
            currentIndex: MovieCubit
                .get(context)
                .currentIndex,
          ),
          body: MovieCubit
              .get(context)
              .screens[MovieCubit
              .get(context)
              .currentIndex],
        );
      },
    );
  }
}
