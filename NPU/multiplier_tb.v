
module tb_multiplier;

    reg clk;
    reg [3:0] M_in, Q_in;
    wire [7:0] Product;

    multiplier #(4) uut (
        .clk(clk),
        .M_in(M_in),
        .Q_in(Q_in),
        .Product(Product)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        $dumpfile("multiplier.vcd");
        $dumpvars(0, tb_multiplier);

        // Test 1: 6 x 9= 54
        M_in = 4'b0110;
        Q_in = 4'b1001;

        #200;
        $finish;
    end

endmodule
