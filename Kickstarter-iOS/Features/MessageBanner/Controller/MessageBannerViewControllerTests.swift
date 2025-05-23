@testable import Kickstarter_Framework
@testable import KsApi
import Library
import Prelude
import SnapshotTesting
import XCTest

internal final class MessageBannerViewControllerTests: TestCase {
  override func setUp() {
    super.setUp()
    UIView.setAnimationsEnabled(false)
  }

  override func tearDown() {
    UIView.setAnimationsEnabled(true)
    super.tearDown()
  }

  func testBannerSuccess() {
    combos(Language.allLanguages, [Device.phone4_7inch, Device.phone5_8inch, Device.pad]).forEach {
      language, device in
      withEnvironment(language: language) {
        let nibName = Nib.MessageBannerViewController.rawValue
        let messageBannerVC = MessageBannerViewController(
          nibName: nibName,
          bundle: .framework
        )

        let (parent, _) = traitControllers(device: device, orientation: .portrait, child: messageBannerVC)
        parent.view.frame.size.height = 200

        messageBannerVC.showBanner(with: .success, message: Strings.Got_it_your_changes_have_been_saved())

        scheduler.run()
        scheduler.advance()

        assertSnapshot(matching: parent.view, as: .image, named: "lang_\(language)_device_\(device)")
      }
    }
  }

  func testBannerError() {
    combos(Language.allLanguages, [Device.phone4_7inch, Device.phone5_8inch, Device.pad]).forEach {
      language, device in
      withEnvironment(language: language) {
        let nibName = Nib.MessageBannerViewController.rawValue
        let messageBannerVC = MessageBannerViewController(
          nibName: nibName,
          bundle: .framework
        )

        let (parent, _) = traitControllers(device: device, orientation: .portrait, child: messageBannerVC)
        parent.view.frame.size.height = 200

        messageBannerVC.showBanner(with: .error, message: Strings.Something_went_wrong_please_try_again())

        scheduler.run()
        scheduler.advance()

        assertSnapshot(matching: parent.view, as: .image, named: "lang_\(language)_device_\(device)")
      }
    }
  }

  func testBannerInfo() {
    combos(Language.allLanguages, [Device.phone4_7inch, Device.phone5_8inch, Device.pad]).forEach {
      language, device in
      withEnvironment(language: language) {
        let nibName = Nib.MessageBannerViewController.rawValue
        let messageBannerVC = MessageBannerViewController(
          nibName: nibName,
          bundle: .framework
        )

        let (parent, _) = traitControllers(device: device, orientation: .portrait, child: messageBannerVC)
        parent.view.frame.size.height = 200

        messageBannerVC.showBanner(with: .info, message: Strings.Verification_email_sent())

        scheduler.run()
        scheduler.advance()

        assertSnapshot(matching: parent.view, as: .image, named: "lang_\(language)_device_\(device)")
      }
    }
  }
}
