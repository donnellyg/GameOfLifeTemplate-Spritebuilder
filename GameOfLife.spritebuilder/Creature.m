//
//  Creature.m
//  GameOfLife
//
//  Created by Gus Donnelly on 7/24/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Creature.h"

@implementation Creature

- (instancetype) initCreature {
    self = [super initWithImageNamed:@"GameOfLifeAssets/Assets/bubble.png"];
    
    if (self) { //prevents error being thrown if there's an error with the above super initialization
        self.isAlive = NO;
    }
    
    return self;
}

- (void) setIsAlive:(BOOL)newState {
    _isAlive = newState;
    self.visible = _isAlive;
    
    
}





@end
