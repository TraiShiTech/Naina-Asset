import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:properties/Constant/Myconstant.dart';
import 'package:properties/core/models/page_model.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/metrics.dart';
import '../../components/appbar/appbar.dart';
import '../../widgets/base_container.dart';
import 'header_left.dart';
import 'header_right.dart';
import 'package:http/http.dart' as http;

class Header extends StatefulWidget {
  const Header({
    Key? key,
    required GlobalKey<State<StatefulWidget>> headerKey,
  })  : _headerKey = headerKey,
        super(key: key);

  @override
  State<Header> createState() => _HeaderState();
  final GlobalKey<State<StatefulWidget>> _headerKey;
}

class _HeaderState extends State<Header> {
  ///////----------------------------------------------->
  @override
  void initState() {
    read_GC_Page();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

///////----------------------------------------------->
  List<PageModel> pageModels = [];
  Future<Null> read_GC_Page() async {
    if (pageModels.length != 0) {
      pageModels.clear();
    }

    String url = '${MyConstant().domain}/GC_Page.php?isAdd=true';

    try {
      var response = await http.get(Uri.parse(url));

      var result = json.decode(response.body);
      // print(result);

      for (var map in result) {
        PageModel pageModelss = PageModel.fromJson(map);
        if (pageModelss.ser.toString() == '1') {
          setState(() {
            pageModels.add(pageModelss);
          });
        } else {}
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    // print(pageModels.length);
    return Container(
      // key: _headerKey,
      width: Metrics.width(context),
      // height: Metrics.height(context),
      height: Metrics.height(context),
      // color: greenBorder,
      decoration: BoxDecoration(
        image: DecorationImage(
            // colorFilter: ColorFilter.mode(Colors.white38, BlendMode.softLight),
            image: NetworkImage('${MyConstant().domain}img/${pageModels[0].corver_img}'),
            // image: AssetImage('images/cb287a4c8aaff8332ca509a48b015fb81.png'),

            // image: NetworkImage(
            //     "https://s3-alpha-sig.figma.com/img/b9aa/1cc9/8177c63d64dc57dadafed19e66fea8a8?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=egbTpZYAzTZSnO2VMtaivEIuzFy1Hi0LVpWp-mm-71zXQBPLJ5XWOQpETBl3fBgFHuyUcg9iM9adymIUWTl8mfY8V2NRsrzeiV3WXMfezEXNM-JtKxb3Kr075s1cmR3fmQtlB6rz8zO1EvtFLDqCcGySdI-90bi983cIJoOOKDyUKG-eblM68Xd07aG0QW7axsh6frIb7UmGp0tZ5I2CxDOWZKE2IT2~sQBW0e6x3yPADrdxZbfuXSpy7Z~DAdH1ZCkg-bbLNvd15ACM9kxSv-0k4egedE5-caHhVKrOn8HM9JWiMQ9UYg5z6hj2lstRFHxkUP5~TwmZ5PRDQJz0Rw__"),
            fit: BoxFit.cover),
      ),
      child: Column(
        children: [
          // Container(color: white.withOpacity(0.5), child: const Appbar()),
          Container(child: const Appbar()),
          Expanded(
            child: BaseContainer(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  HeaderLeft(),
                  // HeaderRight(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
