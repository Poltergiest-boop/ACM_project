module rra_tb;

    reg clk;
    reg rst;
    reg [3:0] req;
    wire [3:0] gnt;

    RRA dut (.clk(clk),.req(req),.rst(rst),.gnt(gnt));
    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1; req = 4'b0000;

        $dumpfile("rra.vcd");
        $dumpvars(0, rra_tb);

        #10; rst = 0;

        // Test 1: No requests
        req = 4'b0000;
        #10;

        // Test 2: Only device 0 requests
        req = 4'b0001;
        #10;

        // Test 3: All devices request simultaneously
        req = 4'b1111;
        #40;

        // Test 4: Devices 0 and 2 request
        req = 4'b0101;
        #40;

        // Test 5: Devices 1 and 3 request
        req = 4'b1010;
        #40;

        // Test 6: No requests again
        req = 4'b0000;
        #10;
        
        $finish;
    end

endmodule
