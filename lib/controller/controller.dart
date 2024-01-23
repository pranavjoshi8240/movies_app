import 'dart:convert';
import 'package:get/get.dart';
import '../model/movies_model.dart';
import '../networking/networking.dart';
import '../utils/constants_api_strings.dart';
import '../utils/flutter_toast.dart';

class Controller extends GetxController {
  Networking networking = Networking();
  Rx<MoviesModel> popularMovies = MoviesModel().obs;
  Rx<MoviesModel> topRatedMovies = MoviesModel().obs;
  Rx<MoviesModel> favMovies = MoviesModel().obs;
  RxList favMoviesId = [].obs;

  getPopularMovies() async {
    var data =
        await networking.get("https://api.themoviedb.org/3/movie/popular?language=en-US&page=1");
    popularMovies(MoviesModel.fromJson(data));
  }

  getTopRatedMovies() async {
    var data = await networking.get("https://api.themoviedb.org/3/movie/top_rated");
    topRatedMovies(MoviesModel.fromJson(data));
  }

  addFavourite(id) async {
    Map body = {"media_type": "movie", "media_id": id, "favorite": true};
    var data = await networking.post(
        '${ConstantApiStrings.ACCOUNT_BASE}/19943163/favorite', json.encode(body));
    if (data['success']) {
      flutterToastMessage('Successfully added movies into Favourite');
    }
  }

  getFavoriteMovies() async {
    favMoviesId = [].obs;
    var data =
        await networking.get('https://api.themoviedb.org/3/account/19943163/favorite/movies');
    favMovies(MoviesModel.fromJson(data));
    for (var element in favMovies.value.results!) {
      favMoviesId.add(element.id.toString());
    }
  }
}
