#include "stdafx.h"
#include "Fix.h"
#include "TMemory.h"



char ConnectIP[28];

void gServerConnectionFix();

void gServerConnectionFix()
{
	//char ConnectIP[] = "127.0.0.1";


	//char ConnectIP[28];
    GetPrivateProfileStringA("LOGIN", "ConnectAddress", "127.0.0.1", ConnectIP, 28, ".\\config.ini");


	char *MainAddr_Eng = (char*)(0x011AFAF2);
	memset(MainAddr_Eng,0,28);
	//memcpy(MainAddr_Eng,"127.0.0.1",13);
	memcpy(MainAddr_Eng,ConnectIP,strlen(ConnectIP));
	
	char MainVersion[6] = "22345";
	char *Version   = (char*)(0x011B0F1A+6);
	memset(Version,0,6);
	memcpy(Version,MainVersion,strlen(MainVersion));


	char MainSerial[17] = "xxxxxxxxxxxxxxxx";
	char *SERIAL   = (char*)(0x011B0F2A-2);
	memset(SERIAL,0,17);
	memcpy(SERIAL,MainSerial,strlen(MainSerial));
	//
	SetByte((LPVOID)(0x00FE6910+4),0xFF);	
	SetByte((LPVOID)(0x00FE6910+5),0x15);	
	SetByte((LPVOID)(0x00FE6910+6),0x90);	
	SetByte((LPVOID)(0x00FE6910+7),0x92);	
	SetByte((LPVOID)(0x00FE6910+8),0x01);	
	SetByte((LPVOID)(0x00FE6910+8),0x01);	

}

void FixList()
{
	gServerConnectionFix();
	
}