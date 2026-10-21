
module RRA(
    input wire clk,
    input wire [3:0] req,
    input wire rst,
    output reg [3:0] gnt
);
    reg [1:0] priority;

    always @(*) begin
        gnt = 4'b0000;

        case (priority)
            2'd0: begin
                gnt=req[0]?4'b0001:(req[1]?4'b0010:(req[2]?4'b0100:req[3]?4'b1000:4'b0000));
            end

            2'd1: begin
                gnt=req[1]?4'b0010:(req[2]?4'b0100:(req[3]?4'b1000:req[0]?4'b0001:4'b0000));
            end

            2'd2: begin
                gnt=req[2]?4'b0100:(req[3]?4'b1000:(req[0]?4'b0001:req[1]?4'b0010:4'b0000));
            end

            2'd3: begin
                gnt=req[3]?4'b1000:(req[0]?4'b0001:(req[1]?4'b0010:req[2]?4'b0100:4'b0000));
            end
        endcase
    end

    always @(posedge clk) begin
        if(rst) begin
            priority<=2'd3;
        end 
        else begin 
        case(gnt)
            4'b0000:priority<=priority; //873812
            4'b0001:priority<=1;
            4'b0010:priority<=2;
            4'b0100:priority<=3;
            4'b1000:priority<=0;
            default:priority<=priority;
        endcase 
    end
    end
endmodule
