import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:properties/core/core.dart';

import '../../aboutus_all.dart';
import '../../asset_all.dart';
import '../../blog.dart';
import '../../rent_all.dart';
import '../../widgets/base_container.dart';
import '../../widgets/icon_btn.dart';
import '../../with_us.dart';

class Appbar extends StatefulWidget {
  const Appbar({super.key});

  @override
  State<Appbar> createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
// class Appbar extends StatefulWidget {
//   const Appbar({
//     Key? key,
//   }) : super(key: key);
  bool dropbar = false;
  @override
  Widget build(BuildContext context) {
    final bool isBigScreen = Metrics.isDesktop(context) || Metrics.isTablet(context);
    List<String> links = [
      // 'Rent',
      // 'Property Management Services',
      'List with Us',
      'About Us',
      'Blogs',
      // 'Contact Us'
    ];
    return Column(
      children: [
        BaseContainer(
          child: Container(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: (Metrics.isDesktop(context) || Metrics.isTablet(context)) ? 80 : 60,
                      height: (Metrics.isDesktop(context) || Metrics.isTablet(context)) ? 80 : 60,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://s3-alpha-sig.figma.com/img/5da3/4bc4/1fbe5a4bd62aa21042bda5592db20d39?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=geKrfG~kUGFIFaThNK326NB9Xq-JXVPXqv69fq2oQWE0VhdxWskf354YLvNhQIm3EYT7zvTsMgDa5YStFmeYsFLS814xjFEKXVgLwjOxHlkPe1IeLMZppAMlrqx4v8ncGKbxTLCORQl7Er60asGy1b70hV21bYVYNHOldpvm3n6A8Cgt6rEhdrz1L4jpxv8Ye9RdJCgpb7OVElv6G8lvvnof0oUPTld4j1raiV8EpyuLJp4EhUuEsT-Mg2LgfJLuAeuIhc7xh-8UhOX7vV7YhuPAnHNz6ufW5tB6hQQw9BEqXBEh205iMqvnxp9TAuSUVdUBsWbathZzvvL~QL7Bcw__"),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          filterQuality: FilterQuality.high,
                          isAntiAlias: true,
                        ),
                      ),
                    ),
                    // Image.network(
                    //   'https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/ChatGPT_logo.svg/1200px-ChatGPT_logo.svg.png'
                    //       .icon,
                    //   width: 36,
                    //   height: 36,
                    //   fit: BoxFit.cover,
                    //   filterQuality: FilterQuality.high,
                    //   isAntiAlias: true,
                    // ),
                    SizedBox(
                      width: isBigScreen == Metrics.isTablet(context)
                          ? Metrics.isMobile(context)
                              ? 0
                              : 10
                          : 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        'Naina Asset'.poppins(
                          color: white,
                          fontWeight: FontWeight.w600,
                          // fontWeight: FontWeight.bold,
                          fontSize: (Metrics.isDesktop(context) || Metrics.isTablet(context))
                              ? 16
                              : Metrics.isMobile(context)
                                  ? 10
                                  : 24,
                          height: 1.5,
                        ),
                        'ในนา แอสเสท - บริการดูแลพร็อพเพอร์ตี้มืออาชีพ '.poppins(
                          color: white,
                          fontWeight: FontWeight.w100,
                          fontSize: (Metrics.isDesktop(context) || Metrics.isTablet(context))
                              ? 14
                              : Metrics.isMobile(context)
                                  ? 8
                                  : 10,
                          height: 1.5,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (Metrics.isDesktop(context) || Metrics.isTablet(context))
                      Container(
                        height: 40,
                        width: 1.5,
                        color: white.withOpacity(1),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                    if (Metrics.isDesktop(context) || Metrics.isTablet(context))
// <<<<<<< HEAD
                      Padding(
                        padding: EdgeInsets.only(left: 0),
                        child: TextButton(
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RentAll(),
                              ),
                            );
                          },
                          child: 'Rent'.poppins(
                            fontWeight: FontWeight.w500,
                            color: white,
                            fontSize: 16,
                            height: 1.5,
// =======
//                       ...List.generate(links.length, (index) {
//                         final link = links[index];

//                         return Padding(
//                           padding: EdgeInsets.only(left: index != 0 ? 24 : 0),
//                           child: TextButton(
//                             onPressed: () {
//                               // List<String> links = [
//                               //   'Rent',
//                               //   'Property Management Services',
//                               //   'List with Us',
//                               //   'About Us',
//                               //   // 'Contact Us'
//                               // ];
//                               if (index == 0) {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => RentAll(),
//                                   ),
//                                 );
//                               } else if (index == 1) {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => AssetAll(),
//                                   ),
//                                 );
//                               } else if (index == 2) {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => WistUs(),
//                                   ),
//                                 );
//                               } else if (index == 3) {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => AboutUs_All(),
//                                   ),
//                                 );
//                               } else if (index == 4) {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => BlogAll(),
//                                   ),
//                                 );
//                               }
//                             },
//                             child: link.poppins(
//                               fontWeight: FontWeight.w500,
//                               color: white,
//                               fontSize: 16,
//                               height: 1.5,
//                             ),
// >>>>>>> upstream/main
                          ),
                        ),
                      ),
                    if (Metrics.isDesktop(context) || Metrics.isTablet(context))
                      Container(
                        height: 40,
                        width: 1.5,
                        color: white.withOpacity(1),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                    if (Metrics.isDesktop(context) || Metrics.isTablet(context))
                      Padding(
                        padding: EdgeInsets.only(left: 0, right: 10),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AssetAll(),
                              ),
                            );
                          },
                          child: 'Property Management Services'.poppins(
                            fontWeight: FontWeight.w500,
                            color: white,
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ),
                    // if (Metrics.isDesktop(context) || Metrics.isTablet(context))
                    //   Padding(
                    //     padding: const EdgeInsets.only(left: 8.0),
                    //     child: IconBtn(
                    //       icon: FontAwesomeIcons.bars,
                    //       onTap: () {},
                    //     ),
                    //   ),
                    if (Metrics.isDesktop(context) || Metrics.isTablet(context))
                      ...List.generate(links.length, (index) {
                        final link = links[index];

                        return Padding(
                          padding: EdgeInsets.only(left: 24),
                          child: TextButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                                ),
                                backgroundColor: index == 0
                                    ? MaterialStateProperty.all<Color>(Color.fromRGBO(40, 53, 80, 1))
                                    : MaterialStateProperty.all<Color>(Color.fromRGBO(211, 211, 211, 1)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                )),
                            onPressed: () {
                              if (index == 0) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WistUs(),
                                  ),
                                );
                              } else if (index == 1) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AboutUs_All(),
                                  ),
                                );
                              } else if (index == 2) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlogAll(),
                                  ),
                                );
                              }
                            },
                            child: link.poppins(
                              fontWeight: FontWeight.w500,
                              color: index == 0 ? white : Color.fromRGBO(77, 74, 74, 1),
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                        );
                      }),
                    if (Metrics.isDesktop(context) || Metrics.isTablet(context))
                      Container(
                        height: 35,
                        width: 2,
                        color: white.withOpacity(0),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                    // IconBtn(
                    //   width: 20,
                    //   icon: FontAwesomeIcons.bars,
                    //   // icon: FontAwesomeIcons.magnifyingGlass,
                    //   onTap: () {},
                    // ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          dropbar = dropbar == true ? false : true;
                          print(dropbar);
                        });
                      },
                      child: Padding(
                        padding: isBigScreen == Metrics.isTablet(context) ? EdgeInsets.all(4.0) : EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.all(4),
                              height: 1.5,
                              width: 30,
                              color: white,
                            ),
                            Container(
                              margin: EdgeInsets.all(4),
                              height: 1.5,
                              width: 30,
                              color: white,
                            ),
                            Container(
                              margin: EdgeInsets.all(4),
                              height: 1.5,
                              width: 30,
                              color: white,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        if (!Metrics.isDesktop(context) && dropbar == true)
          Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RentAll(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: 'Rent'.poppins(color: white),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AssetAll(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: 'Property Management Services'.poppins(color: white),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WistUs(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: 'List with Us'.poppins(color: white),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutUs_All(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: 'About Us'.poppins(color: white),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlogAll(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: 'Blogs'.poppins(color: white),
                ),
              ),
            ],
          ),
        Container(
          width: Metrics.width(context),
          height: 1,
          // color: greenlight,
        ),
      ],
    );
  }
}
