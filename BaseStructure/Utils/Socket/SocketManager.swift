//
//  SocketManager.swift
//
//
//  Created by Gaurang Vyas on 28/01/22.
//

import SocketIO

class SocketIOManager: NSObject {
    static let shared = SocketIOManager()
    let manager = SocketManager(socketURL: URL(string: AppEnvironment.socketUrl)!, config: [.log(false), .compress])
    lazy var socket = manager.defaultSocket

    
    override init() {
        super.init()
        observeClientEvents()
        observeChatEvent()
        observeMessageEvent()
    }
    
    private func observeClientEvents() {
        socket.on(clientEvent: .connect) {_, _ in
            print("[socket] connected")
            SocketIOManager.shared.emit(.connectUser(userId: Helper.userId))
        }
        socket.on(clientEvent: .disconnect) {_, _ in
            print("[socket] disconnected")
        }
        socket.on(clientEvent: .reconnect) {_, _ in
            print("[socket] reconnect")
        }
        socket.on(clientEvent: .error) {data, _ in
            print("[socket] error", data)
        }
        
    }
    
    
    func observeBlockEvent(callback: @escaping (BlockUser) -> Void ) {
        observeOnEventCodable(.blockUser, callback: callback)
    }
    
    func observeUnblockEvent(callback: @escaping (BlockUser) -> Void ) {
        observeOnEventCodable(.unblockUser, callback: callback)
    }
    
    func observeOnEventCodable<T: Decodable>(_ key: OnEvent, callback: @escaping (T) -> Void) {
        
        self.socket.on(key.rawValue) { (data, _) in
            guard !data.isEmpty else {
                print("[SocketIO] \(key.rawValue) data empty")
                return
            }
            print(data[0])
            guard let decoded = try? T(from: data[0]) else {
                print("[SocketIO] \(key.rawValue) data \(data) cannot be decoded to \(T.self)")
                return
            }
            callback(decoded)
        }
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        if socket.status == .connected {
            socket.disconnect()
        }
    }
    
    func emit(_ event: EmitEvent) {
        socket.emit(event.eventId, with: [event.params])
        print("[socket] Emit: - \(event.eventId), params: - \(event.params)")
    }
}

extension Decodable {
    init(from any: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: any)
        self = try JSONDecoder().decode(Self.self, from: data)
    }
}
