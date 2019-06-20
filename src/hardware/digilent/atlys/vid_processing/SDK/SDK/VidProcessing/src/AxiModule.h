/*
 * AxiModule.h
 *
 *  Created on: 17 Jun 2019
 *      Author: administrator
 */

#ifndef AXIMODULE_H_
#define AXIMODULE_H_

#include "AxiBase.h"

template<int BaseAddress, int Control, int Status>
class AxiModule : public AxiBase<BaseAddress> {
public:
	AxiModule() {}
	virtual ~AxiModule() {}

	Xuint32 GetControl() const;
	void SetControl(Xuint32 control);

	Xuint32 GetStatus() const;
	void SetStatus(Xuint32 status);

	virtual bool GetEnabled() const = 0;
	virtual void SetEnabled(bool enable) = 0;

	virtual bool GetReset() const = 0;
	virtual void SetReset(bool reset) = 0;

protected:
	virtual void DumpBody() const;
	virtual void DumpControlSettings() const;
	virtual void DumpStatusSettings() const;
	virtual void DumpCustomSettings() const {}
};

template<int BaseAddress, int Control, int Status>
Xuint32 AxiModule<BaseAddress, Control, Status>::GetControl() const
{
	return this->template GetRegister<Control>();
}

template<int BaseAddress, int Control, int Status>
void AxiModule<BaseAddress, Control, Status>::SetControl(Xuint32 control)
{
	this->template SetRegister<Control>(control);
}

template<int BaseAddress, int Control, int Status>
Xuint32 AxiModule<BaseAddress, Control, Status>::GetStatus() const
{
	return 0; //this->GetRegister<Status>();
}

template<int BaseAddress, int Control, int Status>
void AxiModule<BaseAddress, Control, Status>::SetStatus(Xuint32 status)
{
	this->SetRegister<Status>(status);
}

template<int BaseAddress, int Control, int Status>
void AxiModule<BaseAddress, Control, Status>::DumpBody() const {

  Xuint32 reg_val;

  AxiBase<BaseAddress>::DumpBody();

  reg_val = this->GetControl();
  xil_printf("Control : %8x\r\n", reg_val);
  DumpControlSettings();

  reg_val = this->GetStatus();
  xil_printf("Status: %08x \r\n", reg_val);
  DumpStatusSettings();

  DumpCustomSettings();
}

template<int BaseAddress, int Control, int Status>
void AxiModule<BaseAddress, Control, Status>::DumpControlSettings() const {
	xil_printf("\tEnable Bit: %s\r\n", GetEnabled() ? "high" : "low");
	xil_printf("\tReset Bit: %s\r\n", GetReset() ? "high" : "low");
}

template<int BaseAddress, int Control, int Status>
void AxiModule<BaseAddress, Control, Status>::DumpStatusSettings() const {
}

#endif /* AXIMODULE_H_ */