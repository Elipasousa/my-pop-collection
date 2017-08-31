//
//  ServiceMock.swift
//  MyPopCollection
//
//  Created by Elisabete Bicho on 23/08/2017.
//  Copyright © 2017 Elisabete Sousa. All rights reserved.
//

import Foundation

class ServiceMock {
    
    static let sharedInstance: ServiceMock = ServiceMock()
    
    func getAllFranchises() -> [Franchise] {
        let f1 = Franchise()
        f1.name = "Harry Potter"
        f1.image = "https://cdn.poppriceguide.com/guide/charimg/HarryPotter.jpg"
        
        let f2 = Franchise()
        f2.name = "Futurama"
        f2.image = "https://cdn.poppriceguide.com/guide/charimg/Futurama.jpg"

        let f3 = Franchise()
        f3.name = "Game of Thrones"
        f3.image = "https://cdn.poppriceguide.com/guide/charimg/GameofThrones.jpg"
        
        let f4 = Franchise()
        f4.name = "The Hunger Games"
        f4.image = "https://cdn.poppriceguide.com/guide/charimg/TheHungerGames.jpg"
        
        let f5 = Franchise()
        f5.name = "Halo"
        f5.image = "https://cdn.poppriceguide.com/guide/charimg/Halo.jpg"

        return [f1, f2, f3, f4, f5]
    }
    
    func getItems(fromFranchise franchise: Franchise) -> [Item] {
        var items: [Item] = []
        
        if franchise.name == "Halo" {
            var p = Item()
            p.name = "Cortana"
            p.number = 6
            p.image = "https://cdn.poppriceguide.com/guide/itmimg/thumb/378_Cortana.jpg"
            p.franchise = "Halo"
            p.category = "Pop Vinyl Pop Halo"
            items.append(p)
        }
        
        if franchise.name == "Futurama" {
            var p = Item()
            p.name = "Leela"
            p.number = 28
            p.image = "https://cdn.poppriceguide.com/guide/itmimg/thumb/2504_leela.jpg"
            p.franchise = "Futurama"
            p.category = "Pop Vinyl Pop Animation"
            items.append(p)
            
            p = Item()
            p.name = "Nibbler"
            p.number = 56
            p.image = "https://cdn.poppriceguide.com/guide/itmimg/thumb/5937_nibbler.jpg"
            p.franchise = "Futurama"
            p.category = "Pop Vinyl Pop Animation"
            items.append(p)
        }
        
        if franchise.name == "Harry Potter" {
            var p = Item()
            p.name = "Harry Potter"
            p.number = 1
            p.image = "https://cdn.poppriceguide.com/guide/itmimg/thumb/3698_harrypotter.jpg"
            p.franchise = "Harry Potter"
            p.category = "Pop Vinyl Pop Harry Potter"
            items.append(p)
            
            p = Item()
            p.name = "Ron Weasley"
            p.number = 2
            p.image = "https://cdn.poppriceguide.com/guide/itmimg/thumb/3700_ronweasley.jpg"
            p.franchise = "Harry Potter"
            p.category = "Pop Vinyl Pop Harry Potter"
            items.append(p)

            p = Item()
            p.name = "Hermione Granger"
            p.number = 3
            p.image = "https://cdn.poppriceguide.com/guide/itmimg/thumb/3702_hermionegranger.jpg"
            p.franchise = "Harry Potter"
            p.category = "Pop Vinyl Pop Harry Potter"
            items.append(p)

            p = Item()
            p.name = "Ginny Weasley"
            p.number = 46
            p.image = "https://cdn.poppriceguide.com/guide/itmimg/thumb/11160_ginnyweasley_1503376459.jpg"
            p.franchise = "Harry Potter"
            p.category = "Pop Vinyl Pop Harry Potter"
            items.append(p)

            p = Item()
            p.name = "Harry Potter, Ron Weasley & Hermione Granger (3-Pack)"
            p.image = "https://cdn.poppriceguide.com/guide/itmimg/thumb/4963_harrypotterronweasleyhermionegranger.jpg"
            p.franchise = "Harry Potter"
            p.category = "Pop Vinyl Pop Harry Potter"
            items.append(p)

            p = Item()
            p.name = "Harry Potter on Broom"
            p.number = 31
            p.image = "https://cdn.poppriceguide.com/guide/itmimg/thumb/10828_harrypotteronbroom_1497918543.jpg"
            p.franchise = "Harry Potter"
            p.category = "Pop Vinyl Pop Harry Potter"
            items.append(p)

            p = Item()
            p.name = "Albus Dumbledore"
            p.number = 4
            p.image = "https://cdn.poppriceguide.com/guide/itmimg/thumb/3703_albusdumbledore.jpg"
            p.franchise = "Harry Potter"
            p.category = "Pop Vinyl Pop Harry Potter"
            items.append(p)
            
            p = Item()
            p.name = "Albus Dumbledore (Prisoner of Azkaban)"
            p.number = 15
            p.image = "https://cdn.poppriceguide.com/guide/itmimg/thumb/5959_albusdumbledoreprisonerofazkaban.jpg"
            p.franchise = "Harry Potter"
            p.category = "Pop Vinyl Pop Harry Potter"
            items.append(p)
            
            p = Item()
            p.name = "Bellatrix Lestrange"
            p.number = 35
            p.image = "https://cdn.poppriceguide.com/guide/itmimg/thumb/8580_bellatrixlestrange_1476217438.jpg"
            p.franchise = "Harry Potter"
            p.category = "Pop Vinyl Pop Harry Potter"
            items.append(p)
            
            p = Item()
            p.name = "Bellatrix Lestrange (Prisoner)"
            p.number = 29
            p.image = "https://cdn.poppriceguide.com/guide/itmimg/thumb/8576_bellatrixlestrangeprisoner_1476216053.jpg"
            p.franchise = "Harry Potter"
            p.category = "Pop Vinyl Pop Harry Potter"
            items.append(p)
            
            p = Item()
            p.name = "Cedric Diggory"
            p.number = 20
            p.image = "https://cdn.poppriceguide.com/guide/itmimg/thumb/6094_cedricdiggory_1454367212.jpg"
            p.franchise = "Harry Potter"
            p.category = "Pop Vinyl Pop Harry Potter"
            items.append(p)
            
            p = Item()
            p.name = "Cornish Pixie, Mandrake & Grindylow (3-Pack)"
            p.image = "https://cdn.poppriceguide.com/guide/itmimg/thumb/7754_cornishpixiemandrakegrindylow3pack_1467907320.jpg"
            p.franchise = "Harry Potter"
            p.category = "Pop Vinyl Pop Harry Potter"
            items.append(p)
            
            p = Item()
            p.name = "Dementor"
            p.number = 18
            p.image = "https://cdn.poppriceguide.com/guide/itmimg/thumb/5903_dementor.jpg"
            p.franchise = "Harry Potter"
            p.category = "Pop Vinyl Pop Harry Potter"
            items.append(p)
            
            p = Item()
            p.name = "Dobby"
            p.number = 17
            p.image = "https://cdn.poppriceguide.com/guide/itmimg/thumb/5905_dobby.jpg"
            p.franchise = "Harry Potter"
            p.category = "Pop Vinyl Pop Harry Potter"
            items.append(p)
        }
        return items
    }
}
