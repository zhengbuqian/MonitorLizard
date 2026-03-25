import SwiftUI

@main
struct MonitorLizardApp: App {
    @StateObject private var viewModel = {
        let isDemoMode = CommandLine.arguments.contains("--demo-mode")
        return PRMonitorViewModel(isDemoMode: isDemoMode)
    }()
    private let updateService = UpdateService.shared

    var body: some Scene {
        MenuBarExtra {
            MenuBarView()
                .environmentObject(viewModel)
                .onAppear {
                    // Restore floating window on first menu open if it was active
                    WindowManager.shared.restoreFloatingWindowIfNeeded(viewModel: viewModel)
                }
        } label: {
            MenuBarLabel(showWarningIcon: viewModel.showWarningIcon)
        }
        .menuBarExtraStyle(.window)

        Settings {
            SettingsView()
        }
    }
}

struct MenuBarLabel: View {
    let showWarningIcon: Bool

    var body: some View {
        Image(systemName: showWarningIcon ? "exclamationmark.triangle.fill" : "lizard")
            .foregroundColor(showWarningIcon ? .red : nil)
    }
}
