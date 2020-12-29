//
//  LabelFormatter.swift
//  CountdownTimer3 WatchKit Extension
//
//  Created by Arjan van der Meer on 28/12/2020.
//

import Foundation
import SwiftUI

struct CountdownTextFormatter
{
    var labels:Int
    var labelCounter:Int = 0
    var firstLineDisplayed = false

    
    mutating func format(singleLabel single:String, multipleLabel:String?, amountLabel:Int?) -> Text?
    {
        var amount:Int
        
        if ( amountLabel == nil)
        {
          //  amount = 0
            return nil
        } else {
            amount = amountLabel!
        }
        
        if (!firstLineDisplayed )
        {
            if ( amount == 0 )
            {
                return nil
            } else {
                firstLineDisplayed = true
            }
        }
        
        var multiple = ""
        
        if ( multipleLabel==nil ){
            multiple=single+"s"
        } else {
            multiple = multipleLabel!
        }
        
        labelCounter += 1
        
        if(amount == 1)
        {
            return Text("\(amount) \(single)")
        } else {
            return Text("\(amount) \(multiple)")
        }
    }
}
