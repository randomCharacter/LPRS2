/*****************************************************************************
* Filename:          D:\work\lprs2\2013_2014\Resene_vezbe\lab56\basic_system/drivers/vga_periph_mem_v1_00_a/src/vga_periph_mem.c
* Version:           1.00.a
* Description:       vga_periph_mem Driver Source File
* Date:              Wed Mar 05 10:25:21 2014 (by Create and Import Peripheral Wizard)
*****************************************************************************/


/***************************** Include Files *******************************/

#include "vga_periph_mem.h"
Xuint32 cursor_position;
/************************** Function Definitions ***************************/

void set_cursor(Xuint32 new_value) {
	cursor_position = new_value;
}

void clear_text_screen(Xuint32 BaseAddress) {
	int i;
	for (i = 0; i < 4800; i++){
		VGA_PERIPH_MEM_mWriteMemory(BaseAddress + TEXT_MEM_OFF + i*4, 0x20);
	}
}

void print_string(Xuint32 BaseAddress, unsigned char string_s[], int lenght) {
	int i;
	for (i = 0; i < lenght; i++){
		VGA_PERIPH_MEM_mWriteMemory(BaseAddress + TEXT_MEM_OFF + cursor_position + i*4, (string_s[i]-0x40));
	}
}

void clear_graphics_screen(Xuint32 BaseAddress) {
	int i;
	for (i = 0; i < 9600; i++){
	    VGA_PERIPH_MEM_mWriteMemory(BaseAddress + GRAPHICS_MEM_OFF + i*4, 0x0);
	}
}

/*void draw_square(Xuint32 BaseAddress) {
	int i, j, k;
	for (j = 0; j < 480; j++ ){
		for (k = 0; k < (640/32); k++) {
			i = j*(640/32) + k;
			if ((j > 200) && (j < 280) && (k > 8) && (k < 12)) {
				VGA_PERIPH_MEM_mWriteMemory(BaseAddress + GRAPHICS_MEM_OFF + i*4, 0xFFFFFFFF);
			}
			else {
				VGA_PERIPH_MEM_mWriteMemory(BaseAddress + GRAPHICS_MEM_OFF + i*4, 0x0);
			}
		}
	}
}*/

void print_char(Xuint32 BaseAddress, char ch) {
	VGA_PERIPH_MEM_mWriteMemory(BaseAddress + TEXT_MEM_OFF + cursor_position, ch - 0x40);
}

void clear_screen(Xuint32 BaseAddress) {
	clear_graphics_screen(BaseAddress);
	clear_text_screen(BaseAddress);
}

void set_foreground_color(Xuint32 BaseAddress, Xuint32 color) {
	VGA_PERIPH_MEM_mWriteMemory(BaseAddress + 0x10, color);
}

void set_background_color(Xuint32 BaseAddress, Xuint32 color) {
	VGA_PERIPH_MEM_mWriteMemory(BaseAddress + 0x14, color);
}

void set_font_size(Xuint32 BaseAddress, Xuint32 size) {
	VGA_PERIPH_MEM_mWriteMemory(BaseAddress + 0x0C, size);
}

void draw_rectangle(Xuint32 BaseAddress) {
	int i, j, k;
	for (j = 0; j < 480; j++) {
		for (k = 0; k < (640/32); k++) {
			i = j*(640/32) + k;
			if ((j > 200) && (j < 280) && (k > 8) && (k < 15)) {
				VGA_PERIPH_MEM_mWriteMemory(BaseAddress + GRAPHICS_MEM_OFF + i*4, 0xFFFFFFFF);
			}
			else {
				VGA_PERIPH_MEM_mWriteMemory(BaseAddress + GRAPHICS_MEM_OFF + i*4, 0x0);
			}
		}
	}
}

void draw_circle(Xuint32 BaseAddress) {
	int radius = 7;
    int x = radius-1;
    int y = 0;
    int dx = 1;
    int dy = 1;
    int err = dx - (radius << 1);
    int i;

    int x0 = 200, x1;
    int y0 = 8, y1;

    while (x >= y)
    {
    	x1 = x;
    	y1 = y;


			i = (x0 + x1)*(640/32) + (y0 + y1);
			VGA_PERIPH_MEM_mWriteMemory(BaseAddress + GRAPHICS_MEM_OFF + i*4, 0xFFFFFFFF);

			i = (x0 + y1)*(640/32) + (y0 + x1);
			VGA_PERIPH_MEM_mWriteMemory(BaseAddress + GRAPHICS_MEM_OFF + i*4, 0xFFFFFFFF);

			i = (x0 - y1)*(640/32) + (y0 + x1);
			VGA_PERIPH_MEM_mWriteMemory(BaseAddress + GRAPHICS_MEM_OFF + i*4, 0xFFFFFFFF);

			i = (x0 - x1)*(640/32) + (y0 + y1);
			VGA_PERIPH_MEM_mWriteMemory(BaseAddress + GRAPHICS_MEM_OFF + i*4, 0xFFFFFFFF);

			i = (x0 - x1)*(640/32) + (y0 - y1);
			VGA_PERIPH_MEM_mWriteMemory(BaseAddress + GRAPHICS_MEM_OFF + i*4, 0xFFFFFFFF);

			i = (x0 - y1)*(640/32) + (y0 - x1);
			VGA_PERIPH_MEM_mWriteMemory(BaseAddress + GRAPHICS_MEM_OFF + i*4, 0xFFFFFFFF);

			i = (x0 + y1)*(640/32) + (y0 - x1);
			VGA_PERIPH_MEM_mWriteMemory(BaseAddress + GRAPHICS_MEM_OFF + i*4, 0xFFFFFFFF);

			i = (x0 + x1)*(640/32) + (y0 - y1);
			VGA_PERIPH_MEM_mWriteMemory(BaseAddress + GRAPHICS_MEM_OFF + i*4, 0xFFFFFFFF);


        if (err <= 0)
        {
            y++;
            err += dy;
            dy += 2;
        }

        if (err > 0)
        {
            x--;
            dx += 2;
            err += dx - (radius << 1);
        }
    }
}

struct resolution get_resolution(Xuint32 BaseAddress) {
	struct resolution res;
	res.height = 0;
	res.width = 0;
	return res;
}

void draw_square(Xuint32 BaseAddress, int x, int y){
	int i, j, k;
		for (j = 0; j < 480; j++){
			for (k = 0; k<(640/32); k++){
				i = j*(640/32) + k;
				if ((j > x) && (j < x + 80) && (k > y) && (k < y + 4)) {
					VGA_PERIPH_MEM_mWriteMemory(BaseAddress + GRAPHICS_MEM_OFF + i*4, 0xFFFFFFFF);
				}
				else{
					VGA_PERIPH_MEM_mWriteMemory(BaseAddress + GRAPHICS_MEM_OFF + i*4, 0x0);
				}
			}
		}
}
