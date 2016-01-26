#include "stdafx.h"
#include <process.h>
#include "Fix.h"
// -------------------------------------------------------------------------------


BOOL APIENTRY DllMain(HMODULE hModule, DWORD ul_reason_for_call, LPVOID lpReserved)
{
	switch(ul_reason_for_call)
	{
	case DLL_PROCESS_ATTACH:
		{
			FixList();
		}
		break;
	 case DLL_PROCESS_DETACH:
		//KeyboardSetHook(false);
		break;
	}
	return true;
}
// -------------------------------------------------------------------------------
