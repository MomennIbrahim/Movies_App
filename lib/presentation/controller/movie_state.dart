abstract class MovieStates{}

class InitialState extends MovieStates{}

class ChangeBottomNavState extends MovieStates{}
class ChangeDropValueState extends MovieStates{}
class ToggleSwitchState extends MovieStates{}

class GetLoadingNowPlayingMovieData extends MovieStates{}
class GetSuccessNowPlayingMovieData extends MovieStates{}
class GetErrorNowPlayingMovieData extends MovieStates{
  final String error;
  GetErrorNowPlayingMovieData(this.error);
}

class GetLoadingPopularMovieData extends MovieStates{}
class GetSuccessPopularMovieData extends MovieStates{}
class GetErrorPopularMovieData extends MovieStates{
  final String error;
  GetErrorPopularMovieData(this.error);
}

class GetLoadingTopRatedMovieData extends MovieStates{}
class GetSuccessTopRatedMovieData extends MovieStates{}
class GetErrorTopRatedMovieData extends MovieStates{
  final String error;
  GetErrorTopRatedMovieData(this.error);
}

class GetLoadingDetailsMovieData extends MovieStates{}
class GetSuccessDetailsMovieData extends MovieStates{}
class GetErrorDetailsMovieData extends MovieStates{
  final String error;
  GetErrorDetailsMovieData(this.error);
}

class GetLoadingTvOnAirMovieData extends MovieStates{}
class GetSuccessTvOnAirMovieData extends MovieStates{}
class GetErrorTvOnAirMovieData extends MovieStates{
  final String error;
  GetErrorTvOnAirMovieData(this.error);
}