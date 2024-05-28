class DecorativeItemModel {
  DecorativeItemModel(this.id, this.imgPath, this.title, this.subtitle, this.date, this.price, this.time);

  final int id;
  final String imgPath;
  final String title;
  final String subtitle;
  final String date;
  final String price;
  final String time;
}

List<DecorativeItemModel> decorativeItems = [
  DecorativeItemModel(
    0,
    'https://s3-alpha-sig.figma.com/img/53a5/3145/feb2184851666f7851298fda9131f8f1?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=LcJW9GjN~IXeWW1PStHAI~Hart5yprU8R-FS1b~tEjOC1-DKZz3DZ8Z9OwZ1RDwdUqoH2YQDS-TeSG3kwivJ9VRHtIQrip0I5DXrgqMWZcL4R9UGwL4BN8bgkPDYlw2ou6Yl-dTOmDKlUrceyj-1Bp9n3u24vAdV4x5kMwxLXIfxAtkZmeUiAVhODsfgfCPn6glMXCsvIAeQC~v9UjyrBlebFyJ~X5zWJMC6Fh9ZEQm7L5GDkAEG7LFg5ePyYtE44q0bKbTmghVfCOvTOuAqMOe0XtEMXDgxOyB~p9y7PDK4AFj4r7c5VYU41tAx1ET-0KZ4w71KQAYK6Sv3A9Xffg__',
    'Bourré, France',
    '8,015 km away',
    'Apr. 19  24',
    '\$154 CAD ',
    'night',
  ),
  DecorativeItemModel(
    1,
    'https://s3-alpha-sig.figma.com/img/d69d/9140/9732bd79b7b8bb8380e213398b1a9b98?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=i-vPWLGdBdCazBuyaRLoDUtSb0ZYLUjru8atB-biiw6uw54tQb~g1EO11MQsh3mLUuTFUcV6vCG0weyjSmbTfnNKk5UKrxSY8yPDWvkKEQ9s3M-Es16U1j8oeOZMWidROlyzAaZN6NNBSwv-mA5pT7TzZ5fRWINmDEECXF3RTYzmX35ItGCJX0qMRx0AD~lH8WbhEjLBMHlK~s-GIHBJUB8cQuatHK75ot44pe-LIfEym4ujnWfGLPb4RlBPSMKeBdAizmAeqNbA9iS5Yy-dEkE19flBVFxREFTmwTSfqaBzR2rGNbPzV41yJ-nEA3Fx~rs-~-FoiKLENw4Sl1mKtQ__',
    'Noyers-sur-Cher, France',
    '8,028 km away',
    'May 19 – 24',
    '\$320 CAD  ',
    'night',
  ),
  DecorativeItemModel(
    2,
    'https://s3-alpha-sig.figma.com/img/15c2/7a15/01e1a11017e78b3a5dc1ee2d20bed59f?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=qf6~UFyXeOffoqVz4uNK12ncvcRiKkAeVfHFlZMqls0PFmO-rbubbtO6M13E6JnguWQk3Ivhm4YoieFJBnAXhn7Lw-YaHnwqVHG0vVyJPD8x7gb9dzPvC3sRi~nPLfSBTBraUJevbxj4yb3WXjaMXIR3LLyI6c1D0OdS6Gl8leWHjrfqlyk85xTW~cT9wdn18Q8wh1pGNBV7NKpizh0e-TqJc6XpeW~Y9XvGMqsCRf6V72VEgGnFDRb3~qXxo1a46KP87CjsdrVAyIZD3ImMSTrox3l~3T3vZB~nc9jyCE4KraM5iCtWYY38PpF-RDvT9aiHXOG9ryNq5rOyFpPdRw__',
    'Cortez, Colorado, US',
    '1,757 km away',
    'Jul. 7 – 12',
    '\$572 CAD  ',
    'night',
  ),
  DecorativeItemModel(
    3,
    'https://s3-alpha-sig.figma.com/img/b135/5ace/f51d97df301041a6552234b204cc89fa?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=nZEkzs0jrQuIadq1LZWQRBoSWnGXB78ruh7MfCn2-LBabGaCWQ5M9lY~y80PdmefJr9Vr691wGvQ97vUxLOubBrayPlzi9fdhr~-Vn5XGLI2KwFSUfeoooennNuQ1BuSJFtJugvk~P2aQu9to~nczRsh-Vl8pcnngYjgDrG3U~uk4bfOmxOHLux1J7eyrCJ8-CB~z0pqrvPdQ929wnyVyN9pzfS8GL32KHwmOUm3iPMauRBh54Qs6pIbf-nGUltXPzx7373WIE8gk1Uk3s8MFO-XiVeuIAzxGqEp2xJRWDT4a4NB~b6p3NULGh9MrYcntkUjNnkhZv~xjhlpDZY0NA__',
    'Los Balcones, Spain',
    '8,725 km away',
    'Apr. 18 – 23',
    '\$304 CAD  ',
    'night',
  ),
  DecorativeItemModel(
    4,
    'https://s3-alpha-sig.figma.com/img/58f5/25ea/6a0a97049865dfd11618355d2d223a22?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=jgZZSYvi5Vp347Tub5iZjvSwhtk1dVw8KI9XxZzfsPzbcSE83aBLZzhtckNtsBMmo20C8aPLyR6Vker3Mb2HQnapP6KYtphtMBZYzxikoYCnTpUSsviCK3pP0iRF74Lzp8p114oKwbn5~6SEUzBz~sWUXoL5681PR8cYNUoKNUzw5H1-9I8Lsq0M-lW5Oc7Aj6Zs9~bl4AAgVdidysvrjG~AQuMfSaAFqHBsrQrBji5WIkLUl~xeTSYca9gPwDOuHokmw8FJHcXVo5AChO1WHp7omp5OpICb~6~C6JbIhTRZQ7Nb06zn6HTTCp2KNm8tthWhZoF7lk4fx-DR6nRllQ__',
    'Roswell, New Mexico, US',
    '2,352 km away',
    'May 2 – 7',
    '\$872 CAD  ',
    'night',
  ),
  DecorativeItemModel(
    5,
    'https://s3-alpha-sig.figma.com/img/f458/894d/c3bf8a9b5364426b9885c5ba3631ba02?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=E-70m9anUjeszyXH5nBg4bnGloGIuU4sKGfnCEYJi-F-gvNNcc83PNeFg42sXtc8HNVIPEMeXiDydOfG6Z5taXMR-C63CaPt6hXWWwYLW16Yydc98Cb2v-m6zCzoGZZW6KxBG8ux0K85GPvNfbVCQKri8EV3pMOlT05VzoO0UsSBPj1rm0xc1a46HkJWpcb104qoThXcGvpxuCg0QpJSYn6hLRSbVMOpzfft7~XrT92kgmyt0~2nkmC~4wxTGxfcCzqw4MKmukJ~UQMfoNxW3MKNiQfJYOMSzzt2QjFnwuB8nRkcnaB~9StUDPKq1TZCFt3k5xFhhxBwpTt2IKWMXA__',
    'Broadway, Virginia, US',
    '3,672 km away',
    'Nov. 30 – Dec. 5',
    '\$276 CAD  ',
    'night',
  ),
  DecorativeItemModel(
    6,
    'https://s3-alpha-sig.figma.com/img/2ad6/96f6/4d98818c7c3af995540a5113a805108f?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=DDmyZHG8MsaqriAYFWxg2P6-1cvbhHSdbEZmZ2yb3KTy1odvouChjFZsA8TRkNb0dTjhtaBBQdkEpgAoqA0gtqF67xXnMIcbSnNFwv97qV99whyb3LwFm0RnjHCk01K6sho~zEz0ipZR329X8h~4tT9IXfNcKmpsv92uUkmAPJG2qKy-~NrxYsU~t9yOqU-vB1L75kX1yNj8OVUSwvnZasoBGyAi1QO01nmWnJrV-TU5uwFWjAMzHogjvoMqWJdMSj48LQENX73gpLjgaKlpsjQ6ve4e4MbJ7OutaC1xFOQICyJbrt9yxUhP~xdP2SE1SSXXlrTr5rpfIKXHvX~hPg__',
    'Jaunay-Marigny, France',
    '8,033 km away',
    'Aug. 26 – 31',
    '\$311 CAD ',
    'night',
  ),
  DecorativeItemModel(
    7,
    'https://s3-alpha-sig.figma.com/img/dec3/6808/c137aeffe23ed9efd8101d1b9902698f?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Pw7MDHFWhG0ZwU4i1R1j23ZP93toJfZ~~vAJ5h1jSfeU4xAi7hdRV2obqini12QGkGv6VXXcRo9~fLH2EG7o8H-HT3iSQGyB3e~Gz-G526AP0hT4otZlYh6s3WCmdmPZpGLdB8pt71~yumHlfSMKZZmivF~ERaP0ICxgZbtzWfmjjWDzNfydJyc03zy0BpiW5YeJ46z4IVD6Fd-A0fXH6P30CA3hsg7qY4CjlZ6GMCGD-hUlNYYX6MCrUBnERnETiLb~aLgGHAD-Rhmxj~ntDc5V0HjWnRBozT5RmfzlSexa09aOJAMjVJQ-Cqi1ecS0sCkOTM~crOO4RRJ~kiUZeA__',
    'Villarrubia, Spain',
    '8,585 km away',
    'May 2 – 7',
    '\$343 CAD  ',
    'night',
  ),
];
