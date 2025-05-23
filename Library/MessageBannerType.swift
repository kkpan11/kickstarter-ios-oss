import UIKit

public enum MessageBannerType {
  case success
  case error
  case info

  var backgroundColor: UIColor {
    switch self {
    case .success:
      return LegacyColors.ksr_trust_500.uiColor()
    case .error:
      return LegacyColors.ksr_alert.uiColor()
    case .info:
      return LegacyColors.ksr_trust_500.uiColor()
    }
  }

  var iconImageName: String? {
    switch self {
    case .success:
      return "icon--confirmation"
    case .error:
      return "icon--alert"
    default:
      return nil
    }
  }

  var iconImageTintColor: UIColor? {
    switch self {
    case .success, .info, .error:
      return LegacyColors.ksr_white.uiColor()
    }
  }

  var textColor: UIColor {
    switch self {
    case .success, .info, .error:
      return LegacyColors.ksr_white.uiColor()
    }
  }

  var textAlignment: NSTextAlignment {
    switch self {
    case .info:
      return .center
    default:
      return .left
    }
  }

  var shouldShowIconImage: Bool {
    switch self {
    case .info:
      return false
    default:
      return true
    }
  }
}
