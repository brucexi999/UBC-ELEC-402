// A n-bit shift register with serial/parallel input, serial/parallel output, parallel load, and synchronous reset
parameter n = 8;
module Shift_reg (
    
    input logic clk,
    input logic rst, 
    input logic load, // Basically the load signal selective bewtween serial in or parallel in
    input logic serial_in,
    input logic [n-1:0] parallel_in,
    output logic serial_out,
    output logic [n-1:0] parallel_out
    );
    
    always_ff @ (posedge clk) begin
        if (rst) begin
            parallel_out <= 0;
        end

        else if (load) begin
            parallel_out <= parallel_in; 
        end

        else begin
            parallel_out <= {parallel_out[n-2:0], serial_in};
        end
    end

    assign serial_out = parallel_out [n-1]; 
    
endmodule 