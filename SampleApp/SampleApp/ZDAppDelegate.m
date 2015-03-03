//
//  ZDAppDelegate.m
//  SampleApp
//
//  Created by Zendesk on 23/04/2014.
//  Copyright (c) 2014 Zendesk. All rights reserved.
//


#import "ZDAppDelegate.h"
#import "ZDSampleViewController.h"
#import <ZendeskSDK/ZendeskSDK.h>


@implementation ZDAppDelegate


- (BOOL) application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    [ZDKDispatcher setDebugLogging:YES];
    
    [ZDKLogger enable:YES];

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // OPTIONAL - you can choose to set tags or additional info at any stage
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    [ZDKRequests configure:^(ZDKAccount *account, ZDKRequestCreationConfig *requestCreationConfig) {

        // specify any additional tags desired
        requestCreationConfig.tags = [NSArray arrayWithObjects:@"tag_one", @"tag_two", nil];

        // add some custom content to the description
        NSString *additionalText = @"Some sample extra content.";

        NSString *txt = [NSString stringWithFormat:@"%@%@",
                         [requestCreationConfig contentSeperator],
                         additionalText];

        requestCreationConfig.additionalRequestInfo = txt;
    }];


    /////////////////////////////////////////////////////////////////////////////////////////////////////
    // OPTIONAL - Customize appearance
    /////////////////////////////////////////////////////////////////////////////////////////////////////
    //[self setAppearanceProperties];


    /////////////////////////////////////////////////////////////////////////////////////////////////////
    // Sample app boilerplate
    /////////////////////////////////////////////////////////////////////////////////////////////////////

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.window.backgroundColor = [UIColor colorWithWhite:0.94f alpha:1.0f];
    
    // top view controller
    ZDSampleViewController *vc = [[ZDSampleViewController alloc] initWithNibName:nil bundle:nil];
    
    // nav controller
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    // assign nav controller as root
    self.window.rootViewController = navController;
    
    // make key window
    [self.window makeKeyAndVisible];
    
    if (SYSTEM_VERSION_GREATER_THAN_SEVEN) {
        
        // status bar
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
        // nav bar
        NSDictionary *navbarAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIColor whiteColor] ,UITextAttributeTextColor, nil];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.4705f green:0.6392f blue:0.0f alpha:1.0f]];
        [[UINavigationBar appearance] setTitleTextAttributes:navbarAttributes];
    }
    return YES;
}

- (void) setAppearanceProperties
{
    // request creation screen
    [[ZDKCreateRequestView appearance] setPlaceholderTextColor:[UIColor lightGrayColor]];
    [[ZDKCreateRequestView appearance] setTextEntryColor:[UIColor whiteColor]];
    [[ZDKCreateRequestView appearance] setTextEntryBackgroundColor:[UIColor blackColor]];
    [[ZDKCreateRequestView appearance] setViewBackgroundColor:[UIColor blackColor]];
    [[ZDKCreateRequestView appearance] setTextEntryFont:[UIFont systemFontOfSize:12.0f]];
    
    [[ZDKCreateRequestView appearance] setAttachmentButtonImage:[ZDKBundleUtils imageNamed:@"icoAttach" ofType:@"png"]];
    [[ZDKCreateRequestView appearance] setAttachmentButtonBackground:[UIColor blackColor]];
    [[ZDKCreateRequestView appearance] setAttachmentButtonBorderColor:[UIColor darkGrayColor]];
    [[ZDKCreateRequestView appearance] setAttachmentButtonBorderWidth:@2];
    [[ZDKCreateRequestView appearance] setAttachmentButtonCornerRadius:@10];
    
    [[ZDKCreateRequestView appearance] setAutomaticallyHideNavBarOnLandscape:@1];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [[ZDKCreateRequestView appearance] setSpinner:(id<ZDKSpinnerDelegate>)spinner];
    
    // request list
    [[ZDKRequestListTable appearance] setTableBackgroundColor:[UIColor blackColor]];
    [[ZDKRequestListTable appearance] setBackgroundColor:[UIColor blackColor]];
    [[ZDKRequestListTable appearance] setCellSeparatorColor:[UIColor darkGrayColor]];
    [[UIScrollView appearanceWhenContainedIn:[ZDKRequestListViewController class], nil] setBackgroundColor:[UIColor blackColor]];
    
    // loading cell
    UIActivityIndicatorView * requestListSpinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(20, 20, 20, 20)];
    requestListSpinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [[ZDRequestListLoadingTableCell appearance] setSpinner:(id<ZDKSpinnerDelegate>)requestListSpinner];
    
    // request list cells
    [[ZDKRequestListTableCell appearance] setDescriptionFont:[UIFont systemFontOfSize:15]];
    [[ZDKRequestListTableCell appearance] setCreatedAtFont:[UIFont systemFontOfSize:13]];
    [[ZDKRequestListTableCell appearance] setUnreadColor:[UIColor colorWithRed:0.47059 green:0.6392 blue:0 alpha:1.0]];
    [[ZDKRequestListTableCell appearance] setDescriptionColor:[UIColor colorWithWhite:0.88f alpha:1.0f]];
    [[ZDKRequestListTableCell appearance] setCreatedAtColor:[UIColor lightGrayColor]];
    [[ZDKRequestListTableCell appearance] setVerticalMargin:@20.0f];
    [[ZDKRequestListTableCell appearance] setDescriptionTimestampMargin:@5.0f];
    [[ZDKRequestListTableCell appearance] setLeftInset:@25.0f];
    [[ZDKRequestListTableCell appearance] setCellBackgroundColor:[UIColor blackColor]];
    
    // no requests cell
    [[ZDRequestListEmptyTableCell appearance] setMessageFont:[UIFont systemFontOfSize:11.0f]];
    [[ZDRequestListEmptyTableCell appearance] setMessageColor:[UIColor lightGrayColor]];

    
    // comments list agent comment cells
    [[ZDKAgentCommentTableCell appearance] setAvatarSize:@40.0f];
    [[ZDKAgentCommentTableCell appearance] setAgentNameFont:[UIFont systemFontOfSize:14.0f]];
    [[ZDKAgentCommentTableCell appearance] setAgentNameColor:[UIColor lightGrayColor]];
    [[ZDKAgentCommentTableCell appearance] setTimestampFont:[UIFont systemFontOfSize:11.0f]];
    [[ZDKAgentCommentTableCell appearance] setTimestampColor:[UIColor blackColor]];
    [[ZDKAgentCommentTableCell appearance] setBodyFont:[UIFont systemFontOfSize:15.0f]];
    [[ZDKAgentCommentTableCell appearance] setBodyColor:[UIColor colorWithWhite:0.88f alpha:1.0f]];
    [[ZDKAgentCommentTableCell appearance] setCellBackground:[UIColor darkGrayColor]];
    
    // comments list end user comment cells
    [[ZDKEndUserCommentTableCell appearance] setTimestampFont:[UIFont systemFontOfSize:11.0f]];
    [[ZDKEndUserCommentTableCell appearance] setTimestampColor:[UIColor darkGrayColor]];
    [[ZDKEndUserCommentTableCell appearance] setBodyFont:[UIFont systemFontOfSize:15.0f]];
    [[ZDKEndUserCommentTableCell appearance] setBodyColor:[UIColor colorWithWhite:0.88f alpha:1.0f]];
    [[ZDKEndUserCommentTableCell appearance] setCellBackground:[UIColor colorWithWhite:0.10f alpha:1.0f]];
    
    // comments list loading cell
    UIActivityIndicatorView *commentSpinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    commentSpinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    commentSpinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [[ZDKCommentsListLoadingTableCell appearance] setSpinner:(id<ZDKSpinnerDelegate>)spinner];
    [[ZDKCommentsListLoadingTableCell appearance] setCellBackground:[UIColor blackColor]];
    [[ZDKCommentsListLoadingTableCell appearance] setLeftInset:@25.0f];
    
    // comment input area
    [[ZDKCommentInputView appearance] setTopBorderColor:[UIColor colorWithWhite:0.11f alpha:1.0f]];
    [[ZDKCommentInputView appearance] setTextEntryFont:[UIFont systemFontOfSize:15]];
    [[ZDKCommentInputView appearance] setTextEntryColor:[UIColor colorWithWhite:0.88f alpha:1.0f]];
    [[ZDKCommentInputView appearance] setTextEntryBackgroundColor:[UIColor darkGrayColor]];
    [[ZDKCommentInputView appearance] setTextEntryBorderColor:[UIColor lightGrayColor]];
    [[ZDKCommentInputView appearance] setSendButtonFont:[UIFont systemFontOfSize:12]];
    [[ZDKCommentInputView appearance] setSendButtonColor:[UIColor whiteColor]];
    [[ZDKCommentInputView appearance] setAreaBackgroundColor:[UIColor blackColor]];
    [[ZDKCommentInputView appearance] setBackgroundColor:[UIColor blackColor]];
    [[UITableView appearance] setSeparatorColor:[UIColor lightGrayColor]];
    [[UITableView appearance] setBackgroundColor:[UIColor blackColor]];
    
    //Comments list attachments
    [[ZDKRequestCommentAttachmentLoadingTableCell appearance] setBackgroundColor:[UIColor darkGrayColor]];
    [[ZDKCommentsListLoadingTableCell appearance] setBackgroundColor:[UIColor darkGrayColor]];
    [[ZDKRequestCommentAttachmentTableCell appearance] setBackgroundColor:[UIColor blackColor]];
    [[ZDKUILoadingView appearance] setBackgroundColor:[UIColor darkGrayColor]];
    
    
    //Image viewer
    [[ZDKAttachmentView appearance] setBackgroundColor:[UIColor blackColor]];
    [[ZDKAttachmentView appearance] setCloseButtonBackgroundColor:[UIColor blackColor]];
    [[ZDKUIImageScrollView appearance] setBackgroundColor:[UIColor blackColor]];
    
    //header
    [[ZDKRMADialogView appearance] setHeaderBackgroundColor:[UIColor blackColor]];
    [[ZDKRMADialogView appearance] setHeaderColor:[UIColor whiteColor]];
    [[ZDKRMADialogView appearance] setHeaderFont:[UIFont systemFontOfSize:16.0f]];
    //Button
    [[ZDKRMADialogView appearance] setButtonBackgroundColor:[UIColor blackColor]];
    [[ZDKRMADialogView appearance] setButtonSelectedBackgroundColor:[UIColor whiteColor]];
    [[ZDKRMADialogView appearance] setButtonColor:[UIColor whiteColor]];
    [[ZDKRMADialogView appearance] setButtonFont:[UIFont systemFontOfSize:14.0f]];
    //Seperator
    [[ZDKRMADialogView appearance] setSeparatorLineColor:[UIColor darkGrayColor]];
    
    // style thefeedback view
    [[ZDKRMAFeedbackView appearance] setHeaderFont:[UIFont systemFontOfSize:16.0f]];
    [[ZDKRMAFeedbackView appearance] setSubheaderFont:[UIFont systemFontOfSize:12.0f]];
    [[ZDKRMAFeedbackView appearance] setSeparatorLineColor:[UIColor colorWithWhite:0.2627f alpha:1.0f]];
    [[ZDKRMAFeedbackView appearance] setButtonBackgroundColor:[UIColor blackColor]];
    [[ZDKRMAFeedbackView appearance] setButtonColor:[UIColor whiteColor]];
    [[ZDKRMAFeedbackView appearance] setButtonSelectedColor:[UIColor grayColor]];
    [[ZDKRMAFeedbackView appearance] setButtonFont:[UIFont systemFontOfSize:14.0f]];
    [[ZDKRMAFeedbackView appearance] setTextEntryFont:[UIFont systemFontOfSize:12.0f]];
    [[ZDKRMAFeedbackView appearance] setHeaderColor:[UIColor whiteColor]];
    [[ZDKRMAFeedbackView appearance] setSubHeaderColor:[UIColor whiteColor]];
    [[ZDKRMAFeedbackView appearance] setTextEntryColor:[UIColor whiteColor]];
    [[ZDKRMAFeedbackView appearance] setTextEntryBackgroundColor:[UIColor blackColor]];
    [[ZDKRMAFeedbackView appearance] setViewBackgroundColor:[UIColor blackColor]];
    [[ZDKRMAFeedbackView appearance] setPlaceHolderColor:[UIColor grayColor]];
    
    UIActivityIndicatorView *rmaSpinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [[ZDKRMAFeedbackView appearance] setSpinner:(id<ZDKSpinnerDelegate>)rmaSpinner];
    
    
    // style the help center
    UIActivityIndicatorView *hcSpinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [[ZDKSupportView appearance] setSpinner:(id<ZDKSpinnerDelegate>)hcSpinner];
    
    [[ZDKSupportView appearance] setViewBackgroundColor:[UIColor blackColor]];
    [[ZDKSupportView appearance] setTableBackgroundColor:[UIColor blackColor]];
    [[ZDKSupportView appearance] setSearchBarStyle:@(UIBarStyleBlack)];
    [[ZDKSupportView appearance] setSeparatorColor:[UIColor darkGrayColor]];
    [[ZDKSupportView appearance] setNoResultsFoundLabelFont:[UIFont systemFontOfSize:14.0f]];
    [[ZDKSupportView appearance] setNoResultsFoundLabelColor:[UIColor lightGrayColor]];
    [[ZDKSupportView appearance] setNoResultsFoundLabelBackground:[UIColor blackColor]];
    [[ZDKSupportView appearance] setNoResultsContactButtonBackground:[UIColor blackColor]];
    [[ZDKSupportView appearance] setNoResultsContactButtonBorderColor:[UIColor colorWithWhite:0.2627f alpha:1.0f]];
    [[ZDKSupportView appearance] setNoResultsContactButtonBorderWidth:@1.0f];
    [[ZDKSupportView appearance] setNoResultsContactButtonCornerRadius:@4.0f];
    [[ZDKSupportView appearance] setNoResultsFoundLabelFont:[UIFont systemFontOfSize:14.0f]];
    [[ZDKSupportView appearance] setNoResultsContactButtonEdgeInsets:[NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(12, 22, 12, 22)]];
    [[ZDKSupportView appearance] setNoResultsContactButtonTitleColorNormal:[UIColor whiteColor]];
    [[ZDKSupportView appearance] setNoResultsContactButtonTitleColorHighlighted:[UIColor whiteColor]];
    [[ZDKSupportView appearance] setNoResultsContactButtonTitleColorDisabled:[UIColor whiteColor]];
    
    //HC search cell
    [[ZDKSupportTableViewCell appearance] setBackgroundColor:[UIColor blackColor]];
    [[ZDKSupportTableViewCell appearance] setTitleLabelBackground:[UIColor blackColor]];
    [[ZDKSupportTableViewCell appearance] setTitleLabelColor:[UIColor colorWithWhite:0.88f alpha:1.0f]];
    [[ZDKSupportTableViewCell appearance] setTitleLabelFont:[UIFont systemFontOfSize:18.0f]];
    
    [[ZDKSupportArticleTableViewCell appearance] setBackgroundColor:[UIColor blackColor]];
    [[ZDKSupportArticleTableViewCell appearance] setArticleParentsLabelFont:[UIFont systemFontOfSize:12.0f]];
    [[ZDKSupportArticleTableViewCell appearance] setArticleParentsLabelColor:[UIColor darkGrayColor]];
    [[ZDKSupportArticleTableViewCell appearance] setArticleParnetsLabelBackground:[UIColor blackColor]];
    [[ZDKSupportArticleTableViewCell appearance] setTitleLabelFont:[UIFont systemFontOfSize:18.0f]];
    [[ZDKSupportArticleTableViewCell appearance] setTitleLabelColor:[UIColor colorWithWhite:0.2627f alpha:1.0f]];
    [[ZDKSupportArticleTableViewCell appearance] setTitleLabelBackground:[UIColor blackColor]];
    
    [[ZDKSupportAttachmentCell appearance] setBackgroundColor:[UIColor darkGrayColor]];
    [[ZDKSupportAttachmentCell appearance] setTitleLabelBackground:[UIColor darkGrayColor]];
    [[ZDKSupportAttachmentCell appearance] setTitleLabelColor:[UIColor lightGrayColor]];
    [[ZDKSupportAttachmentCell appearance] setTitleLabelFont:[UIFont systemFontOfSize:12.0f]];
    [[ZDKSupportAttachmentCell appearance] setFileSizeLabelBackground:[UIColor darkGrayColor]];
    [[ZDKSupportAttachmentCell appearance] setFileSizeLabelColor:[UIColor lightGrayColor]];
    [[ZDKSupportAttachmentCell appearance] setFileSizeLabelFont:[UIFont systemFontOfSize:12.0f]];
    
    

}


@end

