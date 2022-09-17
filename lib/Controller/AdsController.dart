import 'package:birthday_app_new/Views/LandingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../Ads/Adsids.dart';

class get_ads extends ChangeNotifier {
  bool loading = true;
  // banner at home page
  late BannerAd homepage_Banner;
  bool ishomepagebanner = false;
  late BannerAd landingpage_banner;
  bool islandingpagebanner = false;
  late BannerAd category_pagebanner;
  bool iscategorypagebanner = false;
  late BannerAd anniversary_page_banner;
  bool isanniversarypagebanner = false;
  late BannerAd birthday_page_banner;
  bool isbirthdaypagebanner = false;
  late BannerAd cardswcake_banner;
  bool iscardwcakebanner = false;
  late BannerAd cardswocake_banner;
  bool iscardwocakebanner = false;
  late BannerAd songslist_banner;
  bool issongslistbanner = false;
  late BannerAd reminderlist_banner;
  bool isreminderlistbanner = false;
  late BannerAd addreminder_banner;
  bool isaddreminderbanner = false;
  late BannerAd musicplayer_banner;
  bool ismusicplayerbanner = false;
    late BannerAd album_banner;
  bool isalbumbanner = false;

  onloading() async {
    loading = true;
    await Future.delayed(const Duration(milliseconds: 2000));
    loading = false;
    EasyLoading.showSuccess("Done", duration: Duration(seconds: 1));
    notifyListeners();
  }
  albumbanner() {
    print("get_banner_add called");
    album_banner = BannerAd(
      // Change Banner Size According to Ur Need
      size: AdSize.banner,
      adUnitId: AdIds.bannerAdUnitId,
      request: request,
      listener: BannerAdListener(onAdLoaded: (_) {
        print("Successfully Load A Banner Ad");
        isalbumbanner = true;
        notifyListeners();
      }, onAdFailedToLoad: (ad, LoadAdError error) {
        print("Failed to Load A Banner Ad = ${error}");
        isalbumbanner = false;
        notifyListeners();
        ad.dispose();
      }),
    );
    album_banner.load();
  }


  musicplayerbanner() {
    print("get_banner_add called");
    musicplayer_banner = BannerAd(
      // Change Banner Size According to Ur Need
      size: AdSize.banner,
      adUnitId: AdIds.bannerAdUnitId,
      request: request,
      listener: BannerAdListener(onAdLoaded: (_) {
        print("Successfully Load A Banner Ad");
        ismusicplayerbanner = true;
        notifyListeners();
      }, onAdFailedToLoad: (ad, LoadAdError error) {
        print("Failed to Load A Banner Ad = ${error}");
        ismusicplayerbanner = false;
        notifyListeners();
        ad.dispose();
      }),
    );
    musicplayer_banner.load();
  }

  addreminderbanner() {
    print("get_banner_add called");
    addreminder_banner = BannerAd(
      // Change Banner Size According to Ur Need
      size: AdSize.banner,
      adUnitId: AdIds.bannerAdUnitId,
      request: request,
      listener: BannerAdListener(onAdLoaded: (_) {
        print("Successfully Load A Banner Ad");
        isaddreminderbanner = true;
        notifyListeners();
      }, onAdFailedToLoad: (ad, LoadAdError error) {
        print("Failed to Load A Banner Ad = ${error}");
        isaddreminderbanner = false;
        notifyListeners();
        ad.dispose();
      }),
    );
    addreminder_banner.load();
  }

  Reminderlistbanner() {
    print("get_banner_add called");
    reminderlist_banner = BannerAd(
      // Change Banner Size According to Ur Need
      size: AdSize.banner,
      adUnitId: AdIds.bannerAdUnitId,
      request: request,
      listener: BannerAdListener(onAdLoaded: (_) {
        print("Successfully Load A Banner Ad");
        isreminderlistbanner = true;
        notifyListeners();
      }, onAdFailedToLoad: (ad, LoadAdError error) {
        print("Failed to Load A Banner Ad = ${error}");
        isreminderlistbanner = false;
        notifyListeners();
        ad.dispose();
      }),
    );
    reminderlist_banner.load();
  }

  Songslistbanner() {
    print("get_banner_add called");
    songslist_banner = BannerAd(
      // Change Banner Size According to Ur Need
      size: AdSize.banner,
      adUnitId: AdIds.bannerAdUnitId,
      request: request,
      listener: BannerAdListener(onAdLoaded: (_) {
        print("Successfully Load A Banner Ad");
        issongslistbanner = true;
        notifyListeners();
      }, onAdFailedToLoad: (ad, LoadAdError error) {
        print("Failed to Load A Banner Ad = ${error}");
        issongslistbanner = false;
        notifyListeners();
        ad.dispose();
      }),
    );
    songslist_banner.load();
  }

  cardswithoutcakebanner() {
    print("get_banner_add called");
    cardswocake_banner = BannerAd(
      // Change Banner Size According to Ur Need
      size: AdSize.banner,
      adUnitId: AdIds.bannerAdUnitId,
      request: request,
      listener: BannerAdListener(onAdLoaded: (_) {
        print("Successfully Load A Banner Ad");
        iscardwocakebanner = true;
        notifyListeners();
      }, onAdFailedToLoad: (ad, LoadAdError error) {
        print("Failed to Load A Banner Ad = ${error}");
        iscardwocakebanner = false;
        notifyListeners();
        ad.dispose();
      }),
    );
    cardswocake_banner.load();
  }

  cardswithcakebanner() {
    print("get_banner_add called");
    cardswcake_banner = BannerAd(
      // Change Banner Size According to Ur Need
      size: AdSize.banner,
      adUnitId: AdIds.bannerAdUnitId,
      request: request,
      listener: BannerAdListener(onAdLoaded: (_) {
        print("Successfully Load A Banner Ad");
        iscardwcakebanner = true;
        notifyListeners();
      }, onAdFailedToLoad: (ad, LoadAdError error) {
        print("Failed to Load A Banner Ad = ${error}");
        iscardwcakebanner = false;
        notifyListeners();
        ad.dispose();
      }),
    );
    cardswcake_banner.load();
  }

  greetingCategoryBanner() {
    print("get_banner_add called");
    category_pagebanner = BannerAd(
      // Change Banner Size According to Ur Need
      size: AdSize.banner,
      adUnitId: AdIds.bannerAdUnitId,
      request: request,
      listener: BannerAdListener(onAdLoaded: (_) {
        print("Successfully Load A Banner Ad");
        iscategorypagebanner = true;
        notifyListeners();
      }, onAdFailedToLoad: (ad, LoadAdError error) {
        print("Failed to Load A Banner Ad = ${error}");
        iscategorypagebanner = false;
        notifyListeners();
        ad.dispose();
      }),
    );
    category_pagebanner.load();
  }

  anniversarypagebanner() {
    print("get_banner_add called");
    anniversary_page_banner = BannerAd(
      // Change Banner Size According to Ur Need
      size: AdSize.banner,
      adUnitId: AdIds.bannerAdUnitId,
      request: request,
      listener: BannerAdListener(onAdLoaded: (_) {
        print("Successfully Load A Banner Ad");
        isanniversarypagebanner = true;
        notifyListeners();
      }, onAdFailedToLoad: (ad, LoadAdError error) {
        print("Failed to Load A Banner Ad = ${error}");
        isanniversarypagebanner = false;
        notifyListeners();
        ad.dispose();
      }),
    );
    anniversary_page_banner.load();
  }

  birthdaypageabnner() {
    print("get_banner_add called");
    birthday_page_banner = BannerAd(
      // Change Banner Size According to Ur Need
      size: AdSize.banner,
      adUnitId: AdIds.bannerAdUnitId,
      request: request,
      listener: BannerAdListener(onAdLoaded: (_) {
        print("Successfully Load A Banner Ad");
        isbirthdaypagebanner = true;
        notifyListeners();
      }, onAdFailedToLoad: (ad, LoadAdError error) {
        print("Failed to Load A Banner Ad = ${error}");
        isbirthdaypagebanner = false;
        notifyListeners();
        ad.dispose();
      }),
    );
    birthday_page_banner.load();
  }

  HomePagebanner() {
    print("get_banner_add called");
    homepage_Banner = BannerAd(
      // Change Banner Size According to Ur Need
      size: AdSize.banner,
      adUnitId: AdIds.bannerAdUnitId,
      request: request,
      listener: BannerAdListener(onAdLoaded: (_) {
        print("Successfully Load A Banner Ad");
        ishomepagebanner = true;
        notifyListeners();
      }, onAdFailedToLoad: (ad, LoadAdError error) {
        print("Failed to Load A Banner Ad = ${error}");
        ishomepagebanner = false;
        notifyListeners();
        ad.dispose();
      }),
    );
    homepage_Banner.load();
  }

  //Loading home page banner
  homepage_banner_load() {
    homepage_Banner.load();
    // notifyListeners();
  }

  landingpagebanner() {
    print("get_banner_add called");
    landingpage_banner = BannerAd(
      // Change Banner Size According to Ur Need
      size: AdSize.banner,
      adUnitId: AdIds.bannerAdUnitId,
      request: request,
      listener: BannerAdListener(onAdLoaded: (_) {
        print("Successfully Load A Banner Ad");
        islandingpagebanner = true;
        notifyListeners();
      }, onAdFailedToLoad: (ad, LoadAdError error) {
        print("Failed to Load A Banner Ad = ${error}");
        islandingpagebanner = false;
        notifyListeners();
        ad.dispose();
      }),
    );
    landingpage_banner.load();
  }

  //Loading home page banner
  LandingPage_banner_load() {
    landingpage_banner.load();
    // notifyListeners();
  }

  static AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  InterstitialAd? interstitialStartEndAd;
  InterstitialAd? albumint;
  InterstitialAd? backint;
  InterstitialAd? cardint;
  int _numInterstitialLoadAttempts = 0;
  int maxFailedLoadAttempts = 3;

  createInterstitialStartEndAd() {
    InterstitialAd.load(
        adUnitId: AdIds.startint,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('\n $ad loaded');
            interstitialStartEndAd = ad;
            _numInterstitialLoadAttempts = 0;
            interstitialStartEndAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('\nInterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            interstitialStartEndAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              createInterstitialStartEndAd();
            }
          },
        ));
  }
  createalbumint() {
    InterstitialAd.load(
        adUnitId: AdIds.albumint,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('\n $ad loaded');
            albumint = ad;
            _numInterstitialLoadAttempts = 0;
            albumint!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('\nInterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            albumint = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              createalbumint();
            }
          },
        ));
  }

   createBackInterstitialad() {
    InterstitialAd.load(
        adUnitId: AdIds.backint,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('\n $ad loaded');
            backint = ad;
            _numInterstitialLoadAttempts = 0;
            backint!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('\nInterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            backint = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              createBackInterstitialad();
            }
          },
        ));
  }

   CreateCardInterstitial() {
    InterstitialAd.load(
        adUnitId: AdIds.cardselectionint,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('\n $ad loaded');
            cardint = ad;
            _numInterstitialLoadAttempts = 0;
            cardint!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('\nInterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            cardint = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              CreateCardInterstitial();
            }
          },
        ));
  }

    showalbumint() {
    if (albumint == null) {
      print('\nWarning: attempt to show interstitial before loaded.');
      return;
    }
    albumint!.fullScreenContentCallback =
        FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('\nad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createalbumint();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createalbumint();
      },
    );
    albumint!.show();
    albumint = null;
  }

  showInterstitialStartEndAd() {
    if (interstitialStartEndAd == null) {
      print('\nWarning: attempt to show interstitial before loaded.');
      return;
    }
    interstitialStartEndAd!.fullScreenContentCallback =
        FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('\nad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitialStartEndAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialStartEndAd();
      },
    );
    interstitialStartEndAd!.show();
    interstitialStartEndAd = null;
  }

   showbackinterstitial() {
    if (backint == null) {
      print('\nWarning: attempt to show interstitial before loaded.');
      return;
    }
    backint!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('\nad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createBackInterstitialad();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createBackInterstitialad();
      },
    );
    backint!.show();
    backint = null;
  }

   showcardinterstitialad() {
    if (cardint == null) {
      print('\nWarning: attempt to show interstitial before loaded.');
      return;
    }
    cardint!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('\nad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        CreateCardInterstitial;
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        CreateCardInterstitial();
      },
    );
    cardint!.show();
    cardint = null;
  }
}
