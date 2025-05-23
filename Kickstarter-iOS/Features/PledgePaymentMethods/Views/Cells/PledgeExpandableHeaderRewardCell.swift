import Library
import Prelude
import UIKit

final class PledgeExpandableHeaderRewardCell: UITableViewCell, ValueCell {
  // MARK: - Properties

  private lazy var amountLabel: UILabel = UILabel(frame: .zero)
  private lazy var rootStackView: UIStackView = UIStackView(frame: .zero)
  private lazy var titleLabel: UILabel = UILabel(frame: .zero)

  private let viewModel: PledgeExpandableHeaderRewardCellViewModelType
    = PledgeExpandableHeaderRewardCellViewModel()

  // MARK: - Lifecycle

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    self.configureViews()
    self.bindViewModel()
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Styles

  override func bindStyles() {
    super.bindStyles()

    _ = self
      |> \.selectionStyle .~ .none
      |> \.separatorInset .~ .init(leftRight: CheckoutConstants.PledgeView.Inset.leftRight)

    _ = self.amountLabel
      |> UILabel.lens.contentHuggingPriority(for: .horizontal) .~ .required
      |> \.adjustsFontForContentSizeCategory .~ true

    _ = self.rootStackView
      |> rootStackViewStyle(self.traitCollection.preferredContentSizeCategory > .accessibilityLarge)

    _ = self.titleLabel
      |> titleLabelStyle
  }

  // MARK: - View model

  override func bindViewModel() {
    super.bindViewModel()

    self.amountLabel.rac.attributedText = self.viewModel.outputs.amountAttributedText

    self.viewModel.outputs.labelText
      .observeForUI()
      .observeValues { [weak self] titleText in
        self?.titleLabel.text = titleText
        self?.titleLabel.setNeedsLayout()
      }
  }

  // MARK: - Configuration

  func configureWith(value: PledgeSummaryRewardCellData) {
    self.viewModel.inputs.configure(with: value)

    self.contentView.layoutIfNeeded()
  }

  private func configureViews() {
    _ = (self.rootStackView, self.contentView)
      |> ksr_addSubviewToParent()
      |> ksr_constrainViewToEdgesInParent()

    _ = ([self.titleLabel, self.amountLabel], self.rootStackView)
      |> ksr_addArrangedSubviewsToStackView()
  }
}

// MARK: - Styles

private let titleLabelStyle: LabelStyle = { label in
  label
    |> \.font .~ UIFont.ksr_subhead().bolded
    |> \.textColor .~ LegacyColors.ksr_support_400.uiColor()
    |> \.numberOfLines .~ 0
}

private func rootStackViewStyle(_ isAccessibilityCategory: Bool) -> (StackViewStyle) {
  let alignment: UIStackView.Alignment = (isAccessibilityCategory ? .leading : .top)
  let axis: NSLayoutConstraint.Axis = (isAccessibilityCategory ? .vertical : .horizontal)
  let distribution: UIStackView.Distribution = (isAccessibilityCategory ? .equalSpacing : .fill)
  let spacing: CGFloat = (isAccessibilityCategory ? Styles.grid(1) : 0)

  return { (stackView: UIStackView) in
    stackView
      |> \.insetsLayoutMarginsFromSafeArea .~ false
      |> \.alignment .~ alignment
      |> \.axis .~ axis
      |> \.distribution .~ distribution
      |> \.spacing .~ spacing
      |> \.isLayoutMarginsRelativeArrangement .~ true
      |> \.layoutMargins .~ .init(
        topBottom: Styles.grid(3),
        leftRight: CheckoutConstants.PledgeView.Inset.leftRight
      )
  }
}
