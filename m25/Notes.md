#  Possible failure:
frame(maxWidth: .infinity, alignment: .leading) does not work well with ScrollView for device's actuall width
 .padding(.horizontal, 100) does not work well with Spacer() because any padding will be ignored by the Spacer.     .frame(maxWidth: .infinity)   is needed
tabview does not work well with ignore safe area. .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
Have showMenu in GridView and showGrid in MenuView, synced. Once active at a time.	
    •	Each fullscreen modal is self-managing.
	•	No cross-binding → no environment pollution.
	•	Dismissals stay predictable.
	•	Future you can replace fullScreenCover with NavigationStack or shared environment routing easily.

NavigationLink(destination: ShopView()) {
    Text("SHOP")
        .font(.system(size: 22, weight: .semibold))
        .multilineTextAlignment(.center)
        .foregroundColor(Color(hex: "FFFFFF"))
}
This will be same-place replacement instead of Full Screen occupy.


#  Existing SwiftUI limitations that might effect design

1. TabView only supports horizontal swiping; Using vertical cards needs to test on all models;
2. Vertical cards does not support dot indicators;
3. In readingView, .frame(maxWidth: UIScreen.main.bounds.width) (or similar) doesn’t behave dynamically

