//
//  ViewController.m
//  MDW-Guia-iOS08
//
//  Created by Javier Cala Uribe on 19/10/11.
//  Copyright (c) 2011 *. All rights reserved.
//

#import "ViewController.h"
#import "SA_OAuthTwitterEngine.h"

#define kOAuthConsumerKey				@"YOUR_ConsumerKey"
#define kOAuthConsumerSecret			@"YOUR_ConsumerSecret"


@implementation ViewController

@synthesize _engine;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


#pragma mark Twitter

- (IBAction)postTwitter
{
	if(!_engine)
    {
		_engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate:self];
		_engine.consumerKey    = kOAuthConsumerKey;
		_engine.consumerSecret = kOAuthConsumerSecret;	
	}
	
	UIViewController *controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine:_engine delegate:self];
    
	if (controller)
    {	
		[self presentModalViewController:controller animated:YES];	
	}
	else 
		[self sendTweet];
}


- (void)sendTweet 
{
	NSString  *mensaje = @"Excelente la Guia para iPhone y iPad de @maestros :)";
    
    [_engine sendUpdate:mensaje];
    
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Posted To Twitter" 
                                                        message:mensaje
													   delegate:self 
                                              cancelButtonTitle:@"Accept" 
                                              otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

#pragma mark SA_OAuthTwitterEngineDelegate

- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username 
{
	NSUserDefaults			*defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setObject: data forKey: @"authData"];
	[defaults synchronize];
	
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Twitter Authentication" 
													message:@"Logged correctly. Please press again the twitter button to send message."
												   delegate:self 
                                          cancelButtonTitle:@"Accept" 
                                          otherButtonTitles:nil];
	[alert show];
	[alert release];	
    
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username 
{
	return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
}

#pragma mark TwitterEngineDelegate

- (void) requestSucceeded: (NSString *) requestIdentifier 
{
	NSLog(@"Request %@ succeeded", requestIdentifier);
}

- (void) requestFailed: (NSString *) requestIdentifier withError: (NSError *) error 
{
	NSLog(@"Request %@ failed with error: %@", requestIdentifier, error);
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
