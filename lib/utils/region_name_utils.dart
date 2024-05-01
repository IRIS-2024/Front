import 'package:iris_flutter/config/region_list.dart';

import 'conversion_utils.dart';

String concatRegionNames(String region1D, String region2D) {
  final shortRegion1D = convertRegionNameToShort(region1D);
  if (region1DepthWithout2Depth.contains(shortRegion1D)) {
    return shortRegion1D;
  } else {
    return '$shortRegion1D $region2D';
  }
}

List<String> splitRegionNames(String concatedRegion) {
  List<String> regions = concatedRegion.split(' ');
  if (regions.length == 1) {
    return [regions[0], ''];
  } else {
    return [regions[0], regions[1]];
  }
}