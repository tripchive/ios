import SwiftUI

struct ContentView: View {
    @State private var language: AppLanguage = .english
    @State private var showLanguagePicker = false
    @State private var isSignUp = false
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    var body: some View {
        ZStack {
            // Background: black with green radial gradients
            backgroundGradient

            ScrollView {
                VStack(spacing: 0) {
                    // Top bar with language switcher
                    languageSwitcherBar
                        .padding(.top, 8)

                    Spacer().frame(height: 48)

                    // Hero section
                    heroSection

                    Spacer().frame(height: 40)

                    // Auth form
                    authForm

                    Spacer().frame(height: 24)

                    // Social login divider + buttons
                    socialLoginSection

                    Spacer().frame(height: 24)

                    // Toggle login/signup
                    toggleAuthMode

                    Spacer().frame(height: 48)
                }
                .padding(.horizontal, 28)
            }
            .scrollIndicators(.hidden)
        }
        .preferredColorScheme(.dark)
    }

    // MARK: - Background

    private var backgroundGradient: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            // Top-left green glow
            RadialGradient(
                colors: [
                    Color.green.opacity(0.3),
                    Color.green.opacity(0.08),
                    Color.clear
                ],
                center: .topLeading,
                startRadius: 20,
                endRadius: 350
            )
            .ignoresSafeArea()

            // Bottom-right green glow
            RadialGradient(
                colors: [
                    Color(red: 0.0, green: 0.8, blue: 0.4).opacity(0.25),
                    Color.green.opacity(0.05),
                    Color.clear
                ],
                center: .bottomTrailing,
                startRadius: 30,
                endRadius: 400
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

    // MARK: - Language Switcher

    private var languageSwitcherBar: some View {
        HStack {
            Spacer()
            Menu {
                ForEach(AppLanguage.allCases) { lang in
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            language = lang
                        }
                    } label: {
                        HStack {
                            Text(lang.flag)
                            Text(lang.displayName)
                            if lang == language {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } label: {
                HStack(spacing: 6) {
                    Text(language.flag)
                        .font(.body)
                    Text(language.displayName)
                        .font(.subheadline)
                        .fontWeight(.medium)
                    Image(systemName: "chevron.down")
                        .font(.caption2)
                        .fontWeight(.semibold)
                }
                .foregroundStyle(.white.opacity(0.8))
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(.white.opacity(0.08))
                        .stroke(.white.opacity(0.12), lineWidth: 1)
                )
            }
        }
    }

    // MARK: - Hero

    private var heroSection: some View {
        VStack(spacing: 16) {
            // App icon / logo area
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.green.opacity(0.6),
                                Color(red: 0.0, green: 0.7, blue: 0.4)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 72, height: 72)

                Image(systemName: "airplane")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundStyle(.white)
            }
            .padding(.bottom, 4)

            Text("Tripchive")
                .font(.system(size: 38, weight: .bold, design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.white, Color(red: 0.6, green: 1.0, blue: 0.7)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )

            Text(language.tagline)
                .font(.title3)
                .fontWeight(.medium)
                .foregroundStyle(.white.opacity(0.9))

            Text(language.subtitle)
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.5))
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .padding(.horizontal, 8)
        }
    }

    // MARK: - Auth Form

    private var authForm: some View {
        VStack(spacing: 16) {
            Text(isSignUp ? language.signUp : language.logIn)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)

            // Email field
            VStack(alignment: .leading, spacing: 6) {
                Text(language.email)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.white.opacity(0.6))

                TextField("", text: $email, prompt: Text(language.email).foregroundStyle(.white.opacity(0.3)))
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding(14)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.white.opacity(0.06))
                            .stroke(.white.opacity(0.1), lineWidth: 1)
                    )
                    .foregroundStyle(.white)
            }

            // Password field
            VStack(alignment: .leading, spacing: 6) {
                Text(language.password)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.white.opacity(0.6))

                SecureField("", text: $password, prompt: Text(language.password).foregroundStyle(.white.opacity(0.3)))
                    .textContentType(isSignUp ? .newPassword : .password)
                    .padding(14)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.white.opacity(0.06))
                            .stroke(.white.opacity(0.1), lineWidth: 1)
                    )
                    .foregroundStyle(.white)
            }

            // Confirm password (sign up only)
            if isSignUp {
                VStack(alignment: .leading, spacing: 6) {
                    Text(language.confirmPassword)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(.white.opacity(0.6))

                    SecureField("", text: $confirmPassword, prompt: Text(language.confirmPassword).foregroundStyle(.white.opacity(0.3)))
                        .textContentType(.newPassword)
                        .padding(14)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.white.opacity(0.06))
                                .stroke(.white.opacity(0.1), lineWidth: 1)
                        )
                        .foregroundStyle(.white)
                }
            }

            // Submit button
            Button {
                // Action placeholder
            } label: {
                Text(isSignUp ? language.signUp : language.logIn)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
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
            .padding(.top, 4)
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white.opacity(0.04))
                .stroke(.white.opacity(0.08), lineWidth: 1)
        )
    }

    // MARK: - Social Login

    private var socialLoginSection: some View {
        VStack(spacing: 16) {
            // Divider with text
            HStack(spacing: 12) {
                Rectangle()
                    .fill(.white.opacity(0.15))
                    .frame(height: 1)
                Text(language.orContinueWith)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.4))
                    .layoutPriority(1)
                Rectangle()
                    .fill(.white.opacity(0.15))
                    .frame(height: 1)
            }

            HStack(spacing: 12) {
                socialButton(icon: "apple.logo", label: "Apple")
                socialButton(icon: "g.circle.fill", label: "Google")
            }
        }
    }

    private func socialButton(icon: String, label: String) -> some View {
        Button {
            // Action placeholder
        } label: {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.body)
                Text(label)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            .foregroundStyle(.white.opacity(0.85))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 13)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white.opacity(0.06))
                    .stroke(.white.opacity(0.1), lineWidth: 1)
            )
        }
    }

    // MARK: - Toggle Auth Mode

    private var toggleAuthMode: some View {
        HStack(spacing: 4) {
            Text(isSignUp ? language.alreadyHaveAccount : language.noAccount)
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.5))

            Button {
                withAnimation(.easeInOut(duration: 0.25)) {
                    isSignUp.toggle()
                    confirmPassword = ""
                }
            } label: {
                Text(isSignUp ? language.logIn : language.signUp)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.green)
            }
        }
    }
}

#Preview {
    ContentView()
}
