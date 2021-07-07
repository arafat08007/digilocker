import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:googledriveclone_flutter/Data/Recent.dart';
import 'package:googledriveclone_flutter/Models/FileCategories.dart';
import 'package:googledriveclone_flutter/Screen/Home.dart';
import 'package:googledriveclone_flutter/Widget/ConditionalImage.dart';
import 'package:googledriveclone_flutter/Widget/constants.dart';
import 'package:googledriveclone_flutter/Widget/recent.dart';
import 'package:flutter/gestures.dart';
import 'package:googledriveclone_flutter/services/AppApi.dart';
import 'package:googledriveclone_flutter/services/baseClient.dart';

void main() {
  runApp(HomeScreen());
}

class HomeScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return HomeScreenPage();
  }
}

class HomeScreenPage extends StatefulWidget {
  HomeScreenPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenPageState createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  int touchedIndex = -1;
  List<FileCategories> _catList = new List<FileCategories>();
  @override
  Future<void> initState() {
    // TODO: implement initState
    _GetCategories(AppApi.FAKE_BASE_API, AppApi.FAKE_BASE_ENDPOINT);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /*  Expanded(
          flex: 1,
          child: PieChart(
           // Optional
            PieChartData(
                pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                  setState(() {
                    final desiredTouch = pieTouchResponse.touchInput is! PointerExitEvent &&
                        pieTouchResponse.touchInput is! PointerUpEvent;
                    if (desiredTouch && pieTouchResponse.touchedSection != null) {
                      touchedIndex = pieTouchResponse.touchedSection.touchedSectionIndex;
                    } else {
                      touchedIndex = -1;
                    }
                  });
                }),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 20,
                sections: showingSectionsWithImage(),
             // centerSpaceColor: Colors.black54,
            ),

            swapAnimationCurve: Curves.ease,
            swapAnimationDuration: Duration(milliseconds: 150),
          ),
        ),*/

          Expanded(
            flex: 1,
            child: GridView.count(
              scrollDirection: Axis.horizontal,
              crossAxisCount: 2,
              mainAxisSpacing: 0,
              children: new List<Widget>.generate(_catList.length, (index) {
                return new GridTile(
                  child: Card(
                      color: Colors.white,
                      shadowColor: kPrimaryLightColor,
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          print(_catList[index].catid);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ClipRRect( child: ConditionalImage.ImageFile(_catList[index].catname),),
                            Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: kPrimaryLightColor,
                                    border: new Border.all(
                                        color: Colors.grey.withOpacity(0.3),
                                        width: 1.0,
                                        style: BorderStyle.solid)),
                                child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      _catList[index].fileNum,
                                      style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold),
                                    ))),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: _catList.length > 0
                                  ? Text(
                                      _catList[index].catname,
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.black54),
                                      maxLines: 2,
                                      softWrap: true,
                                    )
                                  : Text('Nothing found'),
                            )
                          ],
                        ),
                      )),
                );
              }),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Recent',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.normal,
                fontFamily: 'roboto'),
          ),
          Divider(
            height: 20,
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: recents.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: RecentWidget(
                      recent: recents[index],
                    ),
                  );
                }),
          )
        ]);
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }

  List<PieChartSectionData> showingSectionsWithImage() {
    return List.generate(5, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 12.0 : 10.0;
      final radius = isTouched ? 60.0 : 50.0;
      final widgetSize = isTouched ? 25.0 : 30.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              FontAwesomeIcons.solidFileWord,
              size: widgetSize,
              borderColor: const Color(0xff0293ee),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              FontAwesomeIcons.solidFileExcel,
              size: widgetSize,
              borderColor: const Color(0xfff8b250),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 10,
            title: '10%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              FontAwesomeIcons.solidFileImage,
              size: widgetSize,
              borderColor: const Color(0xff845bef),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 10,
            title: '10%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              FontAwesomeIcons.solidFilePdf,
              size: widgetSize,
              borderColor: const Color(0xff13d38e),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 4:
          return PieChartSectionData(
            color: Colors.white70,
            value: 10,
            title: '10%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
            badgeWidget: _Badge(
              FontAwesomeIcons.memory,
              size: widgetSize,
              borderColor: Colors.white70,
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw 'Oh no';
      }
    });
  }

  Future<List<FileCategories>> _GetCategories(
      String baseUrl, String api) async {
    var response = await BaseClient().get(baseUrl, api);
    print(" Category response: $response");
    // If the call to the server was successful, parse the JSON
    List<dynamic> values = new List<dynamic>();
    values = json.decode(response);
    if (values.length > 0) {
      for (int i = 0; i < values.length; i++) {
        if (values[i] != null) {
          Map<String, dynamic> map = values[i];
          _catList.add(FileCategories.fromJson(map));
          debugPrint('Category name-------${map['catname']}');
        }
      }
    }
    return _catList;
  }
}

class _Badge extends StatelessWidget {
  final IconData svgAsset;
  final double size;
  final Color borderColor;

  const _Badge(
    this.svgAsset, {
    Key key,
    this.size,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Icon(
          svgAsset,
          size: 12,
        ),
      ),
    );
  }
}
