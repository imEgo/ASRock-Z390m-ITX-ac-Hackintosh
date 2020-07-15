## 2020/07/16

### Changed (1 changes)
- macOS升级至10.15.6 19G73


## 2020/06/20

### Changed (5 changes)

- 更新CLOVER至5119版本
- 更新Kexts至最新版本
- 更换无线网卡为DW1820A（本来DW1820A换到XPS13 9360使用还挺完美，但是更新至10.15后不能启用ASPM，导致待机功耗飙升，并且也遇到了系统崩溃后网卡不能使用的问题，暂时将DW1820A换回，后续考虑更换为BCM94360CS2）
- 更换CLOVER主题
- 更新BIOS选项设置，PCIE ASPM可选择性开启，开启后节能效果更好

### Removed (1 changes)
- 移除RadeonBoost.kext（使用方法参考[此说明](Resources/GPU/README.md)）


## 2020/06/02

### Changed (1 changes)
- macOS升级至10.15.5 19F101


## 2020/06/01

### Changed (1 changes)
- macOS升级至10.15.5 19F96
- 精简了CLOVER的配置文件
- 更新了SSDT文件，添加_OSI("Darwin")，更容易迁移到OpenCore引导（笔记本更换了OpenCore没有什么特别明显的优势，双系统还是CLOVER更友好）

### Fixed (1 changes)
- 修复SSDT Error


## 2020/05/14

### Changed (2 changes)
- 更换无线网卡为DW1560，DW1820A在系统崩溃后会有时网卡无法驱动（Windows亦如此，需要冷启动才能恢复），不推荐该主板使用DW1820A
- PP_PhmSoftPowerPlayTable修改最低风扇转速及起停温度

### Fixed (1 changes)
- 修复之前部分SSDT错误参数，添加CPU Plugin-Type改为SSDT注入


## 2020/05/05

### Added (1 changes)
- 使用kext注入XFX Radeon RX5700 XT THICC II Ultra定制PP_PhmSoftPowerPlayTable

### Changed (3 changes)
- 精简Clover配置
- 升级kexts


## 2020/04/28

### Changed (2 changes)
- 完善FileVault支持（如果开启的话，修改Clover的隐藏启动项，使用Preboot启动）

### Fixed (2 changes)
- 修复启动时间过长问题（修改核显ID屏蔽输出接口）
- 修复AppleTV+的DRM视频播放问题
- 修改CPU显示类型，修改前关于里显示为i7，改为i9


## 2020/04/27

### Added (1 changes)
- 添加CPUFriend及i9-9900es的配置

### Changed (3 changes)
- Clover升级至r5114
- 隐藏Clover启动时的Preboot及Recovery选项


## 2020/04/18

### Added (1 changes)
- 添加XFX Radeon RX5700 XT THICC II Ultra 8G，伪装为Radeon Pro W5700X ~~（显卡驱动后的启动变长，原因未知待优化）~~

### Changed (3 changes)
- BIOS升级至4.30
- macOS升级至10.15.4 19E287

### Fixed (1 changes)
- 添加Clover参数AFGLowPowerState/ResetHDA，解决睡眠关机时POP音和与Windows双系统的相互影响


## 2020/04/15

### Fixed (1 changes)
- 定制声卡接口，屏蔽全部无用接口，IO面板Line Out/Mic In与前置面板HP Out/Mic In互为一组，前置面板接口插入时自动切换