//
//  UITextField+Tel.swift
//  MCComon
//
//  Created by sabrina on 2018/3/12.
//  Copyright © 2018年 yuanjuhong. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    public var selectedRange:NSRange{
        set{
            let beginning = self.beginningOfDocument;
            let startPosition = self.position(from: beginning, offset: newValue.location)
//                [self positionFromPosition:beginning offset:range.location];
            let endPosition = self.position(from: beginning, offset:  newValue.location + newValue.length)
//                [self positionFromPosition:beginning offset:range.location + range.length];
            let selectionRange = self.textRange(from: startPosition!, to: endPosition!)
//                [self textRangeFromPosition:startPosition toPosition:endPosition];
            self.selectedTextRange = selectionRange
       //     [self setSelectedTextRange:selectionRange];
        }
        get{
            let beginning = self.beginningOfDocument;
            let selectedRange = self.selectedTextRange;
            let selectionStart = selectedRange?.start;
            let selectionEnd = selectedRange?.end;
            let location = self.offset(from: beginning, to: selectionStart!)
//                [self offsetFromPosition:beginning toPosition:selectionStart];
            let length = self.offset(from: selectionStart!, to: selectionEnd!)
//                [self offsetFromPosition:selectionStart toPosition:selectionEnd];
            return NSMakeRange(location, length);
        }
    }
}
