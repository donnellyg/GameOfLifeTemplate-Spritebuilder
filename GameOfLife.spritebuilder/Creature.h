//
//  Creature.h
//  GameOfLife
//
//  Created by Gus Donnelly on 7/24/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Creature : CCSprite


@property (nonatomic, assign) BOOL isAlive;
@property (nonatomic, assign) int livingNeighbors;

- (id)initCreature; //initializer
- (void)setIsAlive:(BOOL)newState;


@end
