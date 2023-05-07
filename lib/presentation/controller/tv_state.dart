abstract class TvStates{}

class InitialState extends TvStates{}

class GetLoadingTvOnAirData extends TvStates{}
class GetSuccessTvOnAirData extends TvStates{}
class GetErrorTvOnAirData extends TvStates{
  final String error;
  GetErrorTvOnAirData(this.error);
}

class GetLoadingTvPopularData extends TvStates{}
class GetSuccessTvPopularData extends TvStates{}
class GetErrorTvPopularData extends TvStates{
  final String error;
  GetErrorTvPopularData(this.error);
}

class GetLoadingTvTopRatedData extends TvStates{}
class GetSuccessTvTopRatedData extends TvStates{}
class GetErrorTvTopRatedData extends TvStates{
  final String error;
  GetErrorTvTopRatedData(this.error);
}

class GetLoadingTvDetailsData extends TvStates{}
class GetSuccessTvDetailsData extends TvStates{}
class GetErrorTvDetailsData extends TvStates{
  final String error;
  GetErrorTvDetailsData(this.error);
}