import FBSDKCoreKit
import FirebaseCrashlytics
import Foundation
import KsApi
import Prelude
import ReactiveSwift

/**
 A global stack that captures the current state of global objects that the app wants access to.
 */
public struct AppEnvironment: AppEnvironmentType {
  internal static let environmentStorageKey = "com.kickstarter.AppEnvironment.current"
  internal static let oauthTokenStorageKey = "com.kickstarter.AppEnvironment.oauthToken"

  /**
   A global stack of environments.
   */
  fileprivate static var stack: [Environment] = [Environment()]

  /**
   Invoke when an access token has been acquired and you want to log the user in. Replaces the current
   environment with a new one that has the authenticated api service and current user model.

   - parameter envelope: An access token envelope with the api access token and user.
   */
  public static func login(_ envelope: AccessTokenEnvelope) {
    self.replaceCurrentEnvironment(
      apiService: self.current.apiService.login(OauthToken(token: envelope.accessToken)),
      currentUser: envelope.user,
      ksrAnalytics: self.current.ksrAnalytics |> KSRAnalytics.lens.loggedInUser .~ envelope.user
    )
  }

  /**
   Invoke when we have acquired a fresh current user and you want to replace the current environment's
   current user with the fresh one.

   - parameter user: A user model.
   */
  public static func updateCurrentUser(_ user: User) {
    self.replaceCurrentEnvironment(
      currentUser: user,
      ksrAnalytics: self.current.ksrAnalytics |> KSRAnalytics.lens.loggedInUser .~ user
    )
  }

  /**
   Invoke when we have acquired a fresh current user and you want to replace the current environment's
   current user email with the fresh one.

   - parameter email: A string.
   */
  public static func updateCurrentUserEmail(_ email: String) {
    self.replaceCurrentEnvironment(
      currentUserEmail: email
    )
  }

  public static func updatecurrentUserServerFeatures(_ features: Set<ServerFeature>) {
    self.replaceCurrentEnvironment(
      currentUserServerFeatures: features
    )
  }

  public static func updateAppTrackingTransparency(_ appTrackingTransparency: AppTrackingTransparencyType) {
    self.replaceCurrentEnvironment(
      appTrackingTransparency: appTrackingTransparency
    )
  }

  public static func updateDebugData(_ debugData: DebugData) {
    self.replaceCurrentEnvironment(
      debugData: debugData
    )
  }

  public static func updateRemoteConfigClient(_ remoteConfigClient: RemoteConfigClientType?) {
    self.replaceCurrentEnvironment(
      remoteConfigClient: remoteConfigClient
    )
  }

  public static func updateServerConfig(_ config: ServerConfigType) {
    let service = Service(serverConfig: config)

    self.replaceCurrentEnvironment(
      apiService: service
    )
  }

  public static func updateConfig(_ config: Config) {
    let debugConfigOrConfig = self.current.debugData?.config ?? config

    self.replaceCurrentEnvironment(
      config: debugConfigOrConfig,
      countryCode: debugConfigOrConfig.countryCode,
      ksrAnalytics: AppEnvironment.current.ksrAnalytics |> KSRAnalytics.lens.config .~ debugConfigOrConfig
    )
  }

  public static func updateLanguage(_ language: Language) {
    self.replaceCurrentEnvironment(language: language)
  }

  // Invoke when you want to end the user's session.
  public static func logout() {
    let storage = AppEnvironment.current.cookieStorage
    storage.cookies?.forEach(storage.deleteCookie)

    // Resetting the segment client
    AppEnvironment.current.ksrAnalytics.identify(newUser: nil)
    self.replaceCurrentEnvironment(
      apiService: AppEnvironment.current.apiService.logout(),
      cache: type(of: AppEnvironment.current.cache).init(),
      currentUser: nil,
      currentUserEmail: nil,
      currentUserPPOSettings: nil,
      currentUserServerFeatures: nil,
      ksrAnalytics: self.current.ksrAnalytics |> KSRAnalytics.lens.loggedInUser .~ nil
    )
  }

  // The most recent environment on the stack.
  public static var current: Environment! {
    return stack.last
  }

  // Push a new environment onto the stack.
  public static func pushEnvironment(_ env: Environment) {
    self.saveEnvironment(
      environment: env, ubiquitousStore: env.ubiquitousStore, userDefaults: env.userDefaults
    )
    self.stack.append(env)
  }

  // Pop an environment off the stack.
  @discardableResult
  public static func popEnvironment() -> Environment? {
    let last = self.stack.popLast()
    let next = self.current ?? Environment()
    self.saveEnvironment(
      environment: next,
      ubiquitousStore: next.ubiquitousStore,
      userDefaults: next.userDefaults
    )

    // If there are no more items in the stack,
    // then the next call to AppEvironment.current will fail.
    assert(self.stack.count > 0)

    return last
  }

  internal static func resetStackForUnitTests() {
    while self.stack.count > 1 {
      _ = self.stack.popLast()
    }

    let next = Environment()
    self.replaceCurrentEnvironment(next)
  }

  // Replace the current environment with a new environment.
  public static func replaceCurrentEnvironment(_ env: Environment) {
    self.pushEnvironment(env)
    self.stack.remove(at: self.stack.count - 2)
  }

  // Pushes a new environment onto the stack that changes only a subset of the current global dependencies.
  public static func pushEnvironment(
    apiService: ServiceType = AppEnvironment.current.apiService,
    apiDelayInterval: DispatchTimeInterval = AppEnvironment.current.apiDelayInterval,
    applePayCapabilities: ApplePayCapabilitiesType = AppEnvironment.current.applePayCapabilities,
    application: UIApplicationType = UIApplication.shared,
    appTrackingTransparency: AppTrackingTransparencyType = AppEnvironment.current.appTrackingTransparency,
    assetImageGeneratorType: AssetImageGeneratorType.Type = AppEnvironment.current.assetImageGeneratorType,
    cache: KSCache = AppEnvironment.current.cache,
    calendar: Calendar = AppEnvironment.current.calendar,
    colorResolver: ColorResolverType = AppEnvironment.current.colorResolver,
    config: Config? = AppEnvironment.current.config,
    cookieStorage: HTTPCookieStorageProtocol = AppEnvironment.current.cookieStorage,
    coreTelephonyNetworkInfo: CoreTelephonyNetworkInfoType = AppEnvironment.current.coreTelephonyNetworkInfo,
    countryCode: String = AppEnvironment.current.countryCode,
    currentUser: User? = AppEnvironment.current.currentUser,
    dateType: DateProtocol.Type = AppEnvironment.current.dateType,
    debounceInterval: DispatchTimeInterval = AppEnvironment.current.debounceInterval,
    debugData: DebugData? = AppEnvironment.current.debugData,
    device: UIDeviceType = AppEnvironment.current.device,
    isVoiceOverRunning: @escaping (() -> Bool) = AppEnvironment.current.isVoiceOverRunning,
    ksrAnalytics: KSRAnalytics = AppEnvironment.current.ksrAnalytics,
    language: Language = AppEnvironment.current.language,
    launchedCountries: LaunchedCountries = AppEnvironment.current.launchedCountries,
    locale: Locale = AppEnvironment.current.locale,
    mainBundle: NSBundleType = AppEnvironment.current.mainBundle,
    pushRegistrationType: PushRegistrationType.Type = AppEnvironment.current.pushRegistrationType,
    reachability: SignalProducer<Reachability, Never> = AppEnvironment.current.reachability,
    remoteConfigClient: RemoteConfigClientType? = AppEnvironment.current.remoteConfigClient,
    scheduler: DateScheduler = AppEnvironment.current.scheduler,
    ubiquitousStore: KeyValueStoreType = AppEnvironment.current.ubiquitousStore,
    userDefaults: KeyValueStoreType = AppEnvironment.current.userDefaults,
    uuidType: UUIDType.Type = AppEnvironment.current.uuidType
  ) {
    self.pushEnvironment(
      Environment(
        apiService: apiService,
        apiDelayInterval: apiDelayInterval,
        applePayCapabilities: applePayCapabilities,
        application: application,
        appTrackingTransparency: appTrackingTransparency,
        assetImageGeneratorType: assetImageGeneratorType,
        cache: cache,
        calendar: calendar,
        colorResolver: colorResolver,
        config: config,
        cookieStorage: cookieStorage,
        coreTelephonyNetworkInfo: coreTelephonyNetworkInfo,
        countryCode: countryCode,
        currentUser: currentUser,
        dateType: dateType,
        debounceInterval: debounceInterval,
        debugData: debugData,
        device: device,
        isVoiceOverRunning: isVoiceOverRunning,
        ksrAnalytics: ksrAnalytics,
        language: language,
        launchedCountries: launchedCountries,
        locale: locale,
        mainBundle: mainBundle,
        pushRegistrationType: pushRegistrationType,
        reachability: reachability,
        remoteConfigClient: remoteConfigClient,
        scheduler: scheduler,
        ubiquitousStore: ubiquitousStore,
        userDefaults: userDefaults,
        uuidType: uuidType
      )
    )
  }

  // Replaces the current environment onto the stack with an environment that changes only a subset
  // of current global dependencies.
  public static func replaceCurrentEnvironment(
    apiService: ServiceType = AppEnvironment.current.apiService,
    apiDelayInterval: DispatchTimeInterval = AppEnvironment.current.apiDelayInterval,
    applePayCapabilities: ApplePayCapabilitiesType = AppEnvironment.current.applePayCapabilities,
    application: UIApplicationType = UIApplication.shared,
    appTrackingTransparency: AppTrackingTransparencyType = AppEnvironment.current.appTrackingTransparency,
    assetImageGeneratorType: AssetImageGeneratorType.Type = AppEnvironment.current.assetImageGeneratorType,
    cache: KSCache = AppEnvironment.current.cache,
    calendar: Calendar = AppEnvironment.current.calendar,
    colorResolver: ColorResolverType = AppEnvironment.current.colorResolver,
    config: Config? = AppEnvironment.current.config,
    cookieStorage: HTTPCookieStorageProtocol = AppEnvironment.current.cookieStorage,
    coreTelephonyNetworkInfo: CoreTelephonyNetworkInfoType = AppEnvironment.current.coreTelephonyNetworkInfo,
    countryCode: String = AppEnvironment.current.countryCode,
    currentUser: User? = AppEnvironment.current.currentUser,
    currentUserEmail: String? = AppEnvironment.current.currentUserEmail,
    currentUserPPOSettings: PPOUserSettings? = AppEnvironment.current.currentUserPPOSettings,
    currentUserServerFeatures: Set<ServerFeature>? = AppEnvironment.current.currentUserServerFeatures,
    dateType: DateProtocol.Type = AppEnvironment.current.dateType,
    debounceInterval: DispatchTimeInterval = AppEnvironment.current.debounceInterval,
    debugData: DebugData? = AppEnvironment.current.debugData,
    device: UIDeviceType = AppEnvironment.current.device,
    isVoiceOverRunning: @escaping (() -> Bool) = AppEnvironment.current.isVoiceOverRunning,
    ksrAnalytics: KSRAnalytics = AppEnvironment.current.ksrAnalytics,
    language: Language = AppEnvironment.current.language,
    launchedCountries: LaunchedCountries = AppEnvironment.current.launchedCountries,
    locale: Locale = AppEnvironment.current.locale,
    mainBundle: NSBundleType = AppEnvironment.current.mainBundle,
    pushRegistrationType: PushRegistrationType.Type = AppEnvironment.current.pushRegistrationType,
    reachability: SignalProducer<Reachability, Never> = AppEnvironment.current.reachability,
    remoteConfigClient: RemoteConfigClientType? = AppEnvironment.current.remoteConfigClient,
    scheduler: DateScheduler = AppEnvironment.current.scheduler,
    ubiquitousStore: KeyValueStoreType = AppEnvironment.current.ubiquitousStore,
    userDefaults: KeyValueStoreType = AppEnvironment.current.userDefaults,
    uuidType: UUIDType.Type = AppEnvironment.current.uuidType
  ) {
    self.replaceCurrentEnvironment(
      Environment(
        apiService: apiService,
        apiDelayInterval: apiDelayInterval,
        applePayCapabilities: applePayCapabilities,
        application: application,
        appTrackingTransparency: appTrackingTransparency,
        assetImageGeneratorType: assetImageGeneratorType,
        cache: cache,
        calendar: calendar,
        colorResolver: colorResolver,
        config: config,
        cookieStorage: cookieStorage,
        coreTelephonyNetworkInfo: coreTelephonyNetworkInfo,
        countryCode: countryCode,
        currentUser: currentUser,
        currentUserEmail: currentUserEmail,
        currentUserPPOSettings: currentUserPPOSettings,
        currentUserServerFeatures: currentUserServerFeatures,
        dateType: dateType,
        debounceInterval: debounceInterval,
        debugData: debugData,
        device: device,
        isVoiceOverRunning: isVoiceOverRunning,
        ksrAnalytics: ksrAnalytics,
        language: language,
        launchedCountries: launchedCountries,
        locale: locale,
        mainBundle: mainBundle,
        pushRegistrationType: pushRegistrationType,
        reachability: reachability,
        remoteConfigClient: remoteConfigClient,
        scheduler: scheduler,
        ubiquitousStore: ubiquitousStore,
        userDefaults: userDefaults,
        uuidType: uuidType
      )
    )
  }

  internal static let accountNameForKeychain = "kickstarter_currently_logged_in_user"

  private static func storeOAuthTokenToKeychain(_ oauthToken: String) -> Bool {
    guard featureUseKeychainForOAuthTokenEnabled()
    else {
      return false
    }

    do {
      try Keychain.storePassword(oauthToken, forAccount: self.accountNameForKeychain)
      return true
    } catch {
      Crashlytics.crashlytics().record(error: error)
    }

    return false
  }

  private static func fetchOAuthTokenFromKeychain() -> String? {
    guard featureUseKeychainForOAuthTokenEnabled()
    else {
      return nil
    }

    do {
      return try Keychain.fetchPassword(forAccount: self.accountNameForKeychain)
    } catch {
      Crashlytics.crashlytics().record(error: error)
    }

    return nil
  }

  private static func removeOAuthTokenFromKeychain() -> Bool {
    guard featureUseKeychainForOAuthTokenEnabled() else { return false }

    do {
      try Keychain.deletePassword(forAccount: self.accountNameForKeychain)
      return true
    } catch {
      Crashlytics.crashlytics().record(error: error)
    }

    return false
  }

  // Returns the last saved environment from user defaults.
  public static func fromStorage(
    ubiquitousStore _: KeyValueStoreType,
    userDefaults: KeyValueStoreType
  ) -> Environment {
    let data = userDefaults.dictionary(forKey: self.environmentStorageKey) ?? [:]

    var service = self.current.apiService
    var currentUser: User? // Will only be set if an OAuth token is also set
    var currentUserServerFeatures: [ServerFeature]? // Will only be set if an OAuth token is also set
    let configDict: [String: Any]? = data["config"] as? [String: Any]
    let config: Config? = configDict.flatMap(Config.decodeJSONDictionary)

    // If there is an oauth token stored, then we can authenticate our api service

    if let oauthToken = fetchOAuthTokenFromKeychain() {
      service = service.login(OauthToken(token: oauthToken))
    } else if let oauthToken = data["apiService.oauthToken.token"] as? String {
      service = service.login(OauthToken(token: oauthToken))
    }

    // Try restoring the client id for the api service
    if let clientId = data["apiService.serverConfig.apiClientAuth.clientId"] as? String {
      service = Service(
        serverConfig: ServerConfig(
          apiBaseUrl: service.serverConfig.apiBaseUrl,
          webBaseUrl: service.serverConfig.webBaseUrl,
          apiClientAuth: ClientAuth(clientId: clientId),
          basicHTTPAuth: service.serverConfig.basicHTTPAuth,
          graphQLEndpointUrl: service.serverConfig.graphQLEndpointUrl
        ),
        oauthToken: service.oauthToken,
        language: self.current.language.rawValue,
        currency: self.current.locale.currencyCode ?? "USD"
      )
    }

    // Try restoring the base urls for the api service
    if let apiBaseUrlString = data["apiService.serverConfig.apiBaseUrl"] as? String,
       let apiBaseUrl = URL(string: apiBaseUrlString),
       let webBaseUrlString = data["apiService.serverConfig.webBaseUrl"] as? String,
       let webBaseUrl = URL(string: webBaseUrlString) {
      service = Service(
        serverConfig: ServerConfig(
          apiBaseUrl: apiBaseUrl,
          webBaseUrl: webBaseUrl,
          apiClientAuth: service.serverConfig.apiClientAuth,
          basicHTTPAuth: service.serverConfig.basicHTTPAuth,
          graphQLEndpointUrl: service.serverConfig.graphQLEndpointUrl
        ),
        oauthToken: service.oauthToken,
        language: self.current.language.rawValue,
        currency: self.current.locale.currencyCode ?? "USD"
      )
    }

    // Try restoring the basic auth data for the api service
    if let username = data["apiService.serverConfig.basicHTTPAuth.username"] as? String,
       let password = data["apiService.serverConfig.basicHTTPAuth.password"] as? String {
      service = Service(
        serverConfig: ServerConfig(
          apiBaseUrl: service.serverConfig.apiBaseUrl,
          webBaseUrl: service.serverConfig.webBaseUrl,
          apiClientAuth: service.serverConfig.apiClientAuth,
          basicHTTPAuth: BasicHTTPAuth(username: username, password: password),
          graphQLEndpointUrl: service.serverConfig.graphQLEndpointUrl
        ),
        oauthToken: service.oauthToken,
        language: self.current.language.rawValue,
        currency: self.current.locale.currencyCode ?? "USD"
      )
    }

    // Try restoring the environment
    if let environment = data["apiService.serverConfig.environment"] as? String,
       let environmentType = EnvironmentType(rawValue: environment) {
      let serverConfig = ServerConfig.config(for: environmentType)

      service = Service(
        serverConfig: serverConfig,
        oauthToken: service.oauthToken,
        language: self.current.language.rawValue,
        currency: self.current.locale.currencyCode ?? "USD"
      )
    }

    // Try restore the current user
    if service.oauthToken != nil {
      currentUser = data["currentUser"].flatMap(tryDecode)
      currentUserServerFeatures = (data["currentUserServerFeatures"] as? [String])?
        .compactMap { ServerFeature(rawValue: $0) }
    }

    // Try restore the PPO settings
    let currentUserPPOSettings: PPOUserSettings? = data["currentUserPPOSettings"].flatMap(tryDecode)

    return Environment(
      apiService: service,
      config: config,
      currentUser: currentUser,
      currentUserPPOSettings: currentUserPPOSettings,
      currentUserServerFeatures: currentUserServerFeatures.flatMap(Set.init),
      ksrAnalytics: self.current.ksrAnalytics |> KSRAnalytics.lens.loggedInUser .~ currentUser |> KSRAnalytics
        .lens.appTrackingTransparency .~ self.current.appTrackingTransparency
    )
  }

  // Saves some key data for the current environment
  internal static func saveEnvironment(
    environment env: Environment = AppEnvironment.current,
    ubiquitousStore _: KeyValueStoreType,
    userDefaults: KeyValueStoreType
  ) {
    var data: [String: Any] = [:]

    // swiftformat:disable wrap

    if let oauthToken = env.apiService.oauthToken?.token {
      // Try to save to the keychain, but if that fails, save to user defaults
      if !self.storeOAuthTokenToKeychain(oauthToken) {
        data["apiService.oauthToken.token"] = oauthToken
      }
    } else {
      _ = self.removeOAuthTokenFromKeychain()
    }

    data["apiService.serverConfig.apiBaseUrl"] = env.apiService.serverConfig.apiBaseUrl.absoluteString
    data["apiService.serverConfig.apiClientAuth.clientId"] = env.apiService.serverConfig.apiClientAuth.clientId
    data["apiService.serverConfig.basicHTTPAuth.username"] = env.apiService.serverConfig.basicHTTPAuth?.username
    data["apiService.serverConfig.basicHTTPAuth.password"] = env.apiService.serverConfig.basicHTTPAuth?.password
    data["apiService.serverConfig.webBaseUrl"] = env.apiService.serverConfig.webBaseUrl.absoluteString
    data["apiService.serverConfig.environment"] = env.apiService.serverConfig.environment.description
    data["apiService.language"] = env.apiService.language
    data["apiService.currency"] = env.apiService.currency
    data["config"] = env.config?.encode()
    data["currentUser"] = env.currentUser?.encode()
    data["currentUserServerFeatures"] = env.currentUserServerFeatures?.map { $0.rawValue }
    data["currentUserPPOSettings"] = env.currentUserPPOSettings?.encode()
    // swiftformat:enable wrap

    userDefaults.set(data, forKey: self.environmentStorageKey)
  }
}
