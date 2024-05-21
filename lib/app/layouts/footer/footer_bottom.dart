import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:properties/core/core.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/methods.dart';
import '../../../core/utils/metrics.dart';
import '../../widgets/base_container.dart';
import 'footer_bottom_licence.dart';
import 'footer_bottom_social_buttons.dart';

class FooterBottom extends StatelessWidget {
  const FooterBottom({
    Key? key,
    required this.bg,
  }) : super(key: key);
  final Color bg;
  @override
  Widget build(BuildContext context) {
    final pad = normalize(min: 576, max: 1440, data: Metrics.width(context));
    // return Container(
    //   width: Metrics.width(context),
    //   decoration: BoxDecoration(
    //     border: Border(
    //       top: BorderSide(
    //         color: brown2,
    //         // color: greenBorder,
    //       ),
    //     ),
    //   ),
    //   child: Column(
    //     children: [
    //       const SizedBox(height: 24),
    //       BaseContainer(
    //         child: Align(
    //           alignment: Alignment.centerLeft,
    //           child: Column(
    //             mainAxisAlignment: Metrics.isMobile(context)
    //                 ? MainAxisAlignment.center
    //                 : MainAxisAlignment.start,
    //             children: [
    //               'Naina Asset Co., Ltd.'.msMadi(
    //                 fontSize: 36 + 24 * pad,
    //                 color: greenBorder,
    //               ),
    //               // 'ในนา แอสเสท'.stixTwoText(
    //               //   fontSize: 30 + 24 * pad,
    //               //   fontWeight: FontWeight.bold,
    //               //   letterSpacing: -0.5,
    //               // ),
    //               'ในนา แอสเสท'.stixTwoText(
    //                 fontSize: 30 + 24 * pad,
    //                 fontWeight: FontWeight.bold,
    //                 letterSpacing: -0.5,
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       const SizedBox(height: 24),
    //       BaseContainer(
    //         child: SizedBox(
    //           height: 100,
    //           child: !Metrics.isMobile(context)
    //               ? Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: const [
    //                     FooterBottomLicence(),
    //                     FooterBottomSocialButtons(),
    //                   ],
    //                 )
    //               : Column(
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   children: const [
    //                     FooterBottomSocialButtons(),
    //                     FooterBottomLicence(),
    //                   ],
    //                 ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    return Container(
      color: bg,
      padding: EdgeInsets.all(Metrics.isMobile(context) ? 25 : 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Naina Asset Co., Ltd.',
            style: GoogleFonts.poppins(color: Color.fromRGBO(39, 39, 39, 1), fontSize: 20),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                'nanainaasset.9@gmail.com\ncall : +66 93 189 9950 https://www.facebook.com/naina.asset',
                style: TextStyle(fontSize: 20),
              )),
              if (Metrics.isDesktop(context) || Metrics.isTablet(context))
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        'https://s3-alpha-sig.figma.com/img/d398/2c58/95fecb47b2fdefc784f0aa67d73fc4ac?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Q86JzBR4DkeoItjgtZrj1uEzJIBwxXeOmDjEYomTZrnuCjiVeeQaidOVlEJoWVw9uusk4QVk6UaIwCSxq~H6LYvbhJ7XG2FePMc25UFfph4r4tZSWA4PdPZ0vR3UQdhsFr0AFatYrmBlfyJIzGu3Eyqhnz5hZ865VN2ROlF2LItI1MyuQC2bogGwdrNOyJNb05W0X0LxqMQRnnUBcCBtUATjg21BLUFSRC6HLgSPJhzdAHI31Qlh6fsziAi51hDTJunHF6ljL8IR0UCY3LGyN3hKPIKXvwdRdPLP92x-4gdVpZKaL1QnVWHFDtqeYD7BArp9K1R9X-Wy~-VyKx3rxw__',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        'https://s3-alpha-sig.figma.com/img/3f80/e57c/9ef6294403f6f9bd97ad79adb3a40fa9?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=LQI444ZcpFrTFSmUM07YwennHmXNbUoWHLZidt7grE9bcXkAAJVUOOumXO1A9ezjOesQxtzXybp4sGTwsJ5E30DWQhSErxtzmM1g4dmqBxSGWTuAtWGYAA2n9qpRUy3K3Tm4pp1EuZl18FIJtuskGHZHlC1iGLl8yNPD0rbK3Dn4cH2jp2huvo3I8CdXQtWAvPEvDPrUT2xP~NY4E0Q8KGDawTMQ~b-1Qc-qBWwz0EWmyko5tQ2WV34kHgake0D5F18pzOtcLDmi7gKKuCfkkXO06mZtuYvIPVqBmwpjIZ8iIXjWPs9-FCLmiSGAH4qVX-7D92xxmx5Enyb9Uj1l0w__',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        'https://s3-alpha-sig.figma.com/img/0bb5/8658/7d152b3be40b7bf849a2ed64c5c34fd9?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=b7jwHchguBRgs2jnnOFXQASNstl4t9s1oYwxCTz3vHkQk1RLEcmz2JT9cIcUHlzfVDNo8tUaB79WT0LCyWYw2XYhHqgdahwiQsMKHAobit2oVK7GpIJpI~3CVK6iVsSs9AM12YiGoGk9fLmF0OMVVuuodekET4uS9mkhEw6~AHTWRXPewgmva9liMYUybeexZ0Ti3hjVaT0-MWy8EdR~xyw0uuw89WSQrMhBBFx0ymURPxP2AcB8TBPDzcaG4qZApdqpbX0uy1yuxfTvj-eLgUWRuoGDNiXruzpMDEIeGGHVB-ABDDuy0e~hzemoxHtJYFsCqKehLR8YQUI-unqG2A__',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        'https://s3-alpha-sig.figma.com/img/d243/ea69/80071ccce519462a946614473e0c2b28?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=X~95XJMSkyonWDPfvlcfKL8~f8incNT4KzZY7uj3SAGzHur3G-gmnrHYpKm6WANGZQNcwPTHUHNPhq-30Lboi1QD4R7wy27e1QtU4s1Y~S-0~MKL92LU3TtnuVmMl3hma6RIQFhH6mPrgjyq-hFHW61eXHCWhwZoWCibnxCK9X1HhmhaOw5C4JiMxG9iM7DJC-AuWgQCk6IKYgKTaf4iEtMt2D~N4zKsfNUxI15a2YW22CnOCGAtUlg3ryrAG7CLMMivj5mcYoteuHiW95jMK2hmW~cFS09xt51Pem96GqW17BJ4M~Pky4FJ1K04h8I1HoMn4EsKxkdMVqSYSTaItA__',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        'https://s3-alpha-sig.figma.com/img/06e0/1635/20803e55c3d2419edc32c18376ceff06?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=FRVEUNFwHboAPG0~djV63cCrbQP4s4D-ZyEW4veQt5I4Z0XEf1lFqUXAgT5KtOhxTecPJS64Onms41B7EpqWtX0qVZu95O1DLg2PWh3m8TRY4S8W-LdeN9~YO3UGH4gxTx0F88j1BTimL~U~f2tvbcqI5YZeqAGchLaZX6lo7jRbOKbnn11PUj9fB18iJ~sbjR~aCMxgWwPMdlFhpNkif5ik4URYS61X2uF8Vc7qM36BL7YWCQjtxxFLCYC1NEaj9GnbnLv9vuE8aXTzm~oDckShutuOV0QRZv33TnuOVHBmec2m493UVEDcfm9NEF1-yTCOvQc6DJXvaVEfUwaUKA__',
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ],
                )),
            ],
          ),
          if (Metrics.isMobile(context))
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    'https://s3-alpha-sig.figma.com/img/d398/2c58/95fecb47b2fdefc784f0aa67d73fc4ac?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Q86JzBR4DkeoItjgtZrj1uEzJIBwxXeOmDjEYomTZrnuCjiVeeQaidOVlEJoWVw9uusk4QVk6UaIwCSxq~H6LYvbhJ7XG2FePMc25UFfph4r4tZSWA4PdPZ0vR3UQdhsFr0AFatYrmBlfyJIzGu3Eyqhnz5hZ865VN2ROlF2LItI1MyuQC2bogGwdrNOyJNb05W0X0LxqMQRnnUBcCBtUATjg21BLUFSRC6HLgSPJhzdAHI31Qlh6fsziAi51hDTJunHF6ljL8IR0UCY3LGyN3hKPIKXvwdRdPLP92x-4gdVpZKaL1QnVWHFDtqeYD7BArp9K1R9X-Wy~-VyKx3rxw__',
                    width: 30,
                    height: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    'https://s3-alpha-sig.figma.com/img/3f80/e57c/9ef6294403f6f9bd97ad79adb3a40fa9?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=LQI444ZcpFrTFSmUM07YwennHmXNbUoWHLZidt7grE9bcXkAAJVUOOumXO1A9ezjOesQxtzXybp4sGTwsJ5E30DWQhSErxtzmM1g4dmqBxSGWTuAtWGYAA2n9qpRUy3K3Tm4pp1EuZl18FIJtuskGHZHlC1iGLl8yNPD0rbK3Dn4cH2jp2huvo3I8CdXQtWAvPEvDPrUT2xP~NY4E0Q8KGDawTMQ~b-1Qc-qBWwz0EWmyko5tQ2WV34kHgake0D5F18pzOtcLDmi7gKKuCfkkXO06mZtuYvIPVqBmwpjIZ8iIXjWPs9-FCLmiSGAH4qVX-7D92xxmx5Enyb9Uj1l0w__',
                    width: 30,
                    height: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    'https://s3-alpha-sig.figma.com/img/0bb5/8658/7d152b3be40b7bf849a2ed64c5c34fd9?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=b7jwHchguBRgs2jnnOFXQASNstl4t9s1oYwxCTz3vHkQk1RLEcmz2JT9cIcUHlzfVDNo8tUaB79WT0LCyWYw2XYhHqgdahwiQsMKHAobit2oVK7GpIJpI~3CVK6iVsSs9AM12YiGoGk9fLmF0OMVVuuodekET4uS9mkhEw6~AHTWRXPewgmva9liMYUybeexZ0Ti3hjVaT0-MWy8EdR~xyw0uuw89WSQrMhBBFx0ymURPxP2AcB8TBPDzcaG4qZApdqpbX0uy1yuxfTvj-eLgUWRuoGDNiXruzpMDEIeGGHVB-ABDDuy0e~hzemoxHtJYFsCqKehLR8YQUI-unqG2A__',
                    width: 30,
                    height: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    'https://s3-alpha-sig.figma.com/img/d243/ea69/80071ccce519462a946614473e0c2b28?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=X~95XJMSkyonWDPfvlcfKL8~f8incNT4KzZY7uj3SAGzHur3G-gmnrHYpKm6WANGZQNcwPTHUHNPhq-30Lboi1QD4R7wy27e1QtU4s1Y~S-0~MKL92LU3TtnuVmMl3hma6RIQFhH6mPrgjyq-hFHW61eXHCWhwZoWCibnxCK9X1HhmhaOw5C4JiMxG9iM7DJC-AuWgQCk6IKYgKTaf4iEtMt2D~N4zKsfNUxI15a2YW22CnOCGAtUlg3ryrAG7CLMMivj5mcYoteuHiW95jMK2hmW~cFS09xt51Pem96GqW17BJ4M~Pky4FJ1K04h8I1HoMn4EsKxkdMVqSYSTaItA__',
                    width: 30,
                    height: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    'https://s3-alpha-sig.figma.com/img/06e0/1635/20803e55c3d2419edc32c18376ceff06?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=FRVEUNFwHboAPG0~djV63cCrbQP4s4D-ZyEW4veQt5I4Z0XEf1lFqUXAgT5KtOhxTecPJS64Onms41B7EpqWtX0qVZu95O1DLg2PWh3m8TRY4S8W-LdeN9~YO3UGH4gxTx0F88j1BTimL~U~f2tvbcqI5YZeqAGchLaZX6lo7jRbOKbnn11PUj9fB18iJ~sbjR~aCMxgWwPMdlFhpNkif5ik4URYS61X2uF8Vc7qM36BL7YWCQjtxxFLCYC1NEaj9GnbnLv9vuE8aXTzm~oDckShutuOV0QRZv33TnuOVHBmec2m493UVEDcfm9NEF1-yTCOvQc6DJXvaVEfUwaUKA__',
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
