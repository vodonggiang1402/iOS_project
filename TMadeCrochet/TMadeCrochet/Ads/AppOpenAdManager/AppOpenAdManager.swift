//
//  AppOpenAdManager.swift
//  TMadeCrochet
//
//  Created by Ly Nguyen Xuan Thao on 20/7/24.
//

import Foundation
import GoogleMobileAds

class AppOpenAdManager: NSObject, GADFullScreenContentDelegate {
  var appOpenAd: GADAppOpenAd?
  var isLoadingAd = false
  var isShowingAd = false

  static let shared = AppOpenAdManager()

  private func loadAd() async {
    // TODO: Implement loading an ad.
      // Do not load ad if there is an unused ad or one is already loading.
      if isLoadingAd || isAdAvailable() {
        return
      }
      isLoadingAd = true

      do {
        appOpenAd = try await GADAppOpenAd.load(
          withAdUnitID: "ca-app-pub-3940256099942544/5575463023", request: GADRequest())
          appOpenAd?.fullScreenContentDelegate = self
      } catch {
        print("App open ad failed to load with error: \(error.localizedDescription)")
      }
      isLoadingAd = false
  }

  func showAdIfAvailable() {
    // TODO: Implement showing an ad.
      // If the app open ad is already showing, do not show the ad again.
        guard !isShowingAd else { return }

        // If the app open ad is not available yet but is supposed to show, load
        // a new ad.
        if !isAdAvailable() {
          Task {
            await loadAd()
          }
          return
        }

        if let ad = appOpenAd {
          isShowingAd = true
          ad.present(fromRootViewController: nil)
        }
  }

  private func isAdAvailable() -> Bool {
    // Check if ad exists and can be shown.
    return appOpenAd != nil
  }
    
    // MARK: - GADFullScreenContentDelegate methods

     func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
       print("App open ad will be presented.")
     }

     func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
       appOpenAd = nil
       isShowingAd = false
       // Reload an ad.
       Task {
         await loadAd()
       }
     }

     func ad(
       _ ad: GADFullScreenPresentingAd,
       didFailToPresentFullScreenContentWithError error: Error
     ) {
       appOpenAd = nil
       isShowingAd = false
       // Reload an ad.
       Task {
         await loadAd()
       }
     }
}
