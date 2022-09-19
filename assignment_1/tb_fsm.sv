module tb_Fsm ();
    logic rst, clk;
    logic [2:0] aim;
    logic [7:0] motion_score, detail_score;
    logic make_motion, check_motion, make_detail, check_detail, make_video;
    logic [7:0] motion_prmt, detail_prmt;

    Fsm DUT (rst, clk, aim, motion_score, detail_score, make_motion, check_motion, make_detail, check_detail, make_video, motion_prmt, detail_prmt);

    initial begin
        clk = 0; #5;
        forever begin
            clk = 1; #5;
            clk = 0; #5;
        end
    end

    initial begin
        rst = 1; #15;
        rst = 0; #50;
        $stop; 
    end

endmodule 