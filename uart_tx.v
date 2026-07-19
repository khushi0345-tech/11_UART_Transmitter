module uart_tx #(
    parameter CLKS_PER_BIT = 5208   // 50 MHz clock, 9600 baud
)(
    input wire clk,
    input wire rst,
    input wire tx_start,
    input wire [7:0] tx_data,

    output reg tx,
    output reg tx_busy,
    output reg tx_done
);

    // FSM States
    localparam IDLE  = 2'b00;
    localparam START = 2'b01;
    localparam DATA  = 2'b10;
    localparam STOP  = 2'b11;

    reg [1:0] state;
    reg [12:0] clk_count;
    reg [2:0] bit_index;
    reg [7:0] data_reg;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state     <= IDLE;
            tx        <= 1'b1;      // UART line remains high when idle
            tx_busy   <= 1'b0;
            tx_done   <= 1'b0;
            clk_count <= 0;
            bit_index <= 0;
            data_reg  <= 8'd0;
        end
        else begin
            tx_done <= 1'b0;

            case(state)

                //-----------------------------------------
                // IDLE STATE
                //-----------------------------------------
                IDLE: begin
                    tx <= 1'b1;
                    tx_busy <= 1'b0;
                    clk_count <= 0;
                    bit_index <= 0;

                    if(tx_start) begin
                        tx_busy  <= 1'b1;
                        data_reg <= tx_data;
                        state    <= START;
                    end
                end

                //-----------------------------------------
                // START BIT
                //-----------------------------------------
                START: begin
                    tx <= 1'b0; // Start bit

                    if(clk_count < CLKS_PER_BIT-1)
                        clk_count <= clk_count + 1;
                    else begin
                        clk_count <= 0;
                        state <= DATA;
                    end
                end

                //-----------------------------------------
                // DATA BITS
                //-----------------------------------------
                DATA: begin
                    tx <= data_reg[bit_index];

                    if(clk_count < CLKS_PER_BIT-1)
                        clk_count <= clk_count + 1;
                    else begin
                        clk_count <= 0;

                        if(bit_index < 7)
                            bit_index <= bit_index + 1;
                        else begin
                            bit_index <= 0;
                            state <= STOP;
                        end
                    end
                end

                //-----------------------------------------
                // STOP BIT
                //-----------------------------------------
                STOP: begin
                    tx <= 1'b1; // Stop bit

                    if(clk_count < CLKS_PER_BIT-1)
                        clk_count <= clk_count + 1;
                    else begin
                        clk_count <= 0;
                        tx_done <= 1'b1;
                        tx_busy <= 1'b0;
                        state <= IDLE;
                    end
                end

                default:
                    state <= IDLE;

            endcase
        end
    end

endmodule