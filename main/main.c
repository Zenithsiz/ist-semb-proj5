#include "driver/gpio.h"
#include "esp_system.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "spi_flash_mmap.h"
#include <stdio.h>

void test1() {
	while (1) {
		for (int i = 0; i < 16; i++) {
			printf("Value: %d\n", i);
			int b0 = (i >> 0) & 1;
			int b1 = (i >> 1) & 1;
			int b2 = (i >> 2) & 1;
			int b3 = (i >> 3) & 1;

			gpio_set_level(5, b0);
			gpio_set_level(4, b1);
			gpio_set_level(3, b2);
			gpio_set_level(2, b3);

			vTaskDelay(10 / portTICK_PERIOD_MS);
		}
	}
}

void test3() {
	int i = 0;
	int dir = 1;
	while (1) {
		printf("Value: %d\n", i);
		int b0 = (i >> 0) & 1;
		int b1 = (i >> 1) & 1;
		int b2 = (i >> 2) & 1;
		int b3 = (i >> 3) & 1;

		gpio_set_level(5, b0);
		gpio_set_level(4, b1);
		gpio_set_level(3, b2);
		gpio_set_level(2, b3);

		vTaskDelay(200 / portTICK_PERIOD_MS);

		i += dir;
		if (i == 15 || i == 0) {
			dir = -dir;
		}
	}
}

void app_main(void) {
	// Initialize the pin
	for (int pin = 2; pin <= 5; pin++) {
		gpio_reset_pin(pin);
		gpio_set_direction(pin, GPIO_MODE_OUTPUT);
	}

	//test1();
	//test3();
}
