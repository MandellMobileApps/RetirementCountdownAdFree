//
//  ColorsClass.m
//  RetirementCountdown
//
//  Created by Jon Mandell on 11/24/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import "ColorsClass.h"


@implementation ColorsClass


+(int)getCountForTextColorNames {
	return 14;
}

+(NSString*)getTextColorNameFor:(int)nameindex {
	NSString *tempColorName = [[[NSString alloc] init] autorelease];
	switch (nameindex) {
		case  0:
			tempColorName = @"black";
			break;
		case  1:
			tempColorName = @"darkgray";
			break;
		case  2:			
			tempColorName = @"lightgray";
			break;
		case  3:						
			tempColorName = @"white";
			break;
		case  4:						
			tempColorName = @"gray";
			break;
		case  5:						
			tempColorName = @"red";
			break;
		case  6:			
			tempColorName = @"green";
			break;
		case  7:			
			tempColorName = @"blue";
			break;
		case  8:			
			tempColorName = @"cyan";
			break;
		case  9:			
			tempColorName = @"yellow";
			break;
		case  10:			
			tempColorName = @"magenta";
			break;
		case  11:			
			tempColorName = @"orange";
			break;
		case  12:			
			tempColorName = @"purple";
			break;
		case  13:			
			tempColorName = @"brown";
	}
	return tempColorName;
}



+(int)getCountForBackgroundColorNames {
	return 16;
}

+(NSString*)getBackgroundColorNameFor:(int)nameindex {
	NSString *tempColorName = [[[NSString alloc] init] autorelease];
	switch (nameindex) {
		case  0:
			tempColorName = @"black";
			break;
		case  1:
			tempColorName = @"darkgray";
			break;
		case  2:			
			tempColorName = @"lightgray";
			break;
		case  3:						
			tempColorName = @"white";
			break;
		case  4:						
			tempColorName = @"gray";
			break;
		case  5:						
			tempColorName = @"red";
			break;
		case  6:			
			tempColorName = @"green";
			break;
		case  7:			
			tempColorName = @"blue";
			break;
		case  8:			
			tempColorName = @"cyan";
			break;
		case  9:			
			tempColorName = @"yellow";
			break;
		case  10:			
			tempColorName = @"magenta";
			break;
		case  11:			
			tempColorName = @"orange";
			break;
		case  12:			
			tempColorName = @"purple";
			break;
		case  13:			
			tempColorName = @"brown";
			break;
		case  14:
			tempColorName = @"lightgray";
			break;
		case  15:
			tempColorName = @"testColor";
//  add     + (UIColor *)colorWithPatternImage:(UIImage *)image
	}
	return tempColorName;
}

+(int)getCountForDayColorNames {
	return 13;
}

+(NSString*)getDayColorNameFor:(int)nameindex {
	NSString *tempColorName = [[[NSString alloc] init] autorelease];
	switch (nameindex) {
		case  0:
			tempColorName = @"GlossBrightGreen";
			break;
		case  1:
			tempColorName = @"GlossDarkAqua";
			break;
		case  2:			
			tempColorName = @"GlossSlateBlue";
			break;
		case  3:						
			tempColorName = @"GlossRed";
			break;
		case  4:						
			tempColorName = @"GlossMaraschino";
			break;
		case  5:						
			tempColorName = @"GlossLemon";
			break;
		case  6:			
			tempColorName = @"GlossAluminum";
			break;
		case  7:			
			tempColorName = @"GlossAqua";
			break;
		case  8:			
			tempColorName = @"GlossWhite";
			break;
		case  9:			
			tempColorName = @"GlossBlack";
			break;
		case  10:			
			tempColorName = @"GlossIce";
			break;
		case  11:			
			tempColorName = @"GlossBlueberry";
			break;
		case  12:			
			tempColorName = @"GlossRedFramed";
			break;
	}
	return tempColorName;
}

+(int)getCountForPredefinedColorNames {
	return 494;
}


+(NSString*)getPredefinedColorNameFor:(int)nameindex {
NSString *tempColorName = [[[NSString alloc] init] autorelease];
	switch (nameindex) {
	case 0:	  tempColorName = @"lightgray"; break;
	case 1:   tempColorName = @"White";   break;
	case 2:   tempColorName = @"Azure2";   break;
	case 3:   tempColorName = @"Ivory";   break;
	case 4:   tempColorName = @"Magnolia";   break;
	case 5:   tempColorName = @"AliceBlue";   break;
	case 6:   tempColorName = @"LavenderBlush";   break;
	case 7:   tempColorName = @"Seashell";   break;
	case 8:   tempColorName = @"Honeydew";   break;
	case 9:   tempColorName = @"BabyBlue";   break;
	case 10:   tempColorName = @"CosmicLatte";   break;
	case 11:   tempColorName = @"OldLace";   break;
	case 12:   tempColorName = @"Linen";   break;
	case 13:   tempColorName = @"Cream";   break;
	case 14:   tempColorName = @"Beige";   break;
	case 15:   tempColorName = @"Lavender2";   break;
	case 16:   tempColorName = @"LemonChiffon";   break;
	case 17:   tempColorName = @"MistyRose";   break;
	case 18:   tempColorName = @"PapayaWhip";   break;
	case 19:   tempColorName = @"PalePink";   break;
	case 20:   tempColorName = @"ClassicRose";   break;
	case 21:   tempColorName = @"Champagne";   break;
	case 22:   tempColorName = @"PastelPink";   break;
	case 23:   tempColorName = @"LightMauve";   break;
	case 24:   tempColorName = @"Platinum";   break;
	case 25:   tempColorName = @"Peach";   break;
	case 26:   tempColorName = @"LavenderBlue";   break;
	case 27:   tempColorName = @"Periwinkle";   break;
	case 28:   tempColorName = @"PaleSpringBud";   break;
	case 29:   tempColorName = @"PeachPuff";   break;
	case 30:   tempColorName = @"Mauve";   break;
	case 31:   tempColorName = @"PaleBlue";   break;
	case 32:   tempColorName = @"NavajoWhite";   break;
	case 33:   tempColorName = @"Pink";   break;
	case 34:   tempColorName = @"PeachYellow";   break;
	case 35:   tempColorName = @"Wheat";   break;
	case 36:   tempColorName = @"LightApricot";   break;
	case 37:   tempColorName = @"MediumChampagne";   break;
	case 38:   tempColorName = @"TeaGreen";   break;
	case 39:   tempColorName = @"LavenderRose";   break;
	case 40:   tempColorName = @"LanguidLavender";   break;
	case 41:   tempColorName = @"CherryBlossomPink";   break;
	case 42:   tempColorName = @"LavenderPink";   break;
	case 43:   tempColorName = @"Apricot";   break;
	case 44:   tempColorName = @"BabyPink";   break;
	case 45:   tempColorName = @"TeaRose2";   break;
	case 46:   tempColorName = @"ColumbiaBlue";   break;
	case 47:   tempColorName = @"LightPink";   break;
	case 48:   tempColorName = @"PowderBlue";   break;
	case 49:   tempColorName = @"DeepChampagne";   break;
	case 50:   tempColorName = @"ElectricBlue";   break;
	case 51:   tempColorName = @"FuchsiaPink";   break;
	case 52:   tempColorName = @"Thistle";   break;
	case 53:   tempColorName = @"CarnationPink";   break;
	case 54:   tempColorName = @"DeepPeach";   break;
	case 55:   tempColorName = @"UltraPink";   break;
	case 56:   tempColorName = @"LightBlue";   break;
	case 57:   tempColorName = @"LightCornflowerBlue";   break;
	case 58:   tempColorName = @"MagicMint";   break;
	case 59:   tempColorName = @"NadeshikoPink";   break;
	case 60:   tempColorName = @"PaleCornflowerBlue";   break;
	case 61:   tempColorName = @"DesertSand";   break;
	case 62:   tempColorName = @"PeachOrange";   break;
	case 63:   tempColorName = @"Khaki2";   break;
	case 64:   tempColorName = @"LightFuchsiaPink";   break;
	case 65:   tempColorName = @"PaleMagenta";   break;
	case 66:   tempColorName = @"LavenderMagenta";   break;
	case 67:   tempColorName = @"PaleAmaranthPink";   break;
	case 68:   tempColorName = @"Violet2";   break;
	case 69:   tempColorName = @"BrightUbe";   break;
	case 70:   tempColorName = @"LavenderGray";   break;
	case 71:   tempColorName = @"Aquamarine";   break;
	case 72:   tempColorName = @"Heliotrope";   break;
	case 73:   tempColorName = @"LightSkyBlue";   break;
	case 74:   tempColorName = @"Buff";   break;
	case 75:   tempColorName = @"Flax";   break;
	case 76:   tempColorName = @"AmaranthPink";   break;
	case 77:   tempColorName = @"Maize";   break;
	case 78:   tempColorName = @"PaleRobinEggBlue";   break;
	case 79:   tempColorName = @"Wisteria";   break;
	case 80:   tempColorName = @"Corn";   break;
	case 81:   tempColorName = @"PaleSilver";   break;
	case 82:   tempColorName = @"Silver";   break;
	case 83:   tempColorName = @"SkyBlue";   break;
	case 84:   tempColorName = @"Celadon";   break;
	case 85:   tempColorName = @"MossGreen";   break;
	case 86:   tempColorName = @"PaleChestnut";   break;
	case 87:   tempColorName = @"BrightLavender";   break;
	case 88:   tempColorName = @"CarolinaBlue";   break;
	case 89:   tempColorName = @"PersianPink";   break;
	case 90:   tempColorName = @"SalmonPink";   break;
	case 91:   tempColorName = @"Jonquil";   break;
	case 92:   tempColorName = @"Lilac";   break;
	case 93:   tempColorName = @"Mustard";   break;
	case 94:   tempColorName = @"CambridgeBlue";   break;
	case 95:   tempColorName = @"LightSalmonPink";   break;
	case 96:   tempColorName = @"MediumLavenderMagenta";   break;
	case 97:   tempColorName = @"Plum";   break;
	case 98:   tempColorName = @"RosePink";   break;
	case 99:   tempColorName = @"MayaBlue";   break;
	case 100:   tempColorName = @"MintGreen";   break;
	case 101:   tempColorName = @"Yellow2";   break;
	case 102:   tempColorName = @"MediumSpringBud";   break;
	case 103:   tempColorName = @"PaleGold";   break;
	case 104:   tempColorName = @"LightThulianPink";   break;
	case 105:   tempColorName = @"Orchid";   break;
	case 106:   tempColorName = @"HotPink";   break;
	case 107:   tempColorName = @"LightSalmon";   break;
	case 108:   tempColorName = @"Tan";   break;
	case 109:   tempColorName = @"Lavender1";   break;
	case 110:   tempColorName = @"Khaki1";   break;
	case 111:   tempColorName = @"EtonBlue";   break;
	case 112:   tempColorName = @"Aqua";   break;
	case 113:   tempColorName = @"AtomicTangerine";   break;
	case 114:   tempColorName = @"Cyan1";   break;
	case 115:   tempColorName = @"Fuchsia";   break;
	case 116:   tempColorName = @"Magenta";   break;
	case 117:   tempColorName = @"PinkOrange";   break;
	case 118:   tempColorName = @"RazzleDazzleRose";   break;
	case 119:   tempColorName = @"Sunglow";   break;
	case 120:   tempColorName = @"Yellow";   break;
	case 121:   tempColorName = @"DarkSalmon";   break;
	case 122:   tempColorName = @"SandyBrown";   break;
	case 123:   tempColorName = @"BrilliantRose";   break;
	case 124:   tempColorName = @"Lemon";   break;
	case 125:   tempColorName = @"CadmiumYellow";   break;
	case 126:   tempColorName = @"CoralPink";   break;
	case 127:   tempColorName = @"DarkChampagne";   break;
	case 128:   tempColorName = @"Ecru";   break;
	case 129:   tempColorName = @"Salmon";   break;
	case 130:   tempColorName = @"Sand";   break;
	case 131:   tempColorName = @"TeaRose1";   break;
	case 132:   tempColorName = @"AmaranthMagenta";   break;
	case 133:   tempColorName = @"LightCoral";   break;
	case 134:   tempColorName = @"SkyMagenta";   break;
	case 135:   tempColorName = @"JuneBud";   break;
	case 136:   tempColorName = @"ThulianPink";   break;
	case 137:   tempColorName = @"Yellow1";   break;
	case 138:   tempColorName = @"Puce";   break;
	case 139:   tempColorName = @"Purple2";   break;
	case 140:   tempColorName = @"RoseQuartz";   break;
	case 141:   tempColorName = @"EarthYellow";   break;
	case 142:   tempColorName = @"Saffron";   break;
	case 143:   tempColorName = @"CornflowerBlue";   break;
	case 144:   tempColorName = @"MediumTurquoise";   break;
	case 145:   tempColorName = @"Pear";   break;
	case 146:   tempColorName = @"IndianYellow";   break;
	case 147:   tempColorName = @"OperaMauve";   break;
	case 148:   tempColorName = @"DarkKhaki";   break;
	case 149:   tempColorName = @"Chartreuse1";   break;
	case 150:   tempColorName = @"GoldenYellow";   break;
	case 151:   tempColorName = @"MediumPurple";   break;
	case 152:   tempColorName = @"PaleRedViolet";   break;
	case 153:   tempColorName = @"PsychedelicPurple";   break;
	case 154:   tempColorName = @"GreenYellow";   break;
	case 155:   tempColorName = @"BrinkPink";   break;
	case 156:   tempColorName = @"RosyBrown";   break;
	case 157:   tempColorName = @"RichLavender";   break;
	case 158:   tempColorName = @"SchoolBusYellow";   break;
	case 159:   tempColorName = @"DeepFuchsia";   break;
	case 160:   tempColorName = @"Gold1";   break;
	case 161:   tempColorName = @"LavenderIndigo";   break;
	case 162:   tempColorName = @"PaleTaupe";   break;
	case 163:   tempColorName = @"UnitedNationsBlue";   break;
	case 164:   tempColorName = @"VegasGold";   break;
	case 165:   tempColorName = @"MikadoYellow";   break;
	case 166:   tempColorName = @"BrightTurquoise";   break;
	case 167:   tempColorName = @"Coral";   break;
	case 168:   tempColorName = @"Turquoise";   break;
	case 169:   tempColorName = @"Amethyst";   break;
	case 170:   tempColorName = @"Bittersweet";   break;
	case 171:   tempColorName = @"DeepSaffron";   break;
	case 172:   tempColorName = @"ElectricLime";   break;
	case 173:   tempColorName = @"HotMagenta";   break;
	case 174:   tempColorName = @"PaleCopper";   break;
	case 175:   tempColorName = @"PastelGreen";   break;
	case 176:   tempColorName = @"ShockingPink";   break;
	case 177:   tempColorName = @"TangerineYellow";   break;
	case 178:   tempColorName = @"CoolGrey";   break;
	case 179:   tempColorName = @"FrenchRose";   break;
	case 180:   tempColorName = @"Pistachio";   break;
	case 181:   tempColorName = @"PersianRose";   break;
	case 182:   tempColorName = @"LavenderPurple";   break;
	case 183:   tempColorName = @"Camel";   break;
	case 184:   tempColorName = @"Desert";   break;
	case 185:   tempColorName = @"Fallow";   break;
	case 186:   tempColorName = @"Olivine";   break;
	case 187:   tempColorName = @"Ube";   break;
	case 188:   tempColorName = @"OldRose";   break;
	case 189:   tempColorName = @"PersianOrange";   break;
	case 190:   tempColorName = @"OldGold";   break;
	case 191:   tempColorName = @"Amber1";   break;
	case 192:   tempColorName = @"ElectricPurple";   break;
	case 193:   tempColorName = @"GoldenPoppy";   break;
	case 194:   tempColorName = @"Lime1";   break;
	case 195:   tempColorName = @"DarkPink";   break;
	case 196:   tempColorName = @"BlueGreen";   break;
	case 197:   tempColorName = @"Gold2";   break;
	case 198:   tempColorName = @"DarkTangerine";   break;
	case 199:   tempColorName = @"SelectiveYellow";   break;
	case 200:   tempColorName = @"TerraCotta";   break;
	case 201:   tempColorName = @"BurntSienna";   break;
	case 202:   tempColorName = @"LightCarminePink";   break;
	case 203:   tempColorName = @"DodgerBlue";   break;
	case 204:   tempColorName = @"CerisePink";   break;
	case 205:   tempColorName = @"DeepLilac";   break;
	case 206:   tempColorName = @"Tomato";   break;
	case 207:   tempColorName = @"TurkishRose";   break;
	case 208:   tempColorName = @"DeepPink";   break;
	case 209:   tempColorName = @"Orange3";   break;
	case 210:   tempColorName = @"AndroidGreen";   break;
	case 211:   tempColorName = @"SpringBud";   break;
	case 212:   tempColorName = @"Cyan2";   break;
	case 213:   tempColorName = @"CadmiumOrange";   break;
	case 214:   tempColorName = @"SatinSheenGold";   break;
	case 215:   tempColorName = @"MountbattenPink";   break;
	case 216:   tempColorName = @"CarrotOrange";   break;
	case 217:   tempColorName = @"DarkTurquoise";   break;
	case 218:   tempColorName = @"Goldenrod";   break;
	case 219:   tempColorName = @"OrangePeel";   break;
	case 220:   tempColorName = @"RoseGold";   break;
	case 221:   tempColorName = @"Brass";   break;
	case 222:   tempColorName = @"Mulberry";   break;
	case 223:   tempColorName = @"Asparagus";   break;
	case 224:   tempColorName = @"DeepMagenta";   break;
	case 225:   tempColorName = @"TaupeGray";   break;
	case 226:   tempColorName = @"YellowGreen";   break;
	case 227:   tempColorName = @"LightSlateGray";   break;
	case 228:   tempColorName = @"RobinEggBlue";   break;
	case 229:   tempColorName = @"VividViolet";   break;
	case 230:   tempColorName = @"BlueViolet";   break;
	case 231:   tempColorName = @"Orange2";   break;
	case 232:   tempColorName = @"DeepCarrotOrange";   break;
	case 233:   tempColorName = @"Fandango";   break;
	case 234:   tempColorName = @"FashionFuchsia";   break;
	case 235:   tempColorName = @"HollywoodCerise";   break;
	case 236:   tempColorName = @"Byzantine";   break;
	case 237:   tempColorName = @"MediumSpringGreen";   break;
	case 238:   tempColorName = @"DeepCerise";   break;
	case 239:   tempColorName = @"RadicalRed";   break;
	case 240:   tempColorName = @"Emerald";   break;
	case 241:   tempColorName = @"AirForceBlue";   break;
	case 242:   tempColorName = @"Magenta2";   break;
	case 243:   tempColorName = @"PortlandOrange";   break;
	case 244:   tempColorName = @"Gamboge";   break;
	case 245:   tempColorName = @"MajorelleBlue";   break;
	case 246:   tempColorName = @"Pumpkin";   break;
	case 247:   tempColorName = @"DarkOrange";   break;
	case 248:   tempColorName = @"RoyalBlue2";   break;
	case 249:   tempColorName = @"ElectricViolet";   break;
	case 250:   tempColorName = @"Violet";   break;
	case 251:   tempColorName = @"RoyalFuchsia";   break;
	case 252:   tempColorName = @"Chestnut";   break;
	case 253:   tempColorName = @"Gray";   break;
	case 254:   tempColorName = @"SlateGray";   break;
	case 255:   tempColorName = @"CoralRed";   break;
	case 256:   tempColorName = @"Violet1";   break;
	case 257:   tempColorName = @"Azure1";   break;
	case 258:   tempColorName = @"BrightPink";   break;
	case 259:   tempColorName = @"Bronze";   break;
	case 260:   tempColorName = @"Chartreuse2";   break;
	case 261:   tempColorName = @"Orange1";   break;
	case 262:   tempColorName = @"Rose";   break;
	case 263:   tempColorName = @"SpringGreen";   break;
	case 264:   tempColorName = @"Amber2";   break;
	case 265:   tempColorName = @"FrenchBeige";   break;
	case 266:   tempColorName = @"LightSeaGreen";   break;
	case 267:   tempColorName = @"SteelBlue";   break;
	case 268:   tempColorName = @"CarminePink";   break;
	case 269:   tempColorName = @"TiffanyBlue";   break;
	case 270:   tempColorName = @"LawnGreen";   break;
	case 271:   tempColorName = @"Tangerine";   break;
	case 272:   tempColorName = @"DarkTerraCotta";   break;
	case 273:   tempColorName = @"AmaranthCerise";   break;
	case 274:   tempColorName = @"MediumRedViolet";   break;
	case 275:   tempColorName = @"Razzmatazz";   break;
	case 276:   tempColorName = @"Cerise";   break;
	case 277:   tempColorName = @"Xanadu";   break;
	case 278:   tempColorName = @"BrandeisBlue";   break;
	case 279:   tempColorName = @"DarkCoral";   break;
	case 280:   tempColorName = @"RichElectricBlue";   break;
	case 281:   tempColorName = @"CamouflageGreen";   break;
	case 282:   tempColorName = @"DarkViolet";   break;
	case 283:   tempColorName = @"BrightGreen";   break;
	case 284:   tempColorName = @"CaribbeanGreen";   break;
	case 285:   tempColorName = @"CopperRose";   break;
	case 286:   tempColorName = @"ElectricIndigo";   break;
	case 287:   tempColorName = @"Ochre";   break;
	case 288:   tempColorName = @"SafetyOrange";   break;
	case 289:   tempColorName = @"HanBlue";   break;
	case 290:   tempColorName = @"HanPurple";   break;
	case 291:   tempColorName = @"DarkTan";   break;
	case 292:   tempColorName = @"RaspberryRose";   break;
	case 293:   tempColorName = @"PaleBrown";   break;
	case 294:   tempColorName = @"DarkChestnut";   break;
	case 295:   tempColorName = @"RedViolet";   break;
	case 296:   tempColorName = @"Amaranth";   break;
	case 297:   tempColorName = @"MediumSeaGreen";   break;
	case 298:   tempColorName = @"Copper";   break;
	case 299:   tempColorName = @"MauveTaupe";   break;
	case 300:   tempColorName = @"JungleGreen";   break;
	case 301:   tempColorName = @"Magenta1";   break;
	case 302:   tempColorName = @"Cinnabar";   break;
	case 303:   tempColorName = @"Cinnamon";   break;
	case 304:   tempColorName = @"OldLavender";   break;
	case 305:   tempColorName = @"DarkLavender";   break;
	case 306:   tempColorName = @"Vermilion";   break;
	case 307:   tempColorName = @"DeepCarminePink";   break;
	case 308:   tempColorName = @"DogwoodRose";   break;
	case 309:   tempColorName = @"Ruby";   break;
	case 310:   tempColorName = @"DeepChestnut";   break;
	case 311:   tempColorName = @"InternationalOrange";   break;
	case 312:   tempColorName = @"BondiBlue";   break;
	case 313:   tempColorName = @"RoseVale";   break;
	case 314:   tempColorName = @"Raspberry";   break;
	case 315:   tempColorName = @"RoseTaupe";   break;
	case 316:   tempColorName = @"RoyalPurple";   break;
	case 317:   tempColorName = @"DarkGoldenrod";   break;
	case 318:   tempColorName = @"Green5";   break;
	case 319:   tempColorName = @"Blue3";   break;
	case 320:   tempColorName = @"Tangelo";   break;
	case 321:   tempColorName = @"OrangeRed";   break;
	case 322:   tempColorName = @"PalatinateBlue";   break;
	case 323:   tempColorName = @"Persimmon";   break;
	case 324:   tempColorName = @"AppleGreen";   break;
	case 325:   tempColorName = @"AmericanRose";   break;
	case 326:   tempColorName = @"Maroon2";   break;
	case 327:   tempColorName = @"RichMaroon";   break;
	case 328:   tempColorName = @"TorchRed";   break;
	case 329:   tempColorName = @"Alizarin";   break;
	case 330:   tempColorName = @"RoseMadder";   break;
	case 331:   tempColorName = @"Harlequin";   break;
	case 332:   tempColorName = @"TwilightLavender";   break;
	case 333:   tempColorName = @"CeruleanBlue";   break;
	case 334:   tempColorName = @"PersianGreen";   break;
	case 335:   tempColorName = @"Red3";   break;
	case 336:   tempColorName = @"Malachite";   break;
	case 337:   tempColorName = @"Violet3";   break;
	case 338:   tempColorName = @"DarkElectricBlue";   break;
	case 339:   tempColorName = @"AmaranthDeepPurple";   break;
	case 340:   tempColorName = @"CarmineRed";   break;
	case 341:   tempColorName = @"Denim";   break;
	case 342:   tempColorName = @"PersianRed";   break;
	case 343:   tempColorName = @"LimeGreen";   break;
	case 344:   tempColorName = @"Viridian";   break;
	case 345:   tempColorName = @"Red2";   break;
	case 346:   tempColorName = @"BrightMaroon";   break;
	case 347:   tempColorName = @"Crimson";   break;
	case 348:   tempColorName = @"MediumCarmine";   break;
	case 349:   tempColorName = @"PaleCarmine";   break;
	case 350:   tempColorName = @"Tenne";   break;
	case 351:   tempColorName = @"Scarlet";   break;
	case 352:   tempColorName = @"Cerulean";   break;
	case 353:   tempColorName = @"AmaranthPurple";   break;
	case 354:   tempColorName = @"BurntOrange";   break;
	case 355:   tempColorName = @"Sienna";   break;
	case 356:   tempColorName = @"Drab";   break;
	case 357:   tempColorName = @"KellyGreen";   break;
	case 358:   tempColorName = @"ModeBeige";   break;
	case 359:   tempColorName = @"SandDune";   break;
	case 360:   tempColorName = @"SandyTaupe";   break;
	case 361:   tempColorName = @"Cardinal";   break;
	case 362:   tempColorName = @"OliveDrab1";   break;
	case 363:   tempColorName = @"RichCarmine";   break;
	case 364:   tempColorName = @"DarkCyan";   break;
	case 365:   tempColorName = @"DarkMagenta";   break;
	case 366:   tempColorName = @"GoldenBrown";   break;
	case 367:   tempColorName = @"Jade";   break;
	case 368:   tempColorName = @"PersianBlue";   break;
	case 369:   tempColorName = @"SeaGreen";   break;
	case 370:   tempColorName = @"JazzberryJam";   break;
	case 371:   tempColorName = @"Cordovan";   break;
	case 372:   tempColorName = @"MediumPersianBlue";   break;
	case 373:   tempColorName = @"FernGreen";   break;
	case 374:   tempColorName = @"Wenge";   break;
	case 375:   tempColorName = @"MediumTealBlue";   break;
	case 376:   tempColorName = @"DeepCarmine";   break;
	case 377:   tempColorName = @"Rust";   break;
	case 378:   tempColorName = @"CadmiumRed";   break;
	case 379:   tempColorName = @"FireEngineRed";   break;
	case 380:   tempColorName = @"Mahogany";   break;
	case 381:   tempColorName = @"Olive";   break;
	case 382:   tempColorName = @"Teal";   break;
	case 383:   tempColorName = @"Blue1";   break;
	case 384:   tempColorName = @"Blue2";   break;
	case 385:   tempColorName = @"DarkPastelGreen";   break;
	case 386:   tempColorName = @"DavysGrey";   break;
	case 387:   tempColorName = @"ElectricGreen";   break;
	case 388:   tempColorName = @"Green1";   break;
	case 389:   tempColorName = @"Lava";   break;
	case 390:   tempColorName = @"Lime2";   break;
	case 391:   tempColorName = @"Red1";   break;
	case 392:   tempColorName = @"Purple1";   break;
	case 393:   tempColorName = @"ShamrockGreen";   break;
	case 394:   tempColorName = @"Feldgrau";   break;
	case 395:   tempColorName = @"Byzantium";   break;
	case 396:   tempColorName = @"MediumTaupe";   break;
	case 397:   tempColorName = @"RoseEbony";   break;
	case 398:   tempColorName = @"Brown2";   break;
	case 399:   tempColorName = @"Bole";   break;
	case 400:   tempColorName = @"SapGreen";   break;
	case 401:   tempColorName = @"Firebrick";   break;
	case 402:   tempColorName = @"Green4";   break;
	case 403:   tempColorName = @"Cobalt";   break;
	case 404:   tempColorName = @"Eggplant";   break;
	case 405:   tempColorName = @"HalayaUbe";   break;
	case 406:   tempColorName = @"VividBurgundy";   break;
	case 407:   tempColorName = @"PalatinatePurple";   break;
	case 408:   tempColorName = @"Skobeloff";   break;
	case 409:   tempColorName = @"YaleBlue";   break;
	case 410:   tempColorName = @"Liver";   break;
	case 411:   tempColorName = @"DarkByzantium";   break;
	case 412:   tempColorName = @"EgyptianBlue";   break;
	case 413:   tempColorName = @"Carnelian";   break;
	case 414:   tempColorName = @"MediumElectricBlue";   break;
	case 415:   tempColorName = @"PineGreen";   break;
	case 416:   tempColorName = @"VenetianRed";   break;
	case 417:   tempColorName = @"GrayAsparagus";   break;
	case 418:   tempColorName = @"UpsdellRed";   break;
	case 419:   tempColorName = @"Brown1";   break;
	case 420:   tempColorName = @"BurntUmber";   break;
	case 421:   tempColorName = @"Russet";   break;
	case 422:   tempColorName = @"FieldDrab";   break;
	case 423:   tempColorName = @"PurpleTaupe";   break;
	case 424:   tempColorName = @"PansyPurple";   break;
	case 425:   tempColorName = @"InternationalKleinBlue";   break;
	case 426:   tempColorName = @"TropicalRainForest";   break;
	case 427:   tempColorName = @"RawUmber";   break;
	case 428:   tempColorName = @"DarkSpringGreen";   break;
	case 429:   tempColorName = @"HunterGreen";   break;
	case 430:   tempColorName = @"DarkSlateGray";   break;
	case 431:   tempColorName = @"Indigo2";   break;
	case 432:   tempColorName = @"MediumBlue";   break;
	case 433:   tempColorName = @"DarkPowderBlue";   break;
	case 434:   tempColorName = @"Smalt";   break;
	case 435:   tempColorName = @"DarkCerulean";   break;
	case 436:   tempColorName = @"Arsenic";   break;
	case 437:   tempColorName = @"Charcoal";   break;
	case 438:   tempColorName = @"DarkBrown";   break;
	case 439:   tempColorName = @"PaynesGrey";   break;
	case 440:   tempColorName = @"Sepia";   break;
	case 441:   tempColorName = @"ArmyGreen";   break;
	case 442:   tempColorName = @"PersianIndigo";   break;
	case 443:   tempColorName = @"Auburn";   break;
	case 444:   tempColorName = @"RifleGreen";   break;
	case 445:   tempColorName = @"Chocolate";   break;
	case 446:   tempColorName = @"DarkLava";   break;
	case 447:   tempColorName = @"DarkTaupe";   break;
	case 448:   tempColorName = @"Taupe";   break;
	case 449:   tempColorName = @"FaluRed";   break;
	case 450:   tempColorName = @"Carmine";   break;
	case 451:   tempColorName = @"Indigo1";   break;
	case 452:   tempColorName = @"Ultramarine";   break;
	case 453:   tempColorName = @"CadmiumGreen";   break;
	case 454:   tempColorName = @"TyrianPurple";   break;
	case 455:   tempColorName = @"IndiaGreen";   break;
	case 456:   tempColorName = @"MidnightBlue";   break;
	case 457:   tempColorName = @"Burgundy";   break;
	case 458:   tempColorName = @"CaputMortuum";   break;
	case 459:   tempColorName = @"DartmouthGreen";   break;
	case 460:   tempColorName = @"DukeBlue";   break;
	case 461:   tempColorName = @"MidnightGreen";   break;
	case 462:   tempColorName = @"Sangria";   break;
	case 463:   tempColorName = @"DarkMidnightBlue";   break;
	case 464:   tempColorName = @"Green3";   break;
	case 465:   tempColorName = @"MSUGreen";   break;
	case 466:   tempColorName = @"PhthaloBlue";   break;
	case 467:   tempColorName = @"SacramentoStateGreen";   break;
	case 468:   tempColorName = @"DeepJungleGreen";   break;
	case 469:   tempColorName = @"Sapphire";   break;
	case 470:   tempColorName = @"Green6";   break;
	case 471:   tempColorName = @"OliveDrab2";   break;
	case 472:   tempColorName = @"DarkBlue";   break;
	case 473:   tempColorName = @"DarkRed";   break;
	case 474:   tempColorName = @"RoyalBlue1";   break;
	case 475:   tempColorName = @"Bistre";   break;
	case 476:   tempColorName = @"PrussianBlue";   break;
	case 477:   tempColorName = @"Myrtle";   break;
	case 478:   tempColorName = @"Green2";   break;
	case 479:   tempColorName = @"Maroon1";   break;
	case 480:   tempColorName = @"NavyBlue";   break;
	case 481:   tempColorName = @"OfficeGreen";   break;
	case 482:   tempColorName = @"MediumJungleGreen";   break;
	case 483:   tempColorName = @"DarkScarlet";   break;
	case 484:   tempColorName = @"Rosewood";   break;
	case 485:   tempColorName = @"PhthaloGreen";   break;
	case 486:   tempColorName = @"BritishRacingGreen";   break;
	case 487:   tempColorName = @"DarkSienna";   break;
	case 488:   tempColorName = @"DarkJungleGreen";   break;
	case 489:   tempColorName = @"ForestGreen";   break;
	case 490:   tempColorName = @"SealBrown";   break;
	case 491:   tempColorName = @"BulgarianRose";   break;
	case 492:   tempColorName = @"DarkGreen";   break;
	case 493:   tempColorName = @"Black";   break;
	}
	return tempColorName;
}


+(UIColor*)black {return [UIColor blackColor];}
+(UIColor*)darkgray {return [UIColor darkGrayColor];}
+(UIColor*)lightgray {return [UIColor lightGrayColor];}
+(UIColor*)white {return [UIColor whiteColor];}
+(UIColor*)gray {return [UIColor grayColor];}
+(UIColor*)red {return [UIColor redColor];}
+(UIColor*)green {return [UIColor greenColor];}
+(UIColor*)blue {return [UIColor blueColor];}
+(UIColor*)cyan {return [UIColor cyanColor];}
+(UIColor*)yellow {return [UIColor yellowColor];}
+(UIColor*)magenta {return [UIColor magentaColor];}
+(UIColor*)orange {return [UIColor orangeColor];}
+(UIColor*)purple {return [UIColor purpleColor];}
+(UIColor*)brown {return [UIColor brownColor];}
+(UIColor*)iPhoneStandard {return [UIColor lightGrayColor];}
+(UIColor*)testColor {return [UIColor colorWithRed: 1.0f green:0.45f blue:0.45f alpha:1.0f];}


+(UIColor*)White {return [UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1.0f];}
+(UIColor*)Azure2 {return [UIColor colorWithRed:0.94f green:1.00f blue:1.00f alpha:1.0f];}
+(UIColor*)Ivory {return [UIColor colorWithRed:1.00f green:1.00f blue:0.94f alpha:1.0f];}
+(UIColor*)Magnolia {return [UIColor colorWithRed:0.97f green:0.96f blue:1.00f alpha:1.0f];}
+(UIColor*)AliceBlue {return [UIColor colorWithRed:0.94f green:0.97f blue:1.00f alpha:1.0f];}
+(UIColor*)LavenderBlush {return [UIColor colorWithRed:1.00f green:0.94f blue:0.96f alpha:1.0f];}
+(UIColor*)Seashell {return [UIColor colorWithRed:1.00f green:0.96f blue:0.93f alpha:1.0f];}
+(UIColor*)Honeydew {return [UIColor colorWithRed:0.94f green:1.00f blue:0.94f alpha:1.0f];}
+(UIColor*)BabyBlue {return [UIColor colorWithRed:0.88f green:1.00f blue:1.00f alpha:1.0f];}
+(UIColor*)CosmicLatte {return [UIColor colorWithRed:1.00f green:0.97f blue:0.91f alpha:1.0f];}
+(UIColor*)OldLace {return [UIColor colorWithRed:0.99f green:0.96f blue:0.90f alpha:1.0f];}
+(UIColor*)Linen {return [UIColor colorWithRed:0.98f green:0.94f blue:0.90f alpha:1.0f];}
+(UIColor*)Cream {return [UIColor colorWithRed:1.00f green:0.99f blue:0.82f alpha:1.0f];}
+(UIColor*)Beige {return [UIColor colorWithRed:0.96f green:0.96f blue:0.86f alpha:1.0f];}
+(UIColor*)Lavender2 {return [UIColor colorWithRed:0.90f green:0.90f blue:0.98f alpha:1.0f];}
+(UIColor*)LemonChiffon {return [UIColor colorWithRed:1.00f green:0.98f blue:0.80f alpha:1.0f];}
+(UIColor*)MistyRose {return [UIColor colorWithRed:1.00f green:0.89f blue:0.88f alpha:1.0f];}
+(UIColor*)PapayaWhip {return [UIColor colorWithRed:1.00f green:0.94f blue:0.84f alpha:1.0f];}
+(UIColor*)PalePink {return [UIColor colorWithRed:0.98f green:0.85f blue:0.87f alpha:1.0f];}
+(UIColor*)ClassicRose {return [UIColor colorWithRed:0.98f green:0.80f blue:0.91f alpha:1.0f];}
+(UIColor*)Champagne {return [UIColor colorWithRed:0.97f green:0.91f blue:0.81f alpha:1.0f];}
+(UIColor*)PastelPink {return [UIColor colorWithRed:1.00f green:0.82f blue:0.86f alpha:1.0f];}
+(UIColor*)LightMauve {return [UIColor colorWithRed:0.86f green:0.82f blue:1.00f alpha:1.0f];}
+(UIColor*)Platinum {return [UIColor colorWithRed:0.90f green:0.89f blue:0.89f alpha:1.0f];}
+(UIColor*)Peach {return [UIColor colorWithRed:1.00f green:0.90f blue:0.71f alpha:1.0f];}
+(UIColor*)LavenderBlue {return [UIColor colorWithRed:0.80f green:0.80f blue:1.00f alpha:1.0f];}
+(UIColor*)Periwinkle {return [UIColor colorWithRed:0.80f green:0.80f blue:1.00f alpha:1.0f];}
+(UIColor*)PaleSpringBud {return [UIColor colorWithRed:0.93f green:0.92f blue:0.74f alpha:1.0f];}
+(UIColor*)PeachPuff {return [UIColor colorWithRed:1.00f green:0.85f blue:0.73f alpha:1.0f];}
+(UIColor*)Mauve {return [UIColor colorWithRed:0.88f green:0.69f blue:1.00f alpha:1.0f];}
+(UIColor*)PaleBlue {return [UIColor colorWithRed:0.69f green:0.93f blue:0.93f alpha:1.0f];}
+(UIColor*)NavajoWhite {return [UIColor colorWithRed:1.00f green:0.87f blue:0.68f alpha:1.0f];}
+(UIColor*)Pink {return [UIColor colorWithRed:1.00f green:0.75f blue:0.80f alpha:1.0f];}
+(UIColor*)PeachYellow {return [UIColor colorWithRed:0.98f green:0.87f blue:0.68f alpha:1.0f];}
+(UIColor*)Wheat {return [UIColor colorWithRed:0.96f green:0.87f blue:0.70f alpha:1.0f];}
+(UIColor*)LightApricot {return [UIColor colorWithRed:0.99f green:0.84f blue:0.69f alpha:1.0f];}
+(UIColor*)MediumChampagne {return [UIColor colorWithRed:0.95f green:0.90f blue:0.67f alpha:1.0f];}
+(UIColor*)TeaGreen {return [UIColor colorWithRed:0.82f green:0.94f blue:0.75f alpha:1.0f];}
+(UIColor*)LavenderRose {return [UIColor colorWithRed:0.98f green:0.63f blue:0.89f alpha:1.0f];}
+(UIColor*)LanguidLavender {return [UIColor colorWithRed:0.84f green:0.79f blue:0.87f alpha:1.0f];}
+(UIColor*)CherryBlossomPink {return [UIColor colorWithRed:1.00f green:0.72f blue:0.77f alpha:1.0f];}
+(UIColor*)LavenderPink {return [UIColor colorWithRed:0.98f green:0.68f blue:0.82f alpha:1.0f];}
+(UIColor*)Apricot {return [UIColor colorWithRed:0.98f green:0.81f blue:0.69f alpha:1.0f];}
+(UIColor*)BabyPink {return [UIColor colorWithRed:0.96f green:0.76f blue:0.76f alpha:1.0f];}
+(UIColor*)TeaRose2 {return [UIColor colorWithRed:0.96f green:0.76f blue:0.76f alpha:1.0f];}
+(UIColor*)ColumbiaBlue {return [UIColor colorWithRed:0.61f green:0.87f blue:1.00f alpha:1.0f];}
+(UIColor*)LightPink {return [UIColor colorWithRed:1.00f green:0.71f blue:0.76f alpha:1.0f];}
+(UIColor*)PowderBlue {return [UIColor colorWithRed:0.69f green:0.88f blue:0.90f alpha:1.0f];}
+(UIColor*)DeepChampagne {return [UIColor colorWithRed:0.98f green:0.84f blue:0.65f alpha:1.0f];}
+(UIColor*)ElectricBlue {return [UIColor colorWithRed:0.49f green:0.98f blue:1.00f alpha:1.0f];}
+(UIColor*)FuchsiaPink {return [UIColor colorWithRed:1.00f green:0.47f blue:1.00f alpha:1.0f];}
+(UIColor*)Thistle {return [UIColor colorWithRed:0.85f green:0.75f blue:0.85f alpha:1.0f];}
+(UIColor*)CarnationPink {return [UIColor colorWithRed:1.00f green:0.65f blue:0.79f alpha:1.0f];}
+(UIColor*)DeepPeach {return [UIColor colorWithRed:1.00f green:0.80f blue:0.64f alpha:1.0f];}
+(UIColor*)UltraPink {return [UIColor colorWithRed:1.00f green:0.44f blue:1.00f alpha:1.0f];}
+(UIColor*)LightBlue {return [UIColor colorWithRed:0.68f green:0.85f blue:0.90f alpha:1.0f];}
+(UIColor*)LightCornflowerBlue {return [UIColor colorWithRed:0.68f green:0.85f blue:0.90f alpha:1.0f];}
+(UIColor*)MagicMint {return [UIColor colorWithRed:0.67f green:0.94f blue:0.82f alpha:1.0f];}
+(UIColor*)NadeshikoPink {return [UIColor colorWithRed:0.96f green:0.68f blue:0.78f alpha:1.0f];}
+(UIColor*)PaleCornflowerBlue {return [UIColor colorWithRed:0.67f green:0.80f blue:0.94f alpha:1.0f];}
+(UIColor*)DesertSand {return [UIColor colorWithRed:0.93f green:0.79f blue:0.69f alpha:1.0f];}
+(UIColor*)PeachOrange {return [UIColor colorWithRed:1.00f green:0.80f blue:0.60f alpha:1.0f];}
+(UIColor*)Khaki2 {return [UIColor colorWithRed:0.94f green:0.90f blue:0.55f alpha:1.0f];}
+(UIColor*)LightFuchsiaPink {return [UIColor colorWithRed:0.98f green:0.52f blue:0.90f alpha:1.0f];}
+(UIColor*)PaleMagenta {return [UIColor colorWithRed:0.98f green:0.52f blue:0.90f alpha:1.0f];}
+(UIColor*)LavenderMagenta {return [UIColor colorWithRed:0.93f green:0.51f blue:0.93f alpha:1.0f];}
+(UIColor*)PaleAmaranthPink {return [UIColor colorWithRed:0.87f green:0.75f blue:0.76f alpha:1.0f];}
+(UIColor*)Violet2 {return [UIColor colorWithRed:0.93f green:0.51f blue:0.93f alpha:1.0f];}
+(UIColor*)BrightUbe {return [UIColor colorWithRed:0.82f green:0.62f blue:0.91f alpha:1.0f];}
+(UIColor*)LavenderGray {return [UIColor colorWithRed:0.77f green:0.76f blue:0.82f alpha:1.0f];}
+(UIColor*)Aquamarine {return [UIColor colorWithRed:0.50f green:1.00f blue:0.83f alpha:1.0f];}
+(UIColor*)Heliotrope {return [UIColor colorWithRed:0.87f green:0.45f blue:1.00f alpha:1.0f];}
+(UIColor*)LightSkyBlue {return [UIColor colorWithRed:0.53f green:0.81f blue:0.98f alpha:1.0f];}
+(UIColor*)Buff {return [UIColor colorWithRed:0.94f green:0.86f blue:0.51f alpha:1.0f];}
+(UIColor*)Flax {return [UIColor colorWithRed:0.93f green:0.86f blue:0.51f alpha:1.0f];}
+(UIColor*)AmaranthPink {return [UIColor colorWithRed:0.95f green:0.61f blue:0.73f alpha:1.0f];}
+(UIColor*)Maize {return [UIColor colorWithRed:0.98f green:0.93f blue:0.37f alpha:1.0f];}
+(UIColor*)PaleRobinEggBlue {return [UIColor colorWithRed:0.59f green:0.87f blue:0.82f alpha:1.0f];}
+(UIColor*)Wisteria {return [UIColor colorWithRed:0.79f green:0.63f blue:0.86f alpha:1.0f];}
+(UIColor*)Corn {return [UIColor colorWithRed:0.98f green:0.93f blue:0.36f alpha:1.0f];}
+(UIColor*)PaleSilver {return [UIColor colorWithRed:0.79f green:0.75f blue:0.73f alpha:1.0f];}
+(UIColor*)Silver {return [UIColor colorWithRed:0.75f green:0.75f blue:0.75f alpha:1.0f];}
+(UIColor*)SkyBlue {return [UIColor colorWithRed:0.53f green:0.81f blue:0.92f alpha:1.0f];}
+(UIColor*)Celadon {return [UIColor colorWithRed:0.67f green:0.88f blue:0.69f alpha:1.0f];}
+(UIColor*)MossGreen {return [UIColor colorWithRed:0.68f green:0.87f blue:0.68f alpha:1.0f];}
+(UIColor*)PaleChestnut {return [UIColor colorWithRed:0.87f green:0.68f blue:0.69f alpha:1.0f];}
+(UIColor*)BrightLavender {return [UIColor colorWithRed:0.75f green:0.58f blue:0.89f alpha:1.0f];}
+(UIColor*)CarolinaBlue {return [UIColor colorWithRed:0.60f green:0.73f blue:0.89f alpha:1.0f];}
+(UIColor*)PersianPink {return [UIColor colorWithRed:0.97f green:0.50f blue:0.75f alpha:1.0f];}
+(UIColor*)SalmonPink {return [UIColor colorWithRed:1.00f green:0.57f blue:0.64f alpha:1.0f];}
+(UIColor*)Jonquil {return [UIColor colorWithRed:0.98f green:0.85f blue:0.37f alpha:1.0f];}
+(UIColor*)Lilac {return [UIColor colorWithRed:0.78f green:0.64f blue:0.78f alpha:1.0f];}
+(UIColor*)Mustard {return [UIColor colorWithRed:1.00f green:0.86f blue:0.35f alpha:1.0f];}
+(UIColor*)CambridgeBlue {return [UIColor colorWithRed:0.60f green:0.80f blue:0.80f alpha:1.0f];}
+(UIColor*)LightSalmonPink {return [UIColor colorWithRed:1.00f green:0.60f blue:0.60f alpha:1.0f];}
+(UIColor*)MediumLavenderMagenta {return [UIColor colorWithRed:0.80f green:0.60f blue:0.80f alpha:1.0f];}
+(UIColor*)Plum {return [UIColor colorWithRed:0.80f green:0.60f blue:0.80f alpha:1.0f];}
+(UIColor*)RosePink {return [UIColor colorWithRed:1.00f green:0.40f blue:0.80f alpha:1.0f];}
+(UIColor*)MayaBlue {return [UIColor colorWithRed:0.45f green:0.76f blue:0.98f alpha:1.0f];}
+(UIColor*)MintGreen {return [UIColor colorWithRed:0.60f green:1.00f blue:0.60f alpha:1.0f];}
+(UIColor*)Yellow2 {return [UIColor colorWithRed:1.00f green:1.00f blue:0.20f alpha:1.0f];}
+(UIColor*)MediumSpringBud {return [UIColor colorWithRed:0.79f green:0.86f blue:0.54f alpha:1.0f];}
+(UIColor*)PaleGold {return [UIColor colorWithRed:0.90f green:0.75f blue:0.54f alpha:1.0f];}
+(UIColor*)LightThulianPink {return [UIColor colorWithRed:0.90f green:0.56f blue:0.67f alpha:1.0f];}
+(UIColor*)Orchid {return [UIColor colorWithRed:0.85f green:0.44f blue:0.84f alpha:1.0f];}
+(UIColor*)HotPink {return [UIColor colorWithRed:1.00f green:0.41f blue:0.71f alpha:1.0f];}
+(UIColor*)LightSalmon {return [UIColor colorWithRed:1.00f green:0.63f blue:0.48f alpha:1.0f];}
+(UIColor*)Tan {return [UIColor colorWithRed:0.82f green:0.71f blue:0.55f alpha:1.0f];}
+(UIColor*)Lavender1 {return [UIColor colorWithRed:0.71f green:0.49f blue:0.86f alpha:1.0f];}
+(UIColor*)Khaki1 {return [UIColor colorWithRed:0.76f green:0.69f blue:0.57f alpha:1.0f];}
+(UIColor*)EtonBlue {return [UIColor colorWithRed:0.59f green:0.78f blue:0.64f alpha:1.0f];}
+(UIColor*)Aqua {return [UIColor colorWithRed:0.00f green:1.00f blue:1.00f alpha:1.0f];}
+(UIColor*)AtomicTangerine {return [UIColor colorWithRed:1.00f green:0.60f blue:0.40f alpha:1.0f];}
+(UIColor*)Cyan1 {return [UIColor colorWithRed:0.00f green:1.00f blue:1.00f alpha:1.0f];}
+(UIColor*)Fuchsia {return [UIColor colorWithRed:1.00f green:0.00f blue:1.00f alpha:1.0f];}
+(UIColor*)Magenta {return [UIColor colorWithRed:1.00f green:0.00f blue:1.00f alpha:1.0f];}
+(UIColor*)PinkOrange {return [UIColor colorWithRed:1.00f green:0.60f blue:0.40f alpha:1.0f];}
+(UIColor*)RazzleDazzleRose {return [UIColor colorWithRed:1.00f green:0.20f blue:0.80f alpha:1.0f];}
+(UIColor*)Sunglow {return [UIColor colorWithRed:1.00f green:0.80f blue:0.20f alpha:1.0f];}
+(UIColor*)Yellow {return [UIColor colorWithRed:1.00f green:1.00f blue:0.00f alpha:1.0f];}
+(UIColor*)DarkSalmon {return [UIColor colorWithRed:0.91f green:0.59f blue:0.48f alpha:1.0f];}
+(UIColor*)SandyBrown {return [UIColor colorWithRed:0.96f green:0.64f blue:0.38f alpha:1.0f];}
+(UIColor*)BrilliantRose {return [UIColor colorWithRed:1.00f green:0.33f blue:0.64f alpha:1.0f];}
+(UIColor*)Lemon {return [UIColor colorWithRed:0.99f green:0.91f blue:0.06f alpha:1.0f];}
+(UIColor*)CadmiumYellow {return [UIColor colorWithRed:1.00f green:0.96f blue:0.00f alpha:1.0f];}
+(UIColor*)CoralPink {return [UIColor colorWithRed:0.97f green:0.51f blue:0.47f alpha:1.0f];}
+(UIColor*)DarkChampagne {return [UIColor colorWithRed:0.76f green:0.70f blue:0.50f alpha:1.0f];}
+(UIColor*)Ecru {return [UIColor colorWithRed:0.76f green:0.70f blue:0.50f alpha:1.0f];}
+(UIColor*)Salmon {return [UIColor colorWithRed:1.00f green:0.55f blue:0.41f alpha:1.0f];}
+(UIColor*)Sand {return [UIColor colorWithRed:0.76f green:0.70f blue:0.50f alpha:1.0f];}
+(UIColor*)TeaRose1 {return [UIColor colorWithRed:0.97f green:0.51f blue:0.47f alpha:1.0f];}
+(UIColor*)AmaranthMagenta {return [UIColor colorWithRed:0.93f green:0.24f blue:0.79f alpha:1.0f];}
+(UIColor*)LightCoral {return [UIColor colorWithRed:0.94f green:0.50f blue:0.50f alpha:1.0f];}
+(UIColor*)SkyMagenta {return [UIColor colorWithRed:0.81f green:0.44f blue:0.69f alpha:1.0f];}
+(UIColor*)JuneBud {return [UIColor colorWithRed:0.74f green:0.85f blue:0.34f alpha:1.0f];}
+(UIColor*)ThulianPink {return [UIColor colorWithRed:0.87f green:0.44f blue:0.63f alpha:1.0f];}
+(UIColor*)Yellow1 {return [UIColor colorWithRed:1.00f green:0.94f blue:0.00f alpha:1.0f];}
+(UIColor*)Puce {return [UIColor colorWithRed:0.80f green:0.53f blue:0.60f alpha:1.0f];}
+(UIColor*)Purple2 {return [UIColor colorWithRed:0.63f green:0.36f blue:0.94f alpha:1.0f];}
+(UIColor*)RoseQuartz {return [UIColor colorWithRed:0.67f green:0.60f blue:0.66f alpha:1.0f];}
+(UIColor*)EarthYellow {return [UIColor colorWithRed:0.88f green:0.66f blue:0.37f alpha:1.0f];}
+(UIColor*)Saffron {return [UIColor colorWithRed:0.96f green:0.77f blue:0.19f alpha:1.0f];}
+(UIColor*)CornflowerBlue {return [UIColor colorWithRed:0.39f green:0.58f blue:0.93f alpha:1.0f];}
+(UIColor*)MediumTurquoise {return [UIColor colorWithRed:0.28f green:0.82f blue:0.80f alpha:1.0f];}
+(UIColor*)Pear {return [UIColor colorWithRed:0.82f green:0.89f blue:0.19f alpha:1.0f];}
+(UIColor*)IndianYellow {return [UIColor colorWithRed:0.89f green:0.66f blue:0.34f alpha:1.0f];}
+(UIColor*)OperaMauve {return [UIColor colorWithRed:0.72f green:0.52f blue:0.65f alpha:1.0f];}
+(UIColor*)DarkKhaki {return [UIColor colorWithRed:0.74f green:0.72f blue:0.42f alpha:1.0f];}
+(UIColor*)Chartreuse1 {return [UIColor colorWithRed:0.87f green:1.00f blue:0.00f alpha:1.0f];}
+(UIColor*)GoldenYellow {return [UIColor colorWithRed:1.00f green:0.87f blue:0.00f alpha:1.0f];}
+(UIColor*)MediumPurple {return [UIColor colorWithRed:0.58f green:0.44f blue:0.86f alpha:1.0f];}
+(UIColor*)PaleRedViolet {return [UIColor colorWithRed:0.86f green:0.44f blue:0.58f alpha:1.0f];}
+(UIColor*)PsychedelicPurple {return [UIColor colorWithRed:0.87f green:0.00f blue:1.00f alpha:1.0f];}
+(UIColor*)GreenYellow {return [UIColor colorWithRed:0.68f green:1.00f blue:0.18f alpha:1.0f];}
+(UIColor*)BrinkPink {return [UIColor colorWithRed:0.98f green:0.38f blue:0.50f alpha:1.0f];}
+(UIColor*)RosyBrown {return [UIColor colorWithRed:0.74f green:0.56f blue:0.56f alpha:1.0f];}
+(UIColor*)RichLavender {return [UIColor colorWithRed:0.67f green:0.38f blue:0.80f alpha:1.0f];}
+(UIColor*)SchoolBusYellow {return [UIColor colorWithRed:1.00f green:0.85f blue:0.00f alpha:1.0f];}
+(UIColor*)DeepFuchsia {return [UIColor colorWithRed:0.76f green:0.33f blue:0.76f alpha:1.0f];}
+(UIColor*)Gold1 {return [UIColor colorWithRed:1.00f green:0.84f blue:0.00f alpha:1.0f];}
+(UIColor*)LavenderIndigo {return [UIColor colorWithRed:0.58f green:0.34f blue:0.92f alpha:1.0f];}
+(UIColor*)PaleTaupe {return [UIColor colorWithRed:0.74f green:0.60f blue:0.49f alpha:1.0f];}
+(UIColor*)UnitedNationsBlue {return [UIColor colorWithRed:0.36f green:0.57f blue:0.90f alpha:1.0f];}
+(UIColor*)VegasGold {return [UIColor colorWithRed:0.77f green:0.70f blue:0.35f alpha:1.0f];}
+(UIColor*)MikadoYellow {return [UIColor colorWithRed:1.00f green:0.77f blue:0.05f alpha:1.0f];}
+(UIColor*)BrightTurquoise {return [UIColor colorWithRed:0.03f green:0.91f blue:0.87f alpha:1.0f];}
+(UIColor*)Coral {return [UIColor colorWithRed:1.00f green:0.50f blue:0.31f alpha:1.0f];}
+(UIColor*)Turquoise {return [UIColor colorWithRed:0.19f green:0.84f blue:0.78f alpha:1.0f];}
+(UIColor*)Amethyst {return [UIColor colorWithRed:0.60f green:0.40f blue:0.80f alpha:1.0f];}
+(UIColor*)Bittersweet {return [UIColor colorWithRed:1.00f green:0.44f blue:0.37f alpha:1.0f];}
+(UIColor*)DeepSaffron {return [UIColor colorWithRed:1.00f green:0.60f blue:0.20f alpha:1.0f];}
+(UIColor*)ElectricLime {return [UIColor colorWithRed:0.80f green:1.00f blue:0.00f alpha:1.0f];}
+(UIColor*)HotMagenta {return [UIColor colorWithRed:1.00f green:0.00f blue:0.80f alpha:1.0f];}
+(UIColor*)PaleCopper {return [UIColor colorWithRed:0.85f green:0.54f blue:0.40f alpha:1.0f];}
+(UIColor*)PastelGreen {return [UIColor colorWithRed:0.47f green:0.87f blue:0.47f alpha:1.0f];}
+(UIColor*)ShockingPink {return [UIColor colorWithRed:0.99f green:0.06f blue:0.75f alpha:1.0f];}
+(UIColor*)TangerineYellow {return [UIColor colorWithRed:1.00f green:0.80f blue:0.00f alpha:1.0f];}
+(UIColor*)CoolGrey {return [UIColor colorWithRed:0.55f green:0.57f blue:0.67f alpha:1.0f];}
+(UIColor*)FrenchRose {return [UIColor colorWithRed:0.96f green:0.29f blue:0.54f alpha:1.0f];}
+(UIColor*)Pistachio {return [UIColor colorWithRed:0.58f green:0.77f blue:0.45f alpha:1.0f];}
+(UIColor*)PersianRose {return [UIColor colorWithRed:1.00f green:0.16f blue:0.64f alpha:1.0f];}
+(UIColor*)LavenderPurple {return [UIColor colorWithRed:0.59f green:0.48f blue:0.71f alpha:1.0f];}
+(UIColor*)Camel {return [UIColor colorWithRed:0.76f green:0.60f blue:0.42f alpha:1.0f];}
+(UIColor*)Desert {return [UIColor colorWithRed:0.76f green:0.60f blue:0.42f alpha:1.0f];}
+(UIColor*)Fallow {return [UIColor colorWithRed:0.76f green:0.60f blue:0.42f alpha:1.0f];}
+(UIColor*)Olivine {return [UIColor colorWithRed:0.60f green:0.73f blue:0.45f alpha:1.0f];}
+(UIColor*)Ube {return [UIColor colorWithRed:0.53f green:0.47f blue:0.76f alpha:1.0f];}
+(UIColor*)OldRose {return [UIColor colorWithRed:0.75f green:0.50f blue:0.51f alpha:1.0f];}
+(UIColor*)PersianOrange {return [UIColor colorWithRed:0.85f green:0.56f blue:0.35f alpha:1.0f];}
+(UIColor*)OldGold {return [UIColor colorWithRed:0.81f green:0.71f blue:0.23f alpha:1.0f];}
+(UIColor*)Amber1 {return [UIColor colorWithRed:1.00f green:0.75f blue:0.00f alpha:1.0f];}
+(UIColor*)ElectricPurple {return [UIColor colorWithRed:0.75f green:0.00f blue:1.00f alpha:1.0f];}
+(UIColor*)GoldenPoppy {return [UIColor colorWithRed:0.99f green:0.76f blue:0.00f alpha:1.0f];}
+(UIColor*)Lime1 {return [UIColor colorWithRed:0.75f green:1.00f blue:0.00f alpha:1.0f];}
+(UIColor*)DarkPink {return [UIColor colorWithRed:0.91f green:0.33f blue:0.50f alpha:1.0f];}
+(UIColor*)BlueGreen {return [UIColor colorWithRed:0.00f green:0.87f blue:0.87f alpha:1.0f];}
+(UIColor*)Gold2 {return [UIColor colorWithRed:0.83f green:0.69f blue:0.22f alpha:1.0f];}
+(UIColor*)DarkTangerine {return [UIColor colorWithRed:1.00f green:0.66f blue:0.07f alpha:1.0f];}
+(UIColor*)SelectiveYellow {return [UIColor colorWithRed:1.00f green:0.73f blue:0.00f alpha:1.0f];}
+(UIColor*)TerraCotta {return [UIColor colorWithRed:0.89f green:0.45f blue:0.36f alpha:1.0f];}
+(UIColor*)BurntSienna {return [UIColor colorWithRed:0.91f green:0.45f blue:0.32f alpha:1.0f];}
+(UIColor*)LightCarminePink {return [UIColor colorWithRed:0.90f green:0.40f blue:0.38f alpha:1.0f];}
+(UIColor*)DodgerBlue {return [UIColor colorWithRed:0.12f green:0.56f blue:1.00f alpha:1.0f];}
+(UIColor*)CerisePink {return [UIColor colorWithRed:0.93f green:0.23f blue:0.51f alpha:1.0f];}
+(UIColor*)DeepLilac {return [UIColor colorWithRed:0.60f green:0.33f blue:0.73f alpha:1.0f];}
+(UIColor*)Tomato {return [UIColor colorWithRed:1.00f green:0.39f blue:0.28f alpha:1.0f];}
+(UIColor*)TurkishRose {return [UIColor colorWithRed:0.71f green:0.45f blue:0.51f alpha:1.0f];}
+(UIColor*)DeepPink {return [UIColor colorWithRed:1.00f green:0.08f blue:0.58f alpha:1.0f];}
+(UIColor*)Orange3 {return [UIColor colorWithRed:1.00f green:0.65f blue:0.00f alpha:1.0f];}
+(UIColor*)AndroidGreen {return [UIColor colorWithRed:0.64f green:0.78f blue:0.22f alpha:1.0f];}
+(UIColor*)SpringBud {return [UIColor colorWithRed:0.65f green:0.99f blue:0.00f alpha:1.0f];}
+(UIColor*)Cyan2 {return [UIColor colorWithRed:0.00f green:0.72f blue:0.92f alpha:1.0f];}
+(UIColor*)CadmiumOrange {return [UIColor colorWithRed:0.93f green:0.53f blue:0.18f alpha:1.0f];}
+(UIColor*)SatinSheenGold {return [UIColor colorWithRed:0.80f green:0.63f blue:0.21f alpha:1.0f];}
+(UIColor*)MountbattenPink {return [UIColor colorWithRed:0.60f green:0.48f blue:0.55f alpha:1.0f];}
+(UIColor*)CarrotOrange {return [UIColor colorWithRed:0.93f green:0.57f blue:0.13f alpha:1.0f];}
+(UIColor*)DarkTurquoise {return [UIColor colorWithRed:0.00f green:0.81f blue:0.82f alpha:1.0f];}
+(UIColor*)Goldenrod {return [UIColor colorWithRed:0.85f green:0.65f blue:0.13f alpha:1.0f];}
+(UIColor*)OrangePeel {return [UIColor colorWithRed:1.00f green:0.63f blue:0.00f alpha:1.0f];}
+(UIColor*)RoseGold {return [UIColor colorWithRed:0.72f green:0.43f blue:0.47f alpha:1.0f];}
+(UIColor*)Brass {return [UIColor colorWithRed:0.71f green:0.65f blue:0.26f alpha:1.0f];}
+(UIColor*)Mulberry {return [UIColor colorWithRed:0.77f green:0.29f blue:0.55f alpha:1.0f];}
+(UIColor*)Asparagus {return [UIColor colorWithRed:0.53f green:0.66f blue:0.42f alpha:1.0f];}
+(UIColor*)DeepMagenta {return [UIColor colorWithRed:0.80f green:0.00f blue:0.80f alpha:1.0f];}
+(UIColor*)TaupeGray {return [UIColor colorWithRed:0.55f green:0.52f blue:0.54f alpha:1.0f];}
+(UIColor*)YellowGreen {return [UIColor colorWithRed:0.60f green:0.80f blue:0.20f alpha:1.0f];}
+(UIColor*)LightSlateGray {return [UIColor colorWithRed:0.47f green:0.53f blue:0.60f alpha:1.0f];}
+(UIColor*)RobinEggBlue {return [UIColor colorWithRed:0.00f green:0.80f blue:0.80f alpha:1.0f];}
+(UIColor*)VividViolet {return [UIColor colorWithRed:0.60f green:0.00f blue:1.00f alpha:1.0f];}
+(UIColor*)BlueViolet {return [UIColor colorWithRed:0.54f green:0.17f blue:0.89f alpha:1.0f];}
+(UIColor*)Orange2 {return [UIColor colorWithRed:0.98f green:0.60f blue:0.01f alpha:1.0f];}
+(UIColor*)DeepCarrotOrange {return [UIColor colorWithRed:1.00f green:0.59f blue:0.00f alpha:1.0f];}
+(UIColor*)Fandango {return [UIColor colorWithRed:0.72f green:0.33f blue:0.54f alpha:1.0f];}
+(UIColor*)FashionFuchsia {return [UIColor colorWithRed:0.96f green:0.00f blue:0.63f alpha:1.0f];}
+(UIColor*)HollywoodCerise {return [UIColor colorWithRed:0.96f green:0.00f blue:0.63f alpha:1.0f];}
+(UIColor*)Byzantine {return [UIColor colorWithRed:0.74f green:0.20f blue:0.64f alpha:1.0f];}
+(UIColor*)MediumSpringGreen {return [UIColor colorWithRed:0.00f green:0.98f blue:0.60f alpha:1.0f];}
+(UIColor*)DeepCerise {return [UIColor colorWithRed:0.85f green:0.20f blue:0.53f alpha:1.0f];}
+(UIColor*)RadicalRed {return [UIColor colorWithRed:1.00f green:0.21f blue:0.37f alpha:1.0f];}
+(UIColor*)Emerald {return [UIColor colorWithRed:0.31f green:0.78f blue:0.47f alpha:1.0f];}
+(UIColor*)AirForceBlue {return [UIColor colorWithRed:0.36f green:0.54f blue:0.66f alpha:1.0f];}
+(UIColor*)Magenta2 {return [UIColor colorWithRed:1.00f green:0.00f blue:0.56f alpha:1.0f];}
+(UIColor*)PortlandOrange {return [UIColor colorWithRed:1.00f green:0.35f blue:0.21f alpha:1.0f];}
+(UIColor*)Gamboge {return [UIColor colorWithRed:0.89f green:0.61f blue:0.06f alpha:1.0f];}
+(UIColor*)MajorelleBlue {return [UIColor colorWithRed:0.38f green:0.31f blue:0.86f alpha:1.0f];}
+(UIColor*)Pumpkin {return [UIColor colorWithRed:1.00f green:0.46f blue:0.09f alpha:1.0f];}
+(UIColor*)DarkOrange {return [UIColor colorWithRed:1.00f green:0.55f blue:0.00f alpha:1.0f];}
+(UIColor*)RoyalBlue2 {return [UIColor colorWithRed:0.25f green:0.41f blue:0.88f alpha:1.0f];}
+(UIColor*)ElectricViolet {return [UIColor colorWithRed:0.55f green:0.00f blue:1.00f alpha:1.0f];}
+(UIColor*)Violet {return [UIColor colorWithRed:0.55f green:0.00f blue:1.00f alpha:1.0f];}
+(UIColor*)RoyalFuchsia {return [UIColor colorWithRed:0.79f green:0.17f blue:0.57f alpha:1.0f];}
+(UIColor*)Chestnut {return [UIColor colorWithRed:0.80f green:0.36f blue:0.36f alpha:1.0f];}
+(UIColor*)Gray {return [UIColor colorWithRed:0.50f green:0.50f blue:0.50f alpha:1.0f];}
+(UIColor*)SlateGray {return [UIColor colorWithRed:0.44f green:0.50f blue:0.56f alpha:1.0f];}
+(UIColor*)CoralRed {return [UIColor colorWithRed:1.00f green:0.25f blue:0.25f alpha:1.0f];}
+(UIColor*)Violet1 {return [UIColor colorWithRed:0.50f green:0.00f blue:1.00f alpha:1.0f];}
+(UIColor*)Azure1 {return [UIColor colorWithRed:0.00f green:0.50f blue:1.00f alpha:1.0f];}
+(UIColor*)BrightPink {return [UIColor colorWithRed:1.00f green:0.00f blue:0.50f alpha:1.0f];}
+(UIColor*)Bronze {return [UIColor colorWithRed:0.80f green:0.50f blue:0.20f alpha:1.0f];}
+(UIColor*)Chartreuse2 {return [UIColor colorWithRed:0.50f green:1.00f blue:0.00f alpha:1.0f];}
+(UIColor*)Orange1 {return [UIColor colorWithRed:1.00f green:0.50f blue:0.00f alpha:1.0f];}
+(UIColor*)Rose {return [UIColor colorWithRed:1.00f green:0.00f blue:0.50f alpha:1.0f];}
+(UIColor*)SpringGreen {return [UIColor colorWithRed:0.00f green:1.00f blue:0.50f alpha:1.0f];}
+(UIColor*)Amber2 {return [UIColor colorWithRed:1.00f green:0.49f blue:0.00f alpha:1.0f];}
+(UIColor*)FrenchBeige {return [UIColor colorWithRed:0.65f green:0.48f blue:0.36f alpha:1.0f];}
+(UIColor*)LightSeaGreen {return [UIColor colorWithRed:0.13f green:0.70f blue:0.67f alpha:1.0f];}
+(UIColor*)SteelBlue {return [UIColor colorWithRed:0.27f green:0.51f blue:0.71f alpha:1.0f];}
+(UIColor*)CarminePink {return [UIColor colorWithRed:0.92f green:0.30f blue:0.26f alpha:1.0f];}
+(UIColor*)TiffanyBlue {return [UIColor colorWithRed:0.04f green:0.73f blue:0.71f alpha:1.0f];}
+(UIColor*)LawnGreen {return [UIColor colorWithRed:0.49f green:0.99f blue:0.00f alpha:1.0f];}
+(UIColor*)Tangerine {return [UIColor colorWithRed:0.95f green:0.52f blue:0.00f alpha:1.0f];}
+(UIColor*)DarkTerraCotta {return [UIColor colorWithRed:0.80f green:0.31f blue:0.36f alpha:1.0f];}
+(UIColor*)AmaranthCerise {return [UIColor colorWithRed:0.80f green:0.15f blue:0.51f alpha:1.0f];}
+(UIColor*)MediumRedViolet {return [UIColor colorWithRed:0.73f green:0.20f blue:0.52f alpha:1.0f];}
+(UIColor*)Razzmatazz {return [UIColor colorWithRed:0.89f green:0.15f blue:0.42f alpha:1.0f];}
+(UIColor*)Cerise {return [UIColor colorWithRed:0.87f green:0.19f blue:0.39f alpha:1.0f];}
+(UIColor*)Xanadu {return [UIColor colorWithRed:0.45f green:0.53f blue:0.47f alpha:1.0f];}
+(UIColor*)BrandeisBlue {return [UIColor colorWithRed:0.00f green:0.44f blue:1.00f alpha:1.0f];}
+(UIColor*)DarkCoral {return [UIColor colorWithRed:0.80f green:0.36f blue:0.27f alpha:1.0f];}
+(UIColor*)RichElectricBlue {return [UIColor colorWithRed:0.03f green:0.57f blue:0.82f alpha:1.0f];}
+(UIColor*)CamouflageGreen {return [UIColor colorWithRed:0.47f green:0.53f blue:0.42f alpha:1.0f];}
+(UIColor*)DarkViolet {return [UIColor colorWithRed:0.58f green:0.00f blue:0.83f alpha:1.0f];}
+(UIColor*)BrightGreen {return [UIColor colorWithRed:0.40f green:1.00f blue:0.00f alpha:1.0f];}
+(UIColor*)CaribbeanGreen {return [UIColor colorWithRed:0.00f green:0.80f blue:0.60f alpha:1.0f];}
+(UIColor*)CopperRose {return [UIColor colorWithRed:0.60f green:0.40f blue:0.40f alpha:1.0f];}
+(UIColor*)ElectricIndigo {return [UIColor colorWithRed:0.40f green:0.00f blue:1.00f alpha:1.0f];}
+(UIColor*)Ochre {return [UIColor colorWithRed:0.80f green:0.47f blue:0.13f alpha:1.0f];}
+(UIColor*)SafetyOrange {return [UIColor colorWithRed:1.00f green:0.40f blue:0.00f alpha:1.0f];}
+(UIColor*)HanBlue {return [UIColor colorWithRed:0.32f green:0.09f blue:0.98f alpha:1.0f];}
+(UIColor*)HanPurple {return [UIColor colorWithRed:0.32f green:0.09f blue:0.98f alpha:1.0f];}
+(UIColor*)DarkTan {return [UIColor colorWithRed:0.57f green:0.51f blue:0.32f alpha:1.0f];}
+(UIColor*)RaspberryRose {return [UIColor colorWithRed:0.70f green:0.27f blue:0.42f alpha:1.0f];}
+(UIColor*)PaleBrown {return [UIColor colorWithRed:0.60f green:0.46f blue:0.33f alpha:1.0f];}
+(UIColor*)DarkChestnut {return [UIColor colorWithRed:0.60f green:0.41f blue:0.38f alpha:1.0f];}
+(UIColor*)RedViolet {return [UIColor colorWithRed:0.78f green:0.08f blue:0.52f alpha:1.0f];}
+(UIColor*)Amaranth {return [UIColor colorWithRed:0.90f green:0.17f blue:0.31f alpha:1.0f];}
+(UIColor*)MediumSeaGreen {return [UIColor colorWithRed:0.24f green:0.70f blue:0.44f alpha:1.0f];}
+(UIColor*)Copper {return [UIColor colorWithRed:0.72f green:0.45f blue:0.20f alpha:1.0f];}
+(UIColor*)MauveTaupe {return [UIColor colorWithRed:0.57f green:0.37f blue:0.43f alpha:1.0f];}
+(UIColor*)JungleGreen {return [UIColor colorWithRed:0.16f green:0.67f blue:0.53f alpha:1.0f];}
+(UIColor*)Magenta1 {return [UIColor colorWithRed:0.79f green:0.08f blue:0.48f alpha:1.0f];}
+(UIColor*)Cinnabar {return [UIColor colorWithRed:0.89f green:0.26f blue:0.20f alpha:1.0f];}
+(UIColor*)Cinnamon {return [UIColor colorWithRed:0.82f green:0.41f blue:0.12f alpha:1.0f];}
+(UIColor*)OldLavender {return [UIColor colorWithRed:0.47f green:0.41f blue:0.47f alpha:1.0f];}
+(UIColor*)DarkLavender {return [UIColor colorWithRed:0.45f green:0.31f blue:0.59f alpha:1.0f];}
+(UIColor*)Vermilion {return [UIColor colorWithRed:0.89f green:0.26f blue:0.20f alpha:1.0f];}
+(UIColor*)DeepCarminePink {return [UIColor colorWithRed:0.94f green:0.19f blue:0.22f alpha:1.0f];}
+(UIColor*)DogwoodRose {return [UIColor colorWithRed:0.84f green:0.09f blue:0.41f alpha:1.0f];}
+(UIColor*)Ruby {return [UIColor colorWithRed:0.88f green:0.07f blue:0.37f alpha:1.0f];}
+(UIColor*)DeepChestnut {return [UIColor colorWithRed:0.73f green:0.31f blue:0.28f alpha:1.0f];}
+(UIColor*)InternationalOrange {return [UIColor colorWithRed:1.00f green:0.31f blue:0.00f alpha:1.0f];}
+(UIColor*)BondiBlue {return [UIColor colorWithRed:0.00f green:0.58f blue:0.71f alpha:1.0f];}
+(UIColor*)RoseVale {return [UIColor colorWithRed:0.67f green:0.31f blue:0.32f alpha:1.0f];}
+(UIColor*)Raspberry {return [UIColor colorWithRed:0.89f green:0.04f blue:0.36f alpha:1.0f];}
+(UIColor*)RoseTaupe {return [UIColor colorWithRed:0.56f green:0.36f blue:0.36f alpha:1.0f];}
+(UIColor*)RoyalPurple {return [UIColor colorWithRed:0.42f green:0.25f blue:0.63f alpha:1.0f];}
+(UIColor*)DarkGoldenrod {return [UIColor colorWithRed:0.72f green:0.53f blue:0.04f alpha:1.0f];}
+(UIColor*)Green5 {return [UIColor colorWithRed:0.40f green:0.69f blue:0.20f alpha:1.0f];}
+(UIColor*)Blue3 {return [UIColor colorWithRed:0.01f green:0.28f blue:1.00f alpha:1.0f];}
+(UIColor*)Tangelo {return [UIColor colorWithRed:0.98f green:0.30f blue:0.00f alpha:1.0f];}
+(UIColor*)OrangeRed {return [UIColor colorWithRed:1.00f green:0.27f blue:0.00f alpha:1.0f];}
+(UIColor*)PalatinateBlue {return [UIColor colorWithRed:0.15f green:0.23f blue:0.89f alpha:1.0f];}
+(UIColor*)Persimmon {return [UIColor colorWithRed:0.93f green:0.35f blue:0.00f alpha:1.0f];}
+(UIColor*)AppleGreen {return [UIColor colorWithRed:0.55f green:0.71f blue:0.00f alpha:1.0f];}
+(UIColor*)AmericanRose {return [UIColor colorWithRed:1.00f green:0.01f blue:0.24f alpha:1.0f];}
+(UIColor*)Maroon2 {return [UIColor colorWithRed:0.69f green:0.19f blue:0.38f alpha:1.0f];}
+(UIColor*)RichMaroon {return [UIColor colorWithRed:0.69f green:0.19f blue:0.38f alpha:1.0f];}
+(UIColor*)TorchRed {return [UIColor colorWithRed:0.99f green:0.05f blue:0.21f alpha:1.0f];}
+(UIColor*)Alizarin {return [UIColor colorWithRed:0.89f green:0.15f blue:0.21f alpha:1.0f];}
+(UIColor*)RoseMadder {return [UIColor colorWithRed:0.89f green:0.15f blue:0.21f alpha:1.0f];}
+(UIColor*)Harlequin {return [UIColor colorWithRed:0.25f green:1.00f blue:0.00f alpha:1.0f];}
+(UIColor*)TwilightLavender {return [UIColor colorWithRed:0.54f green:0.29f blue:0.42f alpha:1.0f];}
+(UIColor*)CeruleanBlue {return [UIColor colorWithRed:0.16f green:0.32f blue:0.75f alpha:1.0f];}
+(UIColor*)PersianGreen {return [UIColor colorWithRed:0.00f green:0.65f blue:0.58f alpha:1.0f];}
+(UIColor*)Red3 {return [UIColor colorWithRed:1.00f green:0.15f blue:0.07f alpha:1.0f];}
+(UIColor*)Malachite {return [UIColor colorWithRed:0.04f green:0.85f blue:0.32f alpha:1.0f];}
+(UIColor*)Violet3 {return [UIColor colorWithRed:0.53f green:0.00f blue:0.69f alpha:1.0f];}
+(UIColor*)DarkElectricBlue {return [UIColor colorWithRed:0.33f green:0.41f blue:0.47f alpha:1.0f];}
+(UIColor*)AmaranthDeepPurple {return [UIColor colorWithRed:0.62f green:0.17f blue:0.41f alpha:1.0f];}
+(UIColor*)CarmineRed {return [UIColor colorWithRed:1.00f green:0.00f blue:0.20f alpha:1.0f];}
+(UIColor*)Denim {return [UIColor colorWithRed:0.08f green:0.38f blue:0.74f alpha:1.0f];}
+(UIColor*)PersianRed {return [UIColor colorWithRed:0.80f green:0.20f blue:0.20f alpha:1.0f];}
+(UIColor*)LimeGreen {return [UIColor colorWithRed:0.20f green:0.80f blue:0.20f alpha:1.0f];}
+(UIColor*)Viridian {return [UIColor colorWithRed:0.25f green:0.51f blue:0.43f alpha:1.0f];}
+(UIColor*)Red2 {return [UIColor colorWithRed:0.93f green:0.11f blue:0.14f alpha:1.0f];}
+(UIColor*)BrightMaroon {return [UIColor colorWithRed:0.76f green:0.13f blue:0.28f alpha:1.0f];}
+(UIColor*)Crimson {return [UIColor colorWithRed:0.86f green:0.08f blue:0.24f alpha:1.0f];}
+(UIColor*)MediumCarmine {return [UIColor colorWithRed:0.69f green:0.25f blue:0.21f alpha:1.0f];}
+(UIColor*)PaleCarmine {return [UIColor colorWithRed:0.69f green:0.25f blue:0.21f alpha:1.0f];}
+(UIColor*)Tenne {return [UIColor colorWithRed:0.80f green:0.34f blue:0.00f alpha:1.0f];}
+(UIColor*)Scarlet {return [UIColor colorWithRed:1.00f green:0.14f blue:0.00f alpha:1.0f];}
+(UIColor*)Cerulean {return [UIColor colorWithRed:0.00f green:0.48f blue:0.65f alpha:1.0f];}
+(UIColor*)AmaranthPurple {return [UIColor colorWithRed:0.67f green:0.15f blue:0.31f alpha:1.0f];}
+(UIColor*)BurntOrange {return [UIColor colorWithRed:0.80f green:0.33f blue:0.00f alpha:1.0f];}
+(UIColor*)Sienna {return [UIColor colorWithRed:0.63f green:0.32f blue:0.18f alpha:1.0f];}
+(UIColor*)Drab {return [UIColor colorWithRed:0.59f green:0.44f blue:0.09f alpha:1.0f];}
+(UIColor*)KellyGreen {return [UIColor colorWithRed:0.30f green:0.73f blue:0.09f alpha:1.0f];}
+(UIColor*)ModeBeige {return [UIColor colorWithRed:0.59f green:0.44f blue:0.09f alpha:1.0f];}
+(UIColor*)SandDune {return [UIColor colorWithRed:0.59f green:0.44f blue:0.09f alpha:1.0f];}
+(UIColor*)SandyTaupe {return [UIColor colorWithRed:0.59f green:0.44f blue:0.09f alpha:1.0f];}
+(UIColor*)Cardinal {return [UIColor colorWithRed:0.77f green:0.12f blue:0.23f alpha:1.0f];}
+(UIColor*)OliveDrab1 {return [UIColor colorWithRed:0.42f green:0.56f blue:0.14f alpha:1.0f];}
+(UIColor*)RichCarmine {return [UIColor colorWithRed:0.84f green:0.00f blue:0.25f alpha:1.0f];}
+(UIColor*)DarkCyan {return [UIColor colorWithRed:0.00f green:0.55f blue:0.55f alpha:1.0f];}
+(UIColor*)DarkMagenta {return [UIColor colorWithRed:0.55f green:0.00f blue:0.55f alpha:1.0f];}
+(UIColor*)GoldenBrown {return [UIColor colorWithRed:0.60f green:0.40f blue:0.08f alpha:1.0f];}
+(UIColor*)Jade {return [UIColor colorWithRed:0.00f green:0.66f blue:0.42f alpha:1.0f];}
+(UIColor*)PersianBlue {return [UIColor colorWithRed:0.11f green:0.22f blue:0.73f alpha:1.0f];}
+(UIColor*)SeaGreen {return [UIColor colorWithRed:0.18f green:0.55f blue:0.34f alpha:1.0f];}
+(UIColor*)JazzberryJam {return [UIColor colorWithRed:0.65f green:0.04f blue:0.37f alpha:1.0f];}
+(UIColor*)Cordovan {return [UIColor colorWithRed:0.54f green:0.25f blue:0.27f alpha:1.0f];}
+(UIColor*)MediumPersianBlue {return [UIColor colorWithRed:0.00f green:0.40f blue:0.65f alpha:1.0f];}
+(UIColor*)FernGreen {return [UIColor colorWithRed:0.31f green:0.47f blue:0.26f alpha:1.0f];}
+(UIColor*)Wenge {return [UIColor colorWithRed:0.39f green:0.33f blue:0.32f alpha:1.0f];}
+(UIColor*)MediumTealBlue {return [UIColor colorWithRed:0.00f green:0.33f blue:0.71f alpha:1.0f];}
+(UIColor*)DeepCarmine {return [UIColor colorWithRed:0.66f green:0.13f blue:0.24f alpha:1.0f];}
+(UIColor*)Rust {return [UIColor colorWithRed:0.72f green:0.25f blue:0.05f alpha:1.0f];}
+(UIColor*)CadmiumRed {return [UIColor colorWithRed:0.89f green:0.00f blue:0.13f alpha:1.0f];}
+(UIColor*)FireEngineRed {return [UIColor colorWithRed:0.81f green:0.09f blue:0.13f alpha:1.0f];}
+(UIColor*)Mahogany {return [UIColor colorWithRed:0.75f green:0.25f blue:0.00f alpha:1.0f];}
+(UIColor*)Olive {return [UIColor colorWithRed:0.50f green:0.50f blue:0.00f alpha:1.0f];}
+(UIColor*)Teal {return [UIColor colorWithRed:0.00f green:0.50f blue:0.50f alpha:1.0f];}
+(UIColor*)Blue1 {return [UIColor colorWithRed:0.00f green:0.00f blue:1.00f alpha:1.0f];}
+(UIColor*)Blue2 {return [UIColor colorWithRed:0.20f green:0.20f blue:0.60f alpha:1.0f];}
+(UIColor*)DarkPastelGreen {return [UIColor colorWithRed:0.01f green:0.75f blue:0.24f alpha:1.0f];}
+(UIColor*)DavysGrey {return [UIColor colorWithRed:0.33f green:0.33f blue:0.33f alpha:1.0f];}
+(UIColor*)ElectricGreen {return [UIColor colorWithRed:0.00f green:1.00f blue:0.00f alpha:1.0f];}
+(UIColor*)Green1 {return [UIColor colorWithRed:0.00f green:1.00f blue:0.00f alpha:1.0f];}
+(UIColor*)Lava {return [UIColor colorWithRed:0.81f green:0.06f blue:0.13f alpha:1.0f];}
+(UIColor*)Lime2 {return [UIColor colorWithRed:0.00f green:1.00f blue:0.00f alpha:1.0f];}
+(UIColor*)Red1 {return [UIColor colorWithRed:1.00f green:0.00f blue:0.00f alpha:1.0f];}
+(UIColor*)Purple1 {return [UIColor colorWithRed:0.50f green:0.00f blue:0.50f alpha:1.0f];}
+(UIColor*)ShamrockGreen {return [UIColor colorWithRed:0.00f green:0.62f blue:0.38f alpha:1.0f];}
+(UIColor*)Feldgrau {return [UIColor colorWithRed:0.30f green:0.36f blue:0.33f alpha:1.0f];}
+(UIColor*)Byzantium {return [UIColor colorWithRed:0.44f green:0.16f blue:0.39f alpha:1.0f];}
+(UIColor*)MediumTaupe {return [UIColor colorWithRed:0.40f green:0.30f blue:0.28f alpha:1.0f];}
+(UIColor*)RoseEbony {return [UIColor colorWithRed:0.40f green:0.30f blue:0.28f alpha:1.0f];}
+(UIColor*)Brown2 {return [UIColor colorWithRed:0.65f green:0.16f blue:0.16f alpha:1.0f];}
+(UIColor*)Bole {return [UIColor colorWithRed:0.47f green:0.27f blue:0.23f alpha:1.0f];}
+(UIColor*)SapGreen {return [UIColor colorWithRed:0.31f green:0.49f blue:0.16f alpha:1.0f];}
+(UIColor*)Firebrick {return [UIColor colorWithRed:0.70f green:0.13f blue:0.13f alpha:1.0f];}
+(UIColor*)Green4 {return [UIColor colorWithRed:0.00f green:0.65f blue:0.31f alpha:1.0f];}
+(UIColor*)Cobalt {return [UIColor colorWithRed:0.00f green:0.28f blue:0.67f alpha:1.0f];}
+(UIColor*)Eggplant {return [UIColor colorWithRed:0.38f green:0.25f blue:0.32f alpha:1.0f];}
+(UIColor*)HalayaUbe {return [UIColor colorWithRed:0.40f green:0.22f blue:0.33f alpha:1.0f];}
+(UIColor*)VividBurgundy {return [UIColor colorWithRed:0.62f green:0.11f blue:0.21f alpha:1.0f];}
+(UIColor*)PalatinatePurple {return [UIColor colorWithRed:0.41f green:0.16f blue:0.38f alpha:1.0f];}
+(UIColor*)Skobeloff {return [UIColor colorWithRed:0.00f green:0.48f blue:0.45f alpha:1.0f];}
+(UIColor*)YaleBlue {return [UIColor colorWithRed:0.06f green:0.30f blue:0.57f alpha:1.0f];}
+(UIColor*)Liver {return [UIColor colorWithRed:0.33f green:0.29f blue:0.31f alpha:1.0f];}
+(UIColor*)DarkByzantium {return [UIColor colorWithRed:0.36f green:0.22f blue:0.33f alpha:1.0f];}
+(UIColor*)EgyptianBlue {return [UIColor colorWithRed:0.06f green:0.20f blue:0.65f alpha:1.0f];}
+(UIColor*)Carnelian {return [UIColor colorWithRed:0.70f green:0.11f blue:0.11f alpha:1.0f];}
+(UIColor*)MediumElectricBlue {return [UIColor colorWithRed:0.01f green:0.31f blue:0.59f alpha:1.0f];}
+(UIColor*)PineGreen {return [UIColor colorWithRed:0.00f green:0.47f blue:0.44f alpha:1.0f];}
+(UIColor*)VenetianRed {return [UIColor colorWithRed:0.78f green:0.03f blue:0.08f alpha:1.0f];}
+(UIColor*)GrayAsparagus {return [UIColor colorWithRed:0.27f green:0.35f blue:0.27f alpha:1.0f];}
+(UIColor*)UpsdellRed {return [UIColor colorWithRed:0.68f green:0.09f blue:0.13f alpha:1.0f];}
+(UIColor*)Brown1 {return [UIColor colorWithRed:0.59f green:0.29f blue:0.00f alpha:1.0f];}
+(UIColor*)BurntUmber {return [UIColor colorWithRed:0.54f green:0.20f blue:0.14f alpha:1.0f];}
+(UIColor*)Russet {return [UIColor colorWithRed:0.50f green:0.27f blue:0.11f alpha:1.0f];}
+(UIColor*)FieldDrab {return [UIColor colorWithRed:0.42f green:0.33f blue:0.12f alpha:1.0f];}
+(UIColor*)PurpleTaupe {return [UIColor colorWithRed:0.31f green:0.25f blue:0.30f alpha:1.0f];}
+(UIColor*)PansyPurple {return [UIColor colorWithRed:0.47f green:0.09f blue:0.29f alpha:1.0f];}
+(UIColor*)InternationalKleinBlue {return [UIColor colorWithRed:0.00f green:0.18f blue:0.65f alpha:1.0f];}
+(UIColor*)TropicalRainForest {return [UIColor colorWithRed:0.00f green:0.46f blue:0.37f alpha:1.0f];}
+(UIColor*)RawUmber {return [UIColor colorWithRed:0.45f green:0.29f blue:0.07f alpha:1.0f];}
+(UIColor*)DarkSpringGreen {return [UIColor colorWithRed:0.09f green:0.45f blue:0.27f alpha:1.0f];}
+(UIColor*)HunterGreen {return [UIColor colorWithRed:0.21f green:0.37f blue:0.23f alpha:1.0f];}
+(UIColor*)DarkSlateGray {return [UIColor colorWithRed:0.18f green:0.31f blue:0.31f alpha:1.0f];}
+(UIColor*)Indigo2 {return [UIColor colorWithRed:0.29f green:0.00f blue:0.51f alpha:1.0f];}
+(UIColor*)MediumBlue {return [UIColor colorWithRed:0.00f green:0.00f blue:0.80f alpha:1.0f];}
+(UIColor*)DarkPowderBlue {return [UIColor colorWithRed:0.00f green:0.20f blue:0.60f alpha:1.0f];}
+(UIColor*)Smalt {return [UIColor colorWithRed:0.00f green:0.20f blue:0.60f alpha:1.0f];}
+(UIColor*)DarkCerulean {return [UIColor colorWithRed:0.03f green:0.27f blue:0.49f alpha:1.0f];}
+(UIColor*)Arsenic {return [UIColor colorWithRed:0.23f green:0.27f blue:0.29f alpha:1.0f];}
+(UIColor*)Charcoal {return [UIColor colorWithRed:0.21f green:0.27f blue:0.31f alpha:1.0f];}
+(UIColor*)DarkBrown {return [UIColor colorWithRed:0.40f green:0.26f blue:0.13f alpha:1.0f];}
+(UIColor*)PaynesGrey {return [UIColor colorWithRed:0.25f green:0.25f blue:0.28f alpha:1.0f];}
+(UIColor*)Sepia {return [UIColor colorWithRed:0.44f green:0.26f blue:0.08f alpha:1.0f];}
+(UIColor*)ArmyGreen {return [UIColor colorWithRed:0.29f green:0.33f blue:0.13f alpha:1.0f];}
+(UIColor*)PersianIndigo {return [UIColor colorWithRed:0.20f green:0.07f blue:0.48f alpha:1.0f];}
+(UIColor*)Auburn {return [UIColor colorWithRed:0.43f green:0.21f blue:0.10f alpha:1.0f];}
+(UIColor*)RifleGreen {return [UIColor colorWithRed:0.25f green:0.28f blue:0.20f alpha:1.0f];}
+(UIColor*)Chocolate {return [UIColor colorWithRed:0.48f green:0.25f blue:0.00f alpha:1.0f];}
+(UIColor*)DarkLava {return [UIColor colorWithRed:0.28f green:0.24f blue:0.20f alpha:1.0f];}
+(UIColor*)DarkTaupe {return [UIColor colorWithRed:0.28f green:0.24f blue:0.20f alpha:1.0f];}
+(UIColor*)Taupe {return [UIColor colorWithRed:0.28f green:0.24f blue:0.20f alpha:1.0f];}
+(UIColor*)FaluRed {return [UIColor colorWithRed:0.50f green:0.09f blue:0.09f alpha:1.0f];}
+(UIColor*)Carmine {return [UIColor colorWithRed:0.59f green:0.00f blue:0.09f alpha:1.0f];}
+(UIColor*)Indigo1 {return [UIColor colorWithRed:0.00f green:0.25f blue:0.42f alpha:1.0f];}
+(UIColor*)Ultramarine {return [UIColor colorWithRed:0.07f green:0.04f blue:0.56f alpha:1.0f];}
+(UIColor*)CadmiumGreen {return [UIColor colorWithRed:0.00f green:0.42f blue:0.24f alpha:1.0f];}
+(UIColor*)TyrianPurple {return [UIColor colorWithRed:0.40f green:0.01f blue:0.24f alpha:1.0f];}
+(UIColor*)IndiaGreen {return [UIColor colorWithRed:0.07f green:0.53f blue:0.03f alpha:1.0f];}
+(UIColor*)MidnightBlue {return [UIColor colorWithRed:0.10f green:0.10f blue:0.44f alpha:1.0f];}
+(UIColor*)Burgundy {return [UIColor colorWithRed:0.50f green:0.00f blue:0.13f alpha:1.0f];}
+(UIColor*)CaputMortuum {return [UIColor colorWithRed:0.35f green:0.15f blue:0.13f alpha:1.0f];}
+(UIColor*)DartmouthGreen {return [UIColor colorWithRed:0.05f green:0.50f blue:0.06f alpha:1.0f];}
+(UIColor*)DukeBlue {return [UIColor colorWithRed:0.00f green:0.00f blue:0.61f alpha:1.0f];}
+(UIColor*)MidnightGreen {return [UIColor colorWithRed:0.00f green:0.29f blue:0.33f alpha:1.0f];}
+(UIColor*)Sangria {return [UIColor colorWithRed:0.57f green:0.00f blue:0.04f alpha:1.0f];}
+(UIColor*)DarkMidnightBlue {return [UIColor colorWithRed:0.00f green:0.20f blue:0.40f alpha:1.0f];}
+(UIColor*)Green3 {return [UIColor colorWithRed:0.00f green:0.60f blue:0.00f alpha:1.0f];}
+(UIColor*)MSUGreen {return [UIColor colorWithRed:0.00f green:0.40f blue:0.20f alpha:1.0f];}
+(UIColor*)PhthaloBlue {return [UIColor colorWithRed:0.00f green:0.06f blue:0.54f alpha:1.0f];}
+(UIColor*)SacramentoStateGreen {return [UIColor colorWithRed:0.00f green:0.34f blue:0.25f alpha:1.0f];}
+(UIColor*)DeepJungleGreen {return [UIColor colorWithRed:0.00f green:0.29f blue:0.29f alpha:1.0f];}
+(UIColor*)Sapphire {return [UIColor colorWithRed:0.03f green:0.15f blue:0.40f alpha:1.0f];}
+(UIColor*)Green6 {return [UIColor colorWithRed:0.00f green:0.56f blue:0.00f alpha:1.0f];}
+(UIColor*)OliveDrab2 {return [UIColor colorWithRed:0.24f green:0.20f blue:0.12f alpha:1.0f];}
+(UIColor*)DarkBlue {return [UIColor colorWithRed:0.00f green:0.00f blue:0.55f alpha:1.0f];}
+(UIColor*)DarkRed {return [UIColor colorWithRed:0.55f green:0.00f blue:0.00f alpha:1.0f];}
+(UIColor*)RoyalBlue1 {return [UIColor colorWithRed:0.00f green:0.14f blue:0.40f alpha:1.0f];}
+(UIColor*)Bistre {return [UIColor colorWithRed:0.24f green:0.17f blue:0.12f alpha:1.0f];}
+(UIColor*)PrussianBlue {return [UIColor colorWithRed:0.00f green:0.19f blue:0.33f alpha:1.0f];}
+(UIColor*)Myrtle {return [UIColor colorWithRed:0.13f green:0.26f blue:0.12f alpha:1.0f];}
+(UIColor*)Green2 {return [UIColor colorWithRed:0.00f green:0.50f blue:0.00f alpha:1.0f];}
+(UIColor*)Maroon1 {return [UIColor colorWithRed:0.50f green:0.00f blue:0.00f alpha:1.0f];}
+(UIColor*)NavyBlue {return [UIColor colorWithRed:0.00f green:0.00f blue:0.50f alpha:1.0f];}
+(UIColor*)OfficeGreen {return [UIColor colorWithRed:0.00f green:0.50f blue:0.00f alpha:1.0f];}
+(UIColor*)MediumJungleGreen {return [UIColor colorWithRed:0.11f green:0.21f blue:0.18f alpha:1.0f];}
+(UIColor*)DarkScarlet {return [UIColor colorWithRed:0.34f green:0.01f blue:0.10f alpha:1.0f];}
+(UIColor*)Rosewood {return [UIColor colorWithRed:0.40f green:0.00f blue:0.04f alpha:1.0f];}
+(UIColor*)PhthaloGreen {return [UIColor colorWithRed:0.07f green:0.21f blue:0.14f alpha:1.0f];}
+(UIColor*)BritishRacingGreen {return [UIColor colorWithRed:0.00f green:0.26f blue:0.15f alpha:1.0f];}
+(UIColor*)DarkSienna {return [UIColor colorWithRed:0.24f green:0.08f blue:0.08f alpha:1.0f];}
+(UIColor*)DarkJungleGreen {return [UIColor colorWithRed:0.10f green:0.14f blue:0.13f alpha:1.0f];}
+(UIColor*)ForestGreen {return [UIColor colorWithRed:0.00f green:0.27f blue:0.08f alpha:1.0f];}
+(UIColor*)SealBrown {return [UIColor colorWithRed:0.20f green:0.08f blue:0.08f alpha:1.0f];}
+(UIColor*)BulgarianRose {return [UIColor colorWithRed:0.28f green:0.02f blue:0.03f alpha:1.0f];}
+(UIColor*)DarkGreen {return [UIColor colorWithRed:0.00f green:0.20f blue:0.13f alpha:1.0f];}
+(UIColor*)Black {return [UIColor colorWithRed:0.00f green:0.00f blue:0.00f alpha:1.0f];}

@end
