//
//  WebSocketManager.swift
//  Speak
//
//  Created by Richard Velasquez on 3/14/24.
//

import Foundation

public final class WebSocketManager {


    // MARK: - Vars

    var onReceivedMessage: ((String) -> Void)?
    private var webSocketTask: URLSessionWebSocketTask?


    // MARK: - Connection

    public func connect() {
        //Kill current connection if any
        if webSocketTask != nil {
            disconnect()
        }

        // Start the connection
        let session = URLSession(configuration: .default)
        webSocketTask = session.webSocketTask(
            with: WebRequestBuilder.buildRecordKickoffWebRequest()
        )

        webSocketTask?.resume()
        websocketConnectionStarted()
    }

    private func websocketConnectionStarted() {
        listenForMessages()
        sendStartMessage()
    }


    // MARK: - Event Listening

    private func listenForMessages() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .failure(let error):
                print("Error in receiving message: \(error.localizedDescription)")
            case .success(let message):
                switch message {
                case .string(let text):
                    guard let data = text.data(using: .utf8) else {
                        print("Unable to convert text to data")
                        return
                    }

                    do {
                        let event = try JSONDecoder().decode(
                            ASREvent.self,
                            from: data
                        )
                        self?.processEvent(event: event)
                    } catch let theError {
                        print("Unable to decode model with error \(theError)")
                    }

                    self?.onReceivedMessage?(text)
                case .data(let data):
                    print("Received data: \(data)")
                default:
                    break
                }
                
                // Keep listening for more messages
                self?.listenForMessages()
            }
        }
    }

    
    // MARK: - Process Event

    private func processEvent(event: ASREvent) {
        switch event.type {
        case .asrStart:
            break // should be handled already
        case .asrMetadata:
            <#code#>
        case .asrError:
            <#code#>
        case .asrClose:
            <#code#>
        case .asrClosed:
            <#code#>
        case .asrStream:
            <#code#>
        case .asrResult:
            <#code#>
        }
    }
    
    // MARK: - Disconnecting

    func disconnect() {
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
    }
    
    
    // MARK: - Start Event

    private func sendStartMessage() {
        let asrStartMessage = ASREvent(
            type: .asrStart,
            learningLocale: "en-US",
            metadata: .init(
                deviceAudio: .init(
                    inputSampleRate: 1600
                )
            )
        )

        do {
            let messageData = try JSONEncoder().encode(asrStartMessage)

            webSocketTask?.send(.data(messageData)) { error in
                if let error = error {
                    print("Error sending start message: \(error.localizedDescription)")
                }
            }
        } catch {
            print("Failed to encode start message: \(error.localizedDescription)")
        }
    }
}
