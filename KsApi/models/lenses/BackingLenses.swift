import Foundation
import Prelude

extension Backing {
  public enum lens {
    public static let addOns = Lens<Backing, [Reward]?>(
      view: { $0.addOns },
      set: { Backing(
        addOns: $0,
        amount: $1.amount,
        backer: $1.backer,
        backerId: $1.backerId,
        backerCompleted: $1.backerCompleted,
        backingDetailsPageRoute: $1.backingDetailsPageRoute,
        bonusAmount: $1.bonusAmount,
        cancelable: $1.cancelable,
        id: $1.id,
        isLatePledge: $1.isLatePledge,
        locationId: $1.locationId,
        locationName: $1.locationName,
        order: $1.order,
        paymentIncrements: $1.paymentIncrements,
        paymentSource: $1.paymentSource,
        pledgedAt: $1.pledgedAt,
        projectCountry: $1.projectCountry,
        projectId: $1.projectId,
        reward: $1.reward,
        rewardsAmount: $1.rewardsAmount,
        rewardId: $1.rewardId,
        sequence: $1.sequence,
        shippingAmount: $1.shippingAmount,
        status: $1.status
      ) }
    )

    public static let amount = Lens<Backing, Double>(
      view: { $0.amount },
      set: { Backing(
        addOns: $1.addOns,
        amount: $0,
        backer: $1.backer,
        backerId: $1.backerId,
        backerCompleted: $1.backerCompleted,
        backingDetailsPageRoute: $1.backingDetailsPageRoute,
        bonusAmount: $1.bonusAmount,
        cancelable: $1.cancelable,
        id: $1.id,
        isLatePledge: $1.isLatePledge,
        locationId: $1.locationId,
        locationName: $1.locationName,
        order: $1.order,
        paymentIncrements: $1.paymentIncrements,
        paymentSource: $1.paymentSource,
        pledgedAt: $1.pledgedAt,
        projectCountry: $1.projectCountry,
        projectId: $1.projectId,
        reward: $1.reward,
        rewardsAmount: $1.rewardsAmount,
        rewardId: $1.rewardId,
        sequence: $1.sequence,
        shippingAmount: $1.shippingAmount,
        status: $1.status
      ) }
    )

    public static let backer = Lens<Backing, User?>(
      view: { $0.backer },
      set: { Backing(
        addOns: $1.addOns,
        amount: $1.amount,
        backer: $0,
        backerId: $1.backerId,
        backerCompleted: $1.backerCompleted,
        backingDetailsPageRoute: $1.backingDetailsPageRoute,
        bonusAmount: $1.bonusAmount,
        cancelable: $1.cancelable,
        id: $1.id,
        isLatePledge: $1.isLatePledge,
        locationId: $1.locationId,
        locationName: $1.locationName,
        order: $1.order,
        paymentIncrements: $1.paymentIncrements,
        paymentSource: $1.paymentSource,
        pledgedAt: $1.pledgedAt,
        projectCountry: $1.projectCountry,
        projectId: $1.projectId,
        reward: $1.reward,
        rewardsAmount: $1.rewardsAmount,
        rewardId: $1.rewardId,
        sequence: $1.sequence,
        shippingAmount: $1.shippingAmount,
        status: $1.status
      ) }
    )

    public static let backerId = Lens<Backing, Int>(
      view: { $0.backerId },
      set: { Backing(
        addOns: $1.addOns,
        amount: $1.amount,
        backer: $1.backer,
        backerId: $0,
        backerCompleted: $1.backerCompleted,
        backingDetailsPageRoute: $1.backingDetailsPageRoute,
        bonusAmount: $1.bonusAmount,
        cancelable: $1.cancelable,
        id: $1.id,
        isLatePledge: $1.isLatePledge,
        locationId: $1.locationId,
        locationName: $1.locationName,
        order: $1.order,
        paymentIncrements: $1.paymentIncrements,
        paymentSource: $1.paymentSource,
        pledgedAt: $1.pledgedAt,
        projectCountry: $1.projectCountry,
        projectId: $1.projectId,
        reward: $1.reward,
        rewardsAmount: $1.rewardsAmount,
        rewardId: $1.rewardId,
        sequence: $1.sequence,
        shippingAmount: $1.shippingAmount,
        status: $1.status
      ) }
    )

    public static let backerCompleted = Lens<Backing, Bool?>(
      view: { $0.backerCompleted },
      set: { Backing(
        addOns: $1.addOns,
        amount: $1.amount,
        backer: $1.backer,
        backerId: $1.backerId,
        backerCompleted: $0,
        backingDetailsPageRoute: $1.backingDetailsPageRoute,
        bonusAmount: $1.bonusAmount,
        cancelable: $1.cancelable,
        id: $1.id,
        isLatePledge: $1.isLatePledge,
        locationId: $1.locationId,
        locationName: $1.locationName,
        order: $1.order,
        paymentIncrements: $1.paymentIncrements,
        paymentSource: $1.paymentSource,
        pledgedAt: $1.pledgedAt,
        projectCountry: $1.projectCountry,
        projectId: $1.projectId,
        reward: $1.reward,
        rewardsAmount: $1.rewardsAmount,
        rewardId: $1.rewardId,
        sequence: $1.sequence,
        shippingAmount: $1.shippingAmount,
        status: $1.status
      ) }
    )

    public static let backingDetailsUrl = Lens<Backing, String>(
      view: { $0.backingDetailsPageRoute },
      set: { Backing(
        addOns: $1.addOns,
        amount: $1.amount,
        backer: $1.backer,
        backerId: $1.backerId,
        backerCompleted: $1.backerCompleted,
        backingDetailsPageRoute: $0,
        bonusAmount: $1.bonusAmount,
        cancelable: $1.cancelable,
        id: $1.id,
        isLatePledge: $1.isLatePledge,
        locationId: $1.locationId,
        locationName: $1.locationName,
        order: $1.order,
        paymentIncrements: $1.paymentIncrements,
        paymentSource: $1.paymentSource,
        pledgedAt: $1.pledgedAt,
        projectCountry: $1.projectCountry,
        projectId: $1.projectId,
        reward: $1.reward,
        rewardsAmount: $1.rewardsAmount,
        rewardId: $1.rewardId,
        sequence: $1.sequence,
        shippingAmount: $1.shippingAmount,
        status: $1.status
      ) }
    )

    public static let bonusAmount = Lens<Backing, Double>(
      view: { $0.bonusAmount },
      set: { Backing(
        addOns: $1.addOns,
        amount: $1.amount,
        backer: $1.backer,
        backerId: $1.backerId,
        backerCompleted: $1.backerCompleted,
        backingDetailsPageRoute: $1.backingDetailsPageRoute,
        bonusAmount: $0,
        cancelable: $1.cancelable,
        id: $1.id,
        isLatePledge: $1.isLatePledge,
        locationId: $1.locationId,
        locationName: $1.locationName,
        order: $1.order,
        paymentIncrements: $1.paymentIncrements,
        paymentSource: $1.paymentSource,
        pledgedAt: $1.pledgedAt,
        projectCountry: $1.projectCountry,
        projectId: $1.projectId,
        reward: $1.reward,
        rewardsAmount: $1.rewardsAmount,
        rewardId: $1.rewardId,
        sequence: $1.sequence,
        shippingAmount: $1.shippingAmount,
        status: $1.status
      ) }
    )

    public static let cancelable = Lens<Backing, Bool>(
      view: { $0.cancelable },
      set: { Backing(
        addOns: $1.addOns,
        amount: $1.amount,
        backer: $1.backer,
        backerId: $1.backerId,
        backerCompleted: $1.backerCompleted,
        backingDetailsPageRoute: $1.backingDetailsPageRoute,
        bonusAmount: $1.bonusAmount,
        cancelable: $0,
        id: $1.id,
        isLatePledge: $1.isLatePledge,
        locationId: $1.locationId,
        locationName: $1.locationName,
        order: $1.order,
        paymentIncrements: $1.paymentIncrements,
        paymentSource: $1.paymentSource,
        pledgedAt: $1.pledgedAt,
        projectCountry: $1.projectCountry,
        projectId: $1.projectId,
        reward: $1.reward,
        rewardsAmount: $1.rewardsAmount,
        rewardId: $1.rewardId,
        sequence: $1.sequence,
        shippingAmount: $1.shippingAmount,
        status: $1.status
      ) }
    )

    public static let id = Lens<Backing, Int>(
      view: { $0.id },
      set: { Backing(
        addOns: $1.addOns,
        amount: $1.amount,
        backer: $1.backer,
        backerId: $1.backerId,
        backerCompleted: $1.backerCompleted,
        backingDetailsPageRoute: $1.backingDetailsPageRoute,
        bonusAmount: $1.bonusAmount,
        cancelable: $1.cancelable,
        id: $0,
        isLatePledge: $1.isLatePledge,
        locationId: $1.locationId,
        locationName: $1.locationName,
        order: $1.order,
        paymentIncrements: $1.paymentIncrements,
        paymentSource: $1.paymentSource,
        pledgedAt: $1.pledgedAt,
        projectCountry: $1.projectCountry,
        projectId: $1.projectId,
        reward: $1.reward,
        rewardsAmount: $1.rewardsAmount,
        rewardId: $1.rewardId,
        sequence: $1.sequence,
        shippingAmount: $1.shippingAmount,
        status: $1.status
      ) }
    )

    public static let isLatePledge = Lens<Backing, Bool>(
      view: { $0.isLatePledge },
      set: { Backing(
        addOns: $1.addOns,
        amount: $1.amount,
        backer: $1.backer,
        backerId: $1.backerId,
        backerCompleted: $1.backerCompleted,
        backingDetailsPageRoute: $1.backingDetailsPageRoute,
        bonusAmount: $1.bonusAmount,
        cancelable: $1.cancelable,
        id: $1.id,
        isLatePledge: $0,
        locationId: $1.locationId,
        locationName: $1.locationName,
        order: $1.order,
        paymentIncrements: $1.paymentIncrements,
        paymentSource: $1.paymentSource,
        pledgedAt: $1.pledgedAt,
        projectCountry: $1.projectCountry,
        projectId: $1.projectId,
        reward: $1.reward,
        rewardsAmount: $1.rewardsAmount,
        rewardId: $1.rewardId,
        sequence: $1.sequence,
        shippingAmount: $1.shippingAmount,
        status: $1.status
      ) }
    )

    public static let locationId = Lens<Backing, Int?>(
      view: { $0.locationId },
      set: { Backing(
        addOns: $1.addOns,
        amount: $1.amount,
        backer: $1.backer,
        backerId: $1.backerId,
        backerCompleted: $1.backerCompleted,
        backingDetailsPageRoute: $1.backingDetailsPageRoute,
        bonusAmount: $1.bonusAmount,
        cancelable: $1.cancelable,
        id: $1.id,
        isLatePledge: $1.isLatePledge,
        locationId: $0,
        locationName: $1.locationName,
        order: $1.order,
        paymentIncrements: $1.paymentIncrements,
        paymentSource: $1.paymentSource,
        pledgedAt: $1.pledgedAt,
        projectCountry: $1.projectCountry,
        projectId: $1.projectId,
        reward: $1.reward,
        rewardsAmount: $1.rewardsAmount,
        rewardId: $1.rewardId,
        sequence: $1.sequence,
        shippingAmount: $1.shippingAmount,
        status: $1.status
      ) }
    )

    public static let paymentSource = Lens<Backing, Backing.PaymentSource?>(
      view: { $0.paymentSource },
      set: { Backing(
        addOns: $1.addOns,
        amount: $1.amount,
        backer: $1.backer,
        backerId: $1.backerId,
        backerCompleted: $1.backerCompleted,
        backingDetailsPageRoute: $1.backingDetailsPageRoute,
        bonusAmount: $1.bonusAmount,
        cancelable: $1.cancelable,
        id: $1.id,
        isLatePledge: $1.isLatePledge,
        locationId: $1.locationId,
        locationName: $1.locationName,
        order: $1.order,
        paymentIncrements: $1.paymentIncrements,
        paymentSource: $0,
        pledgedAt: $1.pledgedAt,
        projectCountry: $1.projectCountry,
        projectId: $1.projectId,
        reward: $1.reward,
        rewardsAmount: $1.rewardsAmount,
        rewardId: $1.rewardId,
        sequence: $1.sequence,
        shippingAmount: $1.shippingAmount,
        status: $1.status
      ) }
    )

    public static let locationName = Lens<Backing, String?>(
      view: { $0.locationName },
      set: { Backing(
        addOns: $1.addOns,
        amount: $1.amount,
        backer: $1.backer,
        backerId: $1.backerId,
        backerCompleted: $1.backerCompleted,
        backingDetailsPageRoute: $1.backingDetailsPageRoute,
        bonusAmount: $1.bonusAmount,
        cancelable: $1.cancelable,
        id: $1.id,
        isLatePledge: $1.isLatePledge,
        locationId: $1.locationId,
        locationName: $0,
        order: $1.order,
        paymentIncrements: $1.paymentIncrements,
        paymentSource: $1.paymentSource,
        pledgedAt: $1.pledgedAt,
        projectCountry: $1.projectCountry,
        projectId: $1.projectId,
        reward: $1.reward,
        rewardsAmount: $1.rewardsAmount,
        rewardId: $1.rewardId,
        sequence: $1.sequence,
        shippingAmount: $1.shippingAmount,
        status: $1.status
      ) }
    )

    public static let order = Lens<Backing, Order?>(
      view: { $0.order },
      set: { Backing(
        addOns: $1.addOns,
        amount: $1.amount,
        backer: $1.backer,
        backerId: $1.backerId,
        backerCompleted: $1.backerCompleted,
        backingDetailsPageRoute: $1.backingDetailsPageRoute,
        bonusAmount: $1.bonusAmount,
        cancelable: $1.cancelable,
        id: $1.id,
        isLatePledge: $1.isLatePledge,
        locationId: $1.locationId,
        locationName: $1.locationName,
        order: $0,
        paymentIncrements: $1.paymentIncrements,
        paymentSource: $1.paymentSource,
        pledgedAt: $1.pledgedAt,
        projectCountry: $1.projectCountry,
        projectId: $1.projectId,
        reward: $1.reward,
        rewardsAmount: $1.rewardsAmount,
        rewardId: $1.rewardId,
        sequence: $1.sequence,
        shippingAmount: $1.shippingAmount,
        status: $1.status
      ) }
    )

    public static let paymentIncrements = Lens<Backing, [PledgePaymentIncrement]>(
      view: { $0.paymentIncrements },
      set: { Backing(
        addOns: $1.addOns,
        amount: $1.amount,
        backer: $1.backer,
        backerId: $1.backerId,
        backerCompleted: $1.backerCompleted,
        backingDetailsPageRoute: $1.backingDetailsPageRoute,
        bonusAmount: $1.bonusAmount,
        cancelable: $1.cancelable,
        id: $1.id,
        isLatePledge: $1.isLatePledge,
        locationId: $1.locationId,
        locationName: $1.locationName,
        order: $1.order,
        paymentIncrements: $0,
        paymentSource: $1.paymentSource,
        pledgedAt: $1.pledgedAt,
        projectCountry: $1.projectCountry,
        projectId: $1.projectId,
        reward: $1.reward,
        rewardsAmount: $1.rewardsAmount,
        rewardId: $1.rewardId,
        sequence: $1.sequence,
        shippingAmount: $1.shippingAmount,
        status: $1.status
      ) }
    )

    public static let pledgedAt = Lens<Backing, TimeInterval>(
      view: { $0.pledgedAt },
      set: { Backing(
        addOns: $1.addOns,
        amount: $1.amount,
        backer: $1.backer,
        backerId: $1.backerId,
        backerCompleted: $1.backerCompleted,
        backingDetailsPageRoute: $1.backingDetailsPageRoute,
        bonusAmount: $1.bonusAmount,
        cancelable: $1.cancelable,
        id: $1.id,
        isLatePledge: $1.isLatePledge,
        locationId: $1.locationId,
        locationName: $1.locationName,
        order: $1.order,
        paymentIncrements: $1.paymentIncrements,
        paymentSource: $1.paymentSource,
        pledgedAt: $0,
        projectCountry: $1.projectCountry,
        projectId: $1.projectId,
        reward: $1.reward,
        rewardsAmount: $1.rewardsAmount,
        rewardId: $1.rewardId,
        sequence: $1.sequence,
        shippingAmount: $1.shippingAmount,
        status: $1.status
      ) }
    )

    public static let projectCountry = Lens<Backing, String>(
      view: { $0.projectCountry },
      set: { Backing(
        addOns: $1.addOns,
        amount: $1.amount,
        backer: $1.backer,
        backerId: $1.backerId,
        backerCompleted: $1.backerCompleted,
        backingDetailsPageRoute: $1.backingDetailsPageRoute,
        bonusAmount: $1.bonusAmount,
        cancelable: $1.cancelable,
        id: $1.id,
        isLatePledge: $1.isLatePledge,
        locationId: $1.locationId,
        locationName: $1.locationName,
        order: $1.order,
        paymentIncrements: $1.paymentIncrements,
        paymentSource: $1.paymentSource,
        pledgedAt: $1.pledgedAt,
        projectCountry: $0,
        projectId: $1.projectId,
        reward: $1.reward,
        rewardsAmount: $1.rewardsAmount,
        rewardId: $1.rewardId,
        sequence: $1.sequence,
        shippingAmount: $1.shippingAmount,
        status: $1.status
      ) }
    )

    public static let projectId = Lens<Backing, Int>(
      view: { $0.projectId },
      set: { Backing(
        addOns: $1.addOns,
        amount: $1.amount,
        backer: $1.backer,
        backerId: $1.backerId,
        backerCompleted: $1.backerCompleted,
        backingDetailsPageRoute: $1.backingDetailsPageRoute,
        bonusAmount: $1.bonusAmount,
        cancelable: $1.cancelable,
        id: $1.id,
        isLatePledge: $1.isLatePledge,
        locationId: $1.locationId,
        locationName: $1.locationName,
        order: $1.order,
        paymentIncrements: $1.paymentIncrements,
        paymentSource: $1.paymentSource,
        pledgedAt: $1.pledgedAt,
        projectCountry: $1.projectCountry,
        projectId: $0,
        reward: $1.reward,
        rewardsAmount: $1.rewardsAmount,
        rewardId: $1.rewardId,
        sequence: $1.sequence,
        shippingAmount: $1.shippingAmount,
        status: $1.status
      ) }
    )

    public static let reward = Lens<Backing, Reward?>(
      view: { $0.reward },
      set: { Backing(
        addOns: $1.addOns,
        amount: $1.amount,
        backer: $1.backer,
        backerId: $1.backerId,
        backerCompleted: $1.backerCompleted,
        backingDetailsPageRoute: $1.backingDetailsPageRoute,
        bonusAmount: $1.bonusAmount,
        cancelable: $1.cancelable,
        id: $1.id,
        isLatePledge: $1.isLatePledge,
        locationId: $1.locationId,
        locationName: $1.locationName,
        order: $1.order,
        paymentIncrements: $1.paymentIncrements,
        paymentSource: $1.paymentSource,
        pledgedAt: $1.pledgedAt,
        projectCountry: $1.projectCountry,
        projectId: $1.projectId,
        reward: $0,
        rewardsAmount: $1.rewardsAmount,
        rewardId: $1.rewardId,
        sequence: $1.sequence,
        shippingAmount: $1.shippingAmount,
        status: $1.status
      ) }
    )

    public static let rewardsAmount = Lens<Backing, Double?>(
      view: { $0.rewardsAmount },
      set: { Backing(
        addOns: $1.addOns,
        amount: $1.amount,
        backer: $1.backer,
        backerId: $1.backerId,
        backerCompleted: $1.backerCompleted,
        backingDetailsPageRoute: $1.backingDetailsPageRoute,
        bonusAmount: $1.bonusAmount,
        cancelable: $1.cancelable,
        id: $1.id,
        isLatePledge: $1.isLatePledge,
        locationId: $1.locationId,
        locationName: $1.locationName,
        order: $1.order,
        paymentIncrements: $1.paymentIncrements,
        paymentSource: $1.paymentSource,
        pledgedAt: $1.pledgedAt,
        projectCountry: $1.projectCountry,
        projectId: $1.projectId,
        reward: $1.reward,
        rewardsAmount: $0,
        rewardId: $1.rewardId,
        sequence: $1.sequence,
        shippingAmount: $1.shippingAmount,
        status: $1.status
      ) }
    )

    public static let rewardId = Lens<Backing, Int?>(
      view: { $0.rewardId },
      set: { Backing(
        addOns: $1.addOns,
        amount: $1.amount,
        backer: $1.backer,
        backerId: $1.backerId,
        backerCompleted: $1.backerCompleted,
        backingDetailsPageRoute: $1.backingDetailsPageRoute,
        bonusAmount: $1.bonusAmount,
        cancelable: $1.cancelable,
        id: $1.id,
        isLatePledge: $1.isLatePledge,
        locationId: $1.locationId,
        locationName: $1.locationName,
        order: $1.order,
        paymentIncrements: $1.paymentIncrements,
        paymentSource: $1.paymentSource,
        pledgedAt: $1.pledgedAt,
        projectCountry: $1.projectCountry,
        projectId: $1.projectId,
        reward: $1.reward,
        rewardsAmount: $1.rewardsAmount,
        rewardId: $0,
        sequence: $1.sequence,
        shippingAmount: $1.shippingAmount,
        status: $1.status
      ) }
    )

    public static let sequence = Lens<Backing, Int>(
      view: { $0.sequence },
      set: { Backing(
        addOns: $1.addOns,
        amount: $1.amount,
        backer: $1.backer,
        backerId: $1.backerId,
        backerCompleted: $1.backerCompleted,
        backingDetailsPageRoute: $1.backingDetailsPageRoute,
        bonusAmount: $1.bonusAmount,
        cancelable: $1.cancelable,
        id: $1.id,
        isLatePledge: $1.isLatePledge,
        locationId: $1.locationId,
        locationName: $1.locationName,
        order: $1.order,
        paymentIncrements: $1.paymentIncrements,
        paymentSource: $1.paymentSource,
        pledgedAt: $1.pledgedAt,
        projectCountry: $1.projectCountry,
        projectId: $1.projectId,
        reward: $1.reward,
        rewardsAmount: $1.rewardsAmount,
        rewardId: $1.rewardId,
        sequence: $0,
        shippingAmount: $1.shippingAmount,
        status: $1.status
      ) }
    )

    public static let shippingAmount = Lens<Backing, Double?>(
      view: { $0.shippingAmount },
      set: { Backing(
        addOns: $1.addOns,
        amount: $1.amount,
        backer: $1.backer,
        backerId: $1.backerId,
        backerCompleted: $1.backerCompleted,
        backingDetailsPageRoute: $1.backingDetailsPageRoute,
        bonusAmount: $1.bonusAmount,
        cancelable: $1.cancelable,
        id: $1.id,
        isLatePledge: $1.isLatePledge,
        locationId: $1.locationId,
        locationName: $1.locationName,
        order: $1.order,
        paymentIncrements: $1.paymentIncrements,
        paymentSource: $1.paymentSource,
        pledgedAt: $1.pledgedAt,
        projectCountry: $1.projectCountry,
        projectId: $1.projectId,
        reward: $1.reward,
        rewardsAmount: $1.rewardsAmount,
        rewardId: $1.rewardId,
        sequence: $1.sequence,
        shippingAmount: $0,
        status: $1.status
      ) }
    )

    public static let status = Lens<Backing, Status>(
      view: { $0.status },
      set: { Backing(
        addOns: $1.addOns,
        amount: $1.amount,
        backer: $1.backer,
        backerId: $1.backerId,
        backerCompleted: $1.backerCompleted,
        backingDetailsPageRoute: $1.backingDetailsPageRoute,
        bonusAmount: $1.bonusAmount,
        cancelable: $1.cancelable,
        id: $1.id,
        isLatePledge: $1.isLatePledge,
        locationId: $1.locationId,
        locationName: $1.locationName,
        order: $1.order,
        paymentIncrements: $1.paymentIncrements,
        paymentSource: $1.paymentSource,
        pledgedAt: $1.pledgedAt,
        projectCountry: $1.projectCountry,
        projectId: $1.projectId,
        reward: $1.reward,
        rewardsAmount: $1.rewardsAmount,
        rewardId: $1.rewardId,
        sequence: $1.sequence,
        shippingAmount: $1.shippingAmount,
        status: $0
      ) }
    )
  }
}
