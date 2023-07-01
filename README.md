# VFL

Visual Formatting Language

Simple wrapper around Apple's ascii based constraints.

Example usage:

```swift
    VFL(self)
      .add(subview: tableVw, name: "tableVw")
      .appendConstraints(
        metrics: view.safeAreaInsets.metrics,
        formats: [
          "V:|-(top)-[tableVw]-(bottom)-|",
          "H:|-(left)-[tableVw]-(right)-|"
        ])
```

### References

1. [Apple's Visual Format Language](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/VisualFormatLanguage.html)

