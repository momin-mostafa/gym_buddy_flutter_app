# ADR 001: Use `intl` package for date formatting

*Date:* 2026‑02‑22  
*Status:* accepted

## Context

Several views in the app need to display human‑readable dates.  
The built‑in `DateTime` API is very limited (only numeric month/day, no
locale or month name support) so formatting logic would have to be
hand‑rolled wherever it’s needed.

## Decision

Introduce the [intl](https://pub.dev/packages/intl) package as a direct
dependency (version ^0.20.2 at the time of writing) and expose a small
extension on `DateTime` for our common format:

```dart
import 'package:intl/intl.dart' show DateFormat;

extension DateFormatterExtension on DateTime {
  String get format => "$day - $monthInCalender $year";
  String get monthInCalender => DateFormat('MMM').format(this);
}
```