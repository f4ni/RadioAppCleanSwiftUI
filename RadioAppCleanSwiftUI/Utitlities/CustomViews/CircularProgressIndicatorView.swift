struct CircularProgressIndicatorView: View {
    
    @State private var animate = false
    
    let gradient = AngularGradient(
        stops: [
            .init(color: .clear, location: 0.0),
            .init(color: .blue, location: 1)
        ],
        center: .center
    )

    var body: some View {
        GeometryReader { geometry in
            Circle()
                .stroke(gradient, lineWidth: geometry.size.width / 2)
                .frame(width: geometry.size.width / 2)
                .rotationEffect(Angle(degrees: animate ? 360 : 0))
                .animation(
                    .linear(duration: 1).repeatForever(autoreverses: false),
                    value: animate
                )
                .position(x: geometry.frame(in: .local).width / 2, y: geometry.frame(in: .local).height / 2)
                .onAppear {
                    withAnimation(.spring(.bouncy)) {
                        animate.toggle()
                    }
                }
        }
    }
}
