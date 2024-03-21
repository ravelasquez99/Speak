//
//  WebSocketManager.swift
//  Speak
//
//  Created by Richard Velasquez on 3/14/24.
//

import Foundation

public final class WebSocketManager {


    // MARK: - Vars

    var onReceivedMessageAndIsFinal: ((String, Bool) -> Void)?
    private var webSocketTask: URLSessionWebSocketTask?
    private var shouldReconnectOnClosedConfirmation = false


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
                // Keep listening for more messages
                self?.listenForMessages()

                // Parse the event
                var providedData: Data?
                switch message {
                case .string(let text):
                    providedData = text.data(using: .utf8)
                case .data(let data):
                    providedData = data
                default:
                    break
                }

                guard let theProvidedData = providedData else {
                    return
                }

                do {
                    let event = try JSONDecoder().decode(
                        ASREvent.self,
                        from: theProvidedData
                    )
                    self?.processEvent(event: event)
                } catch let theError {
                    print("Unable to decode model with error \(theError)")
                }
            }
        }
    }


    // MARK: - Process Event

    private func processEvent(event: ASREvent) {
        switch event.type {
        case .asrStart, .asrClose, .asrStream:
            // these are events we send
            break
        case .asrMetadata:
            guard let chunks = LocalJsonRetriever.dataFromLocalJson(
                named: "asr-stream-audio-chunks",
                modelType: [ASREvent].self
            ) else {
                fatalError("No chunks json")
            }

            recursively(send: chunks)
        case .asrError:
            if event.message == "streamingSessionAlreadyExists" {
                shouldReconnectOnClosedConfirmation = true
                sendCloseEvent()
                print("Error: streamingSessionAlreadyExists")
            } else if event.message == "streamingSessionDoesNotExist" {
                print("Error: streamingSessionDoesNotExist")
                disconnect()
                connect()
            } else {
                print("Recived unhandled asr error: \(event.message ?? "")")
            }
        case .asrClosed:
            if shouldReconnectOnClosedConfirmation {
                shouldReconnectOnClosedConfirmation = false
                connect()
            }
        case .asrResult:
            guard let isFinal = event.isFinal else {
                print("No is final for asr result")
                break
            }

            guard let text = event.text else {
                print("No text for asr result")
                break
            }

            print("Recived text \(text)")
            onReceivedMessageAndIsFinal?(text, isFinal)
            if isFinal {
                print("Should close connection")
                disconnect()
            }
        }
    }

    private func recursively(
        send chunks: [ASREvent],
        currentIndex: Int = 0
    ) {
        guard currentIndex < chunks.count else {
            return
        }

        do {
            let messageData = try JSONEncoder().encode(chunks[currentIndex])

            webSocketTask?.send(.data(messageData)) { [weak self] error in
                if let error = error {
                    print("Error sending chunk with message: \(error.localizedDescription)")
                }

                self?.recursively(send: chunks, currentIndex: currentIndex + 1)
            }
        } catch {
            print("Failed to encode Chunk with error message: \(error.localizedDescription)")
        }
    }

    private func sendCloseEvent() {
        do {
            let messageData = try JSONEncoder().encode(ASREvent(type: .asrClose))

            webSocketTask?.send(.data(messageData)) { error in
                if let error = error {
                    print("Error sending closing with message: \(error.localizedDescription)")
                }
            }
        } catch {
            print("Failed to encode Chunk with error message: \(error.localizedDescription)")
        }
    }


    // MARK: - Disconnecting

    func disconnect() {
        sendCloseEvent()
        webSocketTask?.cancel(with: .normalClosure, reason: nil)
        webSocketTask = nil
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
