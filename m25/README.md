#  Existing SwiftUI limitations that might effect design

1. TabView only supports horizontal swiping; Using vertical cards needs to test on all models;
2. Vertical cards does not support dot indicators;
3. In readingView, .frame(maxWidth: UIScreen.main.bounds.width) (or similar) doesn’t behave dynamically

