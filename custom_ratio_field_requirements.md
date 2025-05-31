# Introduction

This document outlines the requirements for implementing a custom ratio field in the CarbonGuessr mobile application. This feature will allow users to input and manage their estimate of the carbon ratio between two items or activities in a visually engaging and user-friendly manner.

# Description

The custom ratio field will be a specialized input component designed to enhance user interaction by providing a clear and intuitive way to enter numerical values. Each of the two items will be represented by a square outline. The size of each square will be proportional to the carbon ratio between the two items, allowing users to visually compare their estimates. By zooming in and out on the squares, users can adjust the size of each square to reflect their estimated ratio. The component will exist next to the text input field that is already present, and changes to either the text input or the square sizes will update the other in real-time.

# Requirements

## 1. Custom Ratio Field Design

- The custom ratio field should consist of two resizable square outlines, each representing one of the items being compared.
- The squares should be visually distinct, using colors matching those of the items they represent.
- The title of each item should be displayed above its corresponding square.
- Users should be able to use pinch and zoom gestures on either square to resize it, with the aspect ratio maintained.

## Synchronization with Text Input

- The custom ratio field must be synchronized with the existing text input field.
- When the user adjusts the size of either square, the corresponding numerical value in the text input field should update in real-time.
- Conversely, when the user enters a numerical value in the text input field, the sizes of the squares should adjust accordingly to reflect the new ratio.
- The synchronization should be bidirectional, ensuring that changes in either the squares or the text input are immediately reflected in the other.

## 3. User Experience

- The custom ratio field should be intuitive and easy to use, allowing users to quickly grasp how to input their estimates.
- The squares should be large enough to allow for precise adjustments but small enough to fit comfortably within the app's layout.
- If one square is at the maximum size, the other square should automatically adjust to maintain the ratio, i.e. if one square is resized to its maximum but the user still attempts to increase its size, the other square should decrease in size instead to reflect the change.
- Changes to the squares should be smooth and responsive, regardless of whether the user is adjusting the squares or entering text in the input field.

## 4. Accessibility

- The custom ratio field should be accessible to all users, including those with visual impairments.
- Ensure that the squares have sufficient contrast against the background and that the text labels are legible.

## 5. Technical Implementation

- The custom ratio field should be implemented while adhering to the existing codebase's architecture and design patterns.
- State management should be handled efficiently to ensure that updates to the squares and text input are performed without unnecessary re-renders or performance issues.
- The implementation should take performance into account, as this graphical component will be heavily used during gameplay.
