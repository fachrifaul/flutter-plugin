/// Copyright 2021 Google LLC
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///     https://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

/// The payment price statuses supported in the payment selector.
///
/// * [final_price] determines that the price has been calculated and
/// won't change.
/// * [pending] expects changes to the final price in response to user selection
/// or other circumstances that are not known when first requesting the payment.
/// * [unknown] for any other scenario.
enum PaymentItemStatus { unknown, pending, final_price }

/// A set of utility methods associated to the [PaymentItemStatus] enumeration.
extension on PaymentItemStatus {
  /// Creates a string representation of the [PaymentItemStatus] enumeration.
  String toSimpleString() => {
        PaymentItemStatus.unknown: 'unknown',
        PaymentItemStatus.pending: 'pending',
        PaymentItemStatus.final_price: 'final_price',
      }[this]!;
}

/// The payment types supported when showing the payment selector.
///
/// * [item] defines an element as a regular entry in the payment summary.
/// * [total] describes the summary item with the total amount to be paid.
enum PaymentItemType { item, total }

/// A set of utility methods associated to the [PaymentItemType] enumeration.
extension on PaymentItemType {
  /// Creates a string representation of the [PaymentItemType] enumeration.
  String toSimpleString() => {
        PaymentItemType.item: 'item',
        PaymentItemType.total: 'total',
      }[this]!;
}

/// A simple object that holds information about individual entries in the
/// payment summary shown before completing a payment.
///
/// Payment items are typically shown as a collection of entries with basic
/// information about the items being purchased.
///
/// Here is an example of an individual payment item:
/// ```dart
/// PaymentItem(
///   label: 'Your new shoes',
///   amount: '99.99',
///   status: PaymentItemStatus.final_price,
///   type: PaymentItemType.item,
/// )
/// ```
///
/// And a summary entry with the total price.
/// ```dart
/// PaymentItem(
///   label: 'Total',
///   amount: '102.99',
///   status: PaymentItemStatus.final_price,
///   type: PaymentItemType.total,
/// )
/// ```
class PaymentItem {
  /// A text with basic information about the item.
  final String? label;

  ///  The price of the item in string format.
  final String amount;

  /// The type of the item, either [item] or [total].
  final PaymentItemType type;

  /// The status of the price, either [unknown], [pending] or [final_price].
  final PaymentItemStatus status;

  /// The amount of time – in calendar units such as day, month, or year – that represents a fraction of the total payment interval. For example, if you set the intervalUnit to 'month' and intervalCount to 3, then the payment interval is three months.
  final IntervalUnit intervalUnit;

  /// The number of interval units that make up the total payment interval. For example, if you set the intervalUnit to 'month' and intervalCount to 3, then the payment interval is three months.
  final int intervalCount;

  final bool recurring;

  /// Creates a new payment item with the specified parameters, defaulting to
  /// a [total] [type], and an [unknown] [status].
  const PaymentItem({
    required this.amount,
    this.label,
    this.type = PaymentItemType.total,
    this.status = PaymentItemStatus.unknown,
    this.recurring = false,
    this.intervalUnit = IntervalUnit.month,
    this.intervalCount = 1,
  });

  /// Creates a map representation of the object.
  Map<String, Object?> toMap() => {
        'label': label,
        'amount': amount,
        'type': type.toSimpleString(),
        'status': status.toSimpleString(),
        'recurring': recurring,
        'intervalUnit': intervalUnit.toSimpleString(),
        'intervalCount': intervalCount,
      };
}

enum IntervalUnit { minute, hour, day, month, year }

extension on IntervalUnit {
  /// Creates a string representation of the [PaymentItemStatus] enumeration.
  String toSimpleString() => {
        IntervalUnit.minute: 'minute',
        IntervalUnit.hour: 'hour',
        IntervalUnit.day: 'day',
        IntervalUnit.month: 'month',
        IntervalUnit.year: 'year',
      }[this]!;
}
