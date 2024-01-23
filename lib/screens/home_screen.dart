
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/Firebase/FirebaseAuth.dart';
import 'package:movies_app/screens/signIn.dart';
import '../controller/controller.dart';
import '../main.dart';
import '../utils/colors.dart';
import '../widgets/loader.dart';
import '../widgets/movie_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  Controller controller = Get.put(Controller());
  int index = 0;
  bool isMovie = true;
  bool isTv = false;
  bool isFav = false;
  Widget page = Container();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () async => {await controller.getFavoriteMovies(), await controller.getPopularMovies()});
    page = MovieList(movies: controller.popularMovies.value);
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() async {
      Utils(context).startLoading();
      if (_tabController.index == 0) {
        await controller.getPopularMovies();
      } else if (_tabController.index == 1) {
        await controller.getTopRatedMovies();
      } else {
        await controller.getFavoriteMovies();
      }
      Utils(context).stopLoading();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () async {
               _showAlertDialog(context);

            },
              child: Icon(Icons.logout_outlined,color: Colors.white,))
        ],
        backgroundColor: black,
        centerTitle: true,
        title: const Text('Movies'),
        titleTextStyle:
            const TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w500),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            SizedBox(
              height: 75,
              child: TabBar(
                controller: _tabController,
                padding: const EdgeInsets.all(10),
                labelPadding: const EdgeInsets.all(10),
                indicator: BoxDecoration(
                  color: orange,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                unselectedLabelColor: Colors.white,
                labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                unselectedLabelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                tabs: const [
                  Text("Popular"),
                  Text("Top Rated"),
                  Text("Favourite"),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                return TabBarView(
                  controller: _tabController,
                  children: [
                    MovieList(movies: controller.popularMovies.value),
                    MovieList(movies: controller.topRatedMovies.value),
                    MovieList(movies: controller.favMovies.value),
                  ],
                );
              }),
            )
          ],
        ),
      ),
    );
  }
  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text(
            'LogOut!',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Do you want to Logout?',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'No',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () async {
                await AuthService.signOut(context: context);
                await sharedPreferences.clear();
                Get.offAll(()=>SignInScreen());
              },
              child: Text(
                'Yes',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}



