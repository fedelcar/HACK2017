//
//  Extensions.swift
//  PatagoniApp
//
//  Created by Omar Arias Mele on 8/4/17.
//  Copyright © 2017 OYSGroup SA. All rights reserved.
//

import Foundation

extension Date
{
	var age: Int
	{
		return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
	}
}
