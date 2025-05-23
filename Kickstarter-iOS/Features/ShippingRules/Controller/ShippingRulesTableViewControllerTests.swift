@testable import Kickstarter_Framework
@testable import KsApi
@testable import Library
import Prelude
import SnapshotTesting
import UIKit

final class ShippingRulesTableViewControllerTests: TestCase {
  override func setUp() {
    super.setUp()
    UIView.setAnimationsEnabled(false)
  }

  override func tearDown() {
    UIView.setAnimationsEnabled(true)

    super.tearDown()
  }

  func testView() {
    let shippingRule1 = ShippingRule.template
      |> ShippingRule.lens.location .~ .canada

    let shippingRule2 = ShippingRule.template
      |> ShippingRule.lens.location .~ .greatBritain

    let shippingRule3 = ShippingRule.template
      |> ShippingRule.lens.location .~ .usa

    let shippingRules = [shippingRule1, shippingRule2, shippingRule3]
    let selectedShippingRule = shippingRule2

    Device.allCases.forEach { device in
      let vc = ShippingRulesTableViewController.instantiate()
      vc.configureWith(.template, shippingRules: shippingRules, selectedShippingRule: selectedShippingRule)
      let (parent, _) = traitControllers(device: device, orientation: .portrait, child: vc)

      assertSnapshot(matching: parent.view, as: .image, named: "device_\(device)")
    }
  }
}
