# ASRock Z390m-ITX/ac Hackintosh

默认配置为核显+免驱独立显卡配置，仅核显配置参见[核显配置](#仅核显配置无独立显卡)章节，无核显配置建议更换机型为MacPro7,1自行适配


## 硬件配置
- Intel Core i9-9900es(QQZ5) 2.60GHz
- ASRock Z390m-ITX/ac
- Intel UHD Graphics 630
- XFX Radeon RX5700 XT THICC II Ultra 8G
- Kingston Fury DDR4 2400MHz 8G * 2 (Overclock 3600MHz)
- Samsung SM951 SSD 512GB NVMe PCIe M.2
- WD Blue HDD 3TB SATA
- Dell DW1820A WiFi + BT
- Intel I219V + I211AT
- Realtek ALC892


## 软件版本
- BIOS 4.30 (替换98版本06EC微码，非ES版CPU无需替换)
- macOS Big Sur 11.3.1 20E241
- OpenCore 0.6.9


## 工作正常
- Intel UHD Graphics 630
- XFX Radeon RX5700 XT THICC II Ultra 8G
- Intel I219V + Intel I211AT
- Dell DW1820A WiFi + BT
- USB（IO面板保留TypeC接口 + 屏蔽2个USB3.0接口，前置面板保留2个USB3.0接口）
- 声卡
- NVRAM
- 睡眠唤醒
- AirDrop
- iMessage/FaceTime
- AppleTV DRM（Big Sur暂时无法使用，Catalina上正常，对此功能有需求暂时不要升级至Big Sur）


## 工作异常
- 暂无


## TODO
- 随航功能由于没有设备暂时无法测试


## 使用说明

### 补全SMBIOS

#### MacInfoPkg (Windows/Linux/macOS)
- 下载对应平台的[MacInfoPkg](https://github.com/acidanthera/MacInfoPkg/releases)
- 执行```macserial -m iMac19,1```，输出的格式为```SerialNumber | BoardSerialNumber```
- 生成```SystemUUID```，[生成工具](https://www.uuidgenerator.net/version4)
- 生成```ROM```，可以使用网卡MAC或复制SmUUID前6字节（e.g. ```EFD18768C3AE```），并将6字节HEX Binary转换成Base64编码，[转换工具](https://cryptii.com/pipes/binary-to-base64)
- 编辑config.plist
  - 替换```PlatformInfo```下```Generic``` -> ```SystemSerialNumber```为第一步生成的```SerialNumber```
  - 替换```PlatformInfo```下```Generic``` -> ```MLB```为第一步生成的```BoardSerialNumber```
  - 替换```PlatformInfo```下```Generic``` -> ```SystemUUID```为第二步生成的```SystemUUID```
  - 替换```PlatformInfo```下```Generic``` -> ```ROM```为第三步生成的```ROM```

### 修改BIOS设置
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
    - Primary Graphics Adapter -> PCI Express
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

### 更换无线网卡
- 主板自带Intel无线网卡可以直接更换为半高双天线NGFF接口无线网卡，例如DW1560、DW1820A、BCM94360NG等，BCM94360CS2也可以通过转接卡安装但是屏蔽罩上盖需要移除
- 非DW1820A需删除config.plist中，```DeviceProperties``` -> ```Add``` -> ```PciRoot(0x0)/Pci(0x1C,0x6)/Pci(0x0,0x0)```下的全部注入信息

### 修改CPU类型
- 如```关于本机```中无法正确显示CPU类型，则需要修改config.plist的```PlatformInfo``` -> ```Generic``` -> ```ProcessorType```字段，对应列表如下
  ```
  酷睿i3
  2309 (0x0905, 待确认)

  酷睿i5
  1541 (0x0605)

  酷睿i7
  1797 (0x0705)

  酷睿i9
  4101 (0x1005)
  ```

### 定制CPUFriend
- [参考文档](Resources/CPU/README.md)

### 定制显卡

#### 搭配AMD RX5700XT
- AMD RX5700XT注入信息，[参考文档](Resources/GPU/README.md)

#### 仅核显配置（无独立显卡）
- 使用```EFI/OC/config-IGPU.plist```替换```EFI/OC/config.plist```


### 定制USB接口
- 修改config.plist的```Kernel``` -> ```Add``` -> ```USBPorts.kext```的```Enabled```为```false```
- 修改config.plist的```Kernel``` -> ```Quirks``` -> ```XhciPortLimit```为```true```
- 重启系统，使用```Hackintool```，对照[参考文档](Resources/USB/README.md)的接口映射关系进行修改，将生成的```USBPorts.kext```替换至```EFI/OC/Kexts```
- 将前2步的修改恢复修改前，重启系统

### OpenCore图形引导与启动声音
- 下载[OcBinaryData](https://github.com/acidanthera/OcBinaryData/archive/master.zip)
- 复制```OcBinaryData/Resources```的```Font``` & ```Image```及```Label```目录至```EFI/OC/Resources```
- 修改config.plist的```Misc``` -> ```Boot``` -> ```PickerMode```为```External```
- 复制```OcBinaryData/Resources/Audio```的```OCEFIAudio_VoiceOver_Boot.wav```文件至```EFI/OC/Resources/Audio```
- 修改config.plist的```UEFI``` -> ```Audio``` -> ```PlayChime```为```true```
- 以上设置均参考[此文档](https://dortania.github.io/OpenCore-Post-Install/cosmetic/gui.html)

### 禁用SIP
- 修改```NVRAM``` -> ```Add``` -> ```7C436110-AB2A-4BBB-A880-FE41995C9F82``` -> ```csr-active-config```为如下值：
  ```
  00000000 - 启用SIP (0x0)
  03000000 - 禁用kext签名 (0x1) 与 文件系统保护 (0x2)
  FF030000 - 禁用全部 macOS High Sierra (0x3ff)
  FF070000 - 禁用全部 macOS Mojave|Catalina (0x7ff)
  FF0F0000 - 禁用全部 macOS Big Sur (0xfff)
  ```
[参考文档](https://dortania.github.io/OpenCore-Install-Guide/troubleshooting/extended/post-issues.html#disabling-sip)


## 更新
[更新日志](CHANGELOG.md)