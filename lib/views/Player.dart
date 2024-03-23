import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:musicplayerapp/consts/colors.dart';
import 'package:musicplayerapp/consts/text_style.dart';
import 'package:musicplayerapp/controllers/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {
  final List<SongModel> data;
  const Player ({super.key,required this.data});
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(),
      body:Padding(
        padding: EdgeInsets.all(8.0),
        child:Column(
          children: [
            Obx( ()=>
            Expanded(
              child:
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                height: 300,
            width: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.pink[100]
                ),
                alignment: Alignment.center,
                child: QueryArtworkWidget(
                  id: data[controller.playIndex.value].id,
                  type: ArtworkType.AUDIO,
                  artworkHeight: double.infinity,
                  artworkWidth: double.infinity,
                  nullArtworkWidget: Icon(Icons.music_note, size: 48,color: Colors.white,),),
                )
            ),),
            Expanded(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue[100],borderRadius: BorderRadius.vertical(top: Radius.circular(16))
                ),child:Obx(
                  () => Column(
                  children: [
                    Text(
                      data[controller.playIndex.value].displayNameWOExt,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: ourstyle(
                        color: bgDarkColor,
                        Family: bold,
                        size:24,
                      ),
                    ),Text(
                      data[controller.playIndex.value].artist.toString(),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: ourstyle(
                        color: bgDarkColor,
                        Family: bold,
                        size:24,
                      ),
                    ),
                    SizedBox(height: 12,),
                   Obx( () => Row(
                      children: [
                        Text(controller.position.value, style: ourstyle(
                          color: bgDarkColor),
                        ),
                        Expanded(
                            child: Slider(
                              thumbColor: sliderColor,
                            inactiveColor: bgColor,
                            activeColor: sliderColor,
                            min : Duration(seconds: 0).inSeconds.toDouble(),
                                max:controller.max.value,
                                value: controller.value.value,
                                onChanged: (newValue) {
                                controller.changeDurationToSeconds(newValue.toInt());
                                newValue = newValue;
                                })),
                        Text(controller.duration.value, style: ourstyle(
                          color: bgDarkColor,
                        ),
                        ),
                      ],
                    ),),
                    SizedBox(height: 12,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(onPressed: (){
                          controller.playSong(data[controller.playIndex.value-1].uri, controller.playIndex.value-1);
                        }, icon:Icon(Icons.skip_previous_rounded,size: 40,color: bgDarkColor,)),
                        CircleAvatar(
                          radius: 35,
                            backgroundColor: bgColor,
                        child: Transform.scale(
                          scale:2.5,
                        child: IconButton(
                            onPressed: (){
                              if(controller.isPlaying.value) {
                                controller.audioPlayer.pause();
                                controller.isPlaying(false);
                              }else {
                                controller.audioPlayer.pause();
                                controller.isPlaying(true);
                              }
                            }, icon:controller.isPlaying.value ? Icon(
                                Icons.pause,color: Colors.white)
                            :Icon(Icons.play_arrow_rounded,color:whiteColor,)),),),
                        IconButton(onPressed: (){
                          controller.playSong(data[controller.playIndex.value+1].uri, controller.playIndex.value+1);
                        }, icon:Icon(Icons.skip_next_rounded,size: 40,color: bgDarkColor)),
                      ],
                    )
                  ],
                )))
            )
          ],
        )
        
      )
    );
  }
}
