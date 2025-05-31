# Custom Ratio Field Component

This component provides an interactive way for users to input and visualize ratios between two items. It was developed for the CarbonGuessr mobile app to help users estimate carbon ratios.

## Features

- Visual representation of ratios using two resizable squares
- Bidirectional synchronization with text input
- Interactive resizing using pinch-to-zoom gestures
- Clear visual distinction between items with customizable colors
- Automatic size adjustment to maintain proportional representation

## Components

### `CustomRatioField`

A standalone component that displays two squares representing a ratio. Users can adjust the ratio by pinching to resize either square.

#### Properties:

- `initialRatio`: The starting ratio value (default: 1.0)
- `firstItemTitle`: Title for the first item
- `secondItemTitle`: Title for the second item
- `firstItemColor`: Border color for the first item's square
- `secondItemColor`: Border color for the second item's square
- `onRatioChanged`: Callback function when ratio changes

### `CombinedRatioField`

A complete solution that combines the visual `CustomRatioField` with a text input field for direct numerical entry. Changes in either the visual component or text field update the other.

#### Properties:

Same as `CustomRatioField`, with the addition of a synchronized text input field.

## Usage Example

```dart
CombinedRatioField(
  initialRatio: 2.5,
  firstItemTitle: 'Car',
  secondItemTitle: 'Bicycle',
  firstItemColor: Colors.red,
  secondItemColor: Colors.blue,
  onRatioChanged: (newRatio) {
    print('New ratio: $newRatio');
    // Do something with the new ratio value
  },
)
```

## Implementation Details

- The component maintains the proper proportional representation even as users resize the squares
- If one square reaches its maximum/minimum size, the other square will adjust accordingly
- The implementation optimizes for smooth animations and responsive interaction
- The component handles edge cases like extremely large or small ratios

See `custom_ratio_field_example.dart` for a complete working example.
