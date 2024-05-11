import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/metrics.dart';
import '../../components/appbar/appbar.dart';
import '../../widgets/base_container.dart';
import 'header_left.dart';
import 'header_right.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required GlobalKey<State<StatefulWidget>> headerKey,
  })  : _headerKey = headerKey,
        super(key: key);

  final GlobalKey<State<StatefulWidget>> _headerKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _headerKey,
      width: Metrics.width(context),
      // height: Metrics.height(context),
      height: Metrics.height(context),
      // color: greenBorder,
      decoration: const BoxDecoration(
        image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.white38, BlendMode.softLight),
            image: AssetImage('images/cb287a4c8aaff8332ca509a48b015fb81.png'),

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
