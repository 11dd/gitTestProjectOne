//
//  UIView+IQToolbar.h
// https://github.com/hackiftekhar/IQKeyboardManager
// Copyright (c) 2013-14 Iftekhar Qurashi.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import <UIKit/UIView.h>

@class UIBarButtonItem;

/*!
    @category UIView (Toolbar)
 
    @since iOS (5.0 and later), ARC Required
 
    @abstract UIView category methods to add IQToolbar on UIKeyboard.
 */
@interface UIView (Toolbar)


- (void)addRightButtonOnKeyboardWithText:(NSString*)text target:(id)target action:(SEL)action;
- (void)addRightButtonOnKeyboardWithText:(NSString*)text target:(id)target action:(SEL)action shouldShowPlaceholder:(BOOL)showPlaceholder;
- (void)addRightButtonOnKeyboardWithText:(NSString*)text target:(id)target action:(SEL)action titleText:(NSString*)titleText;
- (void)addDoneOnKeyboardWithTarget:(id)target action:(SEL)action;
- (void)addDoneOnKeyboardWithTarget:(id)target action:(SEL)action shouldShowPlaceholder:(BOOL)showPlaceholder;
- (void)addDoneOnKeyboardWithTarget:(id)target action:(SEL)action titleText:(NSString*)titleText;



- (void)addRightLeftOnKeyboardWithTarget:(id)target leftButtonTitle:(NSString*)leftTitle rightButtonTitle:(NSString*)rightTitle rightButtonAction:(SEL)rightAction leftButtonAction:(SEL)leftAction;
- (void)addRightLeftOnKeyboardWithTarget:(id)target leftButtonTitle:(NSString*)leftTitle rightButtonTitle:(NSString*)rightTitle rightButtonAction:(SEL)rightAction leftButtonAction:(SEL)leftAction shouldShowPlaceholder:(BOOL)showPlaceholder;
- (void)addRightLeftOnKeyboardWithTarget:(id)target leftButtonTitle:(NSString*)leftTitle rightButtonTitle:(NSString*)rightTitle rightButtonAction:(SEL)rightAction leftButtonAction:(SEL)leftAction titleText:(NSString*)titleText;
- (void)addCancelDoneOnKeyboardWithTarget:(id)target cancelAction:(SEL)cancelAction doneAction:(SEL)doneAction;
- (void)addCancelDoneOnKeyboardWithTarget:(id)target cancelAction:(SEL)cancelAction doneAction:(SEL)doneAction shouldShowPlaceholder:(BOOL)showPlaceholder;
- (void)addCancelDoneOnKeyboardWithTarget:(id)target cancelAction:(SEL)cancelAction doneAction:(SEL)doneAction titleText:(NSString*)titleText;


- (void)addPreviousNextDoneOnKeyboardWithTarget:(id)target previousAction:(SEL)previousAction nextAction:(SEL)nextAction doneAction:(SEL)doneAction;
- (void)addPreviousNextDoneOnKeyboardWithTarget:(id)target previousAction:(SEL)previousAction nextAction:(SEL)nextAction doneAction:(SEL)doneAction shouldShowPlaceholder:(BOOL)showPlaceholder;
- (void)addPreviousNextDoneOnKeyboardWithTarget:(id)target previousAction:(SEL)previousAction nextAction:(SEL)nextAction doneAction:(SEL)doneAction titleText:(NSString*)titleText;

- (void)setEnablePrevious:(BOOL)isPreviousEnabled next:(BOOL)isNextEnabled;

@end


