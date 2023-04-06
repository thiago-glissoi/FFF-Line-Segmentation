; G-Code generated by Simplify3D(R) Version 4.1.2
; Mar 29, 2023 at 9:42:26 PM
; Settings Summary
;   processName,Process1
;   applyToModels,Peca ensaio Luanne
;   profileName,CORE A1v2 PLA - Ensaio Glissoi 30-02-2023
;   profileVersion,2023-03-29 21:36:18
;   baseProfile,ABS Q. MEDIA
;   printMaterial,
;   printQuality,
;   printExtruders,
;   extruderName,Extruder 1
;   extruderToolheadNumber,0
;   extruderDiameter,0.4
;   extruderAutoWidth,0
;   extruderWidth,0.44
;   extrusionMultiplier,1
;   extruderUseRetract,1
;   extruderRetractionDistance,3.5
;   extruderExtraRestartDistance,0
;   extruderRetractionZLift,0
;   extruderRetractionSpeed,3600
;   extruderUseCoasting,1
;   extruderCoastingDistance,0.1
;   extruderUseWipe,1
;   extruderWipeDistance,2
;   primaryExtruder,0
;   layerHeight,0.4
;   topSolidLayers,9
;   bottomSolidLayers,6
;   perimeterOutlines,3
;   printPerimetersInsideOut,0
;   startPointOption,3
;   startPointOriginX,0
;   startPointOriginY,0
;   sequentialIslands,0
;   spiralVaseMode,0
;   firstLayerHeightPercentage,100
;   firstLayerWidthPercentage,125
;   firstLayerUnderspeed,1
;   useRaft,0
;   raftExtruder,0
;   raftTopLayers,3
;   raftBaseLayers,2
;   raftOffset,3
;   raftSeparationDistance,0.14
;   raftTopInfill,100
;   aboveRaftSpeedMultiplier,0.3
;   useSkirt,1
;   skirtExtruder,0
;   skirtLayers,1
;   skirtOutlines,2
;   skirtOffset,4
;   usePrimePillar,0
;   primePillarExtruder,999
;   primePillarWidth,12
;   primePillarLocation,7
;   primePillarSpeedMultiplier,1
;   useOozeShield,0
;   oozeShieldExtruder,999
;   oozeShieldOffset,2
;   oozeShieldOutlines,1
;   oozeShieldSidewallShape,1
;   oozeShieldSidewallAngle,30
;   oozeShieldSpeedMultiplier,1
;   infillExtruder,0
;   internalInfillPattern,Rectilinear
;   externalInfillPattern,Rectilinear
;   infillPercentage,20
;   outlineOverlapPercentage,15
;   infillExtrusionWidthPercentage,100
;   minInfillLength,5
;   infillLayerInterval,2
;   internalInfillAngles,45,-45
;   overlapInternalInfillAngles,0
;   externalInfillAngles,45,-45
;   generateSupport,0
;   supportExtruder,0
;   supportInfillPercentage,30
;   supportExtraInflation,0.4
;   supportBaseLayers,0
;   denseSupportExtruder,0
;   denseSupportLayers,0
;   denseSupportInfillPercentage,70
;   supportLayerInterval,2
;   supportHorizontalPartOffset,0.4
;   supportUpperSeparationLayers,1
;   supportLowerSeparationLayers,1
;   supportType,0
;   supportGridSpacing,4
;   maxOverhangAngle,60
;   supportAngles,45
;   temperatureName,Extruder 1 Temperature,Heated Bed
;   temperatureNumber,0,0
;   temperatureSetpointCount,2,1
;   temperatureSetpointLayers,1,2,1
;   temperatureSetpointTemperatures,180,180,60
;   temperatureStabilizeAtStartup,1,1
;   temperatureHeatedBed,0,1
;   fanLayers,1,3
;   fanSpeeds,0,100
;   blipFanToFullPower,1
;   adjustSpeedForCooling,0
;   minSpeedLayerTime,25
;   minCoolingSpeedSlowdown,40
;   increaseFanForCooling,1
;   minFanLayerTime,45
;   maxCoolingFanSpeed,100
;   increaseFanForBridging,1
;   bridgingFanSpeed,100
;   use5D,1
;   relativeEdistances,0
;   allowEaxisZeroing,1
;   independentExtruderAxes,0
;   includeM10123,0
;   stickySupport,1
;   applyToolheadOffsets,0
;   gcodeXoffset,0
;   gcodeYoffset,0
;   gcodeZoffset,0
;   overrideMachineDefinition,1
;   machineTypeOverride,0
;   strokeXoverride,300
;   strokeYoverride,200
;   strokeZoverride,300
;   originOffsetXoverride,0
;   originOffsetYoverride,0
;   originOffsetZoverride,0
;   homeXdirOverride,-1
;   homeYdirOverride,-1
;   homeZdirOverride,-1
;   flipXoverride,1
;   flipYoverride,-1
;   flipZoverride,1
;   toolheadOffsets,0,0|0,0|0,0|0,0|0,0|0,0
;   overrideFirmwareConfiguration,0
;   firmwareTypeOverride,RepRap (Marlin/Repetier/Sprinter)
;   GPXconfigOverride,r2
;   baudRateOverride,115200
;   overridePrinterModels,0
;   printerModelsOverride
;   startingGcode,M109 S100; FAZ AQUECIMENTO DO BICO,M402,G28; HOME GERAL,M400,G29 V4 T ; AUTO NIVELAMENTO,M400,M104 S[extruder0_temperature]; FAZ PRE AQUECIMENTO DO BICO,G1 X1 Y1 Z0.8 F1000; VAI PRA PONTO DE PURGA,M109 S[extruder0_temperature]; FAZ AQUECIMENTO DO BICO,G92 E0; RESETA EXTRUSOR,G1 X1.0 E9.0 F1000.0 ; PURGA,G1 X100.0 E12.5 F1000.0 ; PURGA,M117 IMPRIMINDO...,M400,
;   layerChangeGcode,
;   retractionGcode,
;   toolChangeGcode,
;   endingGcode,M107 ; DESLIGA FAN,G1 E-9.0 F1000.0 ; RETRAIR,G1 Z300,G1 Y100,G1 X-8,M104 S0 ; DESLIGA AQUECIMENTO BICO,M140 S0 ; DESLIGA AQUECIMENTO MESA,M84 ; DESLIGA MOTORES,M300 S4 P1000 ; GERA BEEP
;   exportFileFormat,gcode
;   celebration,0
;   celebrationSong,Star Wars
;   postProcessing,
;   defaultSpeed,1200
;   outlineUnderspeed,1
;   solidInfillUnderspeed,1
;   supportUnderspeed,1
;   rapidXYspeed,9000
;   rapidZspeed,2400
;   minBridgingArea,5
;   bridgingExtraInflation,2
;   bridgingExtrusionMultiplier,0.9
;   bridgingSpeedMultiplier,1
;   useFixedBridgingAngle,0
;   fixedBridgingAngle,0
;   applyBridgingToPerimeters,1
;   filamentDiameters,1.74|1.74|1.74|1.74|1.74|1.74
;   filamentPricesPerKg,120|120|120|120|120|120
;   filamentDensities,1.08|1.25|1.25|1.25|1.25|1.25
;   useMinPrintHeight,0
;   minPrintHeight,0
;   useMaxPrintHeight,0
;   maxPrintHeight,0
;   useDiaphragm,0
;   diaphragmLayerInterval,20
;   robustSlicing,1
;   mergeAllIntoSolid,0
;   onlyRetractWhenCrossingOutline,1
;   retractBetweenLayers,1
;   useRetractionMinTravel,0
;   retractionMinTravel,3
;   retractWhileWiping,0
;   onlyWipeOutlines,1
;   avoidCrossingOutline,0
;   maxMovementDetourFactor,3
;   toolChangeRetractionDistance,12
;   toolChangeExtraRestartDistance,-0.5
;   toolChangeRetractionSpeed,600
;   externalThinWallType,1
;   internalThinWallType,1
;   thinWallAllowedOverlapPercentage,30
;   singleExtrusionMinLength,1
;   singleExtrusionMinPrintingWidthPercentage,50
;   singleExtrusionMaxPrintingWidthPercentage,200
;   singleExtrusionEndpointExtension,0.2
;   horizontalSizeCompensation,0
G90
M82
M106 S0
M140 S60
M190 S60
M109 S100; FAZ AQUECIMENTO DO BICO
M402
G28; HOME GERAL
M400
G29 V4 T ; AUTO NIVELAMENTO
M400
M104 S180; FAZ PRE AQUECIMENTO DO BICO
G1 X1 Y1 Z0.8 F1000; VAI PRA PONTO DE PURGA
M109 S180; FAZ AQUECIMENTO DO BICO
G92 E0; RESETA EXTRUSOR
G1 X1.0 E9.0 F1000.0 ; PURGA
G1 X100.0 E12.5 F1000.0 ; PURGA
M117 IMPRIMINDO...
M400
; process Process1
; layer 1, Z = 0.400
T0
G92 E0.0000
G1 E-3.5000 F3600
; feature skirt
; tool H0.400 W0.550
G1 Z0.400 F2400
G1 X94.662 Y52.705 F9000
G1 E0.0000 F3600
G92 E0.0000
G1 X97.488 Y49.879 E0.3698 F1200
G1 X191.485 Y49.879 E9.0664
G1 X194.312 Y52.705 E9.4362
G1 X194.312 Y146.702 E18.1328
G1 X191.485 Y149.528 E18.5026
G1 X97.488 Y149.528 E27.1992
G1 X94.662 Y146.702 E27.5690
G1 X94.662 Y52.705 E36.2656
G92 E0.0000
G1 E-3.5000 F3600
G1 X95.212 Y52.933 F9000
G1 E0.0000 F3600
G92 E0.0000
G1 X97.716 Y50.429 E0.3277 F1200
G1 X191.257 Y50.429 E8.9821
G1 X193.762 Y52.933 E9.3098
G1 X193.762 Y146.474 E17.9642
G1 X191.257 Y148.978 E18.2918
G1 X97.716 Y148.978 E26.9463
G1 X95.212 Y146.474 E27.2739
G1 X95.212 Y52.933 E35.9284
G92 E0.0000
G1 E-3.5000 F3600
; feature outer perimeter
G1 X99.762 Y54.979 F9000
G1 E0.0000 F3600
G92 E0.0000
G1 X189.212 Y54.979 E8.2759 F1200
G1 X189.212 Y144.428 E16.5518
G1 X99.762 Y144.428 E24.8277
G1 X99.762 Y55.079 E33.0943
G1 X99.762 Y54.979 F1200
G1 X101.762 Y54.979 F1200
; feature inner perimeter
G1 X100.312 Y55.529 F9000
G92 E0.0000
G1 X188.662 Y55.529 E8.1741 F1200
G1 X188.662 Y143.878 E16.3482
G1 X100.312 Y143.878 E24.5223
G1 X100.312 Y55.629 E32.6872
G1 X100.312 Y55.529 F1200
G1 X100.862 Y56.079 F9000
G92 E0.0000
G1 X188.112 Y56.079 E8.0723 F1200
G1 X188.112 Y143.328 E16.1447
G1 X100.862 Y143.328 E24.2170
G1 X100.862 Y56.179 E32.2801
G1 X100.862 Y56.079 F1200
; feature solid layer
G1 X186.889 Y56.546 F9000
G92 E0.0000
G1 X187.644 Y57.301 E0.0988 F1200
G1 X187.644 Y58.079 E0.1708
G1 X186.111 Y56.546 E0.3713
G1 X185.333 Y56.546 E0.4433
G1 X187.644 Y58.857 E0.7456
G1 X187.644 Y59.635 E0.8176
G1 X184.556 Y56.546 E1.2217
G1 X183.778 Y56.546 E1.2936
G1 X187.644 Y60.412 E1.7995
G1 X187.644 Y61.190 E1.8715
G1 X183.000 Y56.546 E2.4791
G1 X182.222 Y56.546 E2.5511
G1 X187.644 Y61.968 E3.2605
G1 X187.644 Y62.746 E3.3325
G1 X181.444 Y56.546 E4.1437
G1 X180.667 Y56.546 E4.2156
G1 X187.644 Y63.524 E5.1286
G1 X187.644 Y64.301 E5.2006
G1 X179.889 Y56.546 E6.2153
G1 X179.111 Y56.546 E6.2873
G1 X187.644 Y65.079 E7.4038
G1 X187.644 Y65.857 E7.4757
G1 X178.333 Y56.546 E8.6940
G1 X177.555 Y56.546 E8.7660
G1 X187.644 Y66.635 E10.0860
G1 X187.644 Y67.413 E10.1580
G1 X176.777 Y56.546 E11.5798
G1 X176.000 Y56.546 E11.6518
G1 X187.644 Y68.190 E13.1754
G1 X187.644 Y68.968 E13.2473
G1 X175.222 Y56.546 E14.8727
G1 X174.444 Y56.546 E14.9447
G1 X187.644 Y69.746 E16.6718
G1 X187.644 Y70.524 E16.7438
G1 X173.666 Y56.546 E18.5727
G1 X172.888 Y56.546 E18.6446
G1 X187.644 Y71.302 E20.5753
G1 X187.644 Y72.080 E20.6473
G1 X172.111 Y56.546 E22.6797
G1 X171.333 Y56.546 E22.7517
G1 X187.644 Y72.857 E24.8859
G1 X187.644 Y73.635 E24.9579
G1 X170.555 Y56.546 E27.1939
G1 X169.777 Y56.546 E27.2659
G1 X187.644 Y74.413 E29.6036
G1 X187.644 Y75.191 E29.6756
G1 X168.999 Y56.546 E32.1151
G1 X168.221 Y56.546 E32.1871
G1 X187.644 Y75.969 E34.7284
G1 X187.644 Y76.746 E34.8004
G1 X167.444 Y56.546 E37.4434
G1 X166.666 Y56.546 E37.5154
G1 X187.644 Y77.524 E40.2603
G1 X187.644 Y78.302 E40.3322
G1 X165.888 Y56.546 E43.1789
G1 X165.110 Y56.546 E43.2508
G1 X187.644 Y79.080 E46.1992
G1 X187.644 Y79.858 E46.2712
G1 X164.332 Y56.546 E49.3213
G1 X163.555 Y56.546 E49.3933
G1 X187.644 Y80.636 E52.5453
G1 X187.644 Y81.413 E52.6172
G1 X162.777 Y56.546 E55.8709
G1 X161.999 Y56.546 E55.9429
G1 X187.644 Y82.191 E59.2984
G1 X187.644 Y82.969 E59.3703
G1 X161.221 Y56.546 E62.8276
G1 X160.443 Y56.546 E62.8996
G1 X187.644 Y83.747 E66.4586
G1 X187.644 Y84.525 E66.5306
G1 X159.665 Y56.546 E70.1914
G1 X158.888 Y56.546 E70.2633
G1 X187.644 Y85.302 E74.0259
G1 X187.644 Y86.080 E74.0979
G1 X158.110 Y56.546 E77.9622
G1 X157.332 Y56.546 E78.0342
G1 X187.644 Y86.858 E82.0003
G1 X187.644 Y87.636 E82.0722
G1 X156.554 Y56.546 E86.1401
G1 X155.776 Y56.546 E86.2121
G1 X187.644 Y88.414 E90.3817
G1 X187.644 Y89.192 E90.4537
G1 X154.999 Y56.546 E94.7251
G1 X154.221 Y56.546 E94.7971
G1 X187.644 Y89.969 E99.1703
G1 X187.644 Y90.747 E99.2423
G1 X153.443 Y56.546 E103.7172
G1 X152.665 Y56.546 E103.7892
G1 X187.644 Y91.525 E108.3660
G1 X187.644 Y92.303 E108.4379
G1 X151.887 Y56.546 E113.1164
G1 X151.109 Y56.546 E113.1884
G1 X187.644 Y93.081 E117.9687
G1 X187.644 Y93.858 E118.0406
G1 X150.332 Y56.546 E122.9227
G1 X149.554 Y56.546 E122.9947
G1 X187.644 Y94.636 E127.9785
G1 X187.644 Y95.414 E128.0505
G1 X148.776 Y56.546 E133.1361
G1 X147.998 Y56.546 E133.2080
G1 X187.644 Y96.192 E138.3954
G1 X187.644 Y96.970 E138.4674
G1 X147.220 Y56.546 E143.7565
G1 X146.443 Y56.546 E143.8285
G1 X187.644 Y97.748 E149.2194
G1 X187.644 Y98.525 E149.2914
G1 X145.665 Y56.546 E154.7841
G1 X144.887 Y56.546 E154.8560
G1 X187.644 Y99.303 E160.4505
G1 X187.644 Y100.081 E160.5224
G1 X144.109 Y56.546 E166.2187
G1 X143.331 Y56.546 E166.2906
G1 X187.644 Y100.859 E172.0886
G1 X187.644 Y101.637 E172.1606
G1 X142.553 Y56.546 E178.0604
G1 X141.776 Y56.546 E178.1324
G1 X187.644 Y102.414 E184.1339
G1 X187.644 Y103.192 E184.2059
G1 X140.998 Y56.546 E190.3092
G1 X140.220 Y56.546 E190.3811
G1 X187.644 Y103.970 E196.5862
G1 X187.644 Y104.748 E196.6582
G1 X139.442 Y56.546 E202.9651
G1 X138.664 Y56.546 E203.0370
G1 X187.644 Y105.526 E209.4457
G1 X187.644 Y106.304 E209.5176
G1 X137.887 Y56.546 E216.0280
G1 X137.109 Y56.546 E216.1000
G1 X187.644 Y107.081 E222.7122
G1 X187.644 Y107.859 E222.7841
G1 X136.331 Y56.546 E229.4981
G1 X135.553 Y56.546 E229.5701
G1 X187.644 Y108.637 E236.3858
G1 X187.644 Y109.415 E236.4577
G1 X134.775 Y56.546 E243.3752
G1 X133.998 Y56.546 E243.4472
G1 X187.644 Y110.193 E250.4665
G1 X187.644 Y110.970 E250.5384
G1 X133.220 Y56.546 E257.6595
G1 X132.442 Y56.546 E257.7314
G1 X187.644 Y111.748 E264.9542
G1 X187.644 Y112.526 E265.0262
G1 X131.664 Y56.546 E272.3508
G1 X130.886 Y56.546 E272.4227
G1 X187.644 Y113.304 E279.8491
G1 X187.644 Y114.082 E279.9211
G1 X130.108 Y56.546 E287.4492
G1 X129.331 Y56.546 E287.5212
G1 X187.644 Y114.860 E295.1510
G1 X187.644 Y115.637 E295.2230
G1 X128.553 Y56.546 E302.9547
G1 X127.775 Y56.546 E303.0266
G1 X187.644 Y116.415 E310.8601
G1 X187.644 Y117.193 E310.9320
G1 X126.997 Y56.546 E318.8673
G1 X126.219 Y56.546 E318.9392
G1 X187.644 Y117.971 E326.9762
G1 X187.644 Y118.749 E327.0482
G1 X125.442 Y56.546 E335.1869
G1 X124.664 Y56.546 E335.2589
G1 X187.644 Y119.526 E343.4994
G1 X187.644 Y120.304 E343.5714
G1 X123.886 Y56.546 E351.9137
G1 X123.108 Y56.546 E351.9856
G1 X187.644 Y121.082 E360.4297
G1 X187.644 Y121.860 E360.5017
G1 X122.330 Y56.546 E369.0475
G1 X121.552 Y56.546 E369.1195
G1 X187.644 Y122.638 E377.7671
G1 X187.644 Y123.416 E377.8390
G1 X120.775 Y56.546 E386.5884
G1 X119.997 Y56.546 E386.6604
G1 X187.644 Y124.193 E395.5116
G1 X187.644 Y124.971 E395.5835
G1 X119.219 Y56.546 E404.5364
G1 X118.441 Y56.546 E404.6084
G1 X187.644 Y125.749 E413.6631
G1 X187.644 Y126.527 E413.7351
G1 X117.663 Y56.546 E422.8915
G1 X116.886 Y56.546 E422.9635
G1 X187.644 Y127.305 E432.2217
G1 X187.644 Y128.082 E432.2937
G1 X116.108 Y56.546 E441.6537
G1 X115.330 Y56.546 E441.7257
G1 X187.644 Y128.860 E451.1875
G1 X187.644 Y129.638 E451.2594
G1 X114.552 Y56.546 E460.8230
G1 X113.774 Y56.546 E460.8950
G1 X187.644 Y130.416 E470.5603
G1 X187.644 Y131.194 E470.6323
G1 X112.996 Y56.546 E480.3994
G1 X112.219 Y56.546 E480.4713
G1 X187.644 Y131.972 E490.3402
G1 X187.644 Y132.749 E490.4122
G1 X111.441 Y56.546 E500.3828
G1 X110.663 Y56.546 E500.4548
G1 X187.644 Y133.527 E510.5272
G1 X187.644 Y134.305 E510.5991
G1 X109.885 Y56.546 E520.7733
G1 X109.107 Y56.546 E520.8453
G1 X187.644 Y135.083 E531.1213
G1 X187.644 Y135.861 E531.1932
G1 X108.330 Y56.546 E541.5710
G1 X107.552 Y56.546 E541.6429
G1 X187.644 Y136.638 E552.1224
G1 X187.644 Y137.416 E552.1944
G1 X106.774 Y56.546 E562.7757
G1 X105.996 Y56.546 E562.8476
G1 X187.644 Y138.194 E573.5307
G1 X187.644 Y138.972 E573.6026
G1 X105.218 Y56.546 E584.3874
G1 X104.440 Y56.546 E584.4594
G1 X187.644 Y139.750 E595.3460
G1 X187.644 Y140.528 E595.4180
G1 X103.663 Y56.546 E606.4063
G1 X102.885 Y56.546 E606.4783
G1 X187.644 Y141.305 E617.5684
G1 X187.644 Y142.083 E617.6404
G1 X102.107 Y56.546 E628.8323
G1 X101.329 Y56.546 E628.9043
G1 X187.644 Y142.861 E640.1979
G1 X186.866 Y142.861 E640.2699
G1 X101.329 Y57.324 E651.4618
G1 X101.329 Y58.102 E651.5338
G1 X186.088 Y142.861 E662.6239
G1 X185.311 Y142.861 E662.6959
G1 X101.329 Y58.879 E673.6842
G1 X101.329 Y59.657 E673.7562
G1 X184.533 Y142.861 E684.6428
G1 X183.755 Y142.861 E684.7148
G1 X101.329 Y60.435 E695.4996
G1 X101.329 Y61.213 E695.5715
G1 X182.977 Y142.861 E706.2546
G1 X182.199 Y142.861 E706.3266
G1 X101.329 Y61.991 E716.9078
G1 X101.329 Y62.769 E716.9798
G1 X181.422 Y142.861 E727.4593
G1 X180.644 Y142.861 E727.5313
G1 X101.329 Y63.546 E737.9090
G1 X101.329 Y64.324 E737.9810
G1 X179.866 Y142.861 E748.2569
G1 X179.088 Y142.861 E748.3289
G1 X101.329 Y65.102 E758.5031
G1 X101.329 Y65.880 E758.5750
G1 X178.310 Y142.861 E768.6475
G1 X177.532 Y142.861 E768.7194
G1 X101.329 Y66.658 E778.6901
G1 X101.329 Y67.435 E778.7620
G1 X176.755 Y142.861 E788.6309
G1 X175.977 Y142.861 E788.7029
G1 X101.329 Y68.213 E798.4700
G1 X101.329 Y68.991 E798.5420
G1 X175.199 Y142.861 E808.2073
G1 X174.421 Y142.861 E808.2793
G1 X101.329 Y69.769 E817.8428
G1 X101.329 Y70.547 E817.9148
G1 X173.643 Y142.861 E827.3766
G1 X172.866 Y142.861 E827.4485
G1 X101.329 Y71.325 E836.8085
G1 X101.329 Y72.102 E836.8805
G1 X172.088 Y142.861 E846.1388
G1 X171.310 Y142.861 E846.2107
G1 X101.329 Y72.880 E855.3672
G1 X101.329 Y73.658 E855.4392
G1 X170.532 Y142.861 E864.4939
G1 X169.754 Y142.861 E864.5658
G1 X101.329 Y74.436 E873.5188
G1 X101.329 Y75.214 E873.5907
G1 X168.976 Y142.861 E882.4419
G1 X168.199 Y142.861 E882.5138
G1 X101.329 Y75.991 E891.2632
G1 X101.329 Y76.769 E891.3352
G1 X167.421 Y142.861 E899.9828
G1 X166.643 Y142.861 E900.0548
G1 X101.329 Y77.547 E908.6006
G1 X101.329 Y78.325 E908.6726
G1 X165.865 Y142.861 E917.1167
G1 X165.087 Y142.861 E917.1886
G1 X101.329 Y79.103 E925.5309
G1 X101.329 Y79.880 E925.6029
G1 X164.310 Y142.861 E933.8434
G1 X163.532 Y142.861 E933.9154
G1 X101.329 Y80.658 E942.0541
G1 X101.329 Y81.436 E942.1261
G1 X162.754 Y142.861 E950.1631
G1 X161.976 Y142.861 E950.2351
G1 X101.329 Y82.214 E958.1703
G1 X101.329 Y82.992 E958.2422
G1 X161.198 Y142.861 E966.0757
G1 X160.421 Y142.861 E966.1476
G1 X101.329 Y83.770 E973.8793
G1 X101.329 Y84.547 E973.9513
G1 X159.643 Y142.861 E981.5812
G1 X158.865 Y142.861 E981.6531
G1 X101.329 Y85.325 E989.1813
G1 X101.329 Y86.103 E989.2532
G1 X158.087 Y142.861 E996.6796
G1 X157.309 Y142.861 E996.7515
G1 X101.329 Y86.881 E1004.0761
G1 X101.329 Y87.659 E1004.1481
G1 X156.531 Y142.861 E1011.3709
G1 X155.754 Y142.861 E1011.4429
G1 X101.329 Y88.436 E1018.5639
G1 X101.329 Y89.214 E1018.6359
G1 X154.976 Y142.861 E1025.6551
G1 X154.198 Y142.861 E1025.7271
G1 X101.329 Y89.992 E1032.6446
G1 X101.329 Y90.770 E1032.7166
G1 X153.420 Y142.861 E1039.5323
G1 X152.642 Y142.861 E1039.6043
G1 X101.329 Y91.548 E1046.3182
G1 X101.329 Y92.326 E1046.3902
G1 X151.865 Y142.861 E1053.0024
G1 X151.087 Y142.861 E1053.0743
G1 X101.329 Y93.103 E1059.5847
G1 X101.329 Y93.881 E1059.6567
G1 X150.309 Y142.861 E1066.0653
G1 X149.531 Y142.861 E1066.1373
G1 X101.329 Y94.659 E1072.4442
G1 X101.329 Y95.437 E1072.5161
G1 X148.753 Y142.861 E1078.7212
G1 X147.975 Y142.861 E1078.7932
G1 X101.329 Y96.215 E1084.8965
G1 X101.329 Y96.992 E1084.9685
G1 X147.198 Y142.861 E1090.9700
G1 X146.420 Y142.861 E1091.0420
G1 X101.329 Y97.770 E1096.9418
G1 X101.329 Y98.548 E1097.0137
G1 X145.642 Y142.861 E1102.8118
G1 X144.864 Y142.861 E1102.8837
G1 X101.329 Y99.326 E1108.5800
G1 X101.329 Y100.104 E1108.6519
G1 X144.086 Y142.861 E1114.2464
G1 X143.309 Y142.861 E1114.3183
G1 X101.329 Y100.882 E1119.8110
G1 X101.329 Y101.659 E1119.8830
G1 X142.531 Y142.861 E1125.2739
G1 X141.753 Y142.861 E1125.3459
G1 X101.329 Y102.437 E1130.6350
G1 X101.329 Y103.215 E1130.7070
G1 X140.975 Y142.861 E1135.8944
G1 X140.197 Y142.861 E1135.9663
G1 X101.329 Y103.993 E1141.0520
G1 X101.329 Y104.771 E1141.1239
G1 X139.419 Y142.861 E1146.1078
G1 X138.642 Y142.861 E1146.1797
G1 X101.329 Y105.548 E1151.0618
G1 X101.329 Y106.326 E1151.1337
G1 X137.864 Y142.861 E1155.9140
G1 X137.086 Y142.861 E1155.9860
G1 X101.329 Y107.104 E1160.6645
G1 X101.329 Y107.882 E1160.7365
G1 X136.308 Y142.861 E1165.3132
G1 X135.530 Y142.861 E1165.3852
G1 X101.329 Y108.660 E1169.8602
G1 X101.329 Y109.438 E1169.9321
G1 X134.753 Y142.861 E1174.3053
G1 X133.975 Y142.861 E1174.3773
G1 X101.329 Y110.215 E1178.6487
G1 X101.329 Y110.993 E1178.7207
G1 X133.197 Y142.861 E1182.8904
G1 X132.419 Y142.861 E1182.9623
G1 X101.329 Y111.771 E1187.0302
G1 X101.329 Y112.549 E1187.1022
G1 X131.641 Y142.861 E1191.0683
G1 X130.863 Y142.861 E1191.1403
G1 X101.329 Y113.327 E1195.0046
G1 X101.329 Y114.104 E1195.0766
G1 X130.086 Y142.861 E1198.8392
G1 X129.308 Y142.861 E1198.9111
G1 X101.329 Y114.882 E1202.5719
G1 X101.329 Y115.660 E1202.6439
G1 X128.530 Y142.861 E1206.2029
G1 X127.752 Y142.861 E1206.2749
G1 X101.329 Y116.438 E1209.7321
G1 X101.329 Y117.216 E1209.8041
G1 X126.974 Y142.861 E1213.1596
G1 X126.197 Y142.861 E1213.2316
G1 X101.329 Y117.994 E1216.4853
G1 X101.329 Y118.771 E1216.5572
G1 X125.419 Y142.861 E1219.7092
G1 X124.641 Y142.861 E1219.7811
G1 X101.329 Y119.549 E1222.8313
G1 X101.329 Y120.327 E1222.9033
G1 X123.863 Y142.861 E1225.8517
G1 X123.085 Y142.861 E1225.9236
G1 X101.329 Y121.105 E1228.7703
G1 X101.329 Y121.883 E1228.8422
G1 X122.307 Y142.861 E1231.5871
G1 X121.530 Y142.861 E1231.6591
G1 X101.329 Y122.660 E1234.3021
G1 X101.329 Y123.438 E1234.3741
G1 X120.752 Y142.861 E1236.9154
G1 X119.974 Y142.861 E1236.9874
G1 X101.329 Y124.216 E1239.4269
G1 X101.329 Y124.994 E1239.4989
G1 X119.196 Y142.861 E1241.8367
G1 X118.418 Y142.861 E1241.9086
G1 X101.329 Y125.772 E1244.1446
G1 X101.329 Y126.550 E1244.2166
G1 X117.641 Y142.861 E1246.3508
G1 X116.863 Y142.861 E1246.4228
G1 X101.329 Y127.327 E1248.4552
G1 X101.329 Y128.105 E1248.5272
G1 X116.085 Y142.861 E1250.4579
G1 X115.307 Y142.861 E1250.5299
G1 X101.329 Y128.883 E1252.3588
G1 X101.329 Y129.661 E1252.4307
G1 X114.529 Y142.861 E1254.1579
G1 X113.751 Y142.861 E1254.2298
G1 X101.329 Y130.439 E1255.8552
G1 X101.329 Y131.216 E1255.9272
G1 X112.974 Y142.861 E1257.4508
G1 X112.196 Y142.861 E1257.5227
G1 X101.329 Y131.994 E1258.9446
G1 X101.329 Y132.772 E1259.0165
G1 X111.418 Y142.861 E1260.3366
G1 X110.640 Y142.861 E1260.4085
G1 X101.329 Y133.550 E1261.6268
G1 X101.329 Y134.328 E1261.6988
G1 X109.862 Y142.861 E1262.8153
G1 X109.085 Y142.861 E1262.8873
G1 X101.329 Y135.106 E1263.9020
G1 X101.329 Y135.883 E1263.9740
G1 X108.307 Y142.861 E1264.8869
G1 X107.529 Y142.861 E1264.9589
G1 X101.329 Y136.661 E1265.7701
G1 X101.329 Y137.439 E1265.8421
G1 X106.751 Y142.861 E1266.5515
G1 X105.973 Y142.861 E1266.6234
G1 X101.329 Y138.217 E1267.2311
G1 X101.329 Y138.995 E1267.3031
G1 X105.195 Y142.861 E1267.8089
G1 X104.418 Y142.861 E1267.8809
G1 X101.329 Y139.772 E1268.2850
G1 X101.329 Y140.550 E1268.3570
G1 X103.640 Y142.861 E1268.6593
G1 X102.862 Y142.861 E1268.7313
G1 X101.329 Y141.328 E1268.9318
G1 X101.329 Y142.106 E1269.0038
G1 X102.013 Y142.790 E1269.0934
G1 X102.084 Y142.861 F1200
G92 E0.0000
G1 E-3.5000 F3600
; layer end
M107 ; DESLIGA FAN
G1 E-9.0 F1000.0 ; RETRAIR
G1 Z300
G1 Y100
G1 X-8
M104 S0 ; DESLIGA AQUECIMENTO BICO
M140 S0 ; DESLIGA AQUECIMENTO MESA
M84 ; DESLIGA MOTORES
M300 S4 P1000 ; GERA BEEP
; Build Summary
;   Build time: 0 hours 13 minutes
;   Filament length: 1439.3 mm (1.44 m)
;   Plastic volume: 3422.59 mm^3 (3.42 cc)
;   Plastic weight: 3.70 g (0.01 lb)
;   Material cost: 0.44
