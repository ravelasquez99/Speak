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

    @Published var receivedText: String = ""
    @Published var isProcessing = false
    
    public func connectToWebSocket() {
        webSocketManager?.disconnect()

        isProcessing = true
        webSocketManager = WebSocketManager()
        webSocketManager?.onReceivedMessageAndIsFinal = { [weak self] (message, final) in
            DispatchQueue.main.async {
                self?.receivedText = message
                self?.isProcessing = !final
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
