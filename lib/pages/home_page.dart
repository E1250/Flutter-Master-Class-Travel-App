import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_class_travel_app/cubit/app_cubit_states.dart';
import 'package:master_class_travel_app/cubit/app_cubits.dart';
import 'package:master_class_travel_app/misc/colors.dart';
import 'package:master_class_travel_app/widgets/app_large_taxt.dart';
import 'package:master_class_travel_app/widgets/app_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  var images = {
    'balloning.png' : "Balloning",
    'hiking.png' : "Hiking",
    'kayaking.png' : "Kayaking",
    'snorkling.png' : "Snorkling",
  };

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);

    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: BlocBuilder<AppCubits,CubitStates>(
        builder: (context,state){
          if(state is LoadedState){
            var info =state.places;
            print(info);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Menu text
                Container(
                  padding: EdgeInsets.only(top: 40, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.menu,
                        size: 30,
                        color: Colors.black54,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.5)),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Discover text
                Container(
                    margin: EdgeInsets.only(left: 20),
                    child: AppLargeText(text: 'Discover')),
                SizedBox(
                  height: 20,
                ),
                // Tab bar
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black54,
                    controller: tabController,
                    isScrollable: true,
                    indicator:
                    CircleTabIndicator(radius: 4, color: AppColors.mainColor),
                    tabs: [
                      Tab(text: "Places"),
                      Tab(
                        text: "Inspiratoin",
                      ),
                      Tab(
                        text: "Emotion",
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  height: 250,
                  width: double.maxFinite,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: info.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: (){
                                BlocProvider.of<AppCubits>(context).detailPge(info[index]);
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 15, top: 10),
                                width: 200,
                                height: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: NetworkImage("http://mark.bslmeiyu.com/uploads/"+info[index].img),
                                        fit: BoxFit.cover)),
                              ),
                            );
                          }),
                      Text('There'),
                      Text('Bye'),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppLargeText(text: "Explore More", size: 22),
                      AppText(
                        text: "See More",
                        color: AppColors.textColor1,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Container(
                    width: double.maxFinite,
                    height: 120,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      image: DecorationImage(
                                          image: AssetImage('img/'+images.keys.elementAt(index)),
                                          fit: BoxFit.cover)),
                                ),
                                Container(
                                  child: AppText(text:images.values.elementAt(index),color: AppColors.textColor2),
                                )
                              ],
                            ),
                          );
                        })),
              ],
            );
          }else{
            return Container();
          }
        },
      ),
    ));
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  final double radius;
  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  final double radius;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint paint = Paint();
    paint.color = color;
    paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);

    canvas.drawCircle(circleOffset + offset, radius, paint);
  }
}
