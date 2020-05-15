/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200326 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of SSDT-0-SataTabl.aml, Fri May 15 10:15:36 2020
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000378 (888)
 *     Revision         0x01
 *     Checksum         0x95
 *     OEM ID           "SataRe"
 *     OEM Table ID     "SataTabl"
 *     OEM Revision     0x00001000 (4096)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20160527 (538314023)
 */
DefinitionBlock ("", "SSDT", 1, "SataRe", "SataTabl", 0x00001000)
{
    External (_SB_.PCI0.SAT0, DeviceObj)
    External (_SB_.PCI0.SAT0.PRT0, DeviceObj)
    External (_SB_.PCI0.SAT0.PRT1, DeviceObj)
    External (_SB_.PCI0.SAT0.PRT2, DeviceObj)
    External (_SB_.PCI0.SAT0.PRT3, DeviceObj)
    External (_SB_.PCI0.SAT0.PRT4, DeviceObj)
    External (_SB_.PCI0.SAT0.PRT5, DeviceObj)

    Scope (\)
    {
        Name (STFE, Buffer (0x07)
        {
             0x10, 0x06, 0x00, 0x00, 0x00, 0x00, 0xEF         // .......
        })
        Name (STFD, Buffer (0x07)
        {
             0x90, 0x06, 0x00, 0x00, 0x00, 0x00, 0xEF         // .......
        })
        Name (FZTF, Buffer (0x07)
        {
             0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF5         // .......
        })
        Name (DCFL, Buffer (0x07)
        {
             0xC1, 0x00, 0x00, 0x00, 0x00, 0x00, 0xB1         // .......
        })
        Name (SCBF, Buffer (0x15){})
        Name (CMDC, Zero)
        Method (GTFB, 2, Serialized)
        {
            Local0 = (CMDC * 0x38)
            CreateField (SCBF, Local0, 0x38, CMDX)
            Local0 = (CMDC * 0x07)
            CreateByteField (SCBF, (Local0 + One), A001)
            CMDX = Arg0
            A001 = Arg1
            CMDC++
        }
    }

    Scope (\_SB.PCI0.SAT0)
    {
        Name (TMD0, Buffer (0x14){})
        CreateDWordField (TMD0, Zero, PIO0)
        CreateDWordField (TMD0, 0x04, DMA0)
        CreateDWordField (TMD0, 0x08, PIO1)
        CreateDWordField (TMD0, 0x0C, DMA1)
        CreateDWordField (TMD0, 0x10, CHNF)
        Method (_GTM, 0, NotSerialized)  // _GTM: Get Timing Mode
        {
            PIO0 = 0x78
            DMA0 = 0x14
            PIO1 = 0x78
            DMA1 = 0x14
            CHNF |= 0x05
            Return (TMD0) /* \_SB_.PCI0.SAT0.TMD0 */
        }

        Method (_STM, 3, NotSerialized)  // _STM: Set Timing Mode
        {
        }

        Scope (PRT0)
        {
            Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
            {
                CMDC = Zero
                If (Zero)
                {
                    GTFB (STFD, 0x06)
                }
                Else
                {
                    GTFB (STFE, 0x06)
                }

                GTFB (FZTF, Zero)
                GTFB (DCFL, Zero)
                Return (SCBF) /* \SCBF */
            }
        }

        Scope (PRT1)
        {
            Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
            {
                CMDC = Zero
                If (Zero)
                {
                    GTFB (STFD, 0x06)
                }
                Else
                {
                    GTFB (STFE, 0x06)
                }

                GTFB (FZTF, Zero)
                GTFB (DCFL, Zero)
                Return (SCBF) /* \SCBF */
            }
        }

        Scope (PRT2)
        {
            Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
            {
                CMDC = Zero
                If (Zero)
                {
                    GTFB (STFD, 0x06)
                }
                Else
                {
                    GTFB (STFE, 0x06)
                }

                GTFB (FZTF, Zero)
                GTFB (DCFL, Zero)
                Return (SCBF) /* \SCBF */
            }
        }

        Scope (PRT3)
        {
            Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
            {
                CMDC = Zero
                If (Zero)
                {
                    GTFB (STFD, 0x06)
                }
                Else
                {
                    GTFB (STFE, 0x06)
                }

                GTFB (FZTF, Zero)
                GTFB (DCFL, Zero)
                Return (SCBF) /* \SCBF */
            }
        }

        Scope (PRT4)
        {
            Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
            {
                CMDC = Zero
                If (Zero)
                {
                    GTFB (STFD, 0x06)
                }
                Else
                {
                    GTFB (STFE, 0x06)
                }

                GTFB (FZTF, Zero)
                GTFB (DCFL, Zero)
                Return (SCBF) /* \SCBF */
            }
        }

        Scope (PRT5)
        {
            Method (_GTF, 0, NotSerialized)  // _GTF: Get Task File
            {
                CMDC = Zero
                If (Zero)
                {
                    GTFB (STFD, 0x06)
                }
                Else
                {
                    GTFB (STFE, 0x06)
                }

                GTFB (FZTF, Zero)
                GTFB (DCFL, Zero)
                Return (SCBF) /* \SCBF */
            }
        }
    }
}

