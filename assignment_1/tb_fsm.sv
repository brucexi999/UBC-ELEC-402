module tb_Fsm ();
    logic rst, clk;
    logic [2:0] aim;
    logic [7:0] motion_score, detail_score;
    logic make_motion, check_motion, make_detail, check_detail, make_video;
    logic [7:0] motion_prmt, detail_prmt;

    typedef enum {s_reset, s_make_motion, s_check_motion, s_wait_motion_sccore, s_increase_motion, s_decrease_motion, s_decode_detail, 
    s_make_detail, s_check_detail, s_wait_detail_score, s_increase_detail, s_decrease_detail, s_make_video, s_done} statetype;
    
    Fsm dut (rst, clk, aim, motion_score, detail_score, make_motion, check_motion, make_detail, check_detail, make_video, motion_prmt, detail_prmt);

    initial begin
        clk = 0; #5;
        forever begin
            clk = 1; #5;
            clk = 0; #5;
        end
    end

    initial begin
        rst = 1; #15;
        assert (dut.current_state === s_reset) else $error ("reset failed.");
        rst = 0; #10;
        assert (dut.current_state === s_make_motion && make_motion === 1'b1) else $error ("make_motion failed.");
        #10;
        assert (dut.current_state === s_check_motion && make_motion === 1'b0 && check_motion === 1'b1) else $error ("check_motion failed.");
        #10;
        assert (dut.current_state === s_wait_motion_sccore && check_motion === 1'b0) else $error ("wait_motion_score failed.");
        motion_score = 'd80; #10;
        assert (dut.current_state === s_increase_motion && motion_prmt === 'd51) else $error ("increase_motion failed.");
        #30;
        motion_score = 'd101; #10; 
        assert (dut.current_state === s_decrease_motion && motion_prmt === 'd50) else $error ("decrease_motion failed.");
        #30; 
        motion_score = 'd100; #10;
        assert (dut.current_state === s_decode_detail && motion_prmt === 'd50) else $error ("decode_detail failed.");
        aim = 3'b100; #10; 
        assert (dut.current_state === s_make_detail && dut.detail_target === 'd60 && make_detail === 1'b1) else $error ("make_detail_high failed.");
        #10; 
        assert (dut.current_state === s_check_detail && make_detail === 1'b0 && check_detail === 1'b1) else $error ("check_detail failed.");
        #10; 
        assert (dut.current_state === s_wait_detail_score && check_detail === 1'b0) else $error ("wait_detail_score failed.");
        detail_score = 'd59; #10; 
        assert (dut.current_state === s_increase_detail && detail_prmt === 'd151) else $error ("increase_detail failed.");
        #30;
        detail_score = 'd61; #10; 
        assert (dut.current_state === s_decrease_detail && detail_prmt === 'd150) else $error ("decrease_detail failed.");
        #30;
        detail_score = 'd60; #10;
        assert (dut.current_state === s_make_video && make_video === 1'b1) else $error ("make_video failed.");
        #10; 
        assert (dut.current_state === s_done && make_video === 1'b0) else $error ("done failed.");
        rst = 1; #10; 
        assert (dut.current_state === s_reset) else $error ("reset failed.");
        $stop; 
    end

endmodule 