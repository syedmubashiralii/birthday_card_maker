import 'dart:io';

class AdIds {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2408614506049729/5855530943';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-2408614506049729/8889081834';
    }
    return "";
  }

  static String get startint {
    if (Platform.isAndroid) {
      return 'ca-app-pub-6044006890313003/2672553425';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-2408614506049729/4411614928';
    }
    return "";
  }

  static String get backint {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2408614506049729/6288966829';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-2408614506049729/6071346800';
    }
    return "";
  }

  static String get cardselectionint {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2408614506049729/4788005281';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-2408614506049729/2633012286';
    }
    return "";
  }

  static String get editingint {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2408614506049729/2065816637';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-2408614506049729/8505938459';
    }
    return "";
  }

  static String get albumint {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2408614506049729/5813489955';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-2408614506049729/7228779136';
    }
    return "";
  }

  static String get applovinint {
    return 'd4c24bfd0bf46cc5';
  }
}
