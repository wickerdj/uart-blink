const std = @import("std");
const microzig = @import("microzig");
const time = rp2xxx.time;
const uart_time = microzig.drivers.time;

const led = gpio.num(25);
const rp2xxx = microzig.hal;
const gpio = rp2xxx.gpio;
const clocks = rp2xxx.clocks;

const uart = rp2xxx.uart.instance.num(1);
const uart_tx_pin = gpio.num(4);
const uart_rx_pin = gpio.num(5);

pub fn main() !void {
    inline for (&.{ uart_tx_pin, uart_rx_pin }) |pin| {
        pin.set_function(.uart);
    }

    led.set_function(.sio);
    led.set_direction(.out);

    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });

    while (true) {
        const msgOn = "ON\r\n";

        // write_blocking takes 2 parameters. The second parameter is for a timeout.
        // Skipping dealing with timeout for now
        uart.write_blocking(msgOn, null) catch {
            uart.clear_errors();
        };
        led.put(1);
        time.sleep_ms(3000);

        const msgOff = "OFF\n\r";
        uart.write_blocking(msgOff, null) catch {
            uart.clear_errors();
        };
        led.put(0);
        time.sleep_ms(1000);
    }
}
