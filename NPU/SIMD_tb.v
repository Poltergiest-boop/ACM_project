module SIMD_tb;

    reg [127:0] A, B;
    reg [1:0] CS1;
    reg CS2;
    wire [127:0] Answer;

    SIMD uut (
        .A(A),
        .B(B),
        .CS1(CS1),
        .CS2(CS2),
        .Answer(Answer)
    );

    initial begin
        $dumpfile("SIMD_tb.vcd");
        $dumpvars(0, SIMD_tb);

        // TEST 1: 8-bit addition with saturation
        CS2 = 0; CS1 = 2'b00;
        A = 128'h000000000000000000000000000000FA; //250
        B = 128'h00000000000000000000000000000014; //20
        #10;

        // TEST 2: 8-bit subtraction with saturation
        CS2 = 0; CS1 = 2'b01;
        A = 128'h0000000000000000000000000000000A; //10
        B = 128'h00000000000000000000000000000014; //20
        #10;


        // TEST 3: 16-bit addition with saturation
        CS2 = 1; CS1 = 2'b00;
        A = 128'h0000000000000000000000000000FA00;  //64000
        B = 128'h00000000000000000000000000001400;  //5120
        #10;

        // TEST 4: 16-bit subtraction
        CS2 = 1; CS1 = 2'b01;
        A = 128'h00000000000000000000000000000064; //100
        B = 128'h00000000000000000000000000000014; //20
        #10;

        // TEST 5: 32-bit addition with saturation
        CS2 = 0; CS1 = 2'b10;
        A = 128'h000000000000000000000000FFFFFFFF; 
        B = 128'h00000000000000000000000000000001;
        #10;

        // TEST 6: 32-bit subtraction with saturation
        CS2 = 0; CS1 = 2'b11;
        A = 128'h00000000000000000000000000000005; 
        B = 128'h00000000000000000000000000000009;
        #10;

        #10;
        $finish;
    end

endmodule