module Fsm (rst, clk, aim, motion_score, detail_score, make_motion, check_motion, make_detail, check_detail, make_video, motion_prmt, detail_prmt);
    input logic rst, clk;
    input logic [2:0] aim;
    input logic [7:0] motion_score, detail_score;
    output logic make_motion, check_motion, make_detail, check_detail, make_video;
    output logic [7:0] motion_prmt, detail_prmt;

    logic [7:0] motion_target, detail_target; 

    typedef enum  {s_reset, s_make_motion, s_check_motion, s_wait_motion_sccore, s_increase_motion, s_decrease_motion, s_decode_detail, 
    s_high_detail, s_medium_detail, s_low_detail, s_make_detail, s_check_detail, s_wait_detail_score, s_increase_detail, s_decrease_detail, s_make_video, s_done} statetype;

    statetype current_state, next_state; 

    always_ff @ (posedge clk) begin
        if (rst) begin
            current_state <= s_reset;
        end

        current_state <= next_state;
    end

    always_comb  begin
        case (current_state) 
            s_reset: begin
                make_motion = 0; 
                check_motion = 0;
                make_detail = 0;
                check_detail = 0;
                make_video = 0;
                motion_target = 'd100;
                motion_prmt = 'd50;
                detail_target = 'd0;
                detail_prmt = 'd200;
                if (~rst) begin
                    next_state = s_make_motion;
                end
            end

            s_make_motion: begin
                make_motion = 1;
                next_state = s_check_motion;
            end

            s_check_motion: begin
                make_motion = 0;
                check_motion = 1;
                next_state = s_wait_motion_sccore;
            end

            s_wait_motion_sccore: begin
                check_motion = 0;
            end

        endcase
    end

endmodule