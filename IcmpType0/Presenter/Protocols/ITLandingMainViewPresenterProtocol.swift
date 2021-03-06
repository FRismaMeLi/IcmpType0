//
//  ITLandingMainViewPresenterProtocol.swift
//  IcmpType0
//
//  Created by Franco Risma on 19/07/2018.
//  Copyright © 2018 FRisma. All rights reserved.
//

import Foundation

protocol ITLandingMainViewPresenterProtocol {
    
    func setViewDelegate(delegate :ITLandingMainViewControllerProtocol)
    func fetchConversations()
    func conversationTapped()
    func composeButtonTapped()
}
