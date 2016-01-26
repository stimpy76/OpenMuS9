#pragma once
// ----------------------------------------------------------------------------------------------

#include <windows.h>
// ----------------------------------------------------------------------------------------------

DWORD WriteMemory(const LPVOID lpAddress, const LPVOID lpBuf, const UINT uSize);
DWORD ReadMemory(const LPVOID lpAddress, LPVOID lpBuf, const UINT uSize);
DWORD SetByte(const LPVOID dwOffset, const BYTE btValue);
DWORD GetByte(const LPVOID dwOffset, BYTE & btValue);
DWORD SetWord(const LPVOID dwOffset, const WORD wValue);
DWORD GetWord(const LPVOID dwOffset, WORD & wValue);
DWORD SetDword(const LPVOID dwOffset, const DWORD dwValue);
DWORD GetDword(const LPVOID dwOffset, DWORD & dwValue);
DWORD SetFloat(const LPVOID dwOffset, const float fValue);
DWORD GetFloat(const LPVOID dwOffset, float & fValue);
DWORD SetDouble(const LPVOID dwOffset, double dValue);
DWORD SetJg(const LPVOID dwEnterFunction, const LPVOID dwJMPAddress);
DWORD SetJa(const LPVOID dwEnterFunction, const LPVOID dwJMPAddress);
DWORD SetOp(const LPVOID dwEnterFunction, const LPVOID dwJMPAddress, BYTE cmd);
DWORD SetRange(const LPVOID dwAddress, const USHORT wCount, const BYTE btValue);
// ----------------------------------------------------------------------------------------------
DWORD SetJmp(const LPVOID dwEnterFunction, const LPVOID dwJMPAddress);
void SetTestByte(DWORD dwOffset);
void SetTestByte2(DWORD dwOffset);
void SetTestByte3(DWORD dwOffset);
void SetByte2(DWORD dwOffset, const BYTE btValue);
void HookThisAsm(DWORD dwMyFuncOffset, DWORD dwJmpOffset);
void MsgBox(char *szlog, ...);
void SetByteArrary(DWORD offset,const BYTE btValue1,const BYTE btValue2,const BYTE btValue3,const BYTE btValue4,const BYTE btValue5,const BYTE btValue6,const BYTE btValue7,const BYTE btValue8,const BYTE btValue9,const BYTE btValue10,const BYTE btValue11,const BYTE btValue12,const BYTE btValue13,const BYTE btValue14,const BYTE btValue15,const BYTE btValue16);

