/*
 * main.d
 *
 * This module contains the boot and initialization logic
 * for an architecture
 *
 */

module kernel.arch.x86_64.main;

// import normal architecture dependencies
import kernel.arch.x86_64.core.gdt;
import kernel.arch.x86_64.core.tss;
import kernel.arch.x86_64.core.idt;

// To return error values
import kernel.core.error;
import kernel.core.log;

// We need some values from the linker script
import kernel.arch.x86_64.linker;

// To set some values in the core table
import kernel.system.info;

// This function will initialize the architecture upon boot
ErrorVal archInitialize()
{
	// Read from the linker script
	// We want the length of the kernel module
	System.kernel.start = cast(ubyte*)LinkerScript.kernelLMA;
	System.kernel.length = LinkerScript.ekernel - LinkerScript.kernelVMA;

	// Global Descriptor Table
	printToLog("Initializing GDT", GDT.initialize());

	// Task State Segment
	printToLog("Initializing TSS", TSS.initialize());

	// Interrupt Descriptor Table
	printToLog("Initializing IDT", IDT.initialize());

	// Everything must have succeeded
	return ErrorVal.Success;
}
