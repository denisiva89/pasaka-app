// PasakaApp.swift
import SwiftUI

@main
struct PasakaApp: App {
    // Выставляем горизонтальную ориентацию приложения для всех устройств
    init() {
        // Устанавливаем приложение только в горизонтальной ориентации
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .onAppear {
                    // Убедимся, что на iPhone применяется только горизонтальная ориентация
                    AppDelegate.orientationLock = .landscape
                }
        }
    }
}

// Класс делегата для управления ориентацией
class AppDelegate: NSObject, UIApplicationDelegate {
    static var orientationLock = UIInterfaceOrientationMask.landscape
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}
