import UIKit

public enum HelpType: SettingsCellTypeProtocol, CaseIterable, Equatable {
  case helpCenter
  case community
  case contact
  case howItWorks
  case terms
  case privacy
  case cookie
  case trust
  case accessibility
  case environment
  case aiDisclosure
  case prohibitedItems

  public static func helpType(from url: URL) -> HelpType? {
    let helpType = HelpType.allCases.filter { helpType in
      url.absoluteString == helpType.url(
        withBaseUrl: AppEnvironment.current.apiService.serverConfig.webBaseUrl
      )?.absoluteString
    }
    .first

    return helpType
  }

  public var accessibilityTraits: UIAccessibilityTraits {
    switch self {
    case .contact:
      return .button
    default:
      return .link
    }
  }

  public var title: String {
    switch self {
    case .helpCenter:
      return Strings.Help_center()
    case .community:
      return ""
    case .contact:
      return Strings.profile_settings_about_contact()
    case .howItWorks:
      return Strings.profile_settings_about_how_it_works()
    case .terms:
      return Strings.profile_settings_about_terms()
    case .privacy:
      return Strings.profile_settings_about_privacy()
    case .cookie:
      return Strings.profile_settings_about_cookie()
    case .trust:
      return ""
    case .accessibility:
      return Strings.Accessibility_statement()
    case .environment:
      return ""
    case .aiDisclosure:
      return ""
    case .prohibitedItems:
      return ""
    }
  }

  public var showArrowImageView: Bool {
    switch self {
    case .contact:
      return false
    default:
      return true
    }
  }

  public var textColor: UIColor {
    return LegacyColors.ksr_support_700.uiColor()
  }

  public func url(withBaseUrl baseUrl: URL) -> URL? {
    switch self {
    case .community:
      return baseUrl.appendingPathComponent("help/community")
    case .cookie:
      return baseUrl.appendingPathComponent("cookies")
    case .contact:
      return nil
    case .helpCenter:
      return baseUrl.appendingPathComponent("help")
    case .howItWorks:
      return baseUrl.appendingPathComponent("about")
    case .privacy:
      return baseUrl.appendingPathComponent("privacy")
    case .terms:
      return baseUrl.appendingPathComponent("terms-of-use")
    case .trust:
      return baseUrl.appendingPathComponent("trust")
    case .accessibility:
      return baseUrl.appendingPathComponent("accessibility")
    case .environment:
      return baseUrl.appendingPathComponent("environment")
    case .aiDisclosure:
      return baseUrl.appendingPathComponent("hc/en-us/articles/16848396410267")
    case .prohibitedItems:
      return baseUrl.appendingPathComponent("rules/prohibited")
    }
  }
}
