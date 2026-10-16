MCU_SUB_VARIANT = nrf52840

# Reserve one flash page for a wear-levelled power-cycle window journal.
# Moving the bootloader start down by one page preserves the normal code budget.
override LD_FILE = linker/nrf52840_nice_nano.ld
CFLAGS += -DBOOTLOADER_REGION_START=0xF3000
CFLAGS += -DPOWER_CYCLE_DFU_WINDOW_MS=10000
CFLAGS += -DPOWER_CYCLE_DFU_JOURNAL_ADDR=0xFD000
