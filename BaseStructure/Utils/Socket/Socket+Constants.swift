//
//  Socket+Constants.swift
//  
//
//  Created by Gaurang Vyas on 28/01/22.
//

import Foundation

extension SocketIOManager {
    
    enum OnEvent: String {
        case receiveMessage = "send_message"
        case disconnect
        case newMessage     = "connect_user"
        case blockUser      = "block_user"
        case unblockUser    = "unblock_user"
    }
    
    enum SocketKeys {
        static let userId       = "user_id"
        static let senderId     = "sender_id"
        static let receiverId   = "receiver_id"
        static let message      = "message"
        static let blockUser    = "block_user"
        static let unblockUser  = "unblock_user"
    }
    
    enum EmitEvent {
        case connectUser(userId: String)
        case sendMessage(recieverId: String, message: String)
        case readAllMessages(recieverId: String)
        case blockUser(userId: String)
        case unblockUser(userId: String)
        
        var eventId: String {
            switch self {
            case .connectUser:      return "connect_user"
            case .sendMessage:      return "send_message"
            case .readAllMessages:  return "read_all_message"
            case .blockUser:        return "block_user"
            case .unblockUser:      return "unblock_user"
            }
        }
        
        var params: [String: Any] {
            switch self {
            case .connectUser(let userId):
                return [SocketKeys.userId: userId]
            case .sendMessage(let recieverId, let message):
                return [SocketKeys.senderId: Helper.userId,
                             SocketKeys.receiverId: recieverId,
                             SocketKeys.message: message]
            case .readAllMessages(let recieverId):
                return [SocketKeys.senderId: Helper.userId,
                             SocketKeys.receiverId: recieverId]
            case .blockUser(let userId):
                return [SocketKeys.blockUser: userId, SocketKeys.senderId: Helper.userId, SocketKeys.receiverId: userId]
            case .unblockUser(let userId):
                return [SocketKeys.blockUser: userId, SocketKeys.senderId: Helper.userId, SocketKeys.receiverId: userId]
            }
        }
    }
}
