#  Possible failure:
frame(maxWidth: .infinity, alignment: .leading) does not work well with ScrollView for device's actuall width
 .padding(.horizontal, 100) does not work well with Spacer() because any padding will be ignored by the Spacer.     .frame(maxWidth: .infinity)   is needed
tabview does not work well with ignore safe area. .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
