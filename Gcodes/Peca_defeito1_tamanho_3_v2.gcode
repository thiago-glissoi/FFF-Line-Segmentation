; G-Code generated by Simplify3D(R) Version 4.1.2
; Mar 29, 2023 at 9:43:07 PM
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
G1 X49.662 Y7.705 F9000
G1 E0.0000 F3600
G92 E0.0000
G1 X52.488 Y4.879 E0.3698 F1200
G1 X236.485 Y4.879 E17.3932
G1 X239.312 Y7.705 E17.7630
G1 X239.312 Y191.702 E34.7864
G1 X236.485 Y194.528 E35.1562
G1 X52.488 Y194.528 E52.1795
G1 X49.662 Y191.702 E52.5494
G1 X49.662 Y7.705 E69.5727
G92 E0.0000
G1 E-3.5000 F3600
G1 X50.212 Y7.933 F9000
G1 E0.0000 F3600
G92 E0.0000
G1 X52.716 Y5.429 E0.3277 F1200
G1 X236.257 Y5.429 E17.3089
G1 X238.762 Y7.933 E17.6365
G1 X238.762 Y191.474 E34.6177
G1 X236.257 Y193.978 E34.9454
G1 X52.716 Y193.978 E51.9266
G1 X50.212 Y191.474 E52.2543
G1 X50.212 Y7.933 E69.2355
G92 E0.0000
G1 E-3.5000 F3600
; feature outer perimeter
G1 X54.762 Y9.979 F9000
G1 E0.0000 F3600
G92 E0.0000
G1 X234.212 Y9.979 E16.6027 F1200
G1 X234.212 Y189.428 E28.5566 %alterado para 86%
G1 X54.762 Y189.428 E49.8080
G1 X54.762 Y10.079 E66.4014
G1 X54.762 Y9.979 F1200
G1 X56.762 Y9.979 F1200
; feature inner perimeter
G1 X55.312 Y10.529 F9000
G92 E0.0000
G1 X233.662 Y10.529 E16.5009 F1200
G1 X233.662 Y188.878 E28.3815 %alterado para 86%
G1 X55.312 Y188.878 E49.5027
G1 X55.312 Y10.629 E65.9943
G1 X55.312 Y10.529 F1200
G1 X55.862 Y11.079 F9000
G92 E0.0000
G1 X233.112 Y11.079 E16.3991 F1200
G1 X233.112 Y188.328 E28.2064 %alterado para 86%
G1 X55.862 Y188.328 E49.1973
G1 X55.862 Y11.179 E65.5872
G1 X55.862 Y11.079 F1200
; feature solid layer
G1 X232.116 Y11.546 F9000
G92 E0.0000
G1 X232.644 Y12.074 E0.0691 F1200
G1 X232.644 Y12.852 E0.1411
G1 X231.338 Y11.546 E0.3120
G1 X230.560 Y11.546 E0.3839
G1 X232.644 Y13.630 E0.6566
G1 X232.644 Y14.408 E0.7285
G1 X229.782 Y11.546 E1.1030
G1 X229.005 Y11.546 E1.1749
G1 X232.644 Y15.185 E1.6511
G1 X232.644 Y15.963 E1.7231
G1 X228.227 Y11.546 E2.3010
G1 X227.449 Y11.546 E2.3730
G1 X232.644 Y16.741 E3.0527
G1 X232.644 Y17.519 E3.1247
G1 X226.671 Y11.546 E3.9062
G1 X225.893 Y11.546 E3.9782
G1 X232.644 Y18.297 E4.8615
G1 X232.644 Y19.075 E4.9334
G1 X225.116 Y11.546 E5.9185
G1 X224.338 Y11.546 E5.9904
G1 X232.644 Y19.852 E7.0773
G1 X232.644 Y20.630 E7.1492
G1 X223.560 Y11.546 E8.3378
G1 X222.782 Y11.546 E8.4098
G1 X232.644 Y21.408 E9.7002
G1 X232.644 Y22.186 E9.7721
G1 X222.004 Y11.546 E11.1643
G1 X221.227 Y11.546 E11.2362
G1 X232.644 Y22.964 E12.7301
G1 X232.644 Y23.741 E12.8021
G1 X220.449 Y11.546 E14.3978
G1 X219.671 Y11.546 E14.4698
G1 X232.644 Y24.519 E16.1672
G1 X232.644 Y25.297 E16.2392
G1 X218.893 Y11.546 E18.0384
G1 X218.115 Y11.546 E18.1104
G1 X232.644 Y26.075 E20.0114
G1 X232.644 Y26.853 E20.0833
G1 X217.337 Y11.546 E22.0861
G1 X216.560 Y11.546 E22.1581
G1 X232.644 Y27.631 E24.2626
G1 X232.644 Y28.408 E24.3346
G1 X215.782 Y11.546 E26.5409
G1 X215.004 Y11.546 E26.6128
G1 X232.644 Y29.186 E28.9209
G1 X232.644 Y29.964 E28.9929
G1 X214.226 Y11.546 E31.4027
G1 X213.448 Y11.546 E31.4747
G1 X232.644 Y30.742 E33.9863
G1 X232.644 Y31.520 E34.0583
G1 X212.671 Y11.546 E36.6717
G1 X211.893 Y11.546 E36.7437
G1 X232.644 Y32.297 E39.4588
G1 X232.644 Y33.075 E39.5308
G1 X211.115 Y11.546 E42.3477
G1 X210.337 Y11.546 E42.4197
G1 X232.644 Y33.853 E45.3384
G1 X232.644 Y34.631 E45.4104
G1 X209.559 Y11.546 E48.4309
G1 X208.781 Y11.546 E48.5028
G1 X232.644 Y35.409 E51.6251
G1 X232.644 Y36.187 E51.6971
G1 X208.004 Y11.546 E54.9211
G1 X207.226 Y11.546 E54.9931
G1 X232.644 Y36.964 E58.3189
G1 X232.644 Y37.742 E58.3908
G1 X206.448 Y11.546 E61.8184
G1 X205.670 Y11.546 E61.8904
G1 X232.644 Y38.520 E65.4197
G1 X232.644 Y39.298 E65.4917
G1 X204.892 Y11.546 E69.1228
G1 X204.115 Y11.546 E69.1948
G1 X232.644 Y40.076 E72.9276
G1 X232.644 Y40.853 E72.9996
G1 X203.337 Y11.546 E76.8343
G1 X202.559 Y11.546 E76.9062
G1 X232.644 Y41.631 E80.8427
G1 X232.644 Y42.409 E80.9146
G1 X201.781 Y11.546 E84.9528
G1 X201.003 Y11.546 E85.0248
G1 X232.644 Y43.187 E89.1648
G1 X232.644 Y43.965 E89.2367
G1 X200.225 Y11.546 E93.4785
G1 X199.448 Y11.546 E93.5504
G1 X232.644 Y44.743 E97.8940
G1 X232.644 Y45.520 E97.9659
G1 X198.670 Y11.546 E102.4112
G1 X197.892 Y11.546 E102.4832
G1 X232.644 Y46.298 E107.0302
G1 X232.644 Y47.076 E107.1022
G1 X197.114 Y11.546 E111.7510
G1 X196.336 Y11.546 E111.8230
G1 X232.644 Y47.854 E116.5736
G1 X232.644 Y48.632 E116.6456
G1 X195.559 Y11.546 E121.4980
G1 X194.781 Y11.546 E121.5699
G1 X232.644 Y49.409 E126.5241
G1 X232.644 Y50.187 E126.5960
G1 X194.003 Y11.546 E131.6520
G1 X193.225 Y11.546 E131.7239
G1 X232.644 Y50.965 E136.8816
G1 X232.644 Y51.743 E136.9536
G1 X192.447 Y11.546 E142.2130
G1 X191.669 Y11.546 E142.2850
G1 X232.644 Y52.521 E147.6462
G1 X232.644 Y53.299 E147.7182
G1 X190.892 Y11.546 E153.1812
G1 X190.114 Y11.546 E153.2532
G1 X232.644 Y54.076 E158.8180
G1 X232.644 Y54.854 E158.8899
G1 X189.336 Y11.546 E164.5565
G1 X188.558 Y11.546 E164.6284
G1 X232.644 Y55.632 E170.3968
G1 X232.644 Y56.410 E170.4687
G1 X187.780 Y11.546 E176.3388
G1 X187.003 Y11.546 E176.4108
G1 X232.644 Y57.188 E182.3826
G1 X232.644 Y57.965 E182.4546
G1 X186.225 Y11.546 E188.5282
G1 X185.447 Y11.546 E188.6002
G1 X232.644 Y58.743 E194.7756
G1 X232.644 Y59.521 E194.8476
G1 X184.669 Y11.546 E201.1248
G1 X183.891 Y11.546 E201.1967
G1 X232.644 Y60.299 E207.5757
G1 X232.644 Y61.077 E207.6476
G1 X183.113 Y11.546 E214.1284
G1 X182.336 Y11.546 E214.2003
G1 X232.644 Y61.855 E220.7828
G1 X232.644 Y62.632 E220.8548
G1 X181.558 Y11.546 E227.5391
G1 X180.780 Y11.546 E227.6110
G1 X232.644 Y63.410 E234.3971
G1 X232.644 Y64.188 E234.4690
G1 X180.002 Y11.546 E241.3568
G1 X179.224 Y11.546 E241.4288
G1 X232.644 Y64.966 E248.4184
G1 X232.644 Y65.744 E248.4903
G1 X178.447 Y11.546 E255.5817
G1 X177.669 Y11.546 E255.6537
G1 X232.644 Y66.521 E262.8468
G1 X232.644 Y67.299 E262.9188
G1 X176.891 Y11.546 E270.2137
G1 X176.113 Y11.546 E270.2856
G1 X232.644 Y68.077 E277.6823
G1 X232.644 Y68.855 E277.7543
G1 X175.335 Y11.546 E285.2527
G1 X174.557 Y11.546 E285.3247
G1 X232.644 Y69.633 E292.9249
G1 X232.644 Y70.411 E292.9968
G1 X173.780 Y11.546 E300.6988
G1 X173.002 Y11.546 E300.7708
G1 X232.644 Y71.188 E308.5745
G1 X232.644 Y71.966 E308.6465
G1 X172.224 Y11.546 E316.5520
G1 X171.446 Y11.546 E316.6240
G1 X232.644 Y72.744 E324.6313
G1 X232.644 Y73.522 E324.7033
G1 X170.668 Y11.546 E332.8123
G1 X169.891 Y11.546 E332.8843
G1 X232.644 Y74.300 E341.0951
G1 X232.644 Y75.077 E341.1671
G1 X169.113 Y11.546 E349.4797
G1 X168.335 Y11.546 E349.5517
G1 X232.644 Y75.855 E357.9661
G1 X232.644 Y76.633 E358.0380
G1 X167.557 Y11.546 E366.5542
G1 X166.779 Y11.546 E366.6262
G1 X232.644 Y77.411 E375.2441
G1 X232.644 Y78.189 E375.3160
G1 X166.001 Y11.546 E384.0358
G1 X165.224 Y11.546 E384.1077
G1 X232.644 Y78.967 E392.9292
G1 X232.644 Y79.744 E393.0012
G1 X164.446 Y11.546 E401.9244
G1 X163.668 Y11.546 E401.9964
G1 X232.644 Y80.522 E411.0214
G1 X232.644 Y81.300 E411.0933
G1 X162.890 Y11.546 E420.2201
G1 X162.112 Y11.546 E420.2921
G1 X232.644 Y82.078 E429.5207
G1 X232.644 Y82.856 E429.5926
G1 X161.335 Y11.546 E438.9230
G1 X160.557 Y11.546 E438.9949
G1 X232.644 Y83.633 E448.4270
G1 X232.644 Y84.411 E448.4990
G1 X159.779 Y11.546 E458.0329
G1 X159.001 Y11.546 E458.1048
G1 X232.644 Y85.189 E467.7405
G1 X232.644 Y85.967 E467.8124
G1 X158.223 Y11.546 E477.5499
G1 X157.445 Y11.546 E477.6218
G1 X232.644 Y86.745 E487.4610
G1 X232.644 Y87.523 E487.5330
G1 X156.668 Y11.546 E497.4739
G1 X155.890 Y11.546 E497.5459
G1 X232.644 Y88.300 E507.5886
G1 X232.644 Y89.078 E507.6606
G1 X155.112 Y11.546 E517.8051
G1 X154.334 Y11.546 E517.8771
G1 X232.644 Y89.856 E528.1233
G1 X232.644 Y90.634 E528.1953
G1 X153.556 Y11.546 E538.5434
G1 X152.779 Y11.546 E538.6153
G1 X232.644 Y91.412 E549.0651
G1 X232.644 Y92.189 E549.1371
G1 X152.001 Y11.546 E559.6887
G1 X151.223 Y11.546 E559.7607
G1 X232.644 Y92.967 E570.4140
G1 X232.644 Y93.745 E570.4860
G1 X150.445 Y11.546 E581.2411
G1 X149.667 Y11.546 E581.3131
G1 X232.644 Y94.523 E592.1700
G1 X232.644 Y95.301 E592.2420
G1 X148.889 Y11.546 E603.2006
G1 X148.112 Y11.546 E603.2726
G1 X232.644 Y96.079 E614.3330
G1 X232.644 Y96.856 E614.4050
G1 X147.334 Y11.546 E625.5672
G1 X146.556 Y11.546 E625.6392
G1 X232.644 Y97.634 E636.9032
G1 X232.644 Y98.412 E636.9752
G1 X145.778 Y11.546 E648.3409
G1 X145.000 Y11.546 E648.4129
G1 X232.644 Y99.190 E659.8804
G1 X232.644 Y99.968 E659.9524
G1 X144.223 Y11.546 E671.5217
G1 X143.445 Y11.546 E671.5937
G1 X232.644 Y100.745 E683.2647
G1 X232.644 Y101.523 E683.3367
G1 X142.667 Y11.546 E695.1096
G1 X141.889 Y11.546 E695.1815
G1 X232.644 Y102.301 E707.0561
G1 X232.644 Y103.079 E707.1281
G1 X141.111 Y11.546 E719.1045
G1 X140.333 Y11.546 E719.1765
G1 X232.644 Y103.857 E731.2546
G1 X232.644 Y104.635 E731.3266
G1 X139.556 Y11.546 E743.5065
G1 X138.778 Y11.546 E743.5785
G1 X232.644 Y105.412 E755.8602
G1 X232.644 Y106.190 E755.9322
G1 X138.000 Y11.546 E768.3157
G1 X137.222 Y11.546 E768.3876
G1 X232.644 Y106.968 E780.8729
G1 X232.644 Y107.746 E780.9448
G1 X136.444 Y11.546 E793.5319
G1 X135.667 Y11.546 E793.6038
G1 X232.644 Y108.524 E806.2926
G1 X232.644 Y109.301 E806.3646
G1 X134.889 Y11.546 E819.1552
G1 X134.111 Y11.546 E819.2271
G1 X232.644 Y110.079 E832.1195
G1 X232.644 Y110.857 E832.1914
G1 X133.333 Y11.546 E845.1855
G1 X132.555 Y11.546 E845.2575
G1 X232.644 Y111.635 E858.3534
G1 X232.644 Y112.413 E858.4254
G1 X131.777 Y11.546 E871.6230
G1 X131.000 Y11.546 E871.6950
G1 X232.644 Y113.190 E884.9944
G1 X232.644 Y113.968 E885.0664
G1 X130.222 Y11.546 E898.4676
G1 X129.444 Y11.546 E898.5395
G1 X232.644 Y114.746 E912.0425
G1 X232.644 Y115.524 E912.1145
G1 X128.666 Y11.546 E925.7192
G1 X127.888 Y11.546 E925.7912
G1 X232.644 Y116.302 E939.4977
G1 X232.644 Y117.080 E939.5697
G1 X127.111 Y11.546 E953.3779
G1 X126.333 Y11.546 E953.4499
G1 X232.644 Y117.857 E967.3600
G1 X232.644 Y118.635 E967.4319
G1 X125.555 Y11.546 E981.4438
G1 X124.777 Y11.546 E981.5157
G1 X232.644 Y119.413 E995.6293
G1 X232.644 Y120.191 E995.7013
G1 X123.999 Y11.546 E1009.9167
G1 X123.222 Y11.546 E1009.9886
G1 X232.644 Y120.969 E1024.3058
G1 X232.644 Y121.746 E1024.3777
G1 X122.444 Y11.546 E1038.7966
G1 X121.666 Y11.546 E1038.8686
G1 X232.644 Y122.524 E1053.3893
G1 X232.644 Y123.302 E1053.4613
G1 X120.888 Y11.546 E1068.0837
G1 X120.110 Y11.546 E1068.1557
G1 X232.644 Y124.080 E1082.8799
G1 X232.644 Y124.858 E1082.9519
G1 X119.332 Y11.546 E1097.7779
G1 X118.555 Y11.546 E1097.8499
G1 X232.644 Y125.636 E1112.7776
G1 X232.644 Y126.413 E1112.8496
G1 X117.777 Y11.546 E1127.8791
G1 X116.999 Y11.546 E1127.9511
G1 X232.644 Y127.191 E1143.0824
G1 X232.644 Y127.969 E1143.1544
G1 X116.221 Y11.546 E1158.3875
G1 X115.443 Y11.546 E1158.4594
G1 X232.644 Y128.747 E1173.7943
G1 X232.644 Y129.525 E1173.8663
G1 X114.666 Y11.546 E1189.3029
G1 X113.888 Y11.546 E1189.3749
G1 X232.644 Y130.302 E1204.9133
G1 X232.644 Y131.080 E1204.9852
G1 X113.110 Y11.546 E1220.6254
G1 X112.332 Y11.546 E1220.6974
G1 X232.644 Y131.858 E1236.4393
G1 X232.644 Y132.636 E1236.5113
G1 X111.554 Y11.546 E1252.3550
G1 X110.776 Y11.546 E1252.4270
G1 X232.644 Y133.414 E1268.3725
G1 X232.644 Y134.192 E1268.4444
G1 X109.999 Y11.546 E1284.4917
G1 X109.221 Y11.546 E1284.5637
G1 X232.644 Y134.969 E1300.7127
G1 X232.644 Y135.747 E1300.7846
G1 X108.443 Y11.546 E1317.0355
G1 X107.665 Y11.546 E1317.1074
G1 X232.644 Y136.525 E1333.4600
G1 X232.644 Y137.303 E1333.5320
G1 X106.887 Y11.546 E1349.9863
G1 X106.110 Y11.546 E1350.0583
G1 X232.644 Y138.081 E1366.6144
G1 X232.644 Y138.858 E1366.6864
G1 X105.332 Y11.546 E1383.3443
G1 X104.554 Y11.546 E1383.4162
G1 X232.644 Y139.636 E1400.1759
G1 X232.644 Y140.414 E1400.2478
G1 X103.776 Y11.546 E1417.1093
G1 X102.998 Y11.546 E1417.1813
G1 X232.644 Y141.192 E1434.1445
G1 X232.644 Y141.970 E1434.2164
G1 X102.220 Y11.546 E1451.2814
G1 X101.443 Y11.546 E1451.3534
G1 X232.644 Y142.748 E1468.5201
G1 X232.644 Y143.525 E1468.5921
G1 X100.665 Y11.546 E1485.8606
G1 X99.887 Y11.546 E1485.9326
G1 X232.644 Y144.303 E1503.3029
G1 X232.644 Y145.081 E1503.3748
G1 X99.109 Y11.546 E1520.8469
G1 X98.331 Y11.546 E1520.9189
G1 X232.644 Y145.859 E1538.4927
G1 X232.644 Y146.637 E1538.5647
G1 X97.554 Y11.546 E1556.2403
G1 X96.776 Y11.546 E1556.3122
G1 X232.644 Y147.414 E1574.0896
G1 X232.644 Y148.192 E1574.1616
G1 X95.998 Y11.546 E1592.0407
G1 X95.220 Y11.546 E1592.1127
G1 X232.644 Y148.970 E1610.0936
G1 X232.644 Y149.748 E1610.1656
G1 X94.442 Y11.546 E1628.2483
G1 X93.664 Y11.546 E1628.3203
G1 X232.644 Y150.526 E1646.5047
G1 X232.644 Y151.304 E1646.5767
G1 X92.887 Y11.546 E1664.8629
G1 X92.109 Y11.546 E1664.9349
G1 X232.644 Y152.081 E1683.3229
G1 X232.644 Y152.859 E1683.3949
G1 X91.331 Y11.546 E1701.8847
G1 X90.553 Y11.546 E1701.9566
G1 X232.644 Y153.637 E1720.5482
G1 X232.644 Y154.415 E1720.6201
G1 X89.775 Y11.546 E1739.3135
G1 X88.998 Y11.546 E1739.3854
G1 X232.644 Y155.193 E1758.1805
G1 X232.644 Y155.970 E1758.2525
G1 X88.220 Y11.546 E1777.1494
G1 X87.442 Y11.546 E1777.2213
G1 X232.644 Y156.748 E1796.2200
G1 X232.644 Y157.526 E1796.2919
G1 X86.664 Y11.546 E1815.3923
G1 X85.886 Y11.546 E1815.4643
G1 X232.644 Y158.304 E1834.6665
G1 X232.644 Y159.082 E1834.7385
G1 X85.108 Y11.546 E1854.0424
G1 X84.331 Y11.546 E1854.1144
G1 X232.644 Y159.860 E1873.5201
G1 X232.644 Y160.637 E1873.5921
G1 X83.553 Y11.546 E1893.0996
G1 X82.775 Y11.546 E1893.1715
G1 X232.644 Y161.415 E1912.7808
G1 X232.644 Y162.193 E1912.8528
G1 X81.997 Y11.546 E1932.5638
G1 X81.219 Y11.546 E1932.6358
G1 X232.644 Y162.971 E1952.4486
G1 X232.644 Y163.749 E1952.5206
G1 X80.442 Y11.546 E1972.4352
G1 X79.664 Y11.546 E1972.5071
G1 X232.644 Y164.526 E1992.5235
G1 X232.644 Y165.304 E1992.5954
G1 X78.886 Y11.546 E2012.7136
G1 X78.108 Y11.546 E2012.7855
G1 X232.644 Y166.082 E2033.0054
G1 X232.644 Y166.860 E2033.0774
G1 X77.330 Y11.546 E2053.3991
G1 X76.552 Y11.546 E2053.4710
G1 X232.644 Y167.638 E2073.8945
G1 X232.644 Y168.416 E2073.9665
G1 X75.775 Y11.546 E2094.4917
G1 X74.997 Y11.546 E2094.5636
G1 X232.644 Y169.193 E2115.1906
G1 X232.644 Y169.971 E2115.2626
G1 X74.219 Y11.546 E2135.9914
G1 X73.441 Y11.546 E2136.0633
G1 X232.644 Y170.749 E2156.8938
G1 X232.644 Y171.527 E2156.9658
G1 X72.663 Y11.546 E2177.8981
G1 X71.886 Y11.546 E2177.9701
G1 X232.644 Y172.305 E2199.0042
G1 X232.644 Y173.082 E2199.0761
G1 X71.108 Y11.546 E2220.2120
G1 X70.330 Y11.546 E2220.2839
G1 X232.644 Y173.860 E2241.5216
G1 X232.644 Y174.638 E2241.5935
G1 X69.552 Y11.546 E2262.9329
G1 X68.774 Y11.546 E2263.0049
G1 X232.644 Y175.416 E2284.4460
G1 X232.644 Y176.194 E2284.5180
G1 X67.996 Y11.546 E2306.0609
G1 X67.219 Y11.546 E2306.1329
G1 X232.644 Y176.972 E2327.7776
G1 X232.644 Y177.749 E2327.8496
G1 X66.441 Y11.546 E2349.5960
G1 X65.663 Y11.546 E2349.6680
G1 X232.644 Y178.527 E2371.5163
G1 X232.644 Y179.305 E2371.5882
G1 X64.885 Y11.546 E2393.5382
G1 X64.107 Y11.546 E2393.6102
G1 X232.644 Y180.083 E2415.6620
G1 X232.644 Y180.861 E2415.7340
G1 X63.330 Y11.546 E2437.8875
G1 X62.552 Y11.546 E2437.9595
G1 X232.644 Y181.638 E2460.2148
G1 X232.644 Y182.416 E2460.2868
G1 X61.774 Y11.546 E2482.6439
G1 X60.996 Y11.546 E2482.7159
G1 X232.644 Y183.194 E2505.1747
G1 X232.644 Y183.972 E2505.2467
G1 X60.218 Y11.546 E2527.8074
G1 X59.440 Y11.546 E2527.8793
G1 X232.644 Y184.750 E2550.5418
G1 X232.644 Y185.528 E2550.6137
G1 X58.663 Y11.546 E2573.3779
G1 X57.885 Y11.546 E2573.4499
G1 X232.644 Y186.305 E2596.3158
G1 X232.644 Y187.083 E2596.3878
G1 X57.107 Y11.546 E2619.3555
G1 X56.329 Y11.546 E2619.4275
G1 X232.644 Y187.861 E2642.4970
G1 X231.866 Y187.861 E2642.5690
G1 X56.329 Y12.324 E2665.5367
G1 X56.329 Y13.102 E2665.6087
G1 X231.088 Y187.861 E2688.4747
G1 X230.311 Y187.861 E2688.5466
G1 X56.329 Y13.879 E2711.3108
G1 X56.329 Y14.657 E2711.3828
G1 X229.533 Y187.861 E2734.0452
G1 X228.755 Y187.861 E2734.1172
G1 X56.329 Y15.435 E2756.6778
G1 X56.329 Y16.213 E2756.7498
G1 X227.977 Y187.861 E2779.2087
G1 X227.199 Y187.861 E2779.2806
G1 X56.329 Y16.991 E2801.6378
G1 X56.329 Y17.769 E2801.7097
G1 X226.422 Y187.861 E2823.9651
G1 X225.644 Y187.861 E2824.0370
G1 X56.329 Y18.546 E2846.1906
G1 X56.329 Y19.324 E2846.2626
G1 X224.866 Y187.861 E2868.3144
G1 X224.088 Y187.861 E2868.3863
G1 X56.329 Y20.102 E2890.3363
G1 X56.329 Y20.880 E2890.4083
G1 X223.310 Y187.861 E2912.2566
G1 X222.532 Y187.861 E2912.3285
G1 X56.329 Y21.658 E2934.0750
G1 X56.329 Y22.435 E2934.1470
G1 X221.755 Y187.861 E2955.7917
G1 X220.977 Y187.861 E2955.8636
G1 X56.329 Y23.213 E2977.4066
G1 X56.329 Y23.991 E2977.4785
G1 X220.199 Y187.861 E2998.9197
G1 X219.421 Y187.861 E2998.9917
G1 X56.329 Y24.769 E3020.3311
G1 X56.329 Y25.547 E3020.4030
G1 X218.643 Y187.861 E3041.6407
G1 X217.866 Y187.861 E3041.7126
G1 X56.329 Y26.325 E3062.8485
G1 X56.329 Y27.102 E3062.9204
G1 X217.088 Y187.861 E3083.9545
G1 X216.310 Y187.861 E3084.0265
G1 X56.329 Y27.880 E3104.9588
G1 X56.329 Y28.658 E3105.0308
G1 X215.532 Y187.861 E3125.8613
G1 X214.754 Y187.861 E3125.9333
G1 X56.329 Y29.436 E3146.6620
G1 X56.329 Y30.214 E3146.7340
G1 X213.976 Y187.861 E3167.3610
G1 X213.199 Y187.861 E3167.4329
G1 X56.329 Y30.991 E3187.9582
G1 X56.329 Y31.769 E3188.0301
G1 X212.421 Y187.861 E3208.4536
G1 X211.643 Y187.861 E3208.5255
G1 X56.329 Y32.547 E3228.8472
G1 X56.329 Y33.325 E3228.9192
G1 X210.865 Y187.861 E3249.1391
G1 X210.087 Y187.861 E3249.2111
G1 X56.329 Y34.103 E3269.3292
G1 X56.329 Y34.880 E3269.4012
G1 X209.310 Y187.861 E3289.4175
G1 X208.532 Y187.861 E3289.4895
G1 X56.329 Y35.658 E3309.4041
G1 X56.329 Y36.436 E3309.4760
G1 X207.754 Y187.861 E3329.2889
G1 X206.976 Y187.861 E3329.3608
G1 X56.329 Y37.214 E3349.0719
G1 X56.329 Y37.992 E3349.1438
G1 X206.198 Y187.861 E3368.7531
G1 X205.420 Y187.861 E3368.8251
G1 X56.329 Y38.770 E3388.3326
G1 X56.329 Y39.547 E3388.4045
G1 X204.643 Y187.861 E3407.8103
G1 X203.865 Y187.861 E3407.8822
G1 X56.329 Y40.325 E3427.1862
G1 X56.329 Y41.103 E3427.2582
G1 X203.087 Y187.861 E3446.4604
G1 X202.309 Y187.861 E3446.5323
G1 X56.329 Y41.881 E3465.6327
G1 X56.329 Y42.659 E3465.7047
G1 X201.531 Y187.861 E3484.7033
G1 X200.754 Y187.861 E3484.7753
G1 X56.329 Y43.436 E3503.6722
G1 X56.329 Y44.214 E3503.7442
G1 X199.976 Y187.861 E3522.5393
G1 X199.198 Y187.861 E3522.6112
G1 X56.329 Y44.992 E3541.3045
G1 X56.329 Y45.770 E3541.3765
G1 X198.420 Y187.861 E3559.9681
G1 X197.642 Y187.861 E3560.0400
G1 X56.329 Y46.548 E3578.5298
G1 X56.329 Y47.326 E3578.6018
G1 X196.864 Y187.861 E3596.9898
G1 X196.087 Y187.861 E3597.0618
G1 X56.329 Y48.103 E3615.3480
G1 X56.329 Y48.881 E3615.4200
G1 X195.309 Y187.861 E3633.6045
G1 X194.531 Y187.861 E3633.6764
G1 X56.329 Y49.659 E3651.7591
G1 X56.329 Y50.437 E3651.8311
G1 X193.753 Y187.861 E3669.8120
G1 X192.975 Y187.861 E3669.8840
G1 X56.329 Y51.215 E3687.7631
G1 X56.329 Y51.992 E3687.8351
G1 X192.198 Y187.861 E3705.6125
G1 X191.420 Y187.861 E3705.6844
G1 X56.329 Y52.770 E3723.3601
G1 X56.329 Y53.548 E3723.4320
G1 X190.642 Y187.861 E3741.0059
G1 X189.864 Y187.861 E3741.0778
G1 X56.329 Y54.326 E3758.5499
G1 X56.329 Y55.104 E3758.6219
G1 X189.086 Y187.861 E3775.9922
G1 X188.308 Y187.861 E3776.0641
G1 X56.329 Y55.882 E3793.3327
G1 X56.329 Y56.659 E3793.4046
G1 X187.531 Y187.861 E3810.5714
G1 X186.753 Y187.861 E3810.6433
G1 X56.329 Y57.437 E3827.7083
G1 X56.329 Y58.215 E3827.7803
G1 X185.975 Y187.861 E3844.7435
G1 X185.197 Y187.861 E3844.8155
G1 X56.329 Y58.993 E3861.6769
G1 X56.329 Y59.771 E3861.7489
G1 X184.419 Y187.861 E3878.5085
G1 X183.642 Y187.861 E3878.5805
G1 X56.329 Y60.548 E3895.2384
G1 X56.329 Y61.326 E3895.3104
G1 X182.864 Y187.861 E3911.8665
G1 X182.086 Y187.861 E3911.9385
G1 X56.329 Y62.104 E3928.3928
G1 X56.329 Y62.882 E3928.4648
G1 X181.308 Y187.861 E3944.8174
G1 X180.530 Y187.861 E3944.8893
G1 X56.329 Y63.660 E3961.1401
G1 X56.329 Y64.438 E3961.2121
G1 X179.752 Y187.861 E3977.3611
G1 X178.975 Y187.861 E3977.4331
G1 X56.329 Y65.215 E3993.4804
G1 X56.329 Y65.993 E3993.5523
G1 X178.197 Y187.861 E4009.4978
G1 X177.419 Y187.861 E4009.5698
G1 X56.329 Y66.771 E4025.4135
G1 X56.329 Y67.549 E4025.4855
G1 X176.641 Y187.861 E4041.2274
G1 X175.863 Y187.861 E4041.2994
G1 X56.329 Y68.327 E4056.9396
G1 X56.329 Y69.104 E4057.0115
G1 X175.086 Y187.861 E4072.5499
G1 X174.308 Y187.861 E4072.6219
G1 X56.329 Y69.882 E4088.0585
G1 X56.329 Y70.660 E4088.1305
G1 X173.530 Y187.861 E4103.4654
G1 X172.752 Y187.861 E4103.5373
G1 X56.329 Y71.438 E4118.7704
G1 X56.329 Y72.216 E4118.8424
G1 X171.974 Y187.861 E4133.9737
G1 X171.197 Y187.861 E4134.0457
G1 X56.329 Y72.994 E4149.0752
G1 X56.329 Y73.771 E4149.1472
G1 X170.419 Y187.861 E4164.0750
G1 X169.641 Y187.861 E4164.1469
G1 X56.329 Y74.549 E4178.9729
G1 X56.329 Y75.327 E4179.0449
G1 X168.863 Y187.861 E4193.7691
G1 X168.085 Y187.861 E4193.8411
G1 X56.329 Y76.105 E4208.4636
G1 X56.329 Y76.883 E4208.5355
G1 X167.307 Y187.861 E4223.0562
G1 X166.530 Y187.861 E4223.1282
G1 X56.329 Y77.660 E4237.5471
G1 X56.329 Y78.438 E4237.6191
G1 X165.752 Y187.861 E4251.9362
G1 X164.974 Y187.861 E4252.0082
G1 X56.329 Y79.216 E4266.2236
G1 X56.329 Y79.994 E4266.2955
G1 X164.196 Y187.861 E4280.4091
G1 X163.418 Y187.861 E4280.4811
G1 X56.329 Y80.772 E4294.4929
G1 X56.329 Y81.550 E4294.5649
G1 X162.641 Y187.861 E4308.4750
G1 X161.863 Y187.861 E4308.5469
G1 X56.329 Y82.327 E4322.3552
G1 X56.329 Y83.105 E4322.4272
G1 X161.085 Y187.861 E4336.1337
G1 X160.307 Y187.861 E4336.2057
G1 X56.329 Y83.883 E4349.8104
G1 X56.329 Y84.661 E4349.8824
G1 X159.529 Y187.861 E4363.3853
G1 X158.751 Y187.861 E4363.4573
G1 X56.329 Y85.439 E4376.8585
G1 X56.329 Y86.216 E4376.9305
G1 X157.974 Y187.861 E4390.2299
G1 X157.196 Y187.861 E4390.3019
G1 X56.329 Y86.994 E4403.4995
G1 X56.329 Y87.772 E4403.5715
G1 X156.418 Y187.861 E4416.6674
G1 X155.640 Y187.861 E4416.7393
G1 X56.329 Y88.550 E4429.7335
G1 X56.329 Y89.328 E4429.8054
G1 X154.862 Y187.861 E4442.6978
G1 X154.085 Y187.861 E4442.7697
G1 X56.329 Y90.106 E4455.5603
G1 X56.329 Y90.883 E4455.6323
G1 X153.307 Y187.861 E4468.3211
G1 X152.529 Y187.861 E4468.3930
G1 X56.329 Y91.661 E4480.9801
G1 X56.329 Y92.439 E4481.0520
G1 X151.751 Y187.861 E4493.5373
G1 X150.973 Y187.861 E4493.6093
G1 X56.329 Y93.217 E4505.9927
G1 X56.329 Y93.995 E4506.0647
G1 X150.195 Y187.861 E4518.3464
G1 X149.418 Y187.861 E4518.4184
G1 X56.329 Y94.772 E4530.5983
G1 X56.329 Y95.550 E4530.6703
G1 X148.640 Y187.861 E4542.7485
G1 X147.862 Y187.861 E4542.8204
G1 X56.329 Y96.328 E4554.7968
G1 X56.329 Y97.106 E4554.8688
G1 X147.084 Y187.861 E4566.7434
G1 X146.306 Y187.861 E4566.8154
G1 X56.329 Y97.884 E4578.5882
G1 X56.329 Y98.662 E4578.6602
G1 X145.529 Y187.861 E4590.3313
G1 X144.751 Y187.861 E4590.4033
G1 X56.329 Y99.439 E4601.9726
G1 X56.329 Y100.217 E4602.0445
G1 X143.973 Y187.861 E4613.5121
G1 X143.195 Y187.861 E4613.5840
G1 X56.329 Y100.995 E4624.9498
G1 X56.329 Y101.773 E4625.0218
G1 X142.417 Y187.861 E4636.2858
G1 X141.639 Y187.861 E4636.3577
G1 X56.329 Y102.551 E4647.5200
G1 X56.329 Y103.328 E4647.5919
G1 X140.862 Y187.861 E4658.6524
G1 X140.084 Y187.861 E4658.7243
G1 X56.329 Y104.106 E4669.6830
G1 X56.329 Y104.884 E4669.7550
G1 X139.306 Y187.861 E4680.6119
G1 X138.528 Y187.861 E4680.6839
G1 X56.329 Y105.662 E4691.4390
G1 X56.329 Y106.440 E4691.5110
G1 X137.750 Y187.861 E4702.1643
G1 X136.973 Y187.861 E4702.2363
G1 X56.329 Y107.218 E4712.7879
G1 X56.329 Y107.995 E4712.8599
G1 X136.195 Y187.861 E4723.3097
G1 X135.417 Y187.861 E4723.3816
G1 X56.329 Y108.773 E4733.7297
G1 X56.329 Y109.551 E4733.8017
G1 X134.639 Y187.861 E4744.0479
G1 X133.861 Y187.861 E4744.1199
G1 X56.329 Y110.329 E4754.2644
G1 X56.329 Y111.107 E4754.3364
G1 X133.083 Y187.861 E4764.3791
G1 X132.306 Y187.861 E4764.4511
G1 X56.329 Y111.884 E4774.3920
G1 X56.329 Y112.662 E4774.4640
G1 X131.528 Y187.861 E4784.3032
G1 X130.750 Y187.861 E4784.3752
G1 X56.329 Y113.440 E4794.1126
G1 X56.329 Y114.218 E4794.1846
G1 X129.972 Y187.861 E4803.8202
G1 X129.194 Y187.861 E4803.8922
G1 X56.329 Y114.996 E4813.4260
G1 X56.329 Y115.774 E4813.4980
G1 X128.417 Y187.861 E4822.9301
G1 X127.639 Y187.861 E4823.0021
G1 X56.329 Y116.551 E4832.3324
G1 X56.329 Y117.329 E4832.4044
G1 X126.861 Y187.861 E4841.6329
G1 X126.083 Y187.861 E4841.7049
G1 X56.329 Y118.107 E4850.8317
G1 X56.329 Y118.885 E4850.9037
G1 X125.305 Y187.861 E4859.9287
G1 X124.527 Y187.861 E4860.0007
G1 X56.329 Y119.663 E4868.9239
G1 X56.329 Y120.440 E4868.9959
G1 X123.750 Y187.861 E4877.8173
G1 X122.972 Y187.861 E4877.8893
G1 X56.329 Y121.218 E4886.6090
G1 X56.329 Y121.996 E4886.6810
G1 X122.194 Y187.861 E4895.2989
G1 X121.416 Y187.861 E4895.3709
G1 X56.329 Y122.774 E4903.8870
G1 X56.329 Y123.552 E4903.9590
G1 X120.638 Y187.861 E4912.3734
G1 X119.861 Y187.861 E4912.4454
G1 X56.329 Y124.330 E4920.7580
G1 X56.329 Y125.107 E4920.8299
G1 X119.083 Y187.861 E4929.0408
G1 X118.305 Y187.861 E4929.1127
G1 X56.329 Y125.885 E4937.2218
G1 X56.329 Y126.663 E4937.2938
G1 X117.527 Y187.861 E4945.3011
G1 X116.749 Y187.861 E4945.3731
G1 X56.329 Y127.441 E4953.2786
G1 X56.329 Y128.219 E4953.3506
G1 X115.971 Y187.861 E4961.1543
G1 X115.194 Y187.861 E4961.2263
G1 X56.329 Y128.996 E4968.9283
G1 X56.329 Y129.774 E4969.0002
G1 X114.416 Y187.861 E4976.6004
G1 X113.638 Y187.861 E4976.6724
G1 X56.329 Y130.552 E4984.1709
G1 X56.329 Y131.330 E4984.2428
G1 X112.860 Y187.861 E4991.6395
G1 X112.082 Y187.861 E4991.7115
G1 X56.329 Y132.108 E4999.0064
G1 X56.329 Y132.885 E4999.0783
G1 X111.305 Y187.861 E5006.2715
G1 X110.527 Y187.861 E5006.3434
G1 X56.329 Y133.663 E5013.4348
G1 X56.329 Y134.441 E5013.5067
G1 X109.749 Y187.861 E5020.4963
G1 X108.971 Y187.861 E5020.5683
G1 X56.329 Y135.219 E5027.4561
G1 X56.329 Y135.997 E5027.5281
G1 X108.193 Y187.861 E5034.3141
G1 X107.415 Y187.861 E5034.3861
G1 X56.329 Y136.775 E5041.0703
G1 X56.329 Y137.552 E5041.1423
G1 X106.638 Y187.861 E5047.7248
G1 X105.860 Y187.861 E5047.7968
G1 X56.329 Y138.330 E5054.2775
G1 X56.329 Y139.108 E5054.3495
G1 X105.082 Y187.861 E5060.7284
G1 X104.304 Y187.861 E5060.8004
G1 X56.329 Y139.886 E5067.0776
G1 X56.329 Y140.664 E5067.1495
G1 X103.526 Y187.861 E5073.3250
G1 X102.749 Y187.861 E5073.3969
G1 X56.329 Y141.441 E5079.4706
G1 X56.329 Y142.219 E5079.5425
G1 X101.971 Y187.861 E5085.5144
G1 X101.193 Y187.861 E5085.5864
G1 X56.329 Y142.997 E5091.4565
G1 X56.329 Y143.775 E5091.5284
G1 X100.415 Y187.861 E5097.2967
G1 X99.637 Y187.861 E5097.3687
G1 X56.329 Y144.553 E5103.0353
G1 X56.329 Y145.331 E5103.1072
G1 X98.859 Y187.861 E5108.6720
G1 X98.082 Y187.861 E5108.7440
G1 X56.329 Y146.108 E5114.2070
G1 X56.329 Y146.886 E5114.2789
G1 X97.304 Y187.861 E5119.6402
G1 X96.526 Y187.861 E5119.7122
G1 X56.329 Y147.664 E5124.9716
G1 X56.329 Y148.442 E5125.0436
G1 X95.748 Y187.861 E5130.2013
G1 X94.970 Y187.861 E5130.2732
G1 X56.329 Y149.220 E5135.3292
G1 X56.329 Y149.997 E5135.4011
G1 X94.193 Y187.861 E5140.3553
G1 X93.415 Y187.861 E5140.4272
G1 X56.329 Y150.775 E5145.2796
G1 X56.329 Y151.553 E5145.3516
G1 X92.637 Y187.861 E5150.1022
G1 X91.859 Y187.861 E5150.1742
G1 X56.329 Y152.331 E5154.8230
G1 X56.329 Y153.109 E5154.8950
G1 X91.081 Y187.861 E5159.4420
G1 X90.303 Y187.861 E5159.5140
G1 X56.329 Y153.887 E5163.9593
G1 X56.329 Y154.664 E5164.0313
G1 X89.526 Y187.861 E5168.3748
G1 X88.748 Y187.861 E5168.4467
G1 X56.329 Y155.442 E5172.6885
G1 X56.329 Y156.220 E5172.7605
G1 X87.970 Y187.861 E5176.9004
G1 X87.192 Y187.861 E5176.9724
G1 X56.329 Y156.998 E5181.0106
G1 X56.329 Y157.776 E5181.0826
G1 X86.414 Y187.861 E5185.0190
G1 X85.637 Y187.861 E5185.0910
G1 X56.329 Y158.553 E5188.9256
G1 X56.329 Y159.331 E5188.9976
G1 X84.859 Y187.861 E5192.7305
G1 X84.081 Y187.861 E5192.8025
G1 X56.329 Y160.109 E5196.4336
G1 X56.329 Y160.887 E5196.5055
G1 X83.303 Y187.861 E5200.0349
G1 X82.525 Y187.861 E5200.1069
G1 X56.329 Y161.665 E5203.5344
G1 X56.329 Y162.443 E5203.6064
G1 X81.747 Y187.861 E5206.9322
G1 X80.970 Y187.861 E5207.0042
G1 X56.329 Y163.220 E5210.2282
G1 X56.329 Y163.998 E5210.3002
G1 X80.192 Y187.861 E5213.4224
G1 X79.414 Y187.861 E5213.4944
G1 X56.329 Y164.776 E5216.5149
G1 X56.329 Y165.554 E5216.5868
G1 X78.636 Y187.861 E5219.5056
G1 X77.858 Y187.861 E5219.5775
G1 X56.329 Y166.332 E5222.3945
G1 X56.329 Y167.109 E5222.4664
G1 X77.081 Y187.861 E5225.1816
G1 X76.303 Y187.861 E5225.2536
G1 X56.329 Y167.887 E5227.8670
G1 X56.329 Y168.665 E5227.9389
G1 X75.525 Y187.861 E5230.4506
G1 X74.747 Y187.861 E5230.5225
G1 X56.329 Y169.443 E5232.9324
G1 X56.329 Y170.221 E5233.0044
G1 X73.969 Y187.861 E5235.3125
G1 X73.192 Y187.861 E5235.3844
G1 X56.329 Y170.999 E5237.5907
G1 X56.329 Y171.776 E5237.6627
G1 X72.414 Y187.861 E5239.7673
G1 X71.636 Y187.861 E5239.8392
G1 X56.329 Y172.554 E5241.8420
G1 X56.329 Y173.332 E5241.9140
G1 X70.858 Y187.861 E5243.8150
G1 X70.080 Y187.861 E5243.8869
G1 X56.329 Y174.110 E5245.6861
G1 X56.329 Y174.888 E5245.7581
G1 X69.302 Y187.861 E5247.4556
G1 X68.525 Y187.861 E5247.5275
G1 X56.329 Y175.665 E5249.1232
G1 X56.329 Y176.443 E5249.1952
G1 X67.747 Y187.861 E5250.6891
G1 X66.969 Y187.861 E5250.7611
G1 X56.329 Y177.221 E5252.1532
G1 X56.329 Y177.999 E5252.2252
G1 X66.191 Y187.861 E5253.5155
G1 X65.413 Y187.861 E5253.5875
G1 X56.329 Y178.777 E5254.7761
G1 X56.329 Y179.555 E5254.8481
G1 X64.636 Y187.861 E5255.9349
G1 X63.858 Y187.861 E5256.0069
G1 X56.329 Y180.332 E5256.9919
G1 X56.329 Y181.110 E5257.0639
G1 X63.080 Y187.861 E5257.9472
G1 X62.302 Y187.861 E5258.0191
G1 X56.329 Y181.888 E5258.8007
G1 X56.329 Y182.666 E5258.8726
G1 X61.524 Y187.861 E5259.5524
G1 X60.746 Y187.861 E5259.6243
G1 X56.329 Y183.444 E5260.2023
G1 X56.329 Y184.221 E5260.2743
G1 X59.969 Y187.861 E5260.7505
G1 X59.191 Y187.861 E5260.8224
G1 X56.329 Y184.999 E5261.1968
G1 X56.329 Y185.777 E5261.2688
G1 X58.413 Y187.861 E5261.5415
G1 X57.635 Y187.861 E5261.6134
G1 X56.329 Y186.555 E5261.7843
G1 X56.329 Y187.333 E5261.8563
G1 X56.787 Y187.790 E5261.9161
G1 X56.857 Y187.861 F1200
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
;   Build time: 0 hours 50 minutes
;   Filament length: 5598.7 mm (5.60 m)
;   Plastic volume: 13313.01 mm^3 (13.31 cc)
;   Plastic weight: 14.38 g (0.03 lb)
;   Material cost: 1.73
