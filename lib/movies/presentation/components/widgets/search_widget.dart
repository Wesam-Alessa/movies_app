import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/movies/domain/entities/movie.dart';
import 'package:movies_app/movies/presentation/screens/movie_detail_screen.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utils/api_constance.dart';

class SearchWidget extends StatelessWidget {
  final List<Movie> movies;
  const SearchWidget({Key? key,required this.movies }) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return movies.isNotEmpty
            ? FadeIn(
                duration: const Duration(milliseconds: 500),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => MovieDetailScreen(
                                          id: movies[index].id)));
                            },
                            child: Container(
                                height: 150,
                                decoration: BoxDecoration(
                                    color: Colors.grey[850],
                                    borderRadius: BorderRadius.circular(4)),
                                child: Row(children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        right: 10.0, left: 5.0),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8.0)),
                                      child: movies[index]
                                              .backdropPath.isNotEmpty
                                          ? CachedNetworkImage(
                                              width: 120.0,
                                              height: 140,
                                              fit: BoxFit.cover,
                                              imageUrl: ApiConstance.imageUrl(
                                                  movies[index]
                                                      .backdropPath),
                                              placeholder: (context, url) =>
                                                  Shimmer.fromColors(
                                                baseColor: Colors.grey[850]!,
                                                highlightColor:
                                                    Colors.grey[800]!,
                                                child: Container(
                                                  height: 270.0,
                                                  width: 120.0,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            )
                                          : Container(
                                              height: 270.0,
                                              width: 120.0,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[800]!,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  image: const DecorationImage(
                                                      image: AssetImage(
                                                          "assets/images/no-image.jpg"))),
                                            ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          145,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                            movies[index].title,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                    color: Colors.red[700],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: Text(
                                                    movies[index]
                                                        .releaseDate
                                                        .substring(0, 4),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 20.0,
                                                ),
                                                const SizedBox(width: 4.0),
                                                Text(
                                                  (movies[index]
                                                              .voteAverage /
                                                          2)
                                                      .toStringAsFixed(1),
                                                  style: const TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 1.2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              movies[index].overview,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          ]))
                                ]))));
                  },
                ),
              )
            : const Center(
                child: Text(
                  "No Search Item",
                ),
              );

  }
}
