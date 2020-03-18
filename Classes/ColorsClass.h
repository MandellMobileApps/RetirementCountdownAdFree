//
//  ColorsClass.h
//  RetirementCountdown
//
//  Created by Jon Mandell on 11/24/09.
//  Copyright 2009 MandellMobileApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>


@interface ColorsClass : NSObject {

}


+(int)getCountForTextColorNames;
+(int)getCountForBackgroundColorNames;
+(int)getCountForDayColorNames;
+(int)getCountForPredefinedColorNames;

+(NSString*)getTextColorNameFor:(NSInteger)nameindex;
+(NSString*)getBackgroundColorNameFor:(NSInteger)nameindex;
+(NSString*)getDayColorNameFor:(NSInteger)nameindex;
+(NSString*)getPredefinedColorNameFor:(NSInteger)nameindex;



+(UIColor*)black;
+(UIColor*)darkgray;
+(UIColor*)lightgray;
+(UIColor*)white;
+(UIColor*)gray;
+(UIColor*)red;
+(UIColor*)green;
+(UIColor*)blue;
+(UIColor*)cyan;
+(UIColor*)yellow;
+(UIColor*)magenta;
+(UIColor*)orange;
+(UIColor*)purple;
+(UIColor*)brown;
+(UIColor*)iPhoneStandard;
+(UIColor*)testColor; 

+(UIColor*)White;
+(UIColor*)Azure2;
+(UIColor*)Ivory;
+(UIColor*)Magnolia;
+(UIColor*)AliceBlue;
+(UIColor*)LavenderBlush;
+(UIColor*)Seashell;
+(UIColor*)Honeydew;
+(UIColor*)BabyBlue;
+(UIColor*)CosmicLatte;
+(UIColor*)OldLace;
+(UIColor*)Linen;
+(UIColor*)Cream;
+(UIColor*)Beige;
+(UIColor*)Lavender2;
+(UIColor*)LemonChiffon;
+(UIColor*)MistyRose;
+(UIColor*)PapayaWhip;
+(UIColor*)PalePink;
+(UIColor*)ClassicRose;
+(UIColor*)Champagne;
+(UIColor*)PastelPink;
+(UIColor*)LightMauve;
+(UIColor*)Platinum;
+(UIColor*)Peach;
+(UIColor*)LavenderBlue;
+(UIColor*)Periwinkle;
+(UIColor*)PaleSpringBud;
+(UIColor*)PeachPuff;
+(UIColor*)Mauve;
+(UIColor*)PaleBlue;
+(UIColor*)NavajoWhite;
+(UIColor*)Pink;
+(UIColor*)PeachYellow;
+(UIColor*)Wheat;
+(UIColor*)LightApricot;
+(UIColor*)MediumChampagne;
+(UIColor*)TeaGreen;
+(UIColor*)LavenderRose;
+(UIColor*)LanguidLavender;
+(UIColor*)CherryBlossomPink;
+(UIColor*)LavenderPink;
+(UIColor*)Apricot;
+(UIColor*)BabyPink;
+(UIColor*)TeaRose2;
+(UIColor*)ColumbiaBlue;
+(UIColor*)LightPink;
+(UIColor*)PowderBlue;
+(UIColor*)DeepChampagne;
+(UIColor*)ElectricBlue;
+(UIColor*)FuchsiaPink;
+(UIColor*)Thistle;
+(UIColor*)CarnationPink;
+(UIColor*)DeepPeach;
+(UIColor*)UltraPink;
+(UIColor*)LightBlue;
+(UIColor*)LightCornflowerBlue;
+(UIColor*)MagicMint;
+(UIColor*)NadeshikoPink;
+(UIColor*)PaleCornflowerBlue;
+(UIColor*)DesertSand;
+(UIColor*)PeachOrange;
+(UIColor*)Khaki2;
+(UIColor*)LightFuchsiaPink;
+(UIColor*)PaleMagenta;
+(UIColor*)LavenderMagenta;
+(UIColor*)PaleAmaranthPink;
+(UIColor*)Violet2;
+(UIColor*)BrightUbe;
+(UIColor*)LavenderGray;
+(UIColor*)Aquamarine;
+(UIColor*)Heliotrope;
+(UIColor*)LightSkyBlue;
+(UIColor*)Buff;
+(UIColor*)Flax;
+(UIColor*)AmaranthPink;
+(UIColor*)Maize;
+(UIColor*)PaleRobinEggBlue;
+(UIColor*)Wisteria;
+(UIColor*)Corn;
+(UIColor*)PaleSilver;
+(UIColor*)Silver;
+(UIColor*)SkyBlue;
+(UIColor*)Celadon;
+(UIColor*)MossGreen;
+(UIColor*)PaleChestnut;
+(UIColor*)BrightLavender;
+(UIColor*)CarolinaBlue;
+(UIColor*)PersianPink;
+(UIColor*)SalmonPink;
+(UIColor*)Jonquil;
+(UIColor*)Lilac;
+(UIColor*)Mustard;
+(UIColor*)CambridgeBlue;
+(UIColor*)LightSalmonPink;
+(UIColor*)MediumLavenderMagenta;
+(UIColor*)Plum;
+(UIColor*)RosePink;
+(UIColor*)MayaBlue;
+(UIColor*)MintGreen;
+(UIColor*)Yellow2;
+(UIColor*)MediumSpringBud;
+(UIColor*)PaleGold;
+(UIColor*)LightThulianPink;
+(UIColor*)Orchid;
+(UIColor*)HotPink;
+(UIColor*)LightSalmon;
+(UIColor*)Tan;
+(UIColor*)Lavender1;
+(UIColor*)Khaki1;
+(UIColor*)EtonBlue;
+(UIColor*)Aqua;
+(UIColor*)AtomicTangerine;
+(UIColor*)Cyan1;
+(UIColor*)Fuchsia;
+(UIColor*)Magenta;
+(UIColor*)PinkOrange;
+(UIColor*)RazzleDazzleRose;
+(UIColor*)Sunglow;
+(UIColor*)Yellow;
+(UIColor*)DarkSalmon;
+(UIColor*)SandyBrown;
+(UIColor*)BrilliantRose;
+(UIColor*)Lemon;
+(UIColor*)CadmiumYellow;
+(UIColor*)CoralPink;
+(UIColor*)DarkChampagne;
+(UIColor*)Ecru;
+(UIColor*)Salmon;
+(UIColor*)Sand;
+(UIColor*)TeaRose1;
+(UIColor*)AmaranthMagenta;
+(UIColor*)LightCoral;
+(UIColor*)SkyMagenta;
+(UIColor*)JuneBud;
+(UIColor*)ThulianPink;
+(UIColor*)Yellow1;
+(UIColor*)Puce;
+(UIColor*)Purple2;
+(UIColor*)RoseQuartz;
+(UIColor*)EarthYellow;
+(UIColor*)Saffron;
+(UIColor*)CornflowerBlue;
+(UIColor*)MediumTurquoise;
+(UIColor*)Pear;
+(UIColor*)IndianYellow;
+(UIColor*)OperaMauve;
+(UIColor*)DarkKhaki;
+(UIColor*)Chartreuse1;
+(UIColor*)GoldenYellow;
+(UIColor*)MediumPurple;
+(UIColor*)PaleRedViolet;
+(UIColor*)PsychedelicPurple;
+(UIColor*)GreenYellow;
+(UIColor*)BrinkPink;
+(UIColor*)RosyBrown;
+(UIColor*)RichLavender;
+(UIColor*)SchoolBusYellow;
+(UIColor*)DeepFuchsia;
+(UIColor*)Gold1;
+(UIColor*)LavenderIndigo;
+(UIColor*)PaleTaupe;
+(UIColor*)UnitedNationsBlue;
+(UIColor*)VegasGold;
+(UIColor*)MikadoYellow;
+(UIColor*)BrightTurquoise;
+(UIColor*)Coral;
+(UIColor*)Turquoise;
+(UIColor*)Amethyst;
+(UIColor*)Bittersweet;
+(UIColor*)DeepSaffron;
+(UIColor*)ElectricLime;
+(UIColor*)HotMagenta;
+(UIColor*)PaleCopper;
+(UIColor*)PastelGreen;
+(UIColor*)ShockingPink;
+(UIColor*)TangerineYellow;
+(UIColor*)CoolGrey;
+(UIColor*)FrenchRose;
+(UIColor*)Pistachio;
+(UIColor*)PersianRose;
+(UIColor*)LavenderPurple;
+(UIColor*)Camel;
+(UIColor*)Desert;
+(UIColor*)Fallow;
+(UIColor*)Olivine;
+(UIColor*)Ube;
+(UIColor*)OldRose;
+(UIColor*)PersianOrange;
+(UIColor*)OldGold;
+(UIColor*)Amber1;
+(UIColor*)ElectricPurple;
+(UIColor*)GoldenPoppy;
+(UIColor*)Lime1;
+(UIColor*)DarkPink;
+(UIColor*)BlueGreen;
+(UIColor*)Gold2;
+(UIColor*)DarkTangerine;
+(UIColor*)SelectiveYellow;
+(UIColor*)TerraCotta;
+(UIColor*)BurntSienna;
+(UIColor*)LightCarminePink;
+(UIColor*)DodgerBlue;
+(UIColor*)CerisePink;
+(UIColor*)DeepLilac;
+(UIColor*)Tomato;
+(UIColor*)TurkishRose;
+(UIColor*)DeepPink;
+(UIColor*)Orange3;
+(UIColor*)AndroidGreen;
+(UIColor*)SpringBud;
+(UIColor*)Cyan2;
+(UIColor*)CadmiumOrange;
+(UIColor*)SatinSheenGold;
+(UIColor*)MountbattenPink;
+(UIColor*)CarrotOrange;
+(UIColor*)DarkTurquoise;
+(UIColor*)Goldenrod;
+(UIColor*)OrangePeel;
+(UIColor*)RoseGold;
+(UIColor*)Brass;
+(UIColor*)Mulberry;
+(UIColor*)Asparagus;
+(UIColor*)DeepMagenta;
+(UIColor*)TaupeGray;
+(UIColor*)YellowGreen;
+(UIColor*)LightSlateGray;
+(UIColor*)RobinEggBlue;
+(UIColor*)VividViolet;
+(UIColor*)BlueViolet;
+(UIColor*)Orange2;
+(UIColor*)DeepCarrotOrange;
+(UIColor*)Fandango;
+(UIColor*)FashionFuchsia;
+(UIColor*)HollywoodCerise;
+(UIColor*)Byzantine;
+(UIColor*)MediumSpringGreen;
+(UIColor*)DeepCerise;
+(UIColor*)RadicalRed;
+(UIColor*)Emerald;
+(UIColor*)AirForceBlue;
+(UIColor*)Magenta2;
+(UIColor*)PortlandOrange;
+(UIColor*)Gamboge;
+(UIColor*)MajorelleBlue;
+(UIColor*)Pumpkin;
+(UIColor*)DarkOrange;
+(UIColor*)RoyalBlue2;
+(UIColor*)ElectricViolet;
+(UIColor*)Violet;
+(UIColor*)RoyalFuchsia;
+(UIColor*)Chestnut;
+(UIColor*)Gray;
+(UIColor*)SlateGray;
+(UIColor*)CoralRed;
+(UIColor*)Violet1;
+(UIColor*)Azure1;
+(UIColor*)BrightPink;
+(UIColor*)Bronze;
+(UIColor*)Chartreuse2;
+(UIColor*)Orange1;
+(UIColor*)Rose;
+(UIColor*)SpringGreen;
+(UIColor*)Amber2;
+(UIColor*)FrenchBeige;
+(UIColor*)LightSeaGreen;
+(UIColor*)SteelBlue;
+(UIColor*)CarminePink;
+(UIColor*)TiffanyBlue;
+(UIColor*)LawnGreen;
+(UIColor*)Tangerine;
+(UIColor*)DarkTerraCotta;
+(UIColor*)AmaranthCerise;
+(UIColor*)MediumRedViolet;
+(UIColor*)Razzmatazz;
+(UIColor*)Cerise;
+(UIColor*)Xanadu;
+(UIColor*)BrandeisBlue;
+(UIColor*)DarkCoral;
+(UIColor*)RichElectricBlue;
+(UIColor*)CamouflageGreen;
+(UIColor*)DarkViolet;
+(UIColor*)BrightGreen;
+(UIColor*)CaribbeanGreen;
+(UIColor*)CopperRose;
+(UIColor*)ElectricIndigo;
+(UIColor*)Ochre;
+(UIColor*)SafetyOrange;
+(UIColor*)HanBlue;
+(UIColor*)HanPurple;
+(UIColor*)DarkTan;
+(UIColor*)RaspberryRose;
+(UIColor*)PaleBrown;
+(UIColor*)DarkChestnut;
+(UIColor*)RedViolet;
+(UIColor*)Amaranth;
+(UIColor*)MediumSeaGreen;
+(UIColor*)Copper;
+(UIColor*)MauveTaupe;
+(UIColor*)JungleGreen;
+(UIColor*)Magenta1;
+(UIColor*)Cinnabar;
+(UIColor*)Cinnamon;
+(UIColor*)OldLavender;
+(UIColor*)DarkLavender;
+(UIColor*)Vermilion;
+(UIColor*)DeepCarminePink;
+(UIColor*)DogwoodRose;
+(UIColor*)Ruby;
+(UIColor*)DeepChestnut;
+(UIColor*)InternationalOrange;
+(UIColor*)BondiBlue;
+(UIColor*)RoseVale;
+(UIColor*)Raspberry;
+(UIColor*)RoseTaupe;
+(UIColor*)RoyalPurple;
+(UIColor*)DarkGoldenrod;
+(UIColor*)Green5;
+(UIColor*)Blue3;
+(UIColor*)Tangelo;
+(UIColor*)OrangeRed;
+(UIColor*)PalatinateBlue;
+(UIColor*)Persimmon;
+(UIColor*)AppleGreen;
+(UIColor*)AmericanRose;
+(UIColor*)Maroon2;
+(UIColor*)RichMaroon;
+(UIColor*)TorchRed;
+(UIColor*)Alizarin;
+(UIColor*)RoseMadder;
+(UIColor*)Harlequin;
+(UIColor*)TwilightLavender;
+(UIColor*)CeruleanBlue;
+(UIColor*)PersianGreen;
+(UIColor*)Red3;
+(UIColor*)Malachite;
+(UIColor*)Violet3;
+(UIColor*)DarkElectricBlue;
+(UIColor*)AmaranthDeepPurple;
+(UIColor*)CarmineRed;
+(UIColor*)Denim;
+(UIColor*)PersianRed;
+(UIColor*)LimeGreen;
+(UIColor*)Viridian;
+(UIColor*)Red2;
+(UIColor*)BrightMaroon;
+(UIColor*)Crimson;
+(UIColor*)MediumCarmine;
+(UIColor*)PaleCarmine;
+(UIColor*)Tenne;
+(UIColor*)Scarlet;
+(UIColor*)Cerulean;
+(UIColor*)AmaranthPurple;
+(UIColor*)BurntOrange;
+(UIColor*)Sienna;
+(UIColor*)Drab;
+(UIColor*)KellyGreen;
+(UIColor*)ModeBeige;
+(UIColor*)SandDune;
+(UIColor*)SandyTaupe;
+(UIColor*)Cardinal;
+(UIColor*)OliveDrab1;
+(UIColor*)RichCarmine;
+(UIColor*)DarkCyan;
+(UIColor*)DarkMagenta;
+(UIColor*)GoldenBrown;
+(UIColor*)Jade;
+(UIColor*)PersianBlue;
+(UIColor*)SeaGreen;
+(UIColor*)JazzberryJam;
+(UIColor*)Cordovan;
+(UIColor*)MediumPersianBlue;
+(UIColor*)FernGreen;
+(UIColor*)Wenge;
+(UIColor*)MediumTealBlue;
+(UIColor*)DeepCarmine;
+(UIColor*)Rust;
+(UIColor*)CadmiumRed;
+(UIColor*)FireEngineRed;
+(UIColor*)Mahogany;
+(UIColor*)Olive;
+(UIColor*)Teal;
+(UIColor*)Blue1;
+(UIColor*)Blue2;
+(UIColor*)DarkPastelGreen;
+(UIColor*)DavysGrey;
+(UIColor*)ElectricGreen;
+(UIColor*)Green1;
+(UIColor*)Lava;
+(UIColor*)Lime2;
+(UIColor*)Red1;
+(UIColor*)Purple1;
+(UIColor*)ShamrockGreen;
+(UIColor*)Feldgrau;
+(UIColor*)Byzantium;
+(UIColor*)MediumTaupe;
+(UIColor*)RoseEbony;
+(UIColor*)Brown2;
+(UIColor*)Bole;
+(UIColor*)SapGreen;
+(UIColor*)Firebrick;
+(UIColor*)Green4;
+(UIColor*)Cobalt;
+(UIColor*)Eggplant;
+(UIColor*)HalayaUbe;
+(UIColor*)VividBurgundy;
+(UIColor*)PalatinatePurple;
+(UIColor*)Skobeloff;
+(UIColor*)YaleBlue;
+(UIColor*)Liver;
+(UIColor*)DarkByzantium;
+(UIColor*)EgyptianBlue;
+(UIColor*)Carnelian;
+(UIColor*)MediumElectricBlue;
+(UIColor*)PineGreen;
+(UIColor*)VenetianRed;
+(UIColor*)GrayAsparagus;
+(UIColor*)UpsdellRed;
+(UIColor*)Brown1;
+(UIColor*)BurntUmber;
+(UIColor*)Russet;
+(UIColor*)FieldDrab;
+(UIColor*)PurpleTaupe;
+(UIColor*)PansyPurple;
+(UIColor*)InternationalKleinBlue;
+(UIColor*)TropicalRainForest;
+(UIColor*)RawUmber;
+(UIColor*)DarkSpringGreen;
+(UIColor*)HunterGreen;
+(UIColor*)DarkSlateGray;
+(UIColor*)Indigo2;
+(UIColor*)MediumBlue;
+(UIColor*)DarkPowderBlue;
+(UIColor*)Smalt;
+(UIColor*)DarkCerulean;
+(UIColor*)Arsenic;
+(UIColor*)Charcoal;
+(UIColor*)DarkBrown;
+(UIColor*)PaynesGrey;
+(UIColor*)Sepia;
+(UIColor*)ArmyGreen;
+(UIColor*)PersianIndigo;
+(UIColor*)Auburn;
+(UIColor*)RifleGreen;
+(UIColor*)Chocolate;
+(UIColor*)DarkLava;
+(UIColor*)DarkTaupe;
+(UIColor*)Taupe;
+(UIColor*)FaluRed;
+(UIColor*)Carmine;
+(UIColor*)Indigo1;
+(UIColor*)Ultramarine;
+(UIColor*)CadmiumGreen;
+(UIColor*)TyrianPurple;
+(UIColor*)IndiaGreen;
+(UIColor*)MidnightBlue;
+(UIColor*)Burgundy;
+(UIColor*)CaputMortuum;
+(UIColor*)DartmouthGreen;
+(UIColor*)DukeBlue;
+(UIColor*)MidnightGreen;
+(UIColor*)Sangria;
+(UIColor*)DarkMidnightBlue;
+(UIColor*)Green3;
+(UIColor*)MSUGreen;
+(UIColor*)PhthaloBlue;
+(UIColor*)SacramentoStateGreen;
+(UIColor*)DeepJungleGreen;
+(UIColor*)Sapphire;
+(UIColor*)Green6;
+(UIColor*)OliveDrab2;
+(UIColor*)DarkBlue;
+(UIColor*)DarkRed;
+(UIColor*)RoyalBlue1;
+(UIColor*)Bistre;
+(UIColor*)PrussianBlue;
+(UIColor*)Myrtle;
+(UIColor*)Green2;
+(UIColor*)Maroon1;
+(UIColor*)NavyBlue;
+(UIColor*)OfficeGreen;
+(UIColor*)MediumJungleGreen;
+(UIColor*)DarkScarlet;
+(UIColor*)Rosewood;
+(UIColor*)PhthaloGreen;
+(UIColor*)BritishRacingGreen;
+(UIColor*)DarkSienna;
+(UIColor*)DarkJungleGreen;
+(UIColor*)ForestGreen;
+(UIColor*)SealBrown;
+(UIColor*)BulgarianRose;
+(UIColor*)DarkGreen;
+(UIColor*)Black;


@end
