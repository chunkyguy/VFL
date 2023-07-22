# VFL

Visual Formatting Language

Simple wrapper around Apple's ascii based constraints.

Example usage:

```swift
VFL(self)
  .add(subview: MyView(), name: "view")
  .appendConstraints(formats: ["H:|[view(320)]|", "V:|[view(480)]|"])
```

But unlike other wrappers, VFL is meant to be used as a supplement and not a replacement. So you can also add constraints created using system API.
Here's an example that creates a view of size 320x480 and aligns it to the center of parent

```swift
    let view = VFLColorView()
    VFL(self)
      .add(subview: view, name: "view")
      .appendConstraints(formats: [
        "H:[view(320)]",
        "V:[view(480)]",
      ])
      .appendConstraints([
        NSLayoutConstraint(
          item: view, attribute: .centerX,
          relatedBy: .equal,
          toItem: self, attribute: .centerX,
          multiplier: 1, constant: 0
        ),
        NSLayoutConstraint(
          item: view, attribute: .centerY,
          relatedBy: .equal,
          toItem: self, attribute: .centerY,
          multiplier: 1, constant: 0
        )
      ])
```

### References

1. [Apple's Visual Format Language](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/VisualFormatLanguage.html)

