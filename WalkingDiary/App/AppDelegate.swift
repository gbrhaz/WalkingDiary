//
//  AppDelegate.swift
//  WalkingDiary
//
//  Created by Harry Richardson on 08/052021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white

        let httpClient = DefaultHttpClient()
        let thresholdDistance = Distance(value: 100, unit: .metres)

        let walkViewController = WalkViewController(
            viewModel: WalkViewModel(
                photoStream: LocationBasedPhotoStream(
                    intermittentPhotoProvider: UserLocationBasedIntermittentPhotoProvider(
                        locationService: DefaultUserLocationService(distanceFilter: thresholdDistance),
                        locationPhotoProvider: FlickrPhotoService(
                            client: DefaultFlickrClient(
                                httpClient: httpClient,
                                apiKey: AppConfig.flickrAPIKey
                            )
                        ),
                        distanceThreshold: thresholdDistance
                    ), dataFetcher: DataFetcher(httpClient: httpClient)
                )
            )
        )

        let navController = UINavigationController(rootViewController: walkViewController)
        window?.rootViewController = navController
        
        window?.makeKeyAndVisible()
        return true
    }


}

