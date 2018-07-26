//
//  ITMessagingMockProvider.swift
//  IcmpType0
//
//  Created by Franco Risma on 23/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import Foundation

class ITMessagingMockProvider: ITMessagingProviderProtocol {
    
    static let shared = ITMessagingMockProvider()
    
    private init() {
    }
    
    func send(message: Message, onCompletion: (NSError?) -> Void) {
        onCompletion(nil)
        
        //Reply back by sending a new message and posting a notification
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            let newReplyMessage = self.createReceivingMessageFor(data: message.rawData, type: message.type)
            NotificationCenter.default.post(name: .kITNotificationMessageReceived, object: ITMessagingMockProvider.shared, userInfo: ["data": newReplyMessage])
        })
    }
    
    func getMessages(onCompletion: (Messages?, NSError?) -> Void) {
        guard let messages = try? JSONDecoder().decode(Messages.self, from: mockChats.data(using: .utf8)!) else {
            print("Error: Couldn't decode data into Chat")
            onCompletion(nil,NSError(domain:"com.icmpType0", code:500, userInfo:nil) )
            return
        }
        onCompletion(messages,nil)
    }
    
    func getChats(onCompletion: (Chats?, NSError?) -> Void) {
        guard let chats = try? JSONDecoder().decode(Chats.self, from: mockChats.data(using: .utf8)!) else {
            print("Error: Couldn't decode data into Chat")
            onCompletion(nil,NSError(domain:"com.icmpType0", code:500, userInfo:nil) )
            return
        }
        onCompletion(chats,nil)
    }
    
    // MARK: Internal
    
    private func createReceivingMessageFor(data: Data, type: MessageType) -> Message {
        let date = 02051987
        let uid = "999"
        
        return Message(type: type, rawData: data, date: date, userId: uid, userName: "The Bot")
    }
    
    let mockChats = """
                    {
                        "chat": [
                            {
                                "lastMessage": "Para un argentino no hay nada mejor que otro argentino",
                                "time": 1234566,
                                "member": "8",
                                "memberAlias": "Pedro Risma"
                            },
                            {
                                "lastMessage": "Would you like to learn Swift?",
                                "time": 1234566,
                                "member": "2",
                                "memberAlias": "Rocio Gatica"
                            },
                            {
                                "lastMessage": "Te amo papá",
                                "time": 1234566,
                                "member": "3",
                                "memberAlias": "Emilia Risma"
                            },
                            {
                                "lastMessage": "Abrigate que está frío",
                                "time": 1234566,
                                "member": "4",
                                "memberAlias": "Marina Flores"
                            },
                            {
                                "lastMessage": "Ya compre las pelotas para el metegol",
                                "time": 1827364872,
                                "member": "5",
                                "memberAlias": "Elias Medina"
                            },
                            {
                                "lastMessage": "Feliz día",
                                "time": 1234566,
                                "member": "6",
                                "memberAlias": "Juanma Rodriguez"
                            },
                            {
                                "lastMessage": "7 - 0 le ganamos, nos deben una coca",
                                "time": 1234566,
                                "member": "7",
                                "memberAlias": "Carlos Albornoz"
                            },
                            {
                                "lastMessage": "Hola, que haces?",
                                "time": 12345677,
                                "member": "1",
                                "memberAlias": "Franco Risma"
                            }
                            
                        ]
                    }
                    """
    
    let mockMessages = """
                    {
                        "messages": [
                                {
                                    "message": "Hello",
                                    "name": "Franco Risma",
                                    "member": "1",
                                    "timestamp": 1234566
                                },
                                {
                                    "message": "How are you?",
                                    "name": "Bot",
                                    "member": "999",
                                    "timestamp": 354355535
                                },
                                {
                                    "message": "Fine thanks",
                                    "name": "Franco Risma",
                                    "member": "1",
                                    "timestamp": 123456342
                                }
                        ]
                    }
                    """
}
