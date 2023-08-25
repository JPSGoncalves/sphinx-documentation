Doing and Dones 
----------------


14/08/2023 --  : Trying to make Tezi work for BSP 6 IMXM modules 
    * DONE: Made SDP work with u-boot 2023.07 
    
    * DOING: Trying to make downstream u-boot (v2022.04 toradex, branch toradex_imx_lf_v2022.04) works with uuu, SDP Boot Rom Protocol and Fastboot Protocol over USB OTG port.
            * REMINDERS:
                 Look at NXP patches from UUU docs, event fastboot one. 
                 **DONE** Patches to look (repo uboot-imx, branch imx_v2017.03_4.9.123_imx8mm_ga from uuu docs): 
                    About Fastboot enable:
                        719651a MLK-18257-1 Enable fastboot support in qxp mek board **already applied on tdx branch**
                        d5226a3 MLK-18257-2: fix fastboot build warning **already applied on tdx branch**
                        219c989 MLK-18257-3 run fastboot if initramfs is in validate **already applied on tdx branch**
                        09b1876 MLK-18257-4 use another method check if need run bootcmd_mfg **already applied on tdx branch**
                        3b1fa9d MLK-18257-5 enhence fastboot uboot cmd **already applied on tdx branch**
                        ca96e0b MLK-18406 fastboot support all partition **already applied on tdx branch**
                    About uboot SDP enable:
                        192a26d MLK-18707-1: SDP: use CONFIG_SDP_LOADADDR as default load address **already applied on tdx branch**
                        9764fb2 MLK-18707-2 iMX8M enable fastboot as default **already applied on tdx branch**
                        db9a634 MLK-18862 imx8mm uuu can write emmc by fastboot **already applied on tdx branch**
    
               Patches from mainline to loook: 
                    14d3c8fd0a configs: verdin-imx8mm: Add bootaux command
                    b1030048c2 verdin-imx8mm: various config additions and improvements
                    559c5389c2 verdin-imx8mm: verdin-imx8mp: update env memory layout (again)
                    78f34793ed imx: imx8mm-beacon: Move Environment to eMMC partition 2
                    3a7943a90c imx: imx8mm-beacon: Enable USB booting via SDP
                    b6c8a28090 imx: imx8mm_beacon: Eliminate a few extras to free up SPL space
                    16d6457d84 verdin-imx8mm: verdin-imx8mp: drop obsolete net/phy configs
                    750d7ddf2c imx8mm_evk: Add Serial Download Protocol support
                    330fbafa09 imx8mm_evk: Add an entry for USB boot
                    60929b0506 ARM: dts: imx8m: imx8mm-mx8menlo: Enable SPL SDP support
                    f687c1ef4f ARM: imx8m: verdin-imx8mm: Drop bogus content from spl_board_init()
                    078dfef931 usb: ehci-mx6: Enable OTG detection on imx8mm and imx8mn
                    7f23470885 usb: gadget: f_sdp: Add missing spl_board_prepare_for_boot() call
                    0929b0506 ARM: dts: imx8m: imx8mm-mx8menlo: Enable SPL SDP support
                    2c72ead738 usb: gadget: f_sdp: Allow SPL to load and boot FIT via SDP
                    940db3b410 mx6sabreauto: Enable SPL SDP support
                    52084bfc80 colibri_imx6: use SDP if USB serial downloader has been used
                    15834c6383 apalis_imx6: use SDP if USB serial downloader has been used
                    bbbb50f9fd imx: i.mx6q: imx6q_logic: Migrate to SPL and enable SDP
                    0093b3fcd8 mx6memcal: enable SDP support
                    407e3844fc spl: sdp: Add CONFIG_SPL_SDP_USB_DEV for USB device
                    d74fcee2d8 spl: Add SPL_SERIAL as requirement for SDP_USB_SDP
                    46307ef01e board: colibri_imx7: use SDP if USB serial downloader has been used
                    078dfef931 usb: ehci-mx6: Enable OTG detection on imx8mm and imx8mn

                    Interesting
                    94eb4f81f2 MLK-21846-2 imx8mq_evk: Enable USB SDP in SPL
                    3a7943a90c imx: imx8mm-beacon: Enable USB booting via SDP
                    60929b0506 ARM: dts: imx8m: imx8mm-mx8menlo: Enable SPL SDP support
                    1206ee7161 LFU-464-15 clk: imx8mm/imx8mp: Update clock tree
                    330fbafa09 imx8mm_evk: Add an entry for USB boot
                    750d7ddf2c imx8mm_evk: Add Serial Download Protocol support


