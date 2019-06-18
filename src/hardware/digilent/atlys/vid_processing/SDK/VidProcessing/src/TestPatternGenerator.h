/*
 * TestPatternGenerator.h
 *
 *  Created on: 17 Jun 2019
 *      Author: administrator
 */

#ifndef TESTPATTERNGENERATOR_H_
#define TESTPATTERNGENERATOR_H_

#include "Component.h"

#include "tpg.h"

template<int BaseAddress>
class TestPatternGenerator : public Component<BaseAddress, TPG_CONTROL, TPG_STATUS> {
public:
	TestPatternGenerator() : m_dirty(true) {}
	virtual ~TestPatternGenerator() {}

	bool GetEnabled() const;
	void SetEnabled(bool enable);

	bool GetReset() const;
	void SetReset(bool reset);

	// TPG specific
	void FSyncReset();

	void SetPattern(Xuint32 pattern);
	void SetResolution(Xuint32 width, Xuint32 height);
	void RegisterUpdate();

protected:
	virtual void ReportHeader() const;
	virtual void ReportControlSettings() const;
    virtual void ReportStatusSettings() const;
	virtual void ReportCustomSettings() const;

private:
	bool m_dirty;
};

#include "tpg.h"

template<int BaseAddress>
bool TestPatternGenerator<BaseAddress>::GetEnabled() const
{
	const Xuint32 control = this->GetControl();
	return (control & TPG_CTL_EN_MASK) == TPG_CTL_EN_MASK;
}

template<int BaseAddress>
void TestPatternGenerator<BaseAddress>::SetEnabled(bool enable)
{
	Xuint32 control = this->GetControl();
	if (enable)
	{
		RegisterUpdate();
		control &= ~TPG_CTL_EN_MASK;
	}
	else
	{
		control |= TPG_CTL_EN_MASK;
	}

	this->SetControl(control);
}

template<int BaseAddress>
bool TestPatternGenerator<BaseAddress>::GetReset() const
{
	Xuint32 control = this->GetControl();
	return (control & TPG_RST_RESET) == TPG_RST_RESET;
}

template<int BaseAddress>
void TestPatternGenerator<BaseAddress>::SetReset(bool reset)
{
	Xuint32 control = this->GetControl();
	if (reset)
	{
		control &= ~TPG_RST_RESET;
	}
	else
	{
		control |= TPG_RST_RESET;
	}

	this->SetControl(control);
}

template<int BaseAddress>
void TestPatternGenerator<BaseAddress>::FSyncReset()
{
	Xuint32 control = this->GetControl();
	control |= TPG_RST_AUTORESET;

	this->SetControl(control);
}

template<int BaseAddress>
void TestPatternGenerator<BaseAddress>::SetPattern(Xuint32 pattern)
{
	TPG_WriteReg(BaseAddress, TPG_PATTERN_CONTROL, pattern);
	m_dirty = true;
}

template<int BaseAddress>
void TestPatternGenerator<BaseAddress>::SetResolution(Xuint32 width, Xuint32 height)
{
	TPG_WriteReg(BaseAddress, TPG_ACTIVE_SIZE, width*height);
	m_dirty = true;
}

template<int BaseAddress>
void TestPatternGenerator<BaseAddress>::RegisterUpdate()
{
	if (m_dirty)
	{
		Xuint32 control = this->GetControl();
		this->SetControl(control | TPG_CTL_RUE_MASK);
		m_dirty = false;
	}
}

template<int BaseAddress>
void TestPatternGenerator<BaseAddress>::ReportHeader() const {
	xil_printf("Test Pattern Generator Core Configuration:\r\n");
}

template<int BaseAddress>
void TestPatternGenerator<BaseAddress>::ReportControlSettings() const {

  Xuint32 reg_val;

  reg_val = this->GetControl();
  xil_printf("\tRegister Update Bit: %1d\r\n", (reg_val & TPG_CTL_RUE_MASK) ? "high" : "low");
}

template<int BaseAddress>
void TestPatternGenerator<BaseAddress>::ReportStatusSettings() const {

  //Xuint32 reg_val;

  //reg_val = this->Status();
  //xil_printf("\tRegister Update Bit: %1d\r\n", (reg_val & TPG_CTL_RUE_MASK) ? "high" : "low");
}

template<int BaseAddress>
void TestPatternGenerator<BaseAddress>::ReportCustomSettings() const {

  Xuint32 reg_val;

  xil_printf(" Core Version:   %1d.%1d\r\n", TPG_ReadReg(BaseAddress, TPG_VERSION));
  reg_val = TPG_ReadReg(BaseAddress, TPG_IRQ_EN );
  xil_printf("TPG_IRQ_EN : %8x\r\n", reg_val);
  reg_val = (TPG_ReadReg(BaseAddress, TPG_ACTIVE_SIZE ) && 0x1FFF);
  xil_printf("Active Rows      : %8d\r\n", reg_val);
  reg_val = (TPG_ReadReg(BaseAddress, TPG_ACTIVE_SIZE) >> 16);
  xil_printf("Active Columns      : %8d\r\n", reg_val);
}

#endif /* TESTPATTERNGENERATOR_H_ */
