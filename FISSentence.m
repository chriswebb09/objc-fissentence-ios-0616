//
//  FISSentence.m
//  objc-fissentence
//
//  Created by Christopher Webb-Orenstein on 6/10/16.
//  Copyright © 2016 The Flatiron School. All rights reserved.
//

#import "FISSentence.h"

@interface FISSentence ()

@property (nonatomic, readwrite) NSString* sentence;

-(void)assembleSentence;

-(BOOL)validWord:(NSString *)word;

-(BOOL)validPunctuation:(NSString *)punctuation;

-(BOOL)validIndex:(NSUInteger)index;

@end

@implementation FISSentence

-(void)addWord:(NSString *)word {
    if ([self validWord:word]) {
        [self.words addObject:word];
    }
    [self assembleSentence];
}

-(void)addWords:(NSArray *)words
withPunctuation:(NSString *)punctuation {
    if ([self validPunctuation:punctuation]) {
        self.punctuation = punctuation;
    }
    for (NSString *word in words) {
        if (([self validWord:word]) && [self validPunctuation:punctuation]) {
            [self.words addObject:word];
            [self assembleSentence];
        }
    }
}

-(void)removeWordAtIndex:(NSUInteger)index {
    if ([self validIndex:index]) {
        [self.words removeObjectAtIndex:index];
    }
    [self assembleSentence];
}

-(void)insertWord:(NSString *)word
          atIndex:(NSUInteger)index {
    if (([self validWord:word]) &&  ([self validIndex:index])) {
        [self.words insertObject:word atIndex:index];
    }
    [self assembleSentence];
    
}

-(void)replacePunctuationWithPunctuation:(NSString *)punctuation {
    if ([self validPunctuation:punctuation]) {
        self.punctuation = punctuation;
        [self assembleSentence];
    } else if (![self validPunctuation:punctuation]) {
        [self assembleSentence];
    }
}


-(void)replaceWordAtIndex:(NSUInteger)index
                 withWord:(NSString *)word {
    if (([self validWord:word]) &&  ([self validIndex:index])) {
        [self.words replaceObjectAtIndex:index withObject:word];
    }
    [self assembleSentence];
}

-(void)assembleSentence {
    self.sentence = [[self.words componentsJoinedByString:@" "] mutableCopy];
    self.sentence = [self.sentence stringByAppendingString:self.punctuation];
}

-(BOOL)validWord:(NSString *)word {
    NSArray *invalidWords = @[@"", @" "];
    BOOL yesNo = NO;
    if ((![invalidWords containsObject:word]) && (word != nil)) {
        yesNo = YES;
    }
    return yesNo;
}

-(BOOL)validPunctuation:(NSString *)punctuation {
    NSArray *punctuationArray = @[@".", @"?", @"!", @",", @";", @":"];
    BOOL yesNo = NO;
    if ([punctuationArray containsObject:punctuation]) {
        yesNo = YES;
    }
    return yesNo;
}

-(BOOL)validIndex:(NSUInteger)index {
    BOOL yesNo = NO;
    if (index < [self.words count]) {
        yesNo = YES;
    }
    return yesNo;
}

@end
