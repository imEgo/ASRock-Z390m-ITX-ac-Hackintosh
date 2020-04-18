# ASRock Z390m-ITX/ac Hackintosh

## 硬件配置
- Intel Core i9-9900es(QQZ5) 2.60GHz
- ASRock Z390m-ITX/ac
- Intel UHD Graphics 630
- XFX Radeon RX5700 XT THICC II Ultra 8G
- Kingston Fury DDR4 2133MHz 8G * 2 (Overclock 3000MHz)
- HP EX900 SSD 500GB NVMe PCIe M.2
- WD Blue HDD 3TB SATA
- Dell DW1820A(08PKF4) WiFi + BT
- Intel I219V + I211AT
- Realtek ALC892

## 软件版本
- BIOS 4.30 (替换98版本06EC微码，非ES版CPU无需替换)
  - CFG Lock -> Disabled
  - VT-d -> Disabled
  - Share Memory -> 128M
  - IGPU Multi-Monitor -> Enabled（使用外置显卡时，需要启用核显开启随航）
  - XHCI Hand-off -> Enabled
  - Secure Boot -> Disabled
  - CSM -> Disabled
- macOS 10.15.4 19E287
- Clover 5108

## 工作正常
- Intel UHD Graphics 630（Clover注入 - 主板DisplayPort + 2 * HDMI均正常输出，WhateverGreen - Apple GuC firmware）
- XFX Radeon RX5700 XT THICC II Ultra 8G（Clover注入 - 伪装Radeon Pro W5700X，WhateverGreen - agdpmod=pikera）
- Intel I219V（IntelMausiEthernet）
- Intel I211AT（SmallTreeIntel82576）
- 无线（Clover注入 - 禁用ASPM，AirportBrcmFixup - 使用Brcm4360驱动）
- 蓝牙（BrcmPatchRAM）
- USB（USBInjectAll，IO面板保留TypeC接口 + 屏蔽2个USB3.0接口，前置面板保留2个USB3.0接口）
- 声卡（AppleALC - IO面板/前置面板，WhateverGreen - DisplayPort）
- NVRAM（SSDT-PMC.aml）
- 睡眠唤醒（HibernateMode 0 + ProximityWake 0）
- AirDrop（修改三码）
- iMessage/FaceTime（修改三码）

## 工作异常
- ~~多出一个S/PDIF音频输出，需要重新定制声卡~~

## TODO
- ~~重新定制声卡映射，解决多出一个S/PDIF音频输出的问题~~

## 使用说明
- config.plist中三码已删除，需要重新生成（RtVariables - ROM，SMBIOS - BoardSerialNumber/SerialNumber/SmUUID）

## 更新
- 2020/04/18
  - BIOS升级至4.30
  - 添加Clover参数AFGLowPowerState/ResetHDA，解决睡眠关机时POP音和与Windows双系统的相互影响
  - 添加XFX Radeon RX5700 XT THICC II Ultra 8G，伪装为Radeon Pro W5700X（显卡驱动后的启动变长，原因未知待优化）
  - macOS升级至10.15.4 19E287
- 2020/04/15
  - 定制声卡接口，屏蔽全部无用接口，IO面板Line Out/Mic In与前置面板HP Out/Mic In互为一组，前置面板接口插入时自动切换