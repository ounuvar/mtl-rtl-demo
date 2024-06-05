module TimedPastEventuallyFormula #(
    parameter int unsigned a,
    parameter int unsigned b,
    localparam [0:`MAX_TIME-1] init_a2b = {{a{1'b0}}, {b-a+1{1'b1}}, {`MAX_TIME-b-1{1'b0}}}
) (
    input logic clk,
    input logic rst,
    input logic [0:`MAX_TIME-1] t,
    input logic phi,
    output logic y
);
    logic [0:`MAX_TIME-1] v_r;
    logic [0:`MAX_TIME-1] a2b_r;

    logic [0:`MAX_TIME-1] v_r_next;
    logic [0:`MAX_TIME-1] a2b_r_next;

    assign v_r_next = (v_r & ~(t << 1)) | (phi ? a2b_r : `MAX_TIME'b0);
    assign a2b_r_next = a2b_r >> 1;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            v_r <= `MAX_TIME'b0;
            a2b_r <= init_a2b;
        end else begin
            a2b_r <= a2b_r_next;
            v_r <= v_r_next;
        end
    end

    assign y = |(v_r_next & t);
endmodule
