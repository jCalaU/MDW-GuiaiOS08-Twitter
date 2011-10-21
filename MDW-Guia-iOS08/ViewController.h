//
//  ViewController.h
//  MDW-Guia-iOS08
//
//  Created by Javier Cala Uribe on 19/10/11.
//  Copyright (c) 2011 *. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SA_OAuthTwitterController.h"

@class SA_OAuthTwitterEngine;

@interface ViewController : UIViewController <SA_OAuthTwitterControllerDelegate>
{
    SA_OAuthTwitterEngine	*_engine;
}

@property (nonatomic, retain) SA_OAuthTwitterEngine *_engine;

- (IBAction)postTwitter;
- (void)sendTweet;


@end
