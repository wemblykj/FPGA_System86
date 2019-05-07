--------------------------------------------------------------------------
               1G bits DDR2 SDRAM 
               (64M words x 16bits)
--------------------------------------------------------------------------
Typ           : DDR2 SDRAM
Density       : 1G bits
Organization  : x16
Part Number   : -
Speed         : 800Mbps
Model Rev.    : 3
Date          : Feb.22,2010
Copyright     : Copyright 2010, Elpida Memory,Inc., All Rights Reserved
--------------------------------------------------------------------------
File Name(NC-Verilog)   : ede1116_8e_100222_nc.vp
File Name(VCS)          : ede1116_8e_100222_vc.vp
File Name(ModelSim)     : ede1116_8e_100222_ms.vp
Module Name   : ede1116
List of Port  : cas_n, ck, ck_n, cke, cs_n, ldm, odt, ras_n, udm, we_n, a, ba, ldqs, ldqs_n, udqs, udqs_n, dq
--------------------------------------------------------------------------
                Simulation Option
--------------------------------------------------------------------------
1.Power On Sequence Skip Option 
   By default, "Power on sequence (Initialization)" is required (checked).
   "Power on sequence" can be skipped by specifying the option "pwup_offÅg
        Command example;
              verilog  +define+pwup_off  your_system.v
2.Error Control   
    By default, simulation will be stopped at the first error detection. 
     (error=Timing Error or Illegal command)
     "$stop;" will be issued at the error, then user can control the simulation manually.
      User Can control the simulation by specifying the option "finish" or "proc".
      "finish" : Finish the simulation.(=execute "$finish;" instead of $stop;)
      "proc"  : Proceed the simulation through the end despite the error(s).
       Command example;
           verilog  +define+finish  your_system.v
           verilog  +define+proc    your_system.v
3.tREF test Skip Option
    By default, "tREF test" is required (checked).
   "tREF test" can be skipped by specifying the option "tref_skipÅg
        Command example;
              verilog  +define+tref_skip  your_system.v
--------------------------------------------------------------------------

Notes  :  Please transmit in ASCII mode between PC and UNIX.

--------------------------------------------------------------------------

Author  :   SYSTEM TECHNOLOGY Gr.

---------------------------------------------------------------------------

If you have any question, please contact: <info@elpida.com>  

---------------------------------------------------------------------------


LICENSE AGREEMENT   :


Ownership of Material 

Materials are copyrighted and are protected by worldwide copyright laws and treaty 
provisions.They may not be copied, reproduced, modified, published, uploaded, 
posted, transmitted,or distributed in any way, without Elpida Memory, Inc.'s 
("Elpida") prior written permission. Except as expressly provided herein, Elpida
and its suppliers do not grant any express or implied right to you under 
any patents, copyrights, trademarks, or trade secret information. Other rights
may be granted to you by Elpida in writing or incorporated elsewhere
in the Materials.


Single Copy License

The materials at this Site are owned and copyrighted by Elpida and any unauthorized
use of any materials at this Site may violate copyright, trademark, and other laws.
You may download one copy of the information or software ("Materials") found on this
site on a single computer for your personal, non-commercial internal use only unless
specifically licensed to do otherwise by Elpida in writing or as allowed by any 
license terms which accompany or are provided with individual Materials. This is a 
license, not a transfer of title, and is subject to the following restrictions:
you may not: 
(a) modify the Materials or use them for any commercial purpose, or any public display,
    performance, sale or rental;
(b) decompile, reverse engineer, or disassemble software Materials except and only
    to the extent permitted by applicable law;
(c) remove any copyright or other proprietary notices from the Materials;
(d) transfer the Materials to another person. 
You agree to prevent any unauthorized copying of the Materials.


Termination of License

Elpida may terminate this license at any time if you are in breach of the terms of 
this Agreement. Upon termination, you will immediately destroy the Materials.


Disclaimer

THE MATERIALS ARE PROVIDED "AS IS" WITHOUT ANY EXPRESS OR IMPLIED WARRANTY OF ANY KIND
INCLUDING WARRANTIES OF MERCHANTABILITY, NONINFRINGEMENT OF INTELLECTUAL PROPERTY,
OR FITNESS FOR ANY PARTICULAR PURPOSE. ELPIDA DOES NOT WARRANT THAT THE MATERIALS WILL
MEET YOUR REQUIREMENTS, OR THAT THE OPERATION OF THE MATERIALS WILL BE UNINTERRUPTED
OR ERROR-FREE. FURTHERMORE, ELPIDA DOES NOT MAKE ANY REPRESENTATIONS REGARDING
THE USE OR THE RESULTS OF THE USE OF THE MATERIALS IN TERMS OF ITS CORRECTNESS,
ACCURACY, RELIABILITY, OR OTHERWISE. THE ENTIRE RISK ARISING OUT OF USE OR 
PERFORMANCE OF THE MATERIALS REMAINS WITH YOU. IN NO EVENT SHALL ELPIDA OR ITS
SUPPLIERS BE LIABLE FOR ANY DIRECT, INDIRECT, CONSEQUENTIAL, INCIDENTAL, OR SPECIAL
DAMAGES WHATSOEVER (INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF PROFITS,
BUSINESS INTERRUPTION, LOSS OF INFORMATION) ARISING OUT OF THE USE OF OR INABILITY
TO USE THE MATERIALS, EVEN IF ELPIDA HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH
DAMAGES. BECAUSE SOME JURISDICTIONS PROHIBIT THE EXCLUSION OR LIMITATION OF 
LIABILITY FOR CONSEQUENTIAL OR INCIDENTAL DAMAGES, THE ABOVE LIMITATION MAY NOT
APPLY TO YOU. 

Elpida and its suppliers further do not warrant the accuracy or completeness of 
the information, text, graphics, links or other items contained within these materials.
Elpida may make changes to these materials, or to the products described therein, 
at any time without notice. Elpida makes no commitment to update the Materials. 
Please confirm that this is the latest version.

If you export the materials described in this document that are controlled
by Foreign Exchange and Foreign Trade Law of Japan, you must follow the necessary
procedures in accordance with the relevant laws and regulations of Japan. Also,
if you export the materials controlled by U.S.export control regulations,
or another country's export control laws or regulations, you must follow the 
necessary procedures in accordance with such laws or regulations.
If these materials are sold leased or transferred to a third party, or a third party
is granted license to use these products, that third party must be made aware 
that they are responsible for compliance with the relevant laws and regulations.

---------------------------------------------------------------------------

Revision History  :


Rev.       Date         Author        Changes
---------------------------------------------------------------------------
 0      Sep.01,2009     SYT           New Creation
 1      Sep.17,2009     SYT           DQS_N timing ,WRITE DQ Input
 2      Nov.10,2009     SYT           Main block Rev.35
 3      Feb.22,2010     SYT           Main block rev38







	
