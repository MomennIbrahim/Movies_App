import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_application/presentation/controller/movie_cubit.dart';
import 'package:movie_application/presentation/controller/movie_state.dart';
import 'package:movie_application/presentation/controller/tv_cubit.dart';
import 'package:movie_application/presentation/screens/movie_screens/layout_screen.dart';
import 'package:movie_application/shared/constants/bloc_observe.dart';
import 'package:movie_application/shared/constants/constants.dart';
import 'package:movie_application/shared/network/local/shared_preference.dart';
import 'package:movie_application/shared/network/remote/remote.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CachedHelper.init();

  lang = CachedHelper.getData(key: 'lang');
  lang ??= 'ar';

  runApp(MyApp(lang: lang));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.lang});

  final String? lang;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create:(BuildContext context){
          return MovieCubit()..getNowPlayingData(language: lang)..getPopularData(language: lang)..getTopRatedData(language:lang);
        }),
        BlocProvider(create: (BuildContext context)=> TvCubit()..getTvOnAirData()..getTvPopularData()..getTvTopRatedData()),
      ],
      child: BlocConsumer<MovieCubit,MovieStates>(
        listener:(context,state){},
        builder:(context,state){
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.red,
                fontFamily: '${GoogleFonts.acme()}',
                textTheme: Theme.of(context).textTheme.apply(
                  fontFamily: GoogleFonts.acme().fontFamily,
                  bodyColor: Colors.white,
                ),
                iconTheme: const IconThemeData(
                    color: Colors.white
                ),
                scaffoldBackgroundColor: Colors.grey.shade900,
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    unselectedItemColor: Colors.white
                )
            ),
            home: const LayoutScreen(),
          );
        },
      ),
    );
  }
}
