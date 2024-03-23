import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:musicplayerapp/consts/text_style.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../consts/colors.dart';
import '../controllers/player_controller.dart';
import 'Player.dart';

class Home extends  StatelessWidget {
  const Home ({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: (){}, icon:
          Icon(Icons.search,color: whiteColor)),
        ],
        leading: Icon(Icons.sort_rounded,color: Colors.white),
        title: Text(
          "Beats",
          style: ourstyle(
            Family: bold,
            size: 18,
          )
        ),
      ),
      body: FutureBuilder<List<SongModel>>(
        future: controller.audioQuery.querySongs(
          ignoreCase: true,
          orderType: OrderType.ASC_OR_SMALLER,
          sortType: null,
          uriType: UriType.EXTERNAL,
        ),
        builder: (BuildContext context, AsyncSnapshot<List<SongModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No songs found",
                style: ourstyle(),
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  var song = snapshot.data![index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 4),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      color: bgColor,
                      child: Obx(
                        () =>
                       ListTile(
                        tileColor: Colors.transparent,
                        title: Text(
                          snapshot.data![index].displayNameWOExt,
                          style: ourstyle(Family: bold, size: 15),
                        ),
                        subtitle: Text(
                          "${snapshot.data![index].artist}",
                          style: ourstyle(Family: regular, size: 15),
                        ),
                        leading: QueryArtworkWidget(
                          id: snapshot.data![index].id,
                          type:ArtworkType.AUDIO,nullArtworkWidget: Icon(
                          Icons.music_note_outlined,
                          color: Colors.white,
                          size: 32,
                        ),
                        ),
                        trailing: controller.playIndex.value == index && controller.isPlaying.value ? Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 26)
                        : null,
                        onTap:() {
                          Get.to(() => Player(data: snapshot.data!),
                          transition: Transition.downToUp,);
                          controller.playSong(snapshot.data![index].uri,index);
                        },
                      ),)
                    ),
                  );

                },
              ),
            );
          }
        },
      )

    );
  }
}
