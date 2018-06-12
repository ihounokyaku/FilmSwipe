//
//  Global Variables.swift
//  FilmSwipe
//
//  Created by Dylan Southard on 2018/06/12.
//  Copyright © 2018 Dylan Southard. All rights reserved.
//

import Foundation

var DocumentsDirectory: URL {
    get {
       return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
