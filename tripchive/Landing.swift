import SwiftUI

struct Landing: View {
    var body: some View {
        ZStack {
            backgroundGradient
            
            VStack {
                Spacer()
                
                titleText
                getStartedButton
            }
            .padding(.horizontal, 20)
        }
    }
    
    private var backgroundGradient: some View {
        ZStack {
            RadialGradient(
                colors: [
                    Color.green.opacity(0.2),
                    Color.green.opacity(0.08),
                    Color.clear
                ],
                center: .topLeading,
                startRadius: 20,
                endRadius: 350
            )
            .ignoresSafeArea()

            // Subtle center accent
            RadialGradient(
                colors: [
                    Color.green.opacity(0.06),
                    Color.clear
                ],
                center: .center,
                startRadius: 10,
                endRadius: 300
            )
            .ignoresSafeArea()
        }
    }
    
    private var titleText: some View {
        VStack {
            Image(systemName: "mappin.circle.fill")
                .font(.system(size: 96))
                .foregroundStyle(LinearGradient(
                    colors: [.green, .cyan],
                    startPoint: .top,
                    endPoint: .bottom,
                ))
                .padding()
            
            Text("Tripchive")
                .font(.largeTitle.bold())
            
            Text("Use the best app made for Alvin Sze")
        }
    }
    
    private var getStartedButton: some View {
        Button {} label: {
            Text("Get Started")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.background)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
                .background(
                    LinearGradient(
                        colors: [
                            Color.green,
                            Color(red: 0.0, green: 0.8, blue: 0.4)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding()
    }
}

#Preview {
    Landing()
}
