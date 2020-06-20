# ASRock Z390m-ITX/ac Hackintosh

## 硬件配置
- Intel Core i9-9900es(QQZ5) 2.60GHz
- ASRock Z390m-ITX/ac
- Intel UHD Graphics 630
- XFX Radeon RX5700 XT THICC II Ultra 8G
- Kingston Fury DDR4 2400MHz 8G * 2 (Overclock 3600MHz)
- Samsung SM951 SSD 512GB NVMe PCIe M.2
- WD Blue HDD 3TB SATA
- Dell DW1560 WiFi + BT
- Intel I219V + I211AT
- Realtek ALC892

## 软件版本
- BIOS 4.30 (替换98版本06EC微码，非ES版CPU无需替换)
  - OC Tweaker
    - CPU Configuration
      - Intel SpeedStep Technology -> Enabled
      - Intel Turbo Boost Technology -> Enabled
      - Intel Speed Shift Technology -> Enabled
  - Advanced
    - CPU Configuration
      - CFG Lock -> Disabled
      - Software Guard Extensions (SGX) -> Disabled
    - Chipset Configuration
      - Primary Graphics Adapter -> PCI Express // Required by dGPU
      - Above 4G Decoding -> Enabled            // Keep Disabled if ES CPU (e.g. QQZ5/QQBZ)
      - VT-d -> Disabled
      - Share Memory -> 128M
      - IGPU Multi-Monitor -> Enabled
      - PCI Express Native Control -> Enabled   // Optional
      - PCIE ASPM Support -> Auto               // Optional
      - PCH PCIE ASPM Support -> Auto           // Optional
      - DMI ASPM Support -> Enabled             // Optional
      - PCH DMI ASPM Support -> Enabled         // Optional
    - Storage Configuration
      - SATA Mode Selection -> AHCI
    - USB Configuration
      - XHCI Hand-off -> Enabled
    - Trusted Computing
      - Security Device Support -> Disabled
  - Security
    - Secure Boot
      - Secure Boot -> Disabled
  - Boot
    - CSM
      - CSM -> Disabled
- macOS 10.15.5 19F101
- Clover r5114

## 工作正常
- Intel UHD Graphics 630（Clover注入 - 核显硬件加速，WhateverGreen - Apple GuC firmware）
- XFX Radeon RX5700 XT THICC II Ultra 8G（RadeonBoost - 属性注入，WhateverGreen - agdpmod=pikera）
- Intel I219V（IntelMausiEthernet）
- Intel I211AT（SmallTreeIntel82576）
- 无线（AirportBrcmFixup - 修改区域为#a）
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
- 2020/06/20
  - 更新CLOVER至5119版本
  - 更新Kexts至最新版本
  - 更换无线网卡为DW1820A（XPS13 9360更新至10.15后DW1820A不能启用ASPM，导致待机功耗飙升，并且也遇到了系统崩溃后网卡不能使用的问题，以目前DW820A的价格还是推荐BCM94360CS2）
  - 更换CLOVER主题
  - 移除RadeonBoost.kext（使用方法参考[此说明](Resources/GPU/README.md)）
  - 更新BIOS选项设置，PCIE ASPM可选择性，开启后节能效果更好
- 2020/06/02
  - macOS升级至10.15.5 19F101
- 2020/06/01
  - macOS升级至10.15.5 19F96
  - 精简了CLOVER的配置文件，更新了SSDT文件，解决了之前部分SSDT Error，更容易迁移到OpenCore引导（笔记本更换了OpenCore没有什么特别明显的优势，双系统还是CLOVER更友好）
- 2020/05/14
  - 更换无线网卡为DW1560，DW1820A在系统崩溃后会有时网卡无法驱动（Windows亦如此，需要冷启动才能恢复），不推荐该主板使用DW1820A
  - PP_PhmSoftPowerPlayTable修改最低风扇转速及起停温度
  - 修正之前部分SSDT错误参数，添加CPU Plugin-Type改为SSDT注入
- 2020/05/05
  - 精简Clover配置
  - 使用kext注入XFX Radeon RX5700 XT THICC II Ultra定制PP_PhmSoftPowerPlayTable
  - 升级kexts
- 2020/04/28
  - 完善FileVault支持（如果开启的话，修改Clover的隐藏启动项，使用Preboot启动）
  - 修复启动时间过长问题（修改核显ID屏蔽输出接口）
  - 修复AppleTV+的DRM视频播放问题
  - 修改CPU显示类型，修改前关于里显示为i7，改为i9
- 2020/04/27
  - Clover升级至r5114
  - 隐藏Clover启动时的Preboot及Recovery选项
  - 添加CPUFriend及i9-9900es的配置
- 2020/04/18
  - BIOS升级至4.30
  - 添加Clover参数AFGLowPowerState/ResetHDA，解决睡眠关机时POP音和与Windows双系统的相互影响
  - 添加XFX Radeon RX5700 XT THICC II Ultra 8G，伪装为Radeon Pro W5700X ~~（显卡驱动后的启动变长，原因未知待优化）~~
  - macOS升级至10.15.4 19E287
- 2020/04/15
  - 定制声卡接口，屏蔽全部无用接口，IO面板Line Out/Mic In与前置面板HP Out/Mic In互为一组，前置面板接口插入时自动切换