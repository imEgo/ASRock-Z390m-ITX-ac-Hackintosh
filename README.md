# ASRock Z390m-ITX/ac Hackintosh

master分支为核显+免驱独立显卡配置，仅核显配置使用[igpu-only](https://github.com/imEgo/ASRock-Z390m-ITX-ac-Hackintosh/tree/igpu-only)分支，无核显配置建议更换机型为MacPro7,1自行适配

## 硬件配置
- Intel Core i9-9900es(QQZ5) 2.60GHz
- ASRock Z390m-ITX/ac
- Intel UHD Graphics 630
- XFX Radeon RX5700 XT THICC II Ultra 8G
- Kingston Fury DDR4 2400MHz 8G * 2 (Overclock 3600MHz)
- Samsung SM951 SSD 512GB NVMe PCIe M.2
- WD Blue HDD 3TB SATA
- Dell DW820A WiFi + BT
- Intel I219V + I211AT
- Realtek ALC892


## 软件版本
- BIOS 4.30 (替换98版本06EC微码，非ES版CPU无需替换)
- macOS 10.15.5 19F101
- Clover r5119


## 工作正常
- Intel UHD Graphics 630
- XFX Radeon RX5700 XT THICC II Ultra 8G
- Intel I219V + Intel I211AT
- Dell DW820A WiFi + BT
- USB（IO面板保留TypeC接口 + 屏蔽2个USB3.0接口，前置面板保留2个USB3.0接口）
- 声卡
- NVRAM
- 睡眠唤醒
- AirDrop
- iMessage/FaceTime
- AppleTV DRM


## 工作异常
- 暂无


## TODO
- 随航功能由于没有设备暂时无法测试


## 使用说明

### 补全SMBIOS

#### Clover Configurator (macOS)
- 使用Clover Configurator打开config.plist
- 机型设置 (SMBIOS)
  - System
    - 序列号 (Serial Number) -> 生成新的 (Generate New)
    - SmUUID -> 生成新的 (Generate New)
- 变量设置 (Rt Variables)
  - ROM -> 生成 (Generate)

#### MacSerial (Windows/Linux/macOS)
- 执行```macserial -m iMac19,1```，输出的格式为```SerialNumber | BoardSerialNumber```
- 生成SmUUID，[生成工具](https://www.uuidgenerator.net/version4)
- 生成ROM，可以使用网卡MAC或复制SmUUID前6字节（e.g. ```EFD18768C3AE```），并将6字节Binary转换成Base64编码，[转换工具](https://cryptii.com/pipes/binary-to-base64)
- 编辑config.plist替换RtVariables -> ROM及SMBIOS -> BoardSerialNumber/SerialNumber/SmUUID

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
- 非DW1820A需删除config.plist中，Devices -> Properties -> PciRoot(0x0)/Pci(0x1C,0x6)/Pci(0x0,0x0)的全部注入信息

### 修改CPU类型
- 删除config.plist的CPU -> Type字段，重启后如果关于本机不能正常识别CPU类型，则需要注入正确的CPU Type
- 修改config.plist的CPU -> Type字段，对应列表如下
  ```
  酷睿i3
  0x0309

  酷睿i5
  0x0605、0x0601、0x0407

  酷睿i7
  0x0705、0x0701、0x0507

  酷睿i9
  0x1005
  ```

### 定制显卡
- AMD RX5700XT注入信息，[参考文档](Resources/GPU/README.md)


## 更新
[更新日志](CHANGELOG.md)