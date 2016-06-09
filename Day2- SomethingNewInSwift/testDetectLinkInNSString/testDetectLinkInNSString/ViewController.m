//
//  ViewController.m
//  testDetectLinkInNSString
//
//  Created by Le Phuc on 6/8/16.
//  Copyright © 2016 Lê Phúc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tfText.delegate = self;
    //_tfText.userInteractionEnabled = NO;
    NSString *text = @"I needed to solve this exact same problem: very similar text with those two links in it, over http://stackoverflow.com/questions/20541676/ios-uitextview-or-uilabel-with-clickable-links-to-actions multiple lines, and needing it to be able to be translated in any http://stackoverflow.com/questions/8667993/how-to-get-find-and-get-url-in-a-nsstring-in-iphone<\p> language (including different word orders, etc). I just solved it, so let me share how I did it.";
//    NSArray *a = [text componentsSeparatedByString:@" "];
//    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:@""];
//
//    for (int i=0; i< [a count]; i++) {
//        NSString *temp = (NSString*)[a objectAtIndex:i];
//        NSLog(@"%@",temp);
//        if ([temp containsString:@"http://"]) {
//            NSMutableAttributedString *link = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ",temp]];
//            [link addAttribute: NSLinkAttributeName value: temp range: NSMakeRange(0, temp.length)];
//            [str appendAttributedString:link];
//        }
//        else{
//            NSMutableAttributedString *nomalText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ ",temp]];
//            [str appendAttributedString:nomalText];
//
//        }
//    }
//    
//    _tfText.attributedText = str;

    _tfText.text = text;
    // Do any additional setup after loading the view, typically from a nib.
}


- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0){
    NSLog(@"DMM");
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)buildAgreeTextViewFromString:(NSString *)localizedString
//{
//    // 1. Split the localized string on the "http://" sign:
//    NSArray *localizedStringPieces = [localizedString componentsSeparatedByString:@"http://"];
//    
//    // 2. Loop through all the pieces:
//    NSUInteger msgChunkCount = localizedStringPieces ? localizedStringPieces.count : 0;
//    CGPoint wordLocation = CGPointMake(0.0, 0.0);
//    for (NSUInteger i = 0; i < msgChunkCount; i++)
//    {
//        NSString *chunk = [localizedStringPieces objectAtIndex:i];
//        if ([chunk isEqualToString:@""])
//        {
//            continue;     // skip this loop if the chunk is empty
//        }
//        
//        // 3. Determine what type of word this is:
//        BOOL isTermsOfServiceLink = [chunk hasPrefix:@"<ts>"];
//        BOOL isPrivacyPolicyLink  = [chunk hasPrefix:@"<pp>"];
//        BOOL isLink = (BOOL)(isTermsOfServiceLink || isPrivacyPolicyLink);
//        
//        // 4. Create label, styling dependent on whether it's a link:
//        UILabel *label = [[UILabel alloc] init];
//        label.font = [UIFont systemFontOfSize:15.0f];
//        label.text = chunk;
//        label.userInteractionEnabled = isLink;
//        
//        if (isLink)
//        {
//            label.textColor = [UIColor colorWithRed:110/255.0f green:181/255.0f blue:229/255.0f alpha:1.0];
//            label.highlightedTextColor = [UIColor yellowColor];
//            
//            // 5. Set tap gesture for this clickable text:
//            SEL selectorAction = isTermsOfServiceLink ? @selector(tapOnTermsOfServiceLink:) : @selector(tapOnPrivacyPolicyLink:);
//            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                                         action:selectorAction];
//            [label addGestureRecognizer:tapGesture];
//            
//            // Trim the markup characters from the label:
//            if (isTermsOfServiceLink)
//                label.text = [label.text stringByReplacingOccurrencesOfString:@"<ts>" withString:@""];
//            if (isPrivacyPolicyLink)
//                label.text = [label.text stringByReplacingOccurrencesOfString:@"<pp>" withString:@""];
//        }
//        else
//        {
//            label.textColor = [UIColor whiteColor];
//        }
//        
//        // 6. Lay out the labels so it forms a complete sentence again:
//        
//        // If this word doesn't fit at end of this line, then move it to the next
//        // line and make sure any leading spaces are stripped off so it aligns nicely:
//        
//        [label sizeToFit];
//        
//        if (self.agreeTextContainerView.frame.size.width < wordLocation.x + label.bounds.size.width)
//        {
//            wordLocation.x = 0.0;                       // move this word all the way to the left...
//            wordLocation.y += label.frame.size.height;  // ...on the next line
//            
//            // And trim of any leading white space:
//            NSRange startingWhiteSpaceRange = [label.text rangeOfString:@"^\\s*"
//                                                                options:NSRegularExpressionSearch];
//            if (startingWhiteSpaceRange.location == 0)
//            {
//                label.text = [label.text stringByReplacingCharactersInRange:startingWhiteSpaceRange
//                                                                 withString:@""];
//                [label sizeToFit];
//            }
//        }
//        
//        // Set the location for this label:
//        label.frame = CGRectMake(wordLocation.x,
//                                 wordLocation.y,
//                                 label.frame.size.width,
//                                 label.frame.size.height);
//        // Show this label:
//        [self.agreeTextContainerView addSubview:label];
//        
//        // Update the horizontal position for the next word:
//        wordLocation.x += label.frame.size.width;
//    }
//}
//
//#pragma mark Action when click link.
//- (void)tapOnTermsOfServiceLink:(UITapGestureRecognizer *)tapGesture
//{
//    if (tapGesture.state == UIGestureRecognizerStateEnded)
//    {
//        NSLog(@"User tapped on the Terms of Service link");
//    }
//}
//
//
//- (void)tapOnPrivacyPolicyLink:(UITapGestureRecognizer *)tapGesture
//{
//    if (tapGesture.state == UIGestureRecognizerStateEnded)
//    {
//        NSLog(@"User tapped on the Privacy Policy link");
//    }
//}



@end
