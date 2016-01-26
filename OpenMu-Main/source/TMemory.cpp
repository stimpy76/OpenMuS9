#include "stdafx.h"
#include "TMemory.h"
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------

DWORD WriteMemory(const LPVOID lpAddress, const LPVOID lpBuf, const UINT uSize)
{
    DWORD dwErrorCode   = 0;
    DWORD dwOldProtect  = 0;
	// ----
    int iRes = VirtualProtect(lpAddress, uSize, PAGE_EXECUTE_READWRITE, & dwOldProtect);
	// ----
    if( iRes == 0 )
    {
        dwErrorCode = GetLastError();
        return dwErrorCode;
    }
	// ----
    memcpy(lpAddress, lpBuf, uSize);
	// ----
    DWORD dwBytes   = 0;
	// ----
    iRes = VirtualProtect(lpAddress, uSize, dwOldProtect, & dwBytes);
	// ----
    if ( iRes == 0 )
    {
        dwErrorCode = GetLastError();
        return dwErrorCode;
    }
	// ----
    return 0x00;
}
//---------------------------------------------------------------------------

DWORD ReadMemory(const LPVOID lpAddress, LPVOID lpBuf, const UINT uSize)
{
    DWORD dwErrorCode   = 0;
    DWORD dwOldProtect  = 0;
	// ----
    int iRes = VirtualProtect(lpAddress, uSize, PAGE_EXECUTE_READWRITE, & dwOldProtect);
	// ----
    if ( iRes == 0 )
    {
        dwErrorCode = GetLastError();
        return dwErrorCode;
    }
	// ----
    memcpy(lpBuf, lpAddress, uSize);
	// ----
    DWORD dwBytes   = 0;
	// ----
    iRes = VirtualProtect(lpAddress, uSize, dwOldProtect, & dwBytes);
	// ----
    if ( iRes == 0 )
    {
        dwErrorCode = GetLastError();
        return dwErrorCode;
    }
	// ----
    return 0x00;
}
//---------------------------------------------------------------------------

DWORD SetByte(const LPVOID dwOffset, const BYTE btValue)
{
	return WriteMemory(dwOffset, (LPVOID) & btValue, sizeof(BYTE));
}
//---------------------------------------------------------------------------

DWORD GetByte(const LPVOID dwOffset, BYTE & btValue)
{
	return ReadMemory(dwOffset, (LPVOID) btValue, sizeof(BYTE));
}
//---------------------------------------------------------------------------

DWORD SetWord(const LPVOID dwOffset, const WORD wValue)
{
	return WriteMemory(dwOffset, (LPVOID) & wValue, sizeof(WORD));
}
//---------------------------------------------------------------------------

DWORD GetWord(const LPVOID dwOffset, WORD & wValue)
{
	return ReadMemory(dwOffset, (LPVOID) wValue, sizeof(WORD));
}
//---------------------------------------------------------------------------

DWORD SetDword(const LPVOID dwOffset, const DWORD dwValue)
{
	return WriteMemory(dwOffset, (LPVOID) & dwValue, sizeof(DWORD));
}
//---------------------------------------------------------------------------

DWORD GetDword(const LPVOID dwOffset, DWORD & dwValue)
{
	return ReadMemory(dwOffset, (LPVOID) dwValue, sizeof(DWORD));
}
//---------------------------------------------------------------------------

DWORD SetFloat(const LPVOID dwOffset, float fValue)
{
	return WriteMemory(dwOffset, & fValue, sizeof(float));
}
//---------------------------------------------------------------------------

DWORD GetFloat(const LPVOID dwOffset, float & fValue)
{
	return ReadMemory(dwOffset, & fValue, sizeof(float));
}
//---------------------------------------------------------------------------

DWORD SetDouble(const LPVOID dwOffset, double dValue)
{
	return WriteMemory(dwOffset, & dValue, sizeof(double));
}
//---------------------------------------------------------------------------

DWORD SetJmp(const LPVOID dwEnterFunction, const LPVOID dwJMPAddress)
{
	BYTE btBuf[5];
	DWORD dwShift	= (ULONG_PTR)dwJMPAddress - (ULONG_PTR)dwEnterFunction - 5;
	// ----
	btBuf[0]	= 0xE9;
	memcpy( (LPVOID) & btBuf[1], (LPVOID) & dwShift, sizeof(ULONG_PTR));
	// ----
	return WriteMemory(dwEnterFunction, (LPVOID) btBuf, sizeof(btBuf));
}
//---------------------------------------------------------------------------

DWORD SetJg(const LPVOID dwEnterFunction, const LPVOID dwJMPAddress)
{
	BYTE btBuf[6];
	DWORD dwShift	= (ULONG_PTR)dwJMPAddress - (ULONG_PTR)dwEnterFunction - 6;
	// ----
	btBuf[0]	= 0x0F;
	btBuf[1]	= 0x8F;
	memcpy( (LPVOID) & btBuf[2], (LPVOID) & dwShift, sizeof(ULONG_PTR));
	// ----
	return WriteMemory(dwEnterFunction, (LPVOID) btBuf, sizeof(btBuf));
}
//---------------------------------------------------------------------------

DWORD SetJa(const LPVOID dwEnterFunction, const LPVOID dwJMPAddress)
{
	BYTE btBuf[6];
	DWORD dwShift	= (ULONG_PTR)dwJMPAddress - (ULONG_PTR)dwEnterFunction - 6;
	// ----
	btBuf[0]	= 0x0F;
	btBuf[1]	= 0x87;
	memcpy( (LPVOID) & btBuf[2], (LPVOID) & dwShift, sizeof(ULONG_PTR));
	// ----
	return WriteMemory(dwEnterFunction, (LPVOID) btBuf, sizeof(btBuf));
}
//---------------------------------------------------------------------------

DWORD SetOp(const LPVOID dwEnterFunction, const LPVOID dwJMPAddress, const BYTE cmd)
{
	BYTE btBuf[5];
	DWORD dwShift	= (ULONG_PTR)dwJMPAddress - (ULONG_PTR)dwEnterFunction - 5;
	// ----
	btBuf[0]		= cmd;
	memcpy( (LPVOID) & btBuf[1], (LPVOID) & dwShift, sizeof(ULONG_PTR));
	// ----
	return WriteMemory(dwEnterFunction, (LPVOID) btBuf, sizeof(btBuf));
}
//---------------------------------------------------------------------------

DWORD SetRange(const LPVOID dwAddress, const USHORT wCount, const BYTE btValue)
{
	BYTE * lpBuf	= new BYTE[wCount];
	// ----
	memset(lpBuf, btValue, wCount);
	// ----
	return WriteMemory( dwAddress, (LPVOID) lpBuf, wCount);
}
//---------------------------------------------------------------------------

DWORD SetHook(const LPVOID dwMyFuncOffset, const LPVOID dwJmpOffset, const BYTE cmd)
{
	BYTE btBuf[5];
	// ----
	DWORD dwShift	= (ULONG_PTR)dwMyFuncOffset - ( (ULONG_PTR)dwJmpOffset + 5 );
	// ----
	btBuf[0] = cmd;
	// ----
	memcpy( (LPVOID) & btBuf[1], (LPVOID) & dwShift, sizeof(ULONG_PTR));
	// ----
	return WriteMemory(dwJmpOffset, (LPVOID) btBuf, sizeof(btBuf));
}
//---------------------------------------------------------------------------

void HookThis(DWORD dwMyFuncOffset,DWORD dwJmpOffset)
{
	*(DWORD*)(dwJmpOffset+1) = dwMyFuncOffset-(dwJmpOffset+5);
}
//---------------------------------------------------------------------------
void HookThisAsm(DWORD dwMyFuncOffset, DWORD dwJmpOffset)
{
	*(DWORD*)(dwJmpOffset + 1) = dwMyFuncOffset-(dwJmpOffset+5);
	*(BYTE*)(dwJmpOffset) = 0xE9;
}
//
void SetTestByte(DWORD dwOffset)
{
	const BYTE btValue = 0xB5;
	WriteMemory((LPVOID)(dwOffset+1), (LPVOID) & btValue, sizeof(BYTE));

	const BYTE btValue2 = 0x03;
	WriteMemory((LPVOID)(dwOffset+2), (LPVOID) & btValue2, sizeof(BYTE));
}

void SetTestByte2(DWORD dwOffset)
{
	const BYTE btValue = 0xB5;
	WriteMemory((LPVOID)(dwOffset+3), (LPVOID) & btValue, sizeof(BYTE));

	const BYTE btValue2 = 0x03;
	WriteMemory((LPVOID)(dwOffset+4), (LPVOID) & btValue2, sizeof(BYTE));
}

void SetTestByte3(DWORD dwOffset)
{
	const BYTE btValue = 0xB5;
	WriteMemory((LPVOID)(dwOffset+6), (LPVOID) & btValue, sizeof(BYTE));

	const BYTE btValue2 = 0x03;
	WriteMemory((LPVOID)(dwOffset+7), (LPVOID) & btValue2, sizeof(BYTE));
}

void SetByteArrary(DWORD offset,const BYTE btValue1,const BYTE btValue2,const BYTE btValue3,const BYTE btValue4,const BYTE btValue5,const BYTE btValue6,const BYTE btValue7,const BYTE btValue8,const BYTE btValue9,const BYTE btValue10,const BYTE btValue11,const BYTE btValue12,const BYTE btValue13,const BYTE btValue14,const BYTE btValue15,const BYTE btValue16)
{
	WriteMemory((LPVOID)(offset), (LPVOID) & btValue1, sizeof(BYTE));
	WriteMemory((LPVOID)(offset+1), (LPVOID) & btValue2, sizeof(BYTE));
	WriteMemory((LPVOID)(offset+2), (LPVOID) & btValue3, sizeof(BYTE));
	WriteMemory((LPVOID)(offset+3), (LPVOID) & btValue4, sizeof(BYTE));
	WriteMemory((LPVOID)(offset+4), (LPVOID) & btValue5, sizeof(BYTE));
	WriteMemory((LPVOID)(offset+5), (LPVOID) & btValue6, sizeof(BYTE));
	WriteMemory((LPVOID)(offset+6), (LPVOID) & btValue7, sizeof(BYTE));
	WriteMemory((LPVOID)(offset+7), (LPVOID) & btValue8, sizeof(BYTE));
	WriteMemory((LPVOID)(offset+8), (LPVOID) & btValue9, sizeof(BYTE));
	WriteMemory((LPVOID)(offset+9), (LPVOID) & btValue10, sizeof(BYTE));
	WriteMemory((LPVOID)(offset+10), (LPVOID) & btValue11, sizeof(BYTE));
	WriteMemory((LPVOID)(offset+11), (LPVOID) & btValue12, sizeof(BYTE));
	WriteMemory((LPVOID)(offset+12), (LPVOID) & btValue13, sizeof(BYTE));
	WriteMemory((LPVOID)(offset+13), (LPVOID) & btValue14, sizeof(BYTE));
	WriteMemory((LPVOID)(offset+14), (LPVOID) & btValue15, sizeof(BYTE));
	WriteMemory((LPVOID)(offset+15), (LPVOID) & btValue16, sizeof(BYTE));
}
//
void SetByte2(DWORD dwOffset, const BYTE btValue)
{
	WriteMemory((LPVOID)dwOffset, (LPVOID) & btValue, sizeof(BYTE));
}
//
void MsgBox(char *szlog, ...)
{
	char szBuffer[512]="";
	va_list pArguments;
	va_start(pArguments, szlog);
	vsprintf(szBuffer, szlog, pArguments);
	va_end(pArguments);
	MessageBox(NULL, szBuffer, "error", MB_OK|MB_APPLMODAL);
}