/*
 * Component.h
 *
 *  Created on: 17 Jun 2019
 *      Author: administrator
 */

#ifndef COMPONENT_H_
#define COMPONENT_H_

#include "xbasic_types.h"
#include "xil_io.h"

template<int BaseAddress, int Control, int Status>
class Component {
public:
	Component() {}
	virtual ~Component() {}

	Xuint32 GetBaseAddress() const { return BaseAddress; }

	Xuint32 GetControl() const;
	void SetControl(Xuint32 control);

	Xuint32 GetStatus() const;
	void SetStatus(Xuint32 status);

	virtual bool GetEnabled() const = 0;
	virtual void SetEnabled(bool enable) = 0;

	virtual bool GetReset() const = 0;
	virtual void SetReset(bool reset) = 0;

	void Report() const;

protected:
	virtual void ReportHeader() const;
	virtual void ReportControlSettings() const;
	virtual void ReportStatusSettings() const;
	virtual void ReportCustomSettings() const {}
	virtual void ReportFooter() const;
};

template<int BaseAddress, int Control, int Status>
Xuint32 Component<BaseAddress, Control, Status>::GetControl() const
{
	return Xil_In32(BaseAddress + Control);
}

template<int BaseAddress, int Control, int Status>
void Component<BaseAddress, Control, Status>::SetControl(Xuint32 control)
{
	Xil_Out32(BaseAddress + Control, control);
}

template<int BaseAddress, int Control, int Status>
Xuint32 Component<BaseAddress, Control, Status>::GetStatus() const
{
	return Xil_In32(BaseAddress + Status);
}

template<int BaseAddress, int Control, int Status>
void Component<BaseAddress, Control, Status>::SetStatus(Xuint32 status)
{
	Xil_Out32(BaseAddress + Status, status);
}

template<int BaseAddress, int Control, int Status>
void Component<BaseAddress, Control, Status>::Report() const {

  Xuint32 reg_val;

  ReportHeader();

  reg_val = this->GetControl();
  xil_printf("Control : %8x\r\n", reg_val);
  ReportControlSettings();


  reg_val = this->GetStatus();
  xil_printf("Status: %08x \r\n", reg_val);
  ReportStatusSettings();

  ReportCustomSettings();

  ReportFooter();
}

template<int BaseAddress, int Control, int Status>
void Component<BaseAddress, Control, Status>::ReportHeader() const {

}

template<int BaseAddress, int Control, int Status>
void Component<BaseAddress, Control, Status>::ReportControlSettings() const {
	xil_printf("\tEnable Bit: %s\r\n", GetEnabled() ? "high" : "low");
	xil_printf("\tReset Bit: %1d\r\n", GetReset() ? "high" : "low");
}

template<int BaseAddress, int Control, int Status>
void Component<BaseAddress, Control, Status>::ReportStatusSettings() const {
}

template<int BaseAddress, int Control, int Status>
void Component<BaseAddress, Control, Status>::ReportFooter() const {

}
#endif /* COMPONENT_H_ */
