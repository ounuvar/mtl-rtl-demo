module SinceFormula (
    input logic clk,
    input logic phi1,
    input logic phi2,
    output logic y
);
    logic v;

    always_ff @(posedge clk) begin
        v <= phi2 | (phi1 & v);
    end

    assign y = v;
endmodule
