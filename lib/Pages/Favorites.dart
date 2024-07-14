import 'package:citiguide/Golobal%20Loader/boxrotation.dart';
import 'package:citiguide/Pages/Favorites/likeddetails.dart';
import 'package:citiguide/Pages/cityscreen.dart';
import 'package:citiguide/Pages/maindetails.dart';
import 'package:citiguide/Pages/profile_page.dart';
import 'package:citiguide/components/reusable/appbar.dart';
import 'package:citiguide/components/reusable/bottomnavigationbar.dart';
import 'package:citiguide/components/reusable/places_tile.dart';
import 'package:citiguide/controllers/FavoritesController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_loader_type.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key, this.fromPage = ''});
  final String fromPage;

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final FavoritesController favoritesController =
      Get.put(FavoritesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_Bar('Favorites', true, ''),
      // bottomNavigationBar: CustomBottomNavigationBar(
      //   currentIndex: 1,
      //   label: widget.fromPage == 'CityScreen' ? 'Cities' : 'Attractions',
      //   showLikeButton: true,
      //   onTap: (index) {
      //     if (index == 2) {
      //       Get.to(() => ProfileSettingsPage(fromPage: 'CityScreen'));
      //     }
      //     if (index == 0) {
      //       Get.back();
      //     }
      //   },
      // ),
      body: Obx(
        () {
          if (favoritesController.isLoading.value) {
            // Show loading animation while data is being fetched
            return const Center(
                child: GFLoader(
                    size: GFSize.LARGE,
                    type: GFLoaderType.square,
                    loaderColorOne: Color.fromARGB(255, 0, 250, 217),
                    loaderColorTwo: Color.fromARGB(255, 123, 255, 237),
                    loaderColorThree: Color.fromARGB(255, 201, 255, 248)));
          } else {
            // Show the list of liked places once data is loaded
            return ListView.builder(
              itemCount: favoritesController.likedPlaces.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final place = favoritesController.likedPlaces[index];
                return GestureDetector(
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    await Get.to(() => TilesDetails(
                          placeData: place,
                          placeId: place['id'],
                        ));
                    favoritesController
                        .fetchLikedPlaces(); // Update list after returning
                  },
                  child: PlacesTile(
                    name: place["title"].toString(),
                    city: place["city"].toString(),
                    rating: place["averageRating"] ?? 0.0,
                    imagelink: place["imageurl"].toString(),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
