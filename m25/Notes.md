#  Possible failure:
frame(maxWidth: .infinity, alignment: .leading) does not work well with ScrollView for device's actuall width
 .padding(.horizontal, 100) does not work well with Spacer() because any padding will be ignored by the Spacer.     .frame(maxWidth: .infinity)   is needed
tabview does not work well with ignore safe area. .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
Have showMenu in GridView and showGrid in MenuView, synced. Once active at a time.	
    •	Each fullscreen modal is self-managing.
	•	No cross-binding → no environment pollution.
	•	Dismissals stay predictable.
	•	Future you can replace fullScreenCover with NavigationStack or shared environment routing easily.
