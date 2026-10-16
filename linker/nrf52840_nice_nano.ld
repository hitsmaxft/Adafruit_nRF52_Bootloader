/* nice!nano v2 layout with a dedicated power-cycle DFU journal page. */

SEARCH_DIR(.)
GROUP(-lgcc -lc -lnosys)

MEMORY
{
  /* One extra page is assigned to the bootloader so application images cannot
   * overwrite the journal. The executable keeps the standard 38 KB budget. */
  FLASH (rx) : ORIGIN = 0xF3000, LENGTH = 0xFD000-0xF3000 - 2K
  BOOTLOADER_CONFIG (r): ORIGIN = 0xFD000 - 2K, LENGTH = 2K
  POWER_CYCLE_JOURNAL (rw) : ORIGIN = 0xFD000, LENGTH = 0x1000
  MBR_PARAMS_PAGE (rw) : ORIGIN = 0xFE000, LENGTH = 0x1000
  BOOTLOADER_SETTINGS (rw) : ORIGIN = 0xFF000, LENGTH = 0x1000

  RAM (rwx) : ORIGIN = 0x20008000, LENGTH = 0x20040000-0x20008000
  DBL_RESET (rwx) : ORIGIN = 0x20007F7C, LENGTH = 0x04
  NOINIT (rwx) : ORIGIN = 0x20007F80, LENGTH = 0x80

  UICR_BOOTLOADER (r) : ORIGIN = 0x10001014, LENGTH = 0x04
  UICR_MBR_PARAM_PAGE(r) : ORIGIN = 0x10001018, LENGTH = 0x04
}

SECTIONS
{
  .fs_data_out ALIGN(4):
  {
    PROVIDE(__start_fs_data = .);
    KEEP(*(fs_data))
    PROVIDE(__stop_fs_data = .);
  } = 0

  .bootloaderConfig :
  {
    KEEP(*(.bootloaderConfig))
  } > BOOTLOADER_CONFIG

  .powerCycleJournal (NOLOAD) :
  {
  } > POWER_CYCLE_JOURNAL

  .bootloaderSettings (NOLOAD) :
  {
  } > BOOTLOADER_SETTINGS

  .uicrBootStartAddress :
  {
    KEEP(*(.uicrBootStartAddress))
  } > UICR_BOOTLOADER

  .mbrParamsPage (NOLOAD) :
  {
  } > MBR_PARAMS_PAGE

  .uicrMbrParamsPageAddress :
  {
    KEEP(*(.uicrMbrParamsPageAddress))
  } > UICR_MBR_PARAM_PAGE

  .dbl_reset (NOLOAD) :
  {
  } > DBL_RESET

  .noinit (NOLOAD) :
  {
  } > NOINIT
}

INCLUDE "nrf_common.ld"
