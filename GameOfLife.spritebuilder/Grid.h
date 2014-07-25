//
//  Grid.h
//  GameOfLife
//
//  Created by Gus Donnelly on 7/24/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Grid : CCSprite

@property (nonatomic, assign) int totalAlive;
@property (nonatomic, assign) int generation;

- (void) onEnter;
- (void) setupGrid;
- (void) evolveStep;
- (void) countNeighbors;
- (void) updateCreatures;
- (BOOL) isValidPositionForX:(int)x andY:(int)y;
+ (void) resetGrid:(Grid*)g;

@end
