/*
 * AxiBase.h
 *
 *  Created on: 17 Jun 2019
 *      Author: administrator
 */

#ifndef AXIBASE_H_
#define AXIBASE_H_

#include "xbasic_types.h"
#include "xil_io.h"

template<int BaseAddress>
class AxiBase {
public:
	AxiBase() {}
	virtual ~AxiBase() {}

	Xuint32 GetBaseAddress() const { return BaseAddress; }
	Xuint32 GetRegister(Xuint32 offset) const;
	void SetRegister(Xuint32 offset, Xuint32 value);

	template<int Offset>
	Xuint32 GetRegister() const;

	template<int Offset>
	void SetRegister(Xuint32 value);

	void Dump() const;

protected:
	virtual void DumpHeader() const;
	virtual void DumpBody() const;
	virtual void DumpFooter() const;
};

template<int BaseAddress>
Xuint32 AxiBase<BaseAddress>::GetRegister(Xuint32 offset) const
{
	return Xil_In32(BaseAddress + offset);
}

template<int BaseAddress>
void AxiBase<BaseAddress>::SetRegister(Xuint32 offset, Xuint32 value)
{
	Xil_Out32(BaseAddress + offset, value);
}

template<int BaseAddress>
template<int Offset>
Xuint32 AxiBase<BaseAddress>::GetRegister() const
{
	return Xil_In32(BaseAddress + Offset);
}

template<int BaseAddress>
template<int Offset>
void AxiBase<BaseAddress>::SetRegister(Xuint32 value)
{
	Xil_Out32(BaseAddress + Offset, value);
}

template<int BaseAddress>
void AxiBase<BaseAddress>::Dump() const {
  DumpHeader();
  DumpBody();
  DumpFooter();
}

template<int BaseAddress>
void AxiBase<BaseAddress>::DumpHeader() const {

}

template<int BaseAddress>
void AxiBase<BaseAddress>::DumpBody() const {
	xil_printf("BaseAddress: %1d\r\n", BaseAddress);
}

template<int BaseAddress>
void AxiBase<BaseAddress>::DumpFooter() const {

}
#endif /* AXIBASE_H_ */