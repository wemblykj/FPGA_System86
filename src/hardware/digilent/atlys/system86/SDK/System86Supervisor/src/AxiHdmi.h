/*
 * AxiHdmi.h
 *
 *  Created on: 19 Jun 2019
 *      Author: administrator
 */

#ifndef AXIHDMI_H_
#define AXIHDMI_H_

#include "AxiBase.h"

#define DISP_IN_RESOLUTION             0x000    /**< Control (R/W) */
#define DISP_OUT_RESOLUTION            0x004    /**< Status (R/W) */

template<int BaseAddress>
class AxiHdmi: public AxiBase<BaseAddress> {
public:
	AxiHdmi() {};
	virtual ~AxiHdmi() {};

	void SetInputResolution(Xuint32 width, Xuint32 height);
	void SetOutputResolution(Xuint32 width, Xuint32 height);
};

template<int BaseAddress>
void AxiHdmi<BaseAddress>::SetInputResolution(Xuint32 width, Xuint32 height)
{
	this->template SetRegister(DISP_IN_RESOLUTION, width*height);
}

template<int BaseAddress>
void AxiHdmi<BaseAddress>::SetOutputResolution(Xuint32 width, Xuint32 height)
{
	this->template SetRegister(DISP_OUT_RESOLUTION, width*height);
}

#endif /* AXIHDMI_H_ */
