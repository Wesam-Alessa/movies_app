
// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/services/services_locator.dart';
import 'package:movies_app/movies/presentation/components/widgets/search_widget.dart';
import 'package:movies_app/movies/presentation/controllers/movies_bloc.dart';
import 'package:movies_app/movies/presentation/controllers/movies_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();
  var searchWidget;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return getIt<MoviesBloc>();
      },
      child: BlocConsumer<MoviesBloc, MoviesState>(
          listener: (context, state) {},
          buildWhen: (previous, current) =>
              previous.searchMoviesState != current.searchMoviesState,
          builder: (context, provider) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0.0,
                centerTitle: true,
                title: const Text("Find your movie "),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: controller,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Search',
                          labelStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.5, color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.5, color: Colors.white),
                          ),
                        ),
                        onEditingComplete: () async {
                          await MoviesBloc(
                            getIt(),
                            getIt(),
                            getIt(),
                            getIt(),
                          ).searchFun(controller.text).then((value) {
                            searchWidget = SearchWidget(movies: value);
                            setState(() {});
                          });
                        },
                        
                      ),
                    ),
                    if (searchWidget != null) searchWidget,
                    ],
                ),
              ),
            );
          }),
    );
  }
}
