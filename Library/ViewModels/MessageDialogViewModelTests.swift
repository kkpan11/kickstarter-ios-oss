@testable import KsApi
@testable import Library
import Prelude
import ReactiveExtensions_TestHelpers
import ReactiveSwift
import XCTest

internal final class MessageDialogViewModelTests: TestCase {
  fileprivate let vm: MessageDialogViewModelType = MessageDialogViewModel()

  fileprivate let loadingViewIsHidden = TestObserver<Bool, Never>()
  fileprivate let postButtonEnabled = TestObserver<Bool, Never>()
  fileprivate let notifyPresenterCommentWasPostedSuccesfully = TestObserver<Message, Never>()
  fileprivate let notifyPresenterDialogWantsDismissal = TestObserver<(), Never>()
  fileprivate let recipientName = TestObserver<String, Never>()
  fileprivate let keyboardIsVisible = TestObserver<Bool, Never>()
  fileprivate let showAlertMessage = TestObserver<String, Never>()

  override func setUp() {
    super.setUp()

    self.vm.outputs.loadingViewIsHidden.observe(self.loadingViewIsHidden.observer)
    self.vm.outputs.postButtonEnabled.observe(self.postButtonEnabled.observer)
    self.vm.outputs.notifyPresenterCommentWasPostedSuccesfully
      .observe(self.notifyPresenterCommentWasPostedSuccesfully.observer)
    self.vm.outputs.notifyPresenterDialogWantsDismissal
      .observe(self.notifyPresenterDialogWantsDismissal.observer)
    self.vm.outputs.recipientName.observe(self.recipientName.observer)
    self.vm.outputs.keyboardIsVisible.observe(self.keyboardIsVisible.observer)
    self.vm.outputs.showAlertMessage.observe(self.showAlertMessage.observer)
  }

  func testRecipientName() {
    let thread = MessageThread.template
    self.vm.inputs.configureWith(messageSubject: .messageThread(thread), context: .messages)
    self.vm.inputs.viewDidLoad()

    self.recipientName.assertValues([thread.participant.name])
  }

  func testButtonEnabled() {
    self.vm.inputs.configureWith(messageSubject: .messageThread(.template), context: .messages)
    self.vm.inputs.viewDidLoad()
    self.postButtonEnabled.assertValues([false])

    self.vm.inputs.bodyTextChanged("hello")
    self.postButtonEnabled.assertValues([false, true])

    self.vm.inputs.bodyTextChanged("hello world")
    self.postButtonEnabled.assertValues([false, true])

    self.vm.inputs.bodyTextChanged("")
    self.postButtonEnabled.assertValues([false, true, false])

    self.vm.inputs.bodyTextChanged("  ")
    self.postButtonEnabled.assertValues([false, true, false])

    self.vm.inputs.bodyTextChanged("hello world")
    self.postButtonEnabled.assertValues([false, true, false, true])
  }

  func testKeyboardIsVisible() {
    self.vm.inputs.configureWith(messageSubject: .messageThread(.template), context: .messages)
    self.vm.inputs.viewDidLoad()
    self.keyboardIsVisible.assertValues([true])

    self.vm.inputs.cancelButtonPressed()
    self.keyboardIsVisible.assertValues([true, false])

    self.vm.inputs.viewDidLoad()
    self.keyboardIsVisible.assertValues([true, false, true])

    self.vm.inputs.bodyTextChanged("HELLO")
    self.vm.inputs.postButtonPressed()
    self.scheduler.advance()

    self.keyboardIsVisible.assertValues([true, false, true, false])
  }

  func testPostingMessageToThread() {
    XCTAssertEqual([], self.segmentTrackingClient.events)

    self.vm.inputs.configureWith(messageSubject: .messageThread(.template), context: .messages)
    self.vm.inputs.viewDidLoad()

    self.vm.inputs.bodyTextChanged("HELLO")

    self.loadingViewIsHidden.assertValues([true])
    self.notifyPresenterCommentWasPostedSuccesfully.assertValueCount(0)
    self.notifyPresenterDialogWantsDismissal.assertValueCount(0)

    self.vm.inputs.postButtonPressed()

    self.loadingViewIsHidden.assertValues([true, false])
    self.notifyPresenterCommentWasPostedSuccesfully.assertValueCount(0)
    self.notifyPresenterDialogWantsDismissal.assertValueCount(0)

    self.scheduler.advance()

    self.loadingViewIsHidden.assertValues([true, false, true])
    self.notifyPresenterCommentWasPostedSuccesfully.assertValueCount(1)
    self.notifyPresenterDialogWantsDismissal.assertValueCount(1)
  }

  func testPostingMessageToCreator() {
    let project = Project.template
    self.vm.inputs.configureWith(
      messageSubject: .project(id: project.id, name: project.name),
      context: .messages
    )
    self.vm.inputs.viewDidLoad()
    self.vm.inputs.bodyTextChanged("HELLO")

    self.loadingViewIsHidden.assertValues([true])
    self.notifyPresenterCommentWasPostedSuccesfully.assertValueCount(0)
    self.notifyPresenterDialogWantsDismissal.assertValueCount(0)
    self.recipientName.assertValues(["The Project"])

    self.vm.inputs.postButtonPressed()

    self.loadingViewIsHidden.assertValues([true, false])
    self.notifyPresenterCommentWasPostedSuccesfully.assertValueCount(0)
    self.notifyPresenterDialogWantsDismissal.assertValueCount(0)

    self.scheduler.advance()

    self.loadingViewIsHidden.assertValues([true, false, true])
    self.notifyPresenterCommentWasPostedSuccesfully.assertValueCount(1)
    self.notifyPresenterDialogWantsDismissal.assertValueCount(1)
  }
}
