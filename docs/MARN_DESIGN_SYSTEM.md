# MARN Qatar Design System

This is the working design bible for the app. Every new screen, component, button, input, card, bottom sheet, or small UI addition should follow this unless a newer Figma export explicitly updates the rule.

## Philosophy

MARN is a mobile-first marketplace and service booking product. The interface should feel warm, trustworthy, direct, and practical. Build real product screens, not generic Material surfaces.

Use native Flutter widgets styled through MARN tokens and components. Do not place Figma component-sheet PNGs in the UI. Use PNGs only for real visual assets such as people cutouts, photos, illustrations, and brand/payment logos.

## Tokens

- Brand maroon: `AppColors.brandMaroon`
- Primary action: `AppColors.brandPrimary` / `AppColors.primary600`
- Primary text: `AppColors.baseDark`
- Muted text: `AppColors.gray500` or `AppColors.grayModern400`
- Page background: `AppColors.brandBeige`
- Card background: `AppColors.baseWhite`
- Success status: `AppColors.success700` on `AppColors.success100`
- Pending/error: use the existing `warning` / `error` ramps

Use `AppTypography` for text. The Figma exports read as Inter-like, and the app already uses Inter. Keep `letterSpacing: 0`.

Use `LayoutTokens` for common size decisions:

- Page horizontal padding: `20` or `24` for Figma-like full screens
- Card radius: `22-24`
- Input radius: `16-18`
- Pill radius: `999`
- Bottom nav height: `86`

Use `AppShadows` for Figma shadow scale. Prefer no shadow or subtle `xs/sm` unless the design clearly floats.

## Component Rules

Buttons:

- Use `MarnButton`, not raw `FilledButton`, `OutlinedButton`, or `TextButton`, for product UI.
- Variants: primary, secondary, tertiary.
- Sizes: small, medium, large.
- Keep icon+text buttons balanced; icon-only controls should be circular or square icon buttons.

Inputs:

- Use `MarnTextInput` or `MarnSearchField`.
- Search inputs use a leading search icon, optional clear button, optional filter icon.
- Error and success states change both border and helper text color.

Cards:

- Use `MarnCardSurface` for white rounded surfaces.
- Build dedicated card widgets for listing/request/agency/payment/promo patterns.
- Avoid one-off card styling inside screens when the component will recur.

Filters and selections:

- Use `MarnCheckboxTile`, `MarnChoicePill`, and `MarnSegmentedTabs`.
- Maroon means active/selected. Gray means inactive. Pink/maroon fills are reserved for selected or disabled selected states.

Navigation:

- Bottom navigation uses the Figma pattern: white/off-white bar, top active indicator, maroon active icon/label, warm gray inactive icon/label.
- Keep 5-tab and 3-tab variants possible.
- Grid/list view toggles must use `MarnIconAssets.gridView` and `MarnIconAssets.singleView`. These point to the provided Iconly PNGs and are the source of truth for those controls.
- Back navigation must use `MarnIconAssets.arrowLeft`, sourced from the provided Iconly Arrow Left PNG. Bottom-nav root screens do not show a back icon. Detail and secondary screens should be full-screen routes outside `MarnShellScaffold` and opt into `MarnPageScaffold(showBackButton: true)`.

Overlays:

- Bottom sheets should have rounded top corners, a small drag handle, and native scrolling.
- Dialog actions should use the same `MarnButton` variants.

## Implementation Flow For New Screens

1. Identify screen category: marketplace list, detail, booking, form, profile, payment, request, or overlay.
2. Map every visible Figma element to an existing MARN primitive.
3. If a primitive is missing, add it under `lib/core/ui/` before building the screen.
4. Only use screen-local styling for one-time layout composition.
5. Run `flutter analyze` and a focused widget/smoke test when practical.
6. Visually verify on the 390 x 844 design baseline and one smaller width.

## Current Screens

Home, location, wishlist, splash, language selection, and onboarding are allowed to keep their current screen-specific composition, but future edits should pull repeated controls back into MARN primitives.

The highest priority cleanup areas are:

- Replace raw buttons in auth/location/wishlist/detail screens with `MarnButton`.
- Replace ad hoc chips with `MarnChoicePill`.
- Replace generic request rows with Figma-style request cards.
- Expand card families from the Figma `card.png` sheet as dedicated widgets.
