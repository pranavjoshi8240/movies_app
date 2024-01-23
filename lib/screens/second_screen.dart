import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controller/controller.dart';
import '../model/movies_model.dart';
import '../utils/colors.dart';
import '../utils/style.dart';

class SecondScreen extends StatefulWidget {
  final Results results;
  const SecondScreen(this.results, {super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  Controller controller = Get.find();
  bool fav = false;
  @override
  void initState() {
    for (var element in controller.favMoviesId) {
      if (element == widget.results.id.toString()) {
        fav = true;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(widget.results.releaseDate.toString());
    var releaseDate = DateFormat('dd-MM-yyyy').format(date);
    return SafeArea(
      child: Scaffold(
        backgroundColor: black,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                        height: MediaQuery.sizeOf(context).height / 1.6,
                        width: MediaQuery.sizeOf(context).width,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://image.tmdb.org/t/p/original${widget.results.posterPath.toString()}',
                            fit: BoxFit.cover,
                            placeholder: (context, url) {
                              return const Center(child: CircularProgressIndicator());
                            },
                            imageBuilder: (context, imageProvider) =>
                                Image(image: imageProvider, fit: BoxFit.fitWidth),
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text(
                            widget.results.title.toString(),
                            style: const TextStyle(
                              color: white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(" (${widget.results.originalLanguage.toString()})", style: descText),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: orange,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(widget.results.voteAverage.toString(), style: descText),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '(${widget.results.voteCount.toString()} votes)',
                            style: descText,
                          ),
                          const Spacer(),
                          const Icon(Icons.date_range, color: white),
                          Text(" Release : ", style: descText),
                          Text(releaseDate.toString(), style: descText),
                          const Spacer(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Description',
                        style: titleText,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(widget.results.overview.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.justify),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                      backgroundColor: Colors.transparent.withOpacity(0.8),
                      child: const BackButton()),
                ),
                Positioned(
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent.withOpacity(0.8),
                      child: InkWell(
                        onTap: () {
                          controller.addFavourite(widget.results.id.toString());
                          controller.favMoviesId.add(widget.results.id.toString());
                          setState(() {
                            fav = true;
                          });
                        },
                        child: Icon(Icons.favorite, color: fav ? Colors.red : white, size: 25.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
