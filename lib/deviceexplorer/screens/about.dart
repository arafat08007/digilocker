// framework
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// packages
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 1, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
          <Widget>[
            // normal mode
            SliverAppBar(
                flexibleSpace: FlexibleSpaceBar(),
                title: Container(child: Text('About')),
                forceElevated: innerBoxIsScrolled,
                bottom: PreferredSize(
                    preferredSize: Size.fromHeight(25),
                    child: TabBar(
                      tabs: <Tab>[
                        new Tab(
                          text: "Credit",
                        ),
                      ],
                      controller: _tabController,
                    ))),
          ],
      body: TabBarView(controller: _tabController, children: [Donate()]),
    ));
  }
}

class Donate extends StatelessWidget {
  final String mainwebiste = "https://digilocker.mygov.bd/";


  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => ListView(
            children: <Widget>[
              ListTile(
                title: Text(
                  "Website",
                ),
                subtitle: Column(children: [
                  Text("$mainwebiste"),
                  IconButton(
                    onPressed: () {
                      _launchURL();
                    },
                    icon: Icon(Icons.open_in_browser),
                  )
                ]),
              ),
              Divider(),

            ],
          ),
    );
  }

  _launchURL() async {
    const url = 'https://digilocker.mygov.bd/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
