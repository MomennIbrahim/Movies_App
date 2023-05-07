class MovieModel{
  List<MovieData> list=[];
  MovieModel.fromJson(Map<String,dynamic> json){
    json['results'].forEach((e){
      list.add(MovieData.fromJson(e));
    });
  }
}

class MovieData{
  int? id;
  String? title;
  String? overView;
  String? posterPath;
  String? releaseDate;
  dynamic voteRange;

  MovieData.fromJson(Map<String,dynamic> json){
    title = json['title'];
    id = json['id'];
    overView = json['overview'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    voteRange = json['vote_average'];
  }
}