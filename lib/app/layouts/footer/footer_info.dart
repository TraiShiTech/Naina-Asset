import 'package:flutter/material.dart';
import 'package:properties/core/core.dart';

import '../../../core/utils/methods.dart';
import '../../../core/utils/metrics.dart';

class FooterInfo extends StatelessWidget {
  const FooterInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pad = normalize(min: 976, max: 1440, data: Metrics.width(context));

    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: 20 + 10 * pad),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Image.network(
                    "https://s3-alpha-sig.figma.com/img/5da3/4bc4/1fbe5a4bd62aa21042bda5592db20d39?Expires=1716163200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=geKrfG~kUGFIFaThNK326NB9Xq-JXVPXqv69fq2oQWE0VhdxWskf354YLvNhQIm3EYT7zvTsMgDa5YStFmeYsFLS814xjFEKXVgLwjOxHlkPe1IeLMZppAMlrqx4v8ncGKbxTLCORQl7Er60asGy1b70hV21bYVYNHOldpvm3n6A8Cgt6rEhdrz1L4jpxv8Ye9RdJCgpb7OVElv6G8lvvnof0oUPTld4j1raiV8EpyuLJp4EhUuEsT-Mg2LgfJLuAeuIhc7xh-8UhOX7vV7YhuPAnHNz6ufW5tB6hQQw9BEqXBEh205iMqvnxp9TAuSUVdUBsWbathZzvvL~QL7Bcw__",
                    // .icon,
                    width: 36,
                    height: 36,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    isAntiAlias: true,
                  ),
                ),
                const SizedBox(width: 16),
                'Naina Asset'.poppins(
                  color: white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  height: 1.5,
                ),
              ],
            ),
            SizedBox(height: 24 + 8 * pad),
            '+1 (885) 589 69 85'.poppins(
              color: white,
              fontWeight: FontWeight.w500,
              fontSize: 14 + 4 * pad,
              height: 1.5,
            ),
            SizedBox(height: 16 + 8 * pad),
            'info@ventura.com'.poppins(
              color: white,
              fontWeight: FontWeight.w500,
              fontSize: 14 + 4 * pad,
              height: 1.5,
            ),
            SizedBox(height: 16 + 8 * pad),
            'Ms. Alice Smith Apartment 1C 213 Derrick Street Boston, MA 02130 USA'
                .poppins(
              color: white,
              fontWeight: FontWeight.w500,
              fontSize: 13 + 3 * pad,
              height: 1.5,
            ),
          ],
        ),
      ),
    );
  }
}
