module SIMD(
    input wire [127:0] A,B,
    input wire [1:0] CS1, 
    input wire CS2,
    output reg [127:0] Answer
);
wire [2:0] casee;
integer i;
reg [8:0] sum_8;
reg [16:0] sum_16;
reg [32:0] sum_32;

assign casee={CS2,CS1};
    always @(*) begin 
    Answer = 128'b0;
    case(casee)
        3'b000: begin 
            for( i=1; i<=16; i=i+1) begin 
                sum_8=A[8*(i-1) +: 8]+B[8*(i-1) +: 8];
                if(sum_8 >= 9'b100000000) begin
                    Answer[8*(i-1) +: 8]=8'b11111111;
                end 
                else begin 
                    Answer[8*(i-1) +: 8]= A[8*(i-1) +: 8]+B[8*(i-1) +: 8]; 
                end                
            end 
        end 
        3'b001: begin 
            for( i=1; i<=16; i=i+1) begin 
                if(A[8*(i-1) +: 8]<=B[8*(i-1) +: 8] ) begin
                    Answer[8*(i-1) +: 8]=8'b00000000;
                end 
                else begin 
                    Answer[8*(i-1) +: 8]= A[8*(i-1) +: 8]-B[8*(i-1) +: 8]; 
                end                
            end 
        end
        3'b010: begin 
            for( i=1; i<=8; i=i+1) begin 
                sum_16=A[16*(i-1) +: 16]+B[16*(i-1) +: 16];
                if(sum_16 >= 17'b10000000000000000) begin
                    Answer[16*(i-1) +: 16]=16'b1111111111111111;
                end 
                else begin 
                    Answer[16*(i-1) +: 16]= A[16*(i-1) +: 16]+B[16*(i-1) +: 16]; 
                end                
            end 
        end
        3'b011: begin 
            for( i=1; i<=8; i=i+1) begin 
                if(A[16*(i-1) +: 16]<=B[16*(i-1) +: 16]) begin
                    Answer[16*(i-1) +: 16]=16'b0000000000000000;
                end 
                else begin 
                    Answer[16*(i-1) +: 16]= A[16*(i-1) +: 16]-B[16*(i-1) +: 16]; 
                end                
            end 
        end
        3'b100: begin 
            for( i=1; i<=4; i=i+1) begin 
                sum_32=A[32*(i-1) +: 32]+B[32*(i-1) +: 32];
                if(sum_32 >= 33'b100000000000000000000000000000000) begin
                    Answer[32*(i-1) +: 32]=32'b11111111111111111111111111111111;
                end 
                else begin 
                    Answer[32*(i-1) +: 32]= A[32*(i-1) +: 32]+B[32*(i-1) +: 32]; 
                end                
            end 
        end
        3'b101: begin 
            for( i=1; i<=4; i=i+1) begin 
                if(A[32*(i-1) +: 32]<=B[32*(i-1) +: 32]) begin
                    Answer[32*(i-1) +: 32]=32'd0;
                end 
                else begin 
                    Answer[32*(i-1) +: 32]= A[32*(i-1) +: 32]-B[32*(i-1) +: 32]; 
                end                
            end 
        end
        default: Answer=128'd0;
    endcase 
end 
endmodule
