//
//  RecordViewModel.swift
//  Speak
//
//  Created by Richard Velasquez on 3/14/24.
//

import Foundation
import SwiftUI

public final class RecordViewModel: ObservableObject {


    // MARK: - API

    @Published var receivedText: String = "A table for two"
    
    public func connectToWebSocket() {
        webSocketManager?.disconnect()

        webSocketManager = WebSocketManager()
        webSocketManager?.onReceivedMessage = { [weak self] message in
            DispatchQueue.main.async {
                self?.receivedText = message
            }
        }

        webSocketManager?.connect()
    }

    public func disconnectWebSocket() {
        webSocketManager?.disconnect()
    }

    
    // MARK: - Private Vars

    private var webSocketManager: WebSocketManager?
}
