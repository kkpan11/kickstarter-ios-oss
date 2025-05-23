import KsApi
import Library
import Prelude
import UIKit

final class PledgeRewardsSummaryTotalViewController: UIViewController {
  // MARK: - Properties

  private lazy var titleAndTotalStackView: UIStackView = { UIStackView(frame: .zero) }()
  private lazy var amountLabel: UILabel = { UILabel(frame: .zero) }()
  private lazy var rootStackView: UIStackView = {
    UIStackView(frame: .zero)
      |> \.translatesAutoresizingMaskIntoConstraints .~ false
  }()

  private lazy var titleLabel: UILabel = { UILabel(frame: .zero) }()
  private lazy var totalConversionLabel: UILabel = { UILabel(frame: .zero) }()
  private lazy var confirmationLabel: UILabel = { UILabel(frame: .zero) }()
  private lazy var totalStackView: UIStackView = { UIStackView(frame: .zero) }()
  private lazy var pledgeOverTimeBadgeView: PledgeOverTimeBadgeView = {
    PledgeOverTimeBadgeView(frame: .zero)
  }()

  private let viewModel: PledgeSummaryViewModelType = PledgeSummaryViewModel()

  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    self.configureSubviews()
    self.bindStyles()

    self.viewModel.inputs.viewDidLoad()
  }

  // MARK: - Styles

  override func bindStyles() {
    _ = self.view
      |> checkoutBackgroundStyle

    _ = self.rootStackView
      |> rootStackViewStyle

    _ = self.titleAndTotalStackView
      |> adaptableStackViewStyle(
        self.traitCollection.preferredContentSizeCategory.isAccessibilityCategory
      )
      |> titleAndTotalStackViewStyle

    _ = self.totalStackView
      |> totalStackViewStyle(self.traitCollection.preferredContentSizeCategory.isAccessibilityCategory)

    _ = self.titleLabel
      |> titleLabelStyle

    _ = self.amountLabel
      |> amountLabelStyle

    _ = self.totalConversionLabel
      |> totalConversionLabelStyle

    applyConfirmationLabelStyle(self.confirmationLabel)
  }

  // MARK: - Configuration

  private func configureSubviews() {
    _ = (self.rootStackView, self.view)
      |> ksr_addSubviewToParent()
      |> ksr_constrainViewToEdgesInParent()

    _ = (
      [self.titleAndTotalStackView, self.pledgeOverTimeBadgeView, self.confirmationLabel],
      self.rootStackView
    )
      |> ksr_addArrangedSubviewsToStackView()

    _ = ([self.titleLabel, self.totalStackView], self.titleAndTotalStackView)
      |> ksr_addArrangedSubviewsToStackView()

    _ = ([self.amountLabel, self.totalConversionLabel], self.totalStackView)
      |> ksr_addArrangedSubviewsToStackView()

    self.pledgeOverTimeBadgeView.isHidden = true
  }

  // MARK: - View model

  internal override func bindViewModel() {
    super.bindViewModel()

    self.viewModel.outputs.titleLabelText
      .observeForUI()
      .observeValues { [weak self] text in
        self?.titleLabel.text = text
      }

    self.amountLabel.rac.attributedText = self.viewModel.outputs.amountLabelAttributedText
    self.totalConversionLabel.rac.text = self.viewModel.outputs.totalConversionLabelText

    self.confirmationLabel.rac.hidden = self.viewModel.outputs.confirmationLabelHidden
    self.confirmationLabel.rac.attributedText = self.viewModel.outputs.confirmationLabelAttributedText

    self.pledgeOverTimeBadgeView.rac.hidden = self.viewModel.outputs.pledgeOverTimeStackViewHidden
    self.viewModel.outputs
      .pledgeOverTimeChargesText
      .observeForUI()
      .observeValues { chargesText in
        self.pledgeOverTimeBadgeView.configure(with: chargesText)
      }
  }

  // MARK: - Configuration

  internal func configure(with data: PledgeSummaryViewData) {
    self.viewModel.inputs.configure(with: data)
  }

  internal func configureWith(pledgeOverTimeData: PledgePaymentPlansAndSelectionData?) {
    self.viewModel.inputs.configureWith(pledgeOverTimeData: pledgeOverTimeData)
  }
}

// MARK: - Styles

private let amountLabelStyle: LabelStyle = { (label: UILabel) in
  _ = label
    |> \.adjustsFontForContentSizeCategory .~ true
    |> \.textAlignment .~ NSTextAlignment.right
    |> \.adjustsFontSizeToFitWidth .~ true
    |> \.isAccessibilityElement .~ true
    |> \.minimumScaleFactor .~ 0.75
    |> \.backgroundColor .~ LegacyColors.ksr_white.uiColor()

  return label
}

private let titleAndTotalStackViewStyle: StackViewStyle = { (stackView: UIStackView) in
  stackView
    |> \.alignment .~ UIStackView.Alignment.top
    |> \.backgroundColor .~ LegacyColors.ksr_white.uiColor()
    |> \.layoutMargins .~ UIEdgeInsets(leftRight: Styles.gridHalf(4))
}

private let rootStackViewStyle: StackViewStyle = { (stackView: UIStackView) in
  stackView
    |> verticalStackViewStyle
    |> \.spacing .~ Styles.grid(3)
    |> \.backgroundColor .~ LegacyColors.ksr_white.uiColor()
    |> \.translatesAutoresizingMaskIntoConstraints .~ false
    |> \.isLayoutMarginsRelativeArrangement .~ true
    |> \.layoutMargins .~ UIEdgeInsets(topBottom: Styles.grid(3), leftRight: Styles.grid(4))
}

private let titleLabelStyle: LabelStyle = { (label: UILabel) -> UILabel in
  _ = label
    |> checkoutTitleLabelStyle
    |> \.font .~ .ksr_subhead().bolded
    |> \.backgroundColor .~ LegacyColors.ksr_white.uiColor()

  return label
}

private let totalConversionLabelStyle: LabelStyle = { label in
  _ = label
    |> \.font .~ .ksr_caption1()
    |> \.textColor .~ LegacyColors.ksr_support_400.uiColor()
    |> \.backgroundColor .~ LegacyColors.ksr_white.uiColor()

  return label
}

private func totalStackViewStyle(_ isAccessibilityCategory: Bool) -> StackViewStyle {
  return { stackView in
    stackView
      |> verticalStackViewStyle
      |> \.backgroundColor .~ LegacyColors.ksr_white.uiColor()
      |> \.spacing .~ Styles.grid(1)
      |> \.alignment .~
      (isAccessibilityCategory ? UIStackView.Alignment.leading : UIStackView.Alignment.trailing)
  }
}

private func applyConfirmationLabelStyle(_ label: UILabel) {
  label.numberOfLines = 0
  label.backgroundColor = LegacyColors.ksr_white.uiColor()
}
