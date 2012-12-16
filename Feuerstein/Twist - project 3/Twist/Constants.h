//
//  Constants.h
//  Twist
//
//  Created by Stephen Feuerstein on 8/6/12.
//  Copyright (c) 2012 GingerSnAPPS. All rights reserved.
//
#include "cocos2d.h"

#define MAPNAMEPREFIX @"level" // mapLevel

#define ARC4RANDOM_MAX      0x100000000

#define GRAVITYCONST -450.0
#define JUMPFORCECONST 310.0
#define MINJUMPHEIGHT 150.0
#define MAXHORIZONTALMOVEFORCE 800.0
#define MAXHORIZONTALMOVESPEED 140.0

// Hazard Types
#define HAZARDTYPELAVA @"lava"
#define HAZARDTYPESPIKES @"spikes"

// Teleporter Particles Tag
#define TELEPORTERPARTICLESTAG 555

// UI Tags
#define ENDLEVELBOXTAG 556
#define ENDLEVELMENUTAG 557
#define ENDLEVELMESSAGETAG 558
#define TUTLABELTAG 559
#define TUTBOXTAG 560
#define TUTMENUTAG 561
#define PAUSEMESSAGETAG 562

#define NUMBEROFLEVELS 33