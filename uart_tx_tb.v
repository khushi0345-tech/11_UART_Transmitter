`timescale 1ns/1ps

module uart_tx_tb;

    // Inputs
    reg clk;
    reg rst;
    reg tx_start;
    reg [7:0] tx_data;

    // Outputs
    wire tx;
    wire tx_busy;
    wire tx_done;

    // Instantiate UART Transmitter
    uart_tx #(
        .CLKS_PER_BIT(10)     // Reduced for faster simulation
    ) DUT (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
        .tx_busy(tx_busy),
        .tx_done(tx_done)
    );

    // Clock Generation (100 MHz)
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        tx_start = 0;
        tx_data = 8'h00;

        // Apply reset
        #20;
        rst = 0;

        // Transmit first byte
        #20;
        tx_data = 8'hA5;
        tx_start = 1;

        #10;
        tx_start = 0;

        // Wait for transmission to complete
        wait(tx_done);

        $display("Transmission of %h completed at time %t",
                 tx_data, $time);

        // Transmit another byte
        #50;
        tx_data = 8'h3C;
        tx_start = 1;

        #10;
        tx_start = 0;

        wait(tx_done);

        $display("Transmission of %h completed at time %t",
                 tx_data, $time);

        #100;
        $finish;
    end

    // Monitor signals
    initial begin
        $monitor("Time=%0t | tx_start=%b | tx=%b | tx_busy=%b | tx_done=%b",
                  $time, tx_start, tx, tx_busy, tx_done);
    end

endmodule