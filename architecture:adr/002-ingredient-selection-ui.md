
---

### ADR 002 – Introduce ingredient‑selection UI with bottom sheet 🥗

```markdown
# ADR 002: Initial UI for nutrient/ingredient selection

*Date:* 2026‑02‑22  
*Status:* accepted

## Context

Users need to choose ingredients and specify amounts as part of the
“nutrients” feature. The previous list‑builder in `IngredientsSelectorView`
was too generic and didn’t support the interaction we want.

## Decision

Redesign `IngredientsSelectorView`:

* Show current date (using the new extension).
* Replace the `ListView.builder` with a column containing:
  * a read‑only `TextFormField` that opens a bottom sheet when tapped,
  * an amount entry field,
  * and the list builder moved into a `bottomSheet()` helper method.
* The bottom sheet presents nutrient cards; tapping a card will eventually
  add the nutrient to the user’s selection (TODO placeholders added).
* Moved `number_formatter.extension.dart` into [extensions](http://_vscodecontentref_/0) and updated
  imports accordingly.

## Consequences

* UI code is more complex; state management via `NutrientsVM` continues.
* Future work: wire up selection logic, persist to database, update VM.
* Directory structure is now organised around `extensions/` for similar helpers.