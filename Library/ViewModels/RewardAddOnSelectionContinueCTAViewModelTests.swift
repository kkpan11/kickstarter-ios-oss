import Foundation
@testable import KsApi
@testable import Library
import Prelude
import ReactiveExtensions
import ReactiveExtensions_TestHelpers
import ReactiveSwift
import XCTest

final class RewardAddOnSelectionContinueCTAViewModelTests: TestCase {
  private let vm: RewardAddOnSelectionContinueCTAViewModelType = RewardAddOnSelectionContinueCTAViewModel()

  private let buttonEnabled = TestObserver<Bool, Never>()
  private let buttonTitle = TestObserver<String, Never>()
  private let isLoading = TestObserver<Bool, Never>()

  override func setUp() {
    super.setUp()

    self.vm.outputs.buttonEnabled.observe(self.buttonEnabled.observer)
    self.vm.outputs.buttonTitle.observe(self.buttonTitle.observer)
    self.vm.outputs.isLoading.observe(self.isLoading.observer)
  }

  func testButtonEnabled_Valid() {
    self.buttonEnabled.assertDidNotEmitValue()

    self.vm.inputs.configure(with: (0, true, false, nil))

    self.buttonEnabled.assertValues([true])
  }

  func testButtonEnabled_Invalid() {
    self.buttonEnabled.assertDidNotEmitValue()

    self.vm.inputs.configure(with: (0, false, false, nil))

    self.buttonEnabled.assertValues([false])
  }

  func testButtonIsLoading_IsLoading() {
    self.isLoading.assertDidNotEmitValue()

    self.vm.inputs.configure(with: (0, true, true, nil))

    self.isLoading.assertValues([true])
  }

  func testButtonIsLoading_IsNotLoading() {
    self.isLoading.assertDidNotEmitValue()

    self.vm.inputs.configure(with: (0, false, false, nil))

    self.isLoading.assertValues([false])
  }

  func testButtonTitle() {
    self.buttonTitle.assertDidNotEmitValue()

    self.vm.inputs.configure(with: (0, true, false, nil))

    self.buttonTitle.assertValues(["Continue"])

    self.vm.inputs.configure(with: (2, true, false, nil))

    self.buttonTitle.assertValues(["Continue", "Continue with 2 add-ons"])

    self.vm.inputs.configure(with: (0, true, false, nil))

    self.buttonTitle.assertValues(["Continue", "Continue with 2 add-ons", "Continue"])

    self.vm.inputs.configure(with: (1, true, false, nil))

    self.buttonTitle.assertValues([
      "Continue",
      "Continue with 2 add-ons",
      "Continue",
      "Continue with 1 add-on"
    ])
  }
}
