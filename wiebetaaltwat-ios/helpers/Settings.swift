//
//  Settings.swift
//  parkeerpas-ios
//
//  Created by Markus Wind on 5/19/16.
//  Copyright © 2016 Wind. All rights reserved.
//

import Foundation
import UIKit

struct SETTINGS {

    // Global variables
    static let DEBUG: Bool = true

    static let screenWidth = UIScreen.mainScreen().bounds.width
    static let screenHeight = UIScreen.mainScreen().bounds.height

    // WelcomeViewController texts
    static let infoTextOne = "Komt uw bezoek aan op een tijdstip dat er geen betaald parkeren geldt? En blijft het bezoek de volgende dag minimaal tot een tijdstip dat er wel betaald parkeren geldt? Dan kunt u uw bezoekerspas 's avonds alvast aanmelden. Dan wordt de pas de volgende ochtend automatisch aangemeld."

    static let infoTextTwo = "Is uw bezoek er nog op het moment dat de betaald parkeren-tijd is afgelopen? Dan wordt uw bezoekerspas automatisch afgemeld. Blijft uw bezoek daarna ook nog minimaal tot een tijdstip op de volgende dag dat er wel weer betaald parkeren geldt? Dan moet u uw bezoekerspas weer opnieuw aanmelden. Dat kan de voorgaande avond alvast. Dan wordt de pas de volgende ochtend automatisch weer aangemeld."

}
