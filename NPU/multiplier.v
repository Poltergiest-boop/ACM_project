module multiplier #(parameter n=4)(
    input wire clk,
    input wire  [n-1:0] M_in,
    input wire  [n-1:0] Q_in,
    output wire [2*n-1:0] Product
);
    reg [n-1:0] M, Q , A;
    reg C;                                               // ALL THE REQUIRED REGISTERS 

    wire load , shift , done , mux_in, c_out , q;
    wire [n-1:0] mux_out , sum;                         // All the required wires 

    assign q=Q[0];

    control #(n) inst1(.clk(clk), .q(q), .load(load), .mux_in(mux_in), .shift(shift), .done(done));
    // connected to control 

    mux #(n) inst2(.mux_in(mux_in), .M(M), . mux_out(mux_out));
    // connected to mux

    nadder #(n) inst3(.mux_out(mux_out), .A(A), .c_out(c_out), .sum(sum));
    // connected to nadder


    always @(posedge clk ) begin 
        if(load) begin                                      // ALL THE REGISTERS ARE LOAD WITH THE INITIAL VALUES
            M<= M_in;
            Q<= Q_in;
            C<=1'b0;
            A<={n{1'b0}};
        end 
        else if (shift) begin 
            Q[n-2:0]<=Q[n-1:1];                              // all the shifting is done 
            Q[n-1]<=A[0];
            A[n-2:0]<=A[n-1:1];
            A[n-1]<=C;
            C<=1'b0;
        end 
        else if (~done) begin 
            A<=sum;                                          // Updating of the continuosly done background calculation
            C<=c_out;
        end 
    end 
    assign Product={A,Q};                           
endmodule


module control #(parameter n=4)(
    input wire q,
    input wire clk,
    output wire load, shift , mux_in , done 
);

    localparam LOAD=2'b00;
    localparam CALC=2'b01;
    localparam SHIFT=2'b10;                 // variables for easy understanding
    localparam DONE=2'b11;

    reg [1:0] state = LOAD;
    reg [ $clog2(n+1)-1:0] count;           // state and counter 


    assign load  = (state == LOAD);
    assign shift = (state == SHIFT);        // updating the load state and done for every cycle
    assign done  = (state == DONE);

    assign mux_in= ~q;

    always @(posedge clk ) begin
        if (state==LOAD) begin              // load is set to1 and counter reset
            count<=0;
            state<= CALC;
        end 
        else if ( state == CALC) begin          // none of them are 1 so the ~done case gets executed adn variables are uppdated
            state<=SHIFT;
        end 
        else if (state == SHIFT) begin          // variables shift 
            count<= count + 1'b1;
            if(count == n-1) begin 
                state<= DONE;
            end 
            else begin 
                state<=CALC;
            end 
        end 
        else if (state ==DONE ) begin 

        end
        else begin 
            state<=LOAD;
        end
    end 
endmodule  


module mux #(parameter n=4)(
    input wire mux_in,
    input wire [n-1:0] M,
    output reg [n-1:0] mux_out
);

    always  @(*) begin 
        if(mux_in) begin 
            mux_out={n{1'b0}};
        end 
        else begin 
            mux_out= M;
        end 
    end 
endmodule

module nadder #(parameter n=4)(
    input wire [n-1:0] A,
    input wire [n-1:0] mux_out,
    output wire [n-1:0] sum,
    output wire c_out 
);

    assign {c_out,sum} = {1'b0,A}+{1'b0, mux_out};             // Add A and mux_out 

endmodule







