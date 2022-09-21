module tb_Shift_reg ();
    parameter n = 8;
    logic clk, rst, load, serial_in, serial_out; 
    logic [n-1:0] parallel_in, parallel_out; 

    Shift_reg dut (clk, rst, load, serial_in, parallel_in, serial_out, parallel_out);

    initial begin
        clk = 0; #5;
        forever begin
            clk = 1; #5;
            clk = 0; #5;
        end
    end

    initial begin
        rst = 1; load = 0; #15;
        rst = 0; 
        // Serial in, serial/parallel out 
        serial_in = 1; #10; 
        serial_in = 0; #10;
        serial_in = 1; #10;
        serial_in = 1; #10;
        serial_in = 0; #10;
        serial_in = 1; #100;
        // Parallel in, parallel/serial out
        load = 1; 
        parallel_in = 8'b01101001; #100;
        $stop;
    end
endmodule