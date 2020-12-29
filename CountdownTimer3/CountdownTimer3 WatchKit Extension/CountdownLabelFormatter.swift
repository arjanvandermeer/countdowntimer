//
//  LabelFormatter.swift
//  CountdownTimer3 WatchKit Extension
//
//  Created by Arjan van der Meer on 28/12/2020.
//

import Foundation
import SwiftUI

struct CountdownLabelFormatter
{
    var labels:Int
    
    mutating func format(singleLabel single:String, multipleLabel:String, amount:Int?) -> Text?
    {
        if ( amount == nil )
        {
            return nil
        }
        if(amount == 1)
        {
            return Text("\(single)")
        } else {
            return Text("\(multipleLabel)")
        }
    }
}
