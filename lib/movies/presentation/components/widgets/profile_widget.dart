import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/services/services_locator.dart';
import 'package:movies_app/core/utils/app_string.dart';
import 'package:movies_app/core/utils/dimensions.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/movies/presentation/controllers/bloc/user_bloc.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late Timer timer;
  var w = Dimensions.width20;
  var h = Dimensions.width20;
  bool showText = false;

  checkState(var user) {
    if (user.picture.isNotEmpty) {
      return CachedNetworkImageProvider(
        user.picture,
      );
    } else {
      return const AssetImage("assets/images/profile.png");
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserBlocState>(
        buildWhen: (previous, current) =>
            previous.userDataState != current.userDataState,
        builder: (context, user) {
          switch (user.userDataState) {
            case RequestState.loading:
              return Container();
            case RequestState.loaded:
              return Positioned(
                top: Dimensions.height10 * 4,
                left: Dimensions.width10 / 2,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showText = false;
                    });
                    if (w == Dimensions.width20) {
                      setState(() {
                        w = Dimensions.width30 * 2.7;
                      });
                    } else {
                      setState(() {
                        w = Dimensions.width20;
                      });
                    }
                  },
                  child: AnimatedContainer(
                    width: w,
                    height: h,
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                    onEnd: () {
                      setState(() {
                        showText = !showText;
                      });
                      if (showText) {
                        if (!mounted) {
                          return;
                        }
                        timer = Timer(const Duration(seconds: 5), () {
                          setState(() {
                            showText = !showText;
                            w = Dimensions.width20;
                          });
                          timer.cancel();
                        });
                      }
                    },
                    decoration: BoxDecoration(
                      color: w == Dimensions.width20
                          ? Colors.transparent
                          : Colors.black87,
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                    ),
                    child: w == Dimensions.width20
                        ? Row(
                            children: [
                              CircleAvatar(
                                  radius: Dimensions.radius20,
                                  backgroundImage: checkState(user.userData)),
                              const Spacer(),
                            ],
                          )
                        : InkWell(
                            onTap: () async {
                              timer.cancel();
                              getIt<UserBloc>().add(SignOutEvent(context));
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: Dimensions.radius20,
                                  backgroundImage: CachedNetworkImageProvider(
                                    user.userData!.picture,
                                  ),
                                ),
                                if (showText)
                                  SizedBox(width: Dimensions.width10 / 2),
                                if (showText)
                                  const Text(AppString.signOut,
                                      style: TextStyle(color: Colors.white)),
                                if (showText)
                                  SizedBox(width: Dimensions.width10 / 2),
                                if (showText)
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                  )
                              ],
                            ),
                          ),
                  ),
                ),
              );
            case RequestState.error:
              return Container();
          }
        });
  }
}
