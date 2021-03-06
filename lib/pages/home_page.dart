import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/utils/ai_util.dart';
import 'package:untitled3/model/radio.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MyRadio> radios;
  @override
  void initState() {
    super.initState();
    fetchRadios();
  }

  fetchRadios() async {
    final radioJson = await rootBundle.loadString("assets/radio.json");
    radios = MyRadioList.fromJson(radioJson).radios;
    // _selectedRadio = radios[0];
    // _selectedColor = Color(int.tryParse(_selectedRadio.color));
    print(radios);
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: Stack(
        children: [
          VxAnimatedBox()
              .size(context.screenWidth, context.screenHeight)
              .withGradient(LinearGradient(
                colors: [
                  Aicolors.primaryColor1,
                  Aicolors.primaryColor2,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ))
              .make(),
          AppBar(
            title: "Ai Radio".text.xl4.bold.white.make().shimmer(
                  primaryColor: Vx.purple300,
                  secondaryColor: Colors.white,
                ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ).h(80.0),
          VxSwiper.builder(
              itemCount: radios.length,
              aspectRatio: 1.0,
              enlargeCenterPage: true,
              itemBuilder: (context, index) {
                final red = radios[index];
                return VxBox(
                        child: ZStack([

                          Positioned(
                            top: 0.0,
                            right: 0.0,
                            child: VxBox(
                              child: red.category.text.uppercase.white.make().px16(),
                            ).height(40.0).black.alignCenter.withRounded(value: 10.0).make(),

                          ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: VStack(
                      [
                        red.name.text.xl4.white.bold.make(),
                        5.heightBox,
                        red.tagline.text.sm.white.semiBold.make(),
                      ],
                      crossAlignment: CrossAxisAlignment.center,
                    ),
                  ),
                          Align(
                            alignment: Alignment.center,
                            child: [Icon(CupertinoIcons.play_circle,color: Colors.white,),
                              10.heightBox,
                              "Double tab to plat".text.gray300.make(),

                            ].vStack(),
                          ),
                ])).clip(Clip.antiAlias)

                    .bgImage(DecorationImage(
                      image: NetworkImage(red.image),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.3), BlendMode.darken),
                    ))
                    .border(color: Colors.black, width: 5.0)
                    .withRounded(value: 60.0)
                    .make()
                    .onInkDoubleTap(() { })
                    .p16();
              }).centered(),

          Align(
            alignment: Alignment.bottomCenter,
            child: Icon(CupertinoIcons.stop_circle,color: Colors.white,size: 50.0,),
          ).pOnly(bottom: context.percentHeight*12),
        ],
        fit: StackFit.expand,
      ),
    );
  }
}
