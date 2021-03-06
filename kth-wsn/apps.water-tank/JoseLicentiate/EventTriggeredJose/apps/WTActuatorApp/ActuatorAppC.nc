/*
 * Copyright (c) 2011, KTH Royal Institute of Technology
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 *  - Redistributions of source code must retain the above copyright notice, this list
 * 	  of conditions and the following disclaimer.
 *
 * 	- Redistributions in binary form must reproduce the above copyright notice, this
 *    list of conditions and the following disclaimer in the documentation and/or other
 *	  materials provided with the distribution.
 *
 * 	- Neither the name of the KTH Royal Institute of Technology nor the names of its
 *    contributors may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
 * OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY
 * OF SUCH DAMAGE.
 *
 */
/**
 * @author Joao Faria <jfff@kth.se>
 * @author Aitor Hernandez <aitorhh@kth.se>
 * 
 * @version  $Revision: 1.2 Date: 2011/04/21 $ 
 */
#include "Msp430Adc12.h"
#include <Timer.h>


configuration ActuatorAppC {
}
implementation
{
  //components implemented
  components MainC,  
    LedsC, ActuatorC, Ieee802154BeaconEnabledC as MAC;
  ActuatorC -> MainC.Boot;
  ActuatorC.Leds -> LedsC;
  
  ActuatorC.MLME_SCAN -> MAC;
  ActuatorC.MLME_SYNC -> MAC;
  ActuatorC.MLME_BEACON_NOTIFY -> MAC;
  ActuatorC.MLME_SYNC_LOSS -> MAC;
  ActuatorC.MCPS_DATA -> MAC;
  ActuatorC.MLME_GTS -> MAC;
  ActuatorC.Frame -> MAC;
  ActuatorC.BeaconFrame -> MAC;
  ActuatorC.GtsUtility -> MAC;
  ActuatorC.Packet -> MAC;

  ActuatorC.MLME_RESET -> MAC;
  ActuatorC.MLME_SET -> MAC;
  ActuatorC.MLME_GET -> MAC;
  
	components HplMsp430GeneralIOC;
	components new Msp430GpioC() as ADC0;
	ADC0 -> HplMsp430GeneralIOC.Port60;
	ActuatorC.ADC0 -> ADC0;

	components new Msp430GpioC() as ADC1;
	ADC1 -> HplMsp430GeneralIOC.Port61;
	ActuatorC.ADC1 -> ADC1;
	components PrintfC;
	components SerialStartC;

}
